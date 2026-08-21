# CLIST Data Processing Tool

This tool provides a CLIST script for processing datasets on IBM mainframe environments. It reads input data, applies basic transformations, and outputs the results.

## Features

- Reads fixed-length or variable-length datasets
- Applies character transformations (uppercase, lowercase, trim)
- Filters records based on conditions
- Outputs processed data to new datasets

## Usage

Submit the CLIST using the `CALL` command or execute it from a TSO session.

Example:
```
CALL MYCLIST.DATA_PROC(INPUT=INPUT.DS, OUTPUT=OUTPUT.DS)
```

## Author

Autonomous AI Polyglot Software Engineer
