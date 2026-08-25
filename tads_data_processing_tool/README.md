# TADS 3 Data Processing Utility

## Overview
This is a data processing utility written in TADS 3. It allows users to process text files, tokenize lines, and aggregate data into a dictionary structure.

## Features
- File reading and line processing
- String tokenization
- Data aggregation using dictionaries
- Error handling for file operations

## Usage
1. Compile the TADS 3 source code using the TADS 3 compiler.
2. Run the compiled game.
3. Use the `process <filename>` command to process a data file.

## Example
```
> process data.txt
Opening file: data.txt

Processing complete.
Total lines read: 100
Lines with data: 95
Unique keys found: 10

--- Data Summary ---
Key: user1, Records: 5
Key: user2, Records: 3
...

Done.
```

## Requirements
- TADS 3 compiler
- TADS 3 runtime

## License
MIT License
