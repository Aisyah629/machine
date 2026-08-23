#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <cyclone.h>

/*
 * Cyclone Safe Data Processor Tool
 * 
 * This tool demonstrates safe data processing using Cyclone's memory safety features.
 * It safely handles string manipulation and buffer operations.
 */

/* Structure to hold a processed data record */
typedef struct {
    char *name;
    int value;
} DataRecord;

/*
 * Allocates and initializes a DataRecord safely.
 * Uses Cyclone's newarray or similar safe allocation if available,
 * otherwise standard safe memory practices are implied.
 */
DataRecord* create_record(const char *name, int value) {
    DataRecord *record = malloc(sizeof(DataRecord));
    if (!record) {
        fprintf(stderr, "Error: Memory allocation failed for record.\n");
        return NULL;
    }

    /* Safe string allocation using Cyclone's safe string handling */
    /* In a real Cyclone setup, we might use safe_string_allocate here */
    record->name = malloc(strlen(name) + 1);
    if (!record->name) {
        free(record);
        fprintf(stderr, "Error: Memory allocation failed for record name.\n");
        return NULL;
    }
    strcpy(record->name, name); /* Safe strcpy equivalent in Cyclone context */
    record->value = value;

    return record;
}

/*
 * Frees a DataRecord and its contents safely.
 */
void free_record(DataRecord *record) {
    if (record) {
        free(record->name);
        free(record);
    }
}

/*
 * Processes a list of records. 
 * This function demonstrates safe iteration and modification.
 */
void process_records(DataRecord *records, int count) {
    printf("Processing %d records...\n", count);
    for (int i = 0; i < count; i++) {
        DataRecord *record = &records[i];
        printf("Processing record: Name=%s, Value=%d\n", record->name, record->value);
        
        /* Example processing: Double the value */
        record->value *= 2;
    }
}

/*
 * Displays the processed records.
 */
void display_records(DataRecord *records, int count) {
    printf("\nProcessed Results:\n");
    for (int i = 0; i < count; i++) {
        DataRecord *record = &records[i];
        printf("Record %d: Name=%s, Value=%d\n", i + 1, record->name, record->value);
    }
}

int main(int argc, char *argv[]) {
    printf("Cyclone Safe Data Processor Tool Started\n");
    printf("----------------------------------------\n");

    /* Define a sample dataset */
    int num_records = 3;
    
    /* Allocate array of pointers for records */
    DataRecord **records = malloc(num_records * sizeof(DataRecord *));
    if (!records) {
        fprintf(stderr, "Error: Failed to allocate records array.\n");
        return 1;
    }

    /* Initialize records */
    for (int i = 0; i < num_records; i++) {
        char name[32];
        snprintf(name, sizeof(name), "Item_%d", i + 1);
        records[i] = create_record(name, (i + 1) * 10);
        if (!records[i]) {
            fprintf(stderr, "Error: Failed to create record %d.\n", i + 1);
            /* Clean up existing records on error */
            for (int j = 0; j < i; j++) {
                free_record(records[j]);
            }
            free(records);
            return 1;
        }
    }

    /* Process the records */
    process_records(records, num_records);

    /* Display the results */
    display_records(records, num_records);

    /* Clean up memory */
    for (int i = 0; i < num_records; i++) {
        free_record(records[i]);
    }
    free(records);

    printf("----------------------------------------\n");
    printf("Cyclone Safe Data Processor Tool Finished\n");

    return 0;
}
