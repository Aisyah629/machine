# Scilab Data Processing Tool

This tool provides utility functions for data processing in Scilab.

## Features
- Data normalization
- Basic statistical analysis
- Data cleaning

## Usage

To use the data processing functions, add the `scilab_data_tool` directory to your Scilab path:

```scilab
addpath('path/to/scilab_data_tool')
```

Then call the desired function:

```scilab
normalized_data = normalize_data(data)
mean_val = compute_mean(data)
```

## Functions

- `normalize_data(data)`: Normalizes the input data to zero mean and unit variance.
- `compute_mean(data)`: Computes the mean of the input data.
- `clean_data(data)`: Removes NaN and infinite values from the data.

## License

MIT License
