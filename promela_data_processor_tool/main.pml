/*
 * Promela Data Processing Tool
 * 
 * This model defines a concurrent data processing pipeline.
 * It simulates data ingestion, processing, and validation.
 * 
 * Usage: spin -a main.pml && gcc -o pan pan.c && ./pan
 */

/* Define data structure */
def MAX_DATA_SIZE = 100;
def NUM_SOURCES = 3;

byte data[100];
int data_count = 0;
int processed_count = 0;

/* Channels for communication */
cchannel ingestion = [0] of { byte, byte, byte };
cchannel processing = [0] of { byte, byte, byte };
cchannel validation = [0] of { byte, byte, byte };
cchannel output_channel = [0] of { byte, byte, byte };

/* Process: Data Source */
proctype source(id) {
    byte d1, d2, d3;
    
    /* Simulate generating data */
    d1 = id;
    d2 = 255 - id;
    d3 = id * 2;
    
    /* Send data to ingestion channel */
    printf("Source %d: Sending data (%d, %d, %d)\\n", id, d1, d2, d3);
    ingestion ! d1, d2, d3;
    
    /* Mark source as done */
    atomic {
        data_count++;
    }
}

/* Process: Data Ingestion */
proctype ingester() {
    byte d1, d2, d3;
    
    /* Wait for data from sources */
    do
    :: ingestion ? d1, d2, d3 ->
        printf("Ingestion: Received (%d, %d, %d)\\n", d1, d2, d3);
        processing ! d1, d2, d3;
    :: data_count == NUM_SOURCES ->
        break;
    od;
    
    /* Signal that ingestion is complete */
    printf("Ingestion Complete.\\n");
}

/* Process: Data Processing */
proctype processor() {
    byte d1, d2, d3;
    byte transformed1, transformed2, transformed3;
    
    /* Process data: simple transformation logic */
    do
    :: processing ? d1, d2, d3 ->
        /* Transform data: e.g., increment or XOR */
        transformed1 = d1 + 1;
        transformed2 = d2 ^ 0x0F;
        transformed3 = d3 * 3;
        
        printf("Processing: Transformed to (%d, %d, %d)\\n", transformed1, transformed2, transformed3);
        validation ! transformed1, transformed2, transformed3;
        processed_count++;
    :: processed_count == NUM_SOURCES ->
        break;
    od;
    
    printf("Processing Complete.\\n");
}

/* Process: Data Validation */
proctype validator() {
    byte d1, d2, d3;
    byte valid;
    
    /* Validate data: e.g., check for even sums or specific patterns */
    do
    :: validation ? d1, d2, d3 ->
        if
        :: (d1 + d2 + d3) % 2 == 0 ->
            valid = 1;
            printf("Validation: Record (%d, %d, %d) is VALID\\n", d1, d2, d3);
        :: else ->
            valid = 0;
            printf("Validation: Record (%d, d1, d2, d3) is INVALID\\n", d1, d2, d3);
        fi;
        
        /* Send to output with validity flag (simplified as sending anyway for this model) */
        output_channel ! d1, d2, d3;
        processed_count--; /* Decrement processing count to allow exit if we tracked differently, but here we use explicit break */
    od;
}

/* Process: Data Output */
proctype output_writer() {
    byte d1, d2, d3;
    
    do
    :: output_channel ? d1, d2, d3 ->
        printf("Output: Wrote record (%d, %d, %d)\\n", d1, d2, d3);
    od;
}

/* Main Process */
init {
    run source(1);
    run source(2);
    run source(3);
    run ingester();
    run processor();
    run validator();
    run output_writer();
    
    /* Terminate when all sources are done and output is written */
    assert(data_count == NUM_SOURCES && processed_count == 0);
    printf("Data Processing Pipeline Complete.\\n");
    halt;
}
