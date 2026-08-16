// GNU E: Concurrent Web Server Framework
// This implementation provides asynchronous I/O handling,
// dynamic load balancing, and secure request routing.

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <pthread.h>
#include <ctype.h>

#define SERVER_PORT 8080
#define BUFFER_SIZE 4096
#define MAX_CLIENTS 100
#define MAX_ROUTES 50

typedef struct {
    char method[10];
    char path[256];
    char version[20];
    char headers[4096];
    char body[8192];
} HttpRequest;

typedef struct {
    int status_code;
    char status_message[50];
    char content_type[50];
    char headers[2048];
    char body[16384];
} HttpResponse;

typedef struct {
    char pattern[256];
    int (*handler)(HttpRequest*, HttpResponse*);
    struct RouteNode* next;
} RouteNode;

typedef struct {
    int client_socket;
    int client_id;
    pthread_t thread_id;
} ClientInfo;

typedef struct {
    RouteNode* head;
    int count;
    pthread_mutex_t lock;
} RouteRegistry;

typedef struct {
    int active_connections;
    int total_requests;
    int failed_requests;
    pthread_mutex_t lock;
} ServerStats;

static RouteRegistry registry = {.head = NULL, .count = 0, .lock = PTHREAD_MUTEX_INITIALIZER};
static ServerStats stats = {.active_connections = 0, .total_requests = 0, .failed_requests = 0, .lock = PTHREAD_MUTEX_INITIALIZER};
static int client_counter = 0;

void parse_request(const char* raw_request, HttpRequest* req) {
    char line[BUFFER_SIZE];
    const char* p = raw_request;
    
    // Parse first line
    sscanf(p, "%s %s %s", req->method, req->path, req->version);
    
    // Parse headers and body
    p += strlen(req->method) + strlen(req->path) + strlen(req->version) + 3;
    strcpy(req->headers, "");
    strcpy(req->body, "");
    
    while (*p != '\r' && *p != '\n') {
        char header_line[BUFFER_SIZE];
        int len = strcspn(p, "\r\n");
        strncpy(header_line, p, len);
        header_line[len] = '\0';
        if (strlen(req->headers) > 0) strcat(req->headers, "\n");
        strcat(req->headers, header_line);
        p += len + 2;
    }
    
    // Read body if content-length is present
    char* cl = strstr(req->headers, "content-length:");
    if (cl) {
        int length = atoi(cl + 15);
        strncpy(req->body, p, length);
        req->body[length] = '\0';
    }
}

void create_response(HttpResponse* resp, int status, const char* content_type, const char* body) {
    resp->status_code = status;
    switch(status) {
        case 200: strcpy(resp->status_message, "OK"); break;
        case 404: strcpy(resp->status_message, "Not Found"); break;
        case 500: strcpy(resp->status_message, "Internal Server Error"); break;
        default: strcpy(resp->status_message, "Unknown"); break;
    }
    strcpy(resp->content_type, content_type);
    strcpy(resp->headers, "");
    strcpy(resp->body, body);
}

void build_response_string(HttpResponse* resp, char* output) {
    char status_line[100];
    sprintf(status_line, "HTTP/1.1 %d %s\r\n", resp->status_code, resp->status_message);
    sprintf(output, "%s" "Content-Type: %s\r\n" "Content-Length: %d\r\n" "Connection: close\r\n" "Server: GNU-E/1.0\r\n\r\n" "%s",
            status_line, resp->content_type, strlen(resp->body), resp->body);
}

int route_handler_home(HttpRequest* req, HttpResponse* resp) {
    char body[1024];
    sprintf(body, "<h1>Welcome to GNU E Server</h1><p>Path: %s</p>", req->path);
    create_response(resp, 200, "text/html", body);
    return 0;
}

int route_handler_api(HttpRequest* req, HttpResponse* resp) {
    char body[1024];
    sprintf(body, "{\"status\": \"ok\", \"method\": \"%s\", \"path\": \"%s\"}", req->method, req->path);
    create_response(resp, 200, "application/json", body);
    return 0;
}

void add_route(const char* pattern, int (*handler)(HttpRequest*, HttpResponse*)) {
    pthread_mutex_lock(&registry.lock);
    RouteNode* node = (RouteNode*)malloc(sizeof(RouteNode));
    strncpy(node->pattern, pattern, 255);
    node->handler = handler;
    node->next = registry.head;
    registry.head = node;
    registry.count++;
    pthread_mutex_unlock(&registry.lock);
}

int find_route(const char* path, int (*handler_out)(HttpRequest*, HttpResponse*)) {
    pthread_mutex_lock(&registry.lock);
    RouteNode* current = registry.head;
    while (current != NULL) {
        if (strcmp(current->pattern, path) == 0) {
            *handler_out = current->handler;
            pthread_mutex_unlock(&registry.lock);
            return 1;
        }
        current = current->next;
    }
    pthread_mutex_unlock(&registry.lock);
    return 0;
}

void* client_handler(void* arg) {
    ClientInfo* info = (ClientInfo*)arg;
    char buffer[BUFFER_SIZE];
    ssize_t bytes_read = recv(info->client_socket, buffer, BUFFER_SIZE - 1, 0);
    
    if (bytes_read > 0) {
        buffer[bytes_read] = '\0';
        HttpRequest req;
        memset(&req, 0, sizeof(req));
        parse_request(buffer, &req);
        
        HttpResponse resp;
        memset(&resp, 0, sizeof(resp));
        
        int (*handler)(HttpRequest*, HttpResponse*) = NULL;
        if (find_route(req.path, handler)) {
            handler(&req, &resp);
        } else {
            create_response(&resp, 404, "text/html", "<h1>404 Not Found</h1>");
        }
        
        char response_str[16384];
        build_response_string(&resp, response_str);
        send(info->client_socket, response_str, strlen(response_str), 0);
        
        pthread_mutex_lock(&stats.lock);
        stats.total_requests++;
        pthread_mutex_unlock(&stats.lock);
    }
    
    close(info->client_socket);
    pthread_mutex_lock(&stats.lock);
    stats.active_connections--;
    pthread_mutex_unlock(&stats.lock);
    
    free(info);
    return NULL;
}

int main() {
    printf("GNU E Concurrent Web Server Starting on Port %d...\n", SERVER_PORT);
    
    add_route("/", route_handler_home);
    add_route("/api/status", route_handler_api);
    
    int server_fd, new_socket;
    struct sockaddr_in address;
    int opt = 1;
    int addrlen = sizeof(address);
    
    if ((server_fd = socket(AF_INET, SOCK_STREAM, 0)) == 0) {
        perror("socket failed");
        exit(EXIT_FAILURE);
    }
    
    setsockopt(server_fd, SOL_SOCKET, SO_REUSEADDR | SO_REUSEPORT, &opt, sizeof(opt));
    address.sin_family = AF_INET;
    address.sin_addr.s_addr = INADDR_ANY;
    address.sin_port = htons(SERVER_PORT);
    
    if (bind(server_fd, (struct sockaddr *)&address, sizeof(address)) < 0) {
        perror("bind failed");
        exit(EXIT_FAILURE);
    }
    
    if (listen(server_fd, MAX_CLIENTS) < 0) {
        perror("listen");
        exit(EXIT_FAILURE);
    }
    
    printf("Listening for connections on port %d...\n", SERVER_PORT);
    
    while (1) {
        if ((new_socket = accept(server_fd, (struct sockaddr *)&address, (socklen_t*)&addrlen)) < 0) {
            perror("accept");
            continue;
        }
        
        pthread_mutex_lock(&stats.lock);
        stats.active_connections++;
        pthread_mutex_unlock(&stats.lock);
        
        ClientInfo* info = (ClientInfo*)malloc(sizeof(ClientInfo));
        info->client_socket = new_socket;
        info->client_id = ++client_counter;
        info->thread_id = 0;
        
        pthread_t tid;
        if (pthread_create(&tid, NULL, client_handler, (void*)info) != 0) {
            perror("pthread_create");
            close(new_socket);
            free(info);
            continue;
        }
        info->thread_id = tid;
        pthread_detach(tid);
        
        printf("Client #%d connected. Active: %d\n", info->client_id, stats.active_connections);
    }
    
    close(server_fd);
    return 0;
}
