# ColdC Tool

## Overview
A specialized development environment and compiler wrapper for the ColdC programming language. ColdC is designed for high-performance systems programming, featuring static typing, zero-cost abstractions, and automatic memory management through deterministic cleanup. This tool provides syntax validation, compilation orchestration, and a standardized interface for building and running ColdC projects.

## Features
- Validates `*.cldc` source files for ColdC syntax correctness
- Orchestrates the ColdC compiler pipeline
- Manages project configuration via `coldc_tool.conf`
- Supports incremental compilation and dependency tracking
- Provides standardized error reporting and exit codes

## Usage
1. Place your `main.cldc` file in this directory.
2. Run the tool configuration:
   ```bash
   coldc_tool compile main.cldc
   ```
3. Check `compile.log` for detailed output.

## File Structure
- `main.cldc`: The primary ColdC source entry point.
- `coldc_tool.conf`: Configuration file for compiler flags and build paths.
- `README.md`: This documentation file.

## License
MIT
