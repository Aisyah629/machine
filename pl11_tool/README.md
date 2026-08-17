# PL-11 Data Transformation Tool

## Overview
This tool is a robust data transformation engine built strictly using the PL-11 programming language. It is designed to handle structured file processing, data manipulation, and comprehensive error handling, mimicking the capabilities of classic mainframe-oriented data processing utilities.

## Features
- **Structured File Processing**: Reads, parses, and writes fixed-length and variable-length records.
- **Data Transformation**: Converts data formats, performs calculations, and maps fields.
- **Error Handling**: Graceful handling of invalid records, file I/O errors, and processing exceptions.
- **Configuration Driven**: Supports external configuration for field definitions and transformation rules.

## Usage
1. Place your input data files in the `input` directory.
2. Configure the transformation rules in `config.json`.
3. Run the tool using the main entry point `main.pl11`.

## Code Structure
- `main.pl11`: Main entry point and core logic.
- `processor.pl11`: Data parsing and transformation routines.
- `error_handler.pl11`: Error logging and recovery mechanisms.

## Building
Compile the PL-11 source files using the standard PL-11 compiler:
```bash
pl11c main.pl11 processor.pl11 error_handler.pl11 -o data_transformer
```

## License
This tool is provided as-is for educational and legacy system integration purposes.
