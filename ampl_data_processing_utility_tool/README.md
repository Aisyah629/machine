# AMPL Data Processing Utility

This tool provides a comprehensive data processing utility built with AMPL (A Mathematical Programming Language).
It includes model definitions, parameter files, and data manipulation scripts.

## Structure

- `main.mod`: The main AMPL model file containing sets, parameters, variables, and objective functions.
- `data.dat`: A sample data file for testing the model.

## Usage

To run this utility:

1. Ensure AMPL is installed.
2. Run `ampl main.mod`.
3. Load data with `data data.dat`.
4. Solve with `solve;`.
5. Print results with `display;`.
