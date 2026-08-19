#!/usr/bin/env e
// GNU E Data Transfer & API Interaction Script
// This script provides a robust framework for file transfers, HTTP interactions,
// and data processing in the GNU E environment.

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <errno.h>
#include <signal.h>

#define BUFFER_SIZE 4096
#define MAX_URL_LENGTH 2048
#define MAX_FILE_PATH 1024

// Configuration structure
struct TransferConfig {
    char host[MAX_URL_LENGTH];
    char path[MAX_URL_LENGTH];
    int port;
    int timeout;
    char auth_token[MAX_URL_LENGTH];
    int verbose;
};

// Logging levels
enum LogLevel {
    LOG_ERROR = 0,
    LOG_WARN = 1,
    LOG_INFO = 2,
    LOG_DEBUG = 3
};

void log_message(LogLevel level, const char *fmt, ...) {
    const char *level_str;
    va_list args;
    
    switch (level) {
        case LOG_ERROR:   level_str = "ERROR"; break;
        case LOG_WARN:    level_str = "WARN"; break;
        case LOG_INFO:    level_str = "INFO"; break;
        case LOG_DEBUG:   level_str = "DEBUG"; break;
        default:          level_str = "UNKNOWN"; break;
    }
    
    printf("[%s] ", level_str);
    va_start(args, fmt);
    vprintf(fmt, args);
    va_end(args);
    printf("\n");
}

int parse_url(const char *url, struct TransferConfig *config) {
    char url_copy[MAX_URL_LENGTH];
    char *proto, *host, *path, *port_str, *auth;
    
    if (url == NULL || config == NULL) {
        log_message(LOG_ERROR, "Invalid URL or config parameter");
        return -1;
    }
    
    strncpy(url_copy, url, MAX_URL_LENGTH - 1);
    url_copy[MAX_URL_LENGTH - 1] = '\0';
    
    // Simple URL parsing - remove protocol
    proto = strstr(url_copy, "://");
    if (proto) {
        *proto = '\0';
        host = proto + 3;
    } else {
        host = url_copy;
    }
    
    // Parse host and path
    path = strchr(host, '/');
    if (path) {
        *path = '\0';
        path++;
    } else {
        path = "/";
    }
    
    // Parse port (if present)
    port_str = strchr(host, ':');
    if (port_str) {
        *port_str = '\0';
        config->port = atoi(port_str + 1);
    } else {
        config->port = 80; // Default HTTP port
    }
    
    // Parse auth token (if present in URL as query parameter)
    auth = strstr(url, "token=");
    if (auth) {
        auth += 6; // Skip "token="
        strncpy(config->auth_token, auth, MAX_URL_LENGTH - 1);
        // Remove any query parameters after token
        char *query = strchr(config->auth_token, '&');
        if (query) *query = '\0';
    } else {
        config->auth_token[0] = '\0';
    }
    
    strncpy(config->host, host, MAX_URL_LENGTH - 1);
    strncpy(config->path, path, MAX_URL_LENGTH - 1);
    config->timeout = 30; // Default timeout
    config->verbose = 0;
    
    return 0;
}

int connect_to_server(const char *host, int port) {
    struct sockaddr_in serv_addr;
    struct hostent *server;
    int sockfd;
    
    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) {
        log_message(LOG_ERROR, "ERROR opening socket: %s", strerror(errno));
        return -1;
    }
    
    server = gethostbyname(host);
    if (server == NULL) {
        log_message(LOG_ERROR, "ERROR, no such host: %s", host);
        close(sockfd);
        return -1;
    }
    
    memset(&serv_addr, 0, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    bcopy((char *)server->h_addr,
          (char *)&serv_addr.sin_addr.s_addr,
          server->h_length);
    serv_addr.sin_port = htons(port);
    
    if (connect(sockfd, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) < 0) {
        log_message(LOG_ERROR, "ERROR connecting: %s", strerror(errno));
        close(sockfd);
        return -1;
    }
    
    return sockfd;
}

int send_http_request(int sockfd, const char *method, const char *host, const char *path, 
                      const char *auth_token, const char *body, int body_length) {
    char request[BUFFER_SIZE * 4];
    int request_len;
    int bytes_sent;
    int total_sent = 0;
    
    if (auth_token && auth_token[0] != '\0') {
        request_len = snprintf(request, sizeof(request),
            "%s %s HTTP/1.1\r\n"
            "Host: %s\r\n"
            "Authorization: Bearer %s\r\n"
            "Content-Type: application/json\r\n"
            "Content-Length: %d\r\n"
            "Connection: close\r\n"
            "\r\n"
            "%s",
            method, path, host, auth_token, body_length, body ? body : "");
    } else {
        request_len = snprintf(request, sizeof(request),
            "%s %s HTTP/1.1\r\n"
            "Host: %s\r\n"
            "Content-Type: application/json\r\n"
            "Content-Length: %d\r\n"
            "Connection: close\r\n"
            "\r\n"
            "%s",
            method, path, host, body_length, body ? body : "");
    }
    
    if (request_len < 0 || request_len >= sizeof(request)) {
        log_message(LOG_ERROR, "Request buffer overflow");
        return -1;
    }
    
    // Send request in chunks
    while (total_sent < request_len) {
        bytes_sent = send(sockfd, request + total_sent, request_len - total_sent, 0);
        if (bytes_sent < 0) {
            log_message(LOG_ERROR, "ERROR sending request: %s", strerror(errno));
            return -1;
        }
        total_sent += bytes_sent;
    }
    
    log_message(LOG_INFO, "HTTP request sent successfully");
    return 0;
}

char *read_http_response(int sockfd, int *status_code) {
    char buffer[BUFFER_SIZE * 8];
    int bytes_read;
    int total_read = 0;
    char *response;
    char *status_line;
    char *code_str;
    
    memset(buffer, 0, sizeof(buffer));
    
    // Read response headers and body
    while ((bytes_read = recv(sockfd, buffer + total_read, sizeof(buffer) - total_read - 1, 0)) > 0) {
        total_read += bytes_read;
        buffer[total_read] = '\0';
        
        // Check if we've received the complete response (headers + body)
        if (strstr(buffer, "\r\n\r\n")) {
            break;
        }
    }
    
    if (bytes_read < 0) {
        log_message(LOG_ERROR, "ERROR receiving response: %s", strerror(errno));
        return NULL;
    }
    
    // Extract status code
    status_line = strstr(buffer, "HTTP/");
    if (status_line) {
        code_str = status_line + 9; // Skip "HTTP/1.1 "
        *status_code = atoi(code_str);
    } else {
        *status_code = 0;
    }
    
    // Find body start
    char *body_start = strstr(buffer, "\r\n\r\n");
    if (body_start) {
        body_start += 4; // Skip "\r\n\r\n"
        response = strdup(body_start);
    } else {
        response = strdup(buffer);
    }
    
    return response;
}

int transfer_file_local(const char *src_path, const char *dst_path) {
    FILE *src_file, *dst_file;
    char buffer[BUFFER_SIZE];
    size_t bytes_read, bytes_written;
    
    src_file = fopen(src_path, "rb");
    if (src_file == NULL) {
        log_message(LOG_ERROR, "Cannot open source file: %s", src_path);
        return -1;
    }
    
    dst_file = fopen(dst_path, "wb");
    if (dst_file == NULL) {
        log_message(LOG_ERROR, "Cannot open destination file: %s", dst_path);
        fclose(src_file);
        return -1;
    }
    
    while ((bytes_read = fread(buffer, 1, BUFFER_SIZE, src_file)) > 0) {
        bytes_written = fwrite(buffer, 1, bytes_read, dst_file);
        if (bytes_written != bytes_read) {
            log_message(LOG_ERROR, "Error writing to destination file");
            fclose(src_file);
            fclose(dst_file);
            return -1;
        }
    }
    
    fclose(src_file);
    fclose(dst_file);
    log_message(LOG_INFO, "File transfer completed: %s -> %s", src_path, dst_path);
    return 0;
}

int api_interaction(const char *url, const char *method, const char *payload) {
    struct TransferConfig config;
    int sockfd;
    char *response;
    int status_code;
    int result = -1;
    
    if (parse_url(url, &config) != 0) {
        return -1;
    }
    
    log_message(LOG_INFO, "Connecting to %s:%d", config.host, config.port);
    sockfd = connect_to_server(config.host, config.port);
    if (sockfd < 0) {
        return -1;
    }
    
    log_message(LOG_INFO, "Sending %s request to %s", method, config.path);
    if (send_http_request(sockfd, method, config.host, config.path, 
                         config.auth_token, payload, payload ? strlen(payload) : 0) != 0) {
        close(sockfd);
        return -1;
    }
    
    response = read_http_response(sockfd, &status_code);
    if (response == NULL) {
        close(sockfd);
        return -1;
    }
    
    log_message(LOG_INFO, "HTTP Response Status: %d", status_code);
    log_message(LOG_INFO, "Response Body: %s", response);
    
    if (status_code >= 200 && status_code < 300) {
        result = 0; // Success
    }
    
    free(response);
    close(sockfd);
    return result;
}

int main(int argc, char *argv[]) {
    int i;
    
    if (argc < 2) {
        printf("GNU E Data Transfer & API Interaction Script\n");
        printf("Usage:\n");
        printf("  %s <local_file> <destination_path>\n", argv[0]);
        printf("  %s <api_url> [method] [payload]\n", argv[0]);
        printf("\nExamples:\n");
        printf("  %s data.txt /backup/data.txt\n", argv[0]);
        printf("  %s https://api.example.com/upload POST '{\"file\":\"data.txt\"}'\n", argv[0]);
        printf("  %s https://api.example.com/data GET\n", argv[0]);
        return 1;
    }
    
    // Detect if this is a local file transfer or API call
    if (strstr(argv[1], "://")) {
        // API interaction
        const char *method = "GET";
        const char *payload = NULL;
        
        if (argc >= 3) {
            method = argv[2];
        }
        if (argc >= 4) {
            payload = argv[3];
        }
        
        return api_interaction(argv[1], method, payload);
    } else {
        // Local file transfer
        if (argc < 3) {
            log_message(LOG_ERROR, "Local transfer requires source and destination paths");
            return 1;
        }
        return transfer_file_local(argv[1], argv[2]);
    }
    
    return 0;
}
