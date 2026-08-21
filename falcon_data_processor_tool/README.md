# Falcon Data Processor Tool

A robust data processing utility written in Falcon. It supports loading data from local files or URLs, applying basic filters, processing data structures, and saving the output in JSON format.

## Features

- **Data Loading**: Supports JSON files (local) and JSON APIs (URLs).
- **Data Processing**: Extensible architecture for data transformation (currently includes deep cloning and basic normalization placeholder).
- **Filtering**: Placeholder for filter expression application.
- **Output**: Saves processed data to local files in JSON format.
- **Error Handling**: Comprehensive error handling for network and file I/O operations.

## Prerequisites

- **Falcon Language Compiler**: Ensure Falcon is installed on your system.
- **Network Access**: Required if processing data from URLs.

## Usage

### Command Line Interface

```bash
falcon main.fal [input_file] [output_file] [filter_expression]
```

- `input_file` (Optional): Path to the input JSON file or URL. Defaults to `input.json`.
- `output_file` (Optional): Path to the output JSON file. Defaults to `output.json`.
- `filter_expression` (Optional): String representing the filter to apply. Defaults to `all` (no filtering).

### Example

1. Create a sample input file `input.json`:
   ```json
   {
     "users": [
       { "name": "Alice", "age": 30 },
       { "name": "Bob", "age": 25 }
     ]
   }
   ```

2. Run the tool:
   ```bash
   falcon main.fal input.json output.json
   ```

3. Check `output.json` for the processed data.

## Code Structure

- `main.fal`: Contains the core logic, including `Config`, `DataProcessor` classes, and the `main` function.

## Limitations

- The filtering logic is currently a placeholder and needs implementation for complex expressions.
- JSON is the only supported output format.

## License

MIT License
