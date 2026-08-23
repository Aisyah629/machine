/*
 * Chomski Data Processing Tool
 * Main entry point for data processing operations.
 */

import std.io;
import std.parser;
import std.transform;

// Define data structure for records
type Record = {
  id: int,
  name: string,
  value: float
};

// Parse input data from a string or file
function parse_data(input_string: string) -> List<Record> {
  var records = List<Record>();
  var lines = input_string.split('\n');
  
  for (var line in lines) {
    if (line.empty()) continue;
    
    var parts = line.split(',');
    if (parts.length != 3) {
      io.stderr.println("Error: Invalid line format: " + line);
      continue;
    }
    
    var id = int.parse(parts[0]);
    var name = parts[1];
    var value = float.parse(parts[2]);
    
    var record = Record { id: id, name: name, value: value };
    records.add(record);
  }
  
  return records;
}

// Process the parsed data
function process_records(records: List<Record>) -> List<Record> {
  var processed = List<Record>();
  
  for (var record in records) {
    // Example transformation: double the value
    var new_value = record.value * 2.0;
    var processed_record = Record {
      id: record.id,
      name: record.name,
      value: new_value
    };
    processed.add(processed_record);
  }
  
  return processed;
}

// Output the processed data
function output_data(records: List<Record>) {
  for (var record in records) {
    io.stdout.println(record.id + "," + record.name + "," + record.value);
  }
}

// Main function
function main() {
  var input = "";
  
  // Read from stdin if available, otherwise use default test data
  if (!io.stdin.is_empty()) {
    input = io.stdin.read_all();
  } else {
    input = "1,Alice,10.5\n2,Bob,20.0\n3,Charlie,15.7";
  }
  
  var records = parse_data(input);
  var processed = process_records(records);
  output_data(processed);
}
