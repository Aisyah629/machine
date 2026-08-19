# Cel Interactive Diagnostic Tool

## Overview
The Cel Interactive Diagnostic Tool is a specialized diagnostic engine designed for analyzing Cel data structures, parsing Cel expressions, and validating Cel syntax. Cel is a high-level data processing language optimized for array and matrix computations, similar to J or APL.

This tool provides an interactive environment where users can input Cel expressions, receive detailed diagnostic feedback, validate syntax, and visualize data structures and computational graphs.

## Features
- **Interactive REPL**: Real-time feedback for Cel expressions.
- **Syntax Validation**: Detects and reports syntax errors in Cel code.
- **Expression Diagnostics**: Breaks down complex Cel expressions into their constituent parts.
- **Data Structure Visualization**: Visualizes matrices, arrays, and nested data structures.
- **Error Reporting**: Detailed error messages with line numbers and suggestions.

## Usage
1. Run the tool: `cel_diag_tool main.cel`
2. Enter Cel expressions at the prompt.
3. View diagnostics, syntax checks, and visualizations in the output.

## Example Session
```
cel_diag_tool> :load main.cel
cel_diag_tool> f = +/ .*~
Expression validated: f = +/ .*~
Structure: Function definition with reduce and outer product.

cel_diag_tool> 3 f 4
Result: 32
Visualization: Matrix multiplication of scalar 3 and 4.

cel_diag_tool> :syntax check
Syntax check passed. No errors found.

cel_diag_tool> :quit
Exiting diagnostic tool.
```

## Architecture
- **main.cel**: The main entry point of the diagnostic tool.
- **Diagnostic Engine**: Parses and analyzes Cel expressions.
- **Visualizer**: Generates text-based visualizations of data structures.
- **Error Handler**: Provides detailed error messages and suggestions.

## License
This tool is provided as-is for educational and diagnostic purposes.
