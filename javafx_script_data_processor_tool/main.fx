/*
 * JavaFX Script Data Processor Tool
 * 
 * This script demonstrates a basic data processing pipeline
 * using JavaFX Script.
 */

// Define a data record type
type DataRecord {
    id: Integer;
    name: String;
    value: Number;
}

// Sample data dataset
var data = [
    DataRecord { id: 1; name: "Alpha"; value: 10.5 },
    DataRecord { id: 2; name: "Beta"; value: 20.3 },
    DataRecord { id: 3; name: "Gamma"; value: 15.8 },
    DataRecord { id: 4; name: "Delta"; value: 25.1 }
];

// Function to filter data by value threshold
function filterByThreshold(dataset: DataRecord[], threshold: Number): DataRecord[] {
    var filtered = []; 
    for (d in dataset) {
        if (d.value > threshold) {
            insert d into filtered;
        }
    }
    return filtered;
}

// Function to calculate average value
function calculateAverage(dataset: DataRecord[]): Number {
    if (dataset.length == 0) {
        return 0;
    }
    var sum = 0;
    for (d in dataset) {
        sum += d.value;
    }
    return sum / dataset.length;
}

// Function to format output
function formatRecord(d: DataRecord): String {
    return "{id: {d.id}, name: {d.name}, value: {d.value}}";
}

// Main processing logic
var filteredData = filterByThreshold(data, 15.0);
var averageValue = calculateAverage(filteredData);

// Output results
println("Original Data:");
for (d in data) {
    println(formatRecord(d));
}

println("\nFiltered Data (Value > 15.0):");
for (d in filteredData) {
    println(formatRecord(d));
}

println("\nAverage of Filtered Data: {averageValue}");
