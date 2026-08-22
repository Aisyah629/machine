/*
 * TADS Data Processor Tool
 * main.t
 * 
 * A utility for parsing and transforming structured text data using TADS.
 * This script demonstrates OOP concepts in TADS applied to data engineering tasks.
 */

#include <stdio.h>
#include <tads.h>
#include <stdlib.h>

/*
 * DataRecord Class
 * Represents a single row or entry in the dataset.
 */
class DataRecord
    name: string
    category: string
    value: number
    timestamp: string
    ;

    constructor(nm, cat, val, ts)
    {
        name = nm;
        category = cat;
        value = val;
        timestamp = ts;
    }

    /* Display the record in a standardized format */
    toString()
    {
        return "[" + timestamp + "] " + category + ": " + name + " = " + value;
    }
;

/*
 * DataProcessor Class
 * Manages the collection of records and provides processing methods.
 */
class DataProcessor
    records: list
    filterCategory: string
    ;

    constructor()
    {
        records = [];
        filterCategory = nil;
    }

    /*
     * parseLine
     * Parses a single line of comma-separated data.
     * Expected format: Name,Category,Value,Timestamp
     */
    parseLine(line)
    {
        local fields = line.split(",");
        local name, category, value, timestamp;

        if (fields.length < 4)
            return nil; // Invalid line

        name = fields[0].trim();
        category = fields[1].trim();
        value = strtoi(fields[2].trim());
        timestamp = fields[3].trim();

        return DataRecord.new(name, category, value, timestamp);
    }

    /*
     * loadFromText
     * Loads data from a text string (simulating file read).
     */
    loadFromText(text)
    {
        local lines = text.split("\n");
        local record;

        for (local i = 1; i <= lines.length; i++)
        {
            local line = lines[i].trim();
            if (line.length > 0 && !line.startsWith("#"))
            {
                record = parseLine(line);
                if (record != nil)
                {
                    records.add(record);
                }
            }
        }
        return records.length;
    }

    /*
     * filterByCategory
     * Filters the internal records based on a specific category.
     */
    filterByCategory(cat)
    {
        local result = [];
        for (local i = 1; i <= records.length; i++)
        {
            if (records[i].category == cat)
            {
                result.add(records[i]);
            }
        }
        return result;
    }

    /*
     * calculateAverageValue
     * Calculates the average value of all records (or filtered records if provided).
     */
    calculateAverageValue(filteredList)
    {
        local sum = 0;
        local count = 0;
        local sourceList = filteredList != nil ? filteredList : records;

        for (local i = 1; i <= sourceList.length; i++)
        {
            sum += sourceList[i].value;
            count++;
        }

        if (count == 0)
            return 0;

        return sum / count;
    }

    /*
     * generateReport
     * Generates a textual report of the current state of data.
     */
    generateReport()
    {
        local report = "=== Data Processing Report ===\n";
        report += "Total Records Loaded: " + records.length + "\n\n";

        // Summary by category
        local categories = [];
        for (local i = 1; i <= records.length; i++)
        {
            local cat = records[i].category;
            if (categories.indexOf(cat) == -1)
                categories.add(cat);
        }

        report += "Categories Found: " + categories.join(", ") + "\n";
        report += "Overall Average Value: " + calculateAverageValue() + "\n\n";

        report += "--- Raw Data ---\n";
        for (local i = 1; i <= records.length; i++)
        {
            report += records[i].toString() + "\n";
        }

        return report;
    }
;

/*
 * Main Execution Block
 */
main(args)
{
    local processor = DataProcessor.new();

    /*
     * Simulated Input Data
     * In a real-world scenario, this would be read from a file argument or stdin.
     */
    local sampleData = 
        "SensorA,Temp,24.5,2023-10-27T10:00:00Z,\n" +
        "SensorB,Humidity,65.2,2023-10-27T10:00:00Z,\n" +
        "SensorA,Temp,24.8,2023-10-27T10:05:00Z,\n" +
        "SensorC,Pressure,1013.25,2023-10-27T10:00:00Z,\n" +
        "SensorB,Humidity,64.9,2023-10-27T10:05:00Z,\n";

    print("Initializing TADS Data Processor Tool...\n\n");

    local count = processor.loadFromText(sampleData);
    print("Loaded " + count + " records.\n\n");

    // Example: Filter by category
    local tempRecords = processor.filterByCategory("Temp");
    print("Filtered 'Temp' records: " + tempRecords.length + "\n");
    for (local i = 1; i <= tempRecords.length; i++)
    {
        print("   " + tempRecords[i].toString() + "\n");
    }
    print("Average Temperature: " + processor.calculateAverageValue(tempRecords) + "\n\n");

    // Generate full report
    print(processor.generateReport());

    return 0;
}
