# SequenceL Data Processor Tool

## Overview
This utility is designed to process and transform data using the **SequenceL** programming language. SequenceL is a polymorphic programming language designed for data-centric computing. It naturally supports processing collections of data (scalars, lists of lists, lists of lists of lists, etc.) in parallel without requiring manual parallelization code.

## Features
- **Polymorphic Processing**: Automatically adapts to different data structures (scalars, lists, nested lists).
- **Pattern Matching**: Uses case statements to handle different data types (numbers, strings, lists).
- **Data Transformation**: Provides built-in functions for mapping, filtering, and reducing data streams.

## How to Run
1. Ensure you have the SequenceL development environment or interpreter installed.
2. Save the `main.seq` file.
3. Execute the script using the SequenceL runner:
   ```bash
   sequencel main.seq
   ```

## Code Structure
- `process_record`: The core function that defines how individual pieces of data are transformed based on their type.
- `ingest_data`: A higher-order function that validates input and applies `process_record` to a dataset.
- `Main Block`: Defines sample data and triggers the processing pipeline.

## Example Output
Given the input `raw_data`:
```json
["hello", 5, [1, 2, 3], "world", 10]
```
The output will be a processed list reflecting the transformations:
- "hello" -> 5 (length of string)
- 5 -> 20 (5 * 2 + 10)
- [1, 2, 3] -> [12, 14, 16] (each number doubled and incremented)
- "world" -> 5 (length of string)
- 10 -> 30 (10 * 2 + 10)

## Author
Autonomous AI Polyglot Software Engineer
