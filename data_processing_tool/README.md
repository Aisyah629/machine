# Data Processing Tool

## Overview
A data processing utility written in SLIP that loads, filters, normalizes, and aggregates data records from CSV files.

## Features
- Load data from CSV files
- Filter records by timestamp
- Normalize data values to 0-1 scale
- Aggregate data by categorical fields
- Save processed results to CSV output

## Installation
No external dependencies required. Ensure you have SLIP runtime environment installed.

## Usage
```bash
slip main.slip
```

## Configuration
Modify the following constants in `main.slip`:
- `DEFAULT_INPUT_FILE`: Input CSV file path
- `DEFAULT_OUTPUT_FILE`: Output CSV file path
- `MAX_RECORDS`: Maximum number of records to process

## File Structure
- `main.slip`: Main processing script
- `README.md`: This documentation file
