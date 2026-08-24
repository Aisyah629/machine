/*
 * XMOS Architecture Data Processor Tool
 * 
 * This module demonstrates a parallel data processing pipeline
 * using XMOS XCORE architecture with XC programming language.
 * It uses multiple tiles and cores to handle data ingestion,
 * processing, and output streams concurrently.
 */

#include <xs1.h>
#include <stream.h>
#include <platform.h>
#include <print.h>

/* 
 * Define data structure for processed records
 */
struct data_record {
    unsigned int id;
    float value;
    unsigned char flags;
};

/*
 * Define channel types for communication between tiles/cores
 */
chan c_ingress;
chan c_processed;

/*
 * Core 0: Data Ingestion & Pre-processing
 * Simulates receiving raw data from an external source
 */
task void ingestion_task(chanend c_out) {
    unsigned int packet_count = 0;
    struct data_record record;
    
    while (1) {
        // Simulate receiving data from a stream
        // In a real implementation, this would read from a serial port or network interface
        record.id = packet_count++;
        record.value = (float)packet_count * 1.5;
        record.flags = 0;
        
        // Send processed record downstream
        outstream(c_out, record);
        
        // Small delay to simulate timing
        timer t;
        t :> time_t next_time;
        next_time = t now() + 100000;
        t atnext next_time :> void;
    }
}

/*
 * Core 1: Data Transformation & Filtering
 * Applies business logic to incoming data
 */
void transformation_task(chanend c_in, chanend c_out) {
    struct data_record input_record;
    struct data_record output_record;
    
    while (1) {
        // Receive record from ingestion core
        instream(c_in, input_record);
        
        // Apply transformation logic
        output_record.id = input_record.id;
        output_record.value = input_record.value * 2.0; // Example transformation
        output_record.flags = input_record.flags | 0x01; // Mark as processed
        
        // Send to output stream
        outstream(c_out, output_record);
    }
}

/*
 * Core 2: Output & Monitoring
 * Handles the final output and monitoring of the pipeline
 */
void output_task(chanend c_in) {
    struct data_record record;
    
    while (1) {
        instream(c_in, record);
        
        // In a real implementation, this would send data to a display, storage, or network
        // For demonstration, we just verify the data integrity
        if (record.value < 0.0) {
            // Error handling for invalid data
            printerror("Invalid data detected at record %u\n", record.id);
        } else {
            // Success logging
            // printstring("Processed record ");
            // printhex(record.id);
            // printstring(" with value ");
            // printfloat(record.value);
            // println();
        }
    }
}

/*
 * Main entry point
 */
int main() {
    // Declare channels for internal communication
    chan c_ingress_to_transform;
    chan c_transform_to_output;
    
    // Launch parallel tasks on available cores
    par {
        // Ingestion task runs on first available core
        task ingestion_task(c_ingress_to_transform);
        
        // Transformation task runs on second available core
        transformation_task(c_ingress_to_transform, c_transform_to_output);
        
        // Output task runs on third available core
        output_task(c_transform_to_output);
    }
    
    return 0;
}
