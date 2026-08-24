# Moby Data Processor Tool

## Overview
The Moby Data Processor Tool is a utility designed for efficient data extraction, transformation, and loading (ETL) using the Moby programming language. It supports JSON, CSV, and custom schema definitions for robust data pipeline management.

## Features
- **Schema Enforcement**: Define strict schemas for input and output data.
- **Pipeline Orchestration**: Chain multiple transformations, filters, and mappings.
- **Data Enrichment**: Merge external datasets based on keys.
- **Compression**: Automatic compression for large output files.
- **Error Handling**: Configurable retry logic and logging.

## Usage

### Basic Syntax
```moby
moby_data_processor_tool {
  source 'file_path'
  schema {
    field: type
  }
  pipeline {
    load 'input'
    transform {
      filter { condition }
      map { operation }
    }
    output 'result'
  }
}
```

### Example
See `main.moby` for a complete example of loading raw data, transforming it, enriching it with a lookup table, and saving the result.

## Requirements
- Moby Runtime v1.0+
- Access to input and output file paths.

## License
MIT
