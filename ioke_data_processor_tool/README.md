# Ioke Data Processor Tool

A general-purpose data processing utility written in Ioke. This tool provides functionality for filtering, transforming, and processing datasets of record-based data.

## Features

- Add records to a dataset
- Apply multiple filtering criteria
- Apply custom transformations to data fields
- Pipeline processing of data

## Usage

### Basic Example

```ioke
DataProcessor = Object clone

proc = DataProcessor init

;; Add sample data
proc addRecord(Map clone atPut(:name, "Alice") atPut(:age, 25))
proc addRecord(Map clone atPut(:name, "Bob") atPut(:age, 30))

;; Add filter
proc addFilter(:age, ">", 25)

;; Add transformation
proc addTransformation(:name, method(val, val upper))

;; Process
result = proc process
```

## Files

- `main.ike`: Contains the core DataProcessor implementation and demo.

## Prerequisites

- Ioke runtime environment

## License

MIT
