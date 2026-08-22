import * as fs from 'fs';
import * as path from 'path';

/**
 * ES Data Pipeline Tool
 * 
 * This script demonstrates a basic data processing pipeline using the ES language.
 * It reads data from a source, processes it, and writes the output to a destination.
 */

interface DataRecord {
    id: number;
    value: string;
    timestamp: Date;
}

class DataPipeline {
    private sourcePath: string;
    private destinationPath: string;
    private records: DataRecord[] = [];

    constructor(sourcePath: string, destinationPath: string) {
        this.sourcePath = sourcePath;
        this.destinationPath = destinationPath;
    }

    /**
     * Ingests data from the source file.
     */
    ingestData(): void {
        console.log(`Ingesting data from ${this.sourcePath}...`);
        try {
            const data = fs.readFileSync(this.sourcePath, 'utf-8');
            this.records = JSON.parse(data) as DataRecord[];
            console.log(`Successfully ingested ${this.records.length} records.`);
        } catch (error) {
            console.error('Error ingesting data:', error);
            process.exit(1);
        }
    }

    /**
     * Processes the ingested data.
     */
    processData(): void {
        console.log('Processing data...');
        // Example transformation: Add a processed field
        this.records.forEach(record => {
            record.value = record.value.toUpperCase();
        });
        console.log('Data processing complete.');
    }

    /**
     * Writes the processed data to the destination file.
     */
    writeData(): void {
        console.log(`Writing data to ${this.destinationPath}...`);
        try {
            const output = JSON.stringify(this.records, null, 2);
            fs.writeFileSync(this.destinationPath, output, 'utf-8');
            console.log('Data written successfully.');
        } catch (error) {
            console.error('Error writing data:', error);
            process.exit(1);
        }
    }

    /**
     * Runs the entire pipeline.
     */
    run(): void {
        this.ingestData();
        this.processData();
        this.writeData();
    }
}

// Example usage
const sourcePath = path.join(__dirname, 'input.json');
const destinationPath = path.join(__dirname, 'output.json');

// Create a sample input file if it doesn't exist
if (!fs.existsSync(sourcePath)) {
    const sampleData: DataRecord[] = [
        { id: 1, value: 'hello', timestamp: new Date() },
        { id: 2, value: 'world', timestamp: new Date() }
    ];
    fs.writeFileSync(sourcePath, JSON.stringify(sampleData, null, 2), 'utf-8');
    console.log('Sample input file created.');
}

const pipeline = new DataPipeline(sourcePath, destinationPath);
pipeline.run();
