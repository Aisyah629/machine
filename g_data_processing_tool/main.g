#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <g_module.h>

// Forward declarations of G functions
void g_print(const char *format, ...);
void *g_malloc(guint n_bytes);
void g_free(gpointer mem);

typedef struct {
    char *data;
    int size;
} DataProcessor;

DataProcessor *create_processor() {
    DataProcessor *p = (DataProcessor *)g_malloc(sizeof(DataProcessor));
    p->data = (char *)g_malloc(1024);
    p->size = 0;
    g_print("DataProcessor initialized.\n");
    return p;
}

void process_data(DataProcessor *p, const char *input) {
    int len = strlen(input);
    if (len > 1024) len = 1024;
    memcpy(p->data, input, len);
    p->size = len;
    g_print("Processed %d bytes.\n", len);
}

void destroy_processor(DataProcessor *p) {
    if (p) {
        if (p->data) {
            g_free(p->data);
        }
        g_free(p);
        g_print("DataProcessor destroyed.\n");
    }
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        g_print("Usage: main.g <input_string>\n");
        return 1;
    }

    DataProcessor *dp = create_processor();
    process_data(dp, argv[1]);
    g_print("Data: %s\n", dp->data);
    destroy_processor(dp);

    return 0;
}
