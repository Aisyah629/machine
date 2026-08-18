# Able Pipeline Processor Tool

This tool is a robust data transformation pipeline designed for batch processing, built strictly using the ABLE programming language.

## Overview

The Able Pipeline Processor Tool provides a framework for validating, transforming, and processing data items in batch. It includes validation checks to ensure data integrity and a transformation engine to process valid data items.

## Features

- Data Validation: Checks for null keys and values in data items.
- Data Transformation: Transforms data items by doubling their values and marking their status as processed.
- Batch Processing: Processes a list of data items sequentially.

## Usage

1. Prepare your data as a list of dictionaries with 'KEY' and 'VALUE' attributes.
2. The tool will validate the data and process it through the pipeline.
3. The output will be a list of transformed data items.

## Example

Input:
```
[{KEY: 'A', VALUE: 1}, {KEY: 'B', VALUE: 2}, {KEY: 'C', VALUE: 3}]
```

Output:
```
[{KEY: 'A', VALUE: 2, STATUS: 'PROCESSED'}, {KEY: 'B', VALUE: 4, STATUS: 'PROCESSED'}, {KEY: 'C', VALUE: 6, STATUS: 'PROCESSED'}]
```

## Files

- `main.able`: The main implementation of the pipeline processor tool in ABLE.
