# TADS Data Processor Tool

## Description
This utility is a specialized data processing engine built using TADS (Text Adventure Development System). It leverages TADS's object-oriented capabilities and robust string/list manipulation features to parse, transform, and analyze structured text data. While TADS is primarily designed for interactive fiction, its strong data structures make it surprisingly effective for batch-style text processing tasks.

## Features
- **Structured Text Parsing**: Efficiently breaks down delimited or formatted text files into structured objects.
- **Data Transformation**: Applies rule-based transformations to data fields.
- **Validation Engine**: Checks data integrity against defined schemas or rules.
- **Output Formatting**: Generates cleaned, standardized text outputs or simple JSON-like structures.

## Usage
1. Place your input data file in the `data/` directory.
2. Run the tool using a TADS compiler/interpreter (e.g., `t3make`, `blorb`, or an interactive interpreter).
3. The tool will parse the input and output the processed results to the console or an output file.

## File Structure
- `README.md`: This file.
- `main.t`: The core TADS source code containing the data processing classes and logic.

## Dependencies
- TADS 3 (t3v) or TADS 2 interpreter/compiler.
