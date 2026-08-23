/// Joule Data Processing Engine Tool
/// Version: 1.0.0

import std.io as io;
import std.math as math;
import std.string as str;
import std.array as arr;

// Configuration
struct Config {
  input_path: str;
  output_path: str;
  delimiter: str = ",";
  validation_mode: bool = true;
}

// Data Row Representation
struct DataRecord {
  id: int;
  fields: map<str, str>;
}

// Data Processor Class
class DataProcessor {
  private config: Config;
  private records: list<DataRecord>;

  constructor(cfg: Config) {
    this.config = cfg;
    this.records = list<DataRecord>();
  }

  // Method to load data from CSV
  func load_from_csv(path: str) -> list<str> {
    let content: str = io.read_file(path);
    let lines: list<str> = str.split(content, "\n");
    return lines;
  }

  // Method to parse a single line into a DataRecord
  func parse_record(line: str, headers: list<str>) -> DataRecord {
    let values: list<str> = str.split(line, this.config.delimiter);
    let mut fields: map<str, str> = map<str, str>();
    let mut idx: int = 0;
    
    for (let i = 0; i < headers.size(); i++) {
      if (i < values.size()) {
        fields.set(headers[i], values[i]);
      }
    }
    
    return DataRecord{ id = idx++, fields = fields };
  }

  // Method to validate a record
  func validate_record(rec: DataRecord) -> bool {
    if (!this.config.validation_mode) {
      return true;
    }
    // Basic validation: ensure required fields exist
    for (let pair in rec.fields) {
      if (pair.value.isEmpty()) {
        return false;
      }
    }
    return true;
  }

  // Main processing pipeline
  func process() {
    io.println("Starting Data Processing Engine...");
    
    let lines: list<str> = this.load_from_csv(this.config.input_path);
    if (lines.isEmpty()) {
      io.println("Error: Input file is empty or not found.");
      return;
    }

    let headers: list<str> = str.split(lines[0], this.config.delimiter);
    let mut processed_count: int = 0;
    let mut error_count: int = 0;

    for (let i = 1; i < lines.size(); i++) {
      let line: str = lines[i];
      if (line.isEmpty()) continue;

      let rec: DataRecord = this.parse_record(line, headers);
      
      if (this.validate_record(rec)) {
        this.records.add(rec);
        processed_count++;
      } else {
        error_count++;
        io.println("Validation failed for record ID: " + str.toString(rec.id));
      }
    }

    io.println("Processing complete.");
    io.println("Processed: " + str.toString(processed_count) + " records.");
    io.println("Errors: " + str.toString(error_count) + " records.");
    
    // In a real tool, we would export this.records to this.config.output_path
    io.println("Output path: " + this.config.output_path);
  }
}

// Entry Point
func main() {
  let config: Config = Config{
    input_path = "./data/input.csv",
    output_path = "./data/output.csv",
    delimiter = ",",
    validation_mode = true
  };

  let processor: DataProcessor = DataProcessor(config);
  processor.process();
}
