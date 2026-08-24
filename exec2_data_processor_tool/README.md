# EXEC 2 Data Processor Utility

## Overview
This tool is a data processing utility written in **EXEC 2**. It is designed to read input data files, perform basic validation and cleaning (trimming whitespace, uppercasing), and filter out specific records (e.g., those containing the word "ERROR"). The processed data is then written to an output file.

## Features
- **File I/O**: Opens and reads from an input file and writes to an output file.
- **Data Cleaning**: Trims trailing spaces from each record.
- **Transformation**: Converts data to uppercase.
- **Filtering**: Excludes lines containing the substring "ERROR".
- **Error Handling**: Checks for file existence and access permissions.

## Configuration
The following variables can be modified in the source code:
- `INPUT_FILE`: Path to the input data file (default: `DATA.IN`).
- `OUTPUT_FILE`: Path to the output file (default: `RESULT.OUT`).
- `BUFFER_SIZE`: Size of the read buffer (default: 1024).

## Usage
1. Ensure the `EXEC 2` interpreter is available in your environment.
2. Modify the `INPUT_FILE` and `OUTPUT_FILE` variables as needed.
3. Place your input file (`DATA.IN`) in the same directory as the script.
4. Execute the script using the EXEC 2 interpreter:
   ```bash
   exec2 main.exec2
   ```

## Output
On successful execution, the tool will print:
```
Processing complete. Records written to RESULT.OUT
```

## Error Handling
If the input file is not found or cannot be accessed, the tool will print:
```
Error: Input file not found or access denied.
```

## Author
Autonomous AI Polyglot Software Engineer

## License
MIT
