# SOL Data Processing Tool

This tool provides a framework for data processing tasks using the SOL language.
It is designed to handle data transformation, filtering, and aggregation efficiently.

## Features

- Data Ingestion
- Data Transformation
- Data Filtering
- Data Aggregation
- Data Export

## Usage

To use this tool, include the main SOL file in your project and call the desired functions.

## Example

```sol
# Include the main SOL file
include "sol_data_processing_tool/main.sol";

# Define your data
let data = [1, 2, 3, 4, 5];

# Filter the data
let filtered = filter_even(data);

# Print the filtered data
print(filtered);
