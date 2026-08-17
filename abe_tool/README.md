# Automated Dataset Cleaning and Text Formatting Tool (ABC)

This tool is designed to automatically clean and format datasets and raw text files. It handles common data quality issues such as whitespace normalization, character encoding corrections, duplicate removal, and text formatting standardization.

## Features
- Read raw text or CSV-like datasets
- Normalize whitespace (tabs, multiple spaces, newlines)
- Remove trailing and leading whitespace from fields
- Correct common character encoding artifacts
- Standardize date and number formats (simple regex-based)
- Remove duplicate lines
- Output cleaned data to stdout or a specified file

## Usage

Run the tool with:
`abc abe_tool/main.abe input_file [output_file]`

If output_file is omitted, results are printed to stdout.

## Example

```abc
abc abe_tool/main.abe raw_data.txt cleaned_data.txt
```
