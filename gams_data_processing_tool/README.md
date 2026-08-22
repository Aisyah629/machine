# GAMS Data Processing Tool

This tool is designed for robust data processing, statistical analysis, and optimization modeling using GAMS (General Algebraic Modeling System).

## Usage

To execute this tool, you will need the GAMS installation environment.

1.  Ensure GAMS is installed and accessible in your system path.
2.  Place the `main.gms` file in this directory.
3.  Run the model using the command line:
    ```bash
    gams main.gms
    ```

## Features

-   **Data Ingestion**: Reads CSV data files directly into GAMS sets and parameters.
-   **Data Transformation**: Performs calculations, aggregations, and transformations.
-   **Optimization**: Sets up and solves linear/non-linear programming problems.
-   **Output Generation**: Writes processed results to CSV or GDX formats.

## Structure

-   `main.gms`: The main GAMS model file containing data definitions, equations, and solver calls.
