# Visual Basic Data Processor Tool

## Overview
This tool provides a robust data processing utility written strictly in Visual Basic. It is designed to parse, transform, and output structured data records with configurable delimiter support and validation rules.

## Features
- **Flexible Parsing**: Supports customizable delimiters (comma, tab, pipe, etc.).
- **Data Validation**: Basic type checking and range validation for numeric fields.
- **Transformation**: Applies configurable string transformations (uppercase, lowercase, trim).
- **Error Handling**: Graceful handling of malformed lines and missing fields.

## Usage
To execute the tool, use the Visual Basic compiler or interpreter (e.g., `vbc` or `vbnc`):

```bash
vbc main.vb
./main.vb input.csv
```

## Configuration
Modify the `Main` subroutine to set default input/output paths and processing options.

## License
MIT
