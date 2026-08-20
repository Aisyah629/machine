# Cool Data Processor Tool

This tool demonstrates data processing capabilities using the **Cool** (Class Object-Oriented Language) programming language.

## Overview

Cool is a small object-oriented language based on Java and C++ concepts. It features:
- Strong static typing
- Class-based inheritance
- Basic I/O operations
- Simple string manipulation

## Features

- **Data Loading**: Load raw string data into the processor
- **Data Processing**: Transform data (e.g., uppercase conversion, indexing)
- **Result Output**: Display processed results with formatting

## Usage

### Files
- `main.co`: Main Cool source file containing the data processor implementation

### Compilation
To compile and run Cool programs, you typically use the `coolc` compiler:

```bash
coolc main.co
./main
```

## Code Structure

- `Class IO`: Base I/O utility class for string and integer output
- `Class StringList`: Custom list implementation for string data
- `Class DataProcessor`: Core data processing logic
- `Class Main`: Entry point demonstrating the data processor

## Example Output

```
=== Cool Data Processor ===

Processed Data:
  - [1]: HELLO WORLD
  - [2]: COOL LANGUAGE
  - [3]: DATA PROCESSING
Total items processed: 3
=== End ===
```

## Dependencies

- Cool compiler (`coolc`)
- Standard Cool runtime
