# Onyx Tool

## Overview
A robust Onyx-based static code analysis engine for high-performance type checking. This tool is designed to parse, analyze, and validate Onyx source code, ensuring type safety and identifying potential issues before runtime.

## Features
- **Static Analysis**: Parses Onyx source files to extract syntax trees.
- **Type Checking**: Validates variable declarations, function signatures, and data structures.
- **Error Reporting**: Provides detailed diagnostics with line numbers and severity levels.
- **Performance**: Optimized for speed and memory efficiency.

## Usage
1. Navigate to the `onyx_tool` directory.
2. Run the Onyx compiler to build the tool:
   ```
   onyx build main.onx
   ```
3. Execute the tool with a target source file:
   ```
   ./onyx_tool main.onx
   ```

## Directory Structure
- `main.onx`: Main implementation of the static analysis engine.
- `README.md`: This file.

## License
MIT License
