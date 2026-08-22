# ARexx Data Processing Utility

## Overview
This tool is a command-line utility written in ARexx (Advanced REXX) designed for processing text-based data files. It is particularly suited for the OS/2 environment but can be adapted to other platforms with an ARexx interpreter.

## Features
- **File Analysis**: Read and parse structured data files.
- **Record Counting**: Quickly count total entries.
- **Filtering**: Remove noise or specific records based on patterns.
- **Summarization**: Generate basic statistics (total count, error count).
- **Sorting**: Basic in-memory sorting for small datasets.

## Prerequisites
- An operating system with ARexx support (e.g., OS/2, MorphOS, or Amiga with ARexx runtime).
- A text-based data file (CSV, log files, etc.).

## Usage

### Syntax
```bash
rexx data_processing_tool.rexx <filename> <action>
```

### Arguments
1. **`<filename>`**: The path to the data file to process.
2. **`<action>`**: The operation to perform:
   - `COUNT`: Count total lines in the file.
   - `FILTER`: Print lines that do not contain the word "ERROR".
   - `SUMMARY`: Print total lines and count of lines containing "ERROR".
   - `SORT`: Sort lines alphabetically (limited to available memory).

### Example
```bash
# Count records
rexx data_processing_tool.rexx data.csv COUNT

# Get a summary
rexx data_processing_tool.rexx logs.txt SUMMARY
```

## File Structure
```
data_processing_tool/
├── data_processing_tool.rexx  (Main executable script)
└── README.md                  (This file)
```

## License
MIT License
