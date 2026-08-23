# Mortran Data Processing Utility Tool

## Description
This is a **Mortran** (Matrix Fortran) utility designed for numerical data processing. Mortran is an extension of Fortran that supports array operations and vectorization, making it highly suitable for matrix manipulations and scientific computations.

## Features
- **Matrix Ingestion**: Loads data into a multidimensional array structure.
- **Vector Operations**: Calculates row sums and column averages using nested loops (optimized in standard Mortran compilers).
- **Statistics**: Computes global averages of the dataset.
- **Structured Output**: Formatted printing of intermediate and final results.

## Prerequisites
- A Mortran compiler (e.g., Mortran2 or legacy Mortran compilers).
- Fortran runtime libraries.

## File Structure
- `main.mortran`: The core source code implementing the data processing logic.
- `mortran_data_processing_utility_tool.conf`: Configuration file for default parameters.

## Usage
1. Compile the source code:
   ```bash
   mortran2 main.mortran -o data_processor
   ```
2. Run the executable:
   ```bash
   ./data_processor
   ```

## Logic Overview
1. **Initialization**: Sets up matrix dimensions and clears accumulators.
2. **Data Loading**: Populates a 5x4 matrix with deterministic values.
3. **Processing**: 
   - Iterates over rows to compute sums.
   - Iterates over columns to compute averages.
4. **Output**: Displays row sums, column averages, and the global average.

## License
Internal Utility Tool
