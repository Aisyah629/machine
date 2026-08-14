#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <getopt.h>
#include <sys/stat.h>
#include <errno.h>

#define MAX_CONFIG_LINES 1024
#define MAX_ENTRY_LEN 256

typedef struct {
    char key[MAX_ENTRY_LEN];
    char value[MAX_ENTRY_LEN];
    int active;
} ConfigEntry;

typedef struct {
    ConfigEntry entries[MAX_CONFIG_LINES];
    int count;
} ConfigStore;

void print_usage(const char *program) {
    printf("Usage: %s [OPTIONS] <config_file>\n", program);
    printf("Options:\n");
    printf("  -h, --help          Show this help message\n");
    printf("  -p, --parse         Parse the config file and display entries\n");
    printf("  -s, --set KEY=VAL   Set a configuration value\n");
    printf("  -d, --delete KEY    Delete a configuration key\n");
    printf("  -l, --list          List all active configuration entries\n");
}

int parse_config(ConfigStore *store, const char *filepath) {
    FILE *fp = fopen(filepath, "r");
    if (!fp) {
        fprintf(stderr, "Error: Cannot open file '%s': %s\n", filepath, strerror(errno));
        return -1;
    }

    char line[MAX_ENTRY_LEN * 2];
    while (fgets(line, sizeof(line), fp) && store->count < MAX_CONFIG_LINES) {
        // Remove trailing newline
        line[strcspn(line, "\n")] = 0;

        // Skip empty lines and comments
        if (line[0] == '\0' || line[0] == '#' || line[0] == ';') continue;

        char *eq = strchr(line, '=');
        if (!eq) continue;

        *eq = '\0';
        strncpy(store->entries[store->count].key, line, MAX_ENTRY_LEN - 1);
        strncpy(store->entries[store->count].value, eq + 1, MAX_ENTRY_LEN - 1);
        store->entries[store->count].active = 1;
        store->count++;
    }

    fclose(fp);
    return 0;
}

int save_config(ConfigStore *store, const char *filepath) {
    FILE *fp = fopen(filepath, "w");
    if (!fp) {
        fprintf(stderr, "Error: Cannot write to file '%s': %s\n", filepath, strerror(errno));
        return -1;
    }

    for (int i = 0; i < store->count; i++) {
        if (store->entries[i].active) {
            fprintf(fp, "%s=%s\n", store->entries[i].key, store->entries[i].value);
        }
    }

    fclose(fp);
    return 0;
}

int list_config(ConfigStore *store) {
    if (store->count == 0) {
        printf("No configuration entries found.\n");
        return 0;
    }
    for (int i = 0; i < store->count; i++) {
        if (store->entries[i].active) {
            printf("%s = %s\n", store->entries[i].key, store->entries[i].value);
        }
    }
    return 0;
}

int set_config(ConfigStore *store, const char *key, const char *value) {
    for (int i = 0; i < store->count; i++) {
        if (store->entries[i].active && strcmp(store->entries[i].key, key) == 0) {
            strncpy(store->entries[i].value, value, MAX_ENTRY_LEN - 1);
            return 0;
        }
    }
    if (store->count < MAX_CONFIG_LINES) {
        strncpy(store->entries[store->count].key, key, MAX_ENTRY_LEN - 1);
        strncpy(store->entries[store->count].value, value, MAX_ENTRY_LEN - 1);
        store->entries[store->count].active = 1;
        store->count++;
        return 0;
    }
    return -1;
}

int delete_config(ConfigStore *store, const char *key) {
    for (int i = 0; i < store->count; i++) {
        if (store->entries[i].active && strcmp(store->entries[i].key, key) == 0) {
            store->entries[i].active = 0;
            return 0;
        }
    }
    return -1;
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        print_usage(argv[0]);
        return 1;
    }

    int opt;
    const char *config_file = NULL;
    int parse_only = 0;
    int list_only = 0;
    char *set_key = NULL;
    char *set_val = NULL;
    char *del_key = NULL;

    static struct option long_options[] = {
        {"help",    no_argument,       0,  'h' },
        {"parse",   no_argument,       0,  'p' },
        {"set",     required_argument, 0,  's' },
        {"delete",  required_argument, 0,  'd' },
        {"list",    no_argument,       0,  'l' },
        {0, 0, 0, 0}
    };

    while ((opt = getopt_long(argc, argv, "hps:d:l", long_options, NULL)) != -1) {
        switch (opt) {
            case 'h':
                print_usage(argv[0]);
                return 0;
            case 'p':
                parse_only = 1;
                break;
            case 's':
                set_key = optarg;
                break;
            case 'd':
                del_key = optarg;
                break;
            case 'l':
                list_only = 1;
                break;
            default:
                print_usage(argv[0]);
                return 1;
        }
    }

    if (optind < argc) {
        config_file = argv[optind];
    } else {
        fprintf(stderr, "Error: Configuration file path required.\n");
        print_usage(argv[0]);
        return 1;
    }

    ConfigStore store = {0};

    // Always load existing config first if we are modifying or listing
    if (!parse_only || !config_file) {
        if (config_file) {
            parse_config(&store, config_file);
        } else {
            fprintf(stderr, "Error: Configuration file path required.\n");
            return 1;
        }
    }

    if (parse_only) {
        if (config_file) {
            parse_config(&store, config_file);
            list_config(&store);
        } else {
            fprintf(stderr, "Error: Configuration file path required.\n");
            return 1;
        }
    } else if (set_key) {
        if (!list_only) {
            printf("Setting '%s' to '%s'\n", set_key, optind + 1 < argc ? argv[optind + 1] : "");
            // If -s was used with KEY=VAL format, parse it
            char *eq = strchr(set_key, '=');
            if (eq) {
                *eq = '\0';
                set_config(&store, set_key, eq + 1);
            } else {
                fprintf(stderr, "Error: Use -s KEY=VALUE\n");
                return 1;
            }
        }
        if (config_file) {
            save_config(&store, config_file);
            printf("Configuration saved successfully.\n");
        }
    } else if (del_key) {
        if (delete_config(&store, del_key) == 0) {
            printf("Deleted '%s' successfully.\n", del_key);
        } else {
            printf("Key '%s' not found.\n", del_key);
        }
        if (config_file) {
            save_config(&store, config_file);
            printf("Configuration saved successfully.\n");
        }
    }

    if (list_only) {
        printf("Active Configuration Entries:\n");
        list_config(&store);
    }

    return 0;
}
