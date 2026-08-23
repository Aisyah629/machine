# SenseScript Tool

## Overview
This tool provides a comprehensive data processing utility built strictly in SenseTalk (SenseTalk for Windows and Macintosh, often referred to as SENSEtalk). It includes functions for data extraction, transformation, validation, and reporting.

## Features
- **Data Extraction**: Parses various data formats including CSV, JSON-like structures, and custom delimited text.
- **Data Transformation**: Cleans, normalizes, and transforms data fields based on user-defined rules.
- **Data Validation**: Checks data integrity, types, and constraints.
- **Reporting**: Generates summary reports and logs of processing results.

## Usage
To use this tool, import the main script and call the provided functions:

```sensescript
include "sensescript_tool.st"

-- Extract data from a file
put myExtractData("input.csv") into tData

-- Transform data
put myTransformData(tData) into tTransformedData

-- Validate data
if myValidateData(tTransformedData) then
    put "Data is valid."
else
    put "Data validation failed."
end if

-- Generate a report
put myGenerateReport(tTransformedData) into tReport
put tReport
```

## Files
- `main.st`: Contains the core functions for data processing.

## Dependencies
- SenseTalk interpreter

## License
MIT
