# xHarbour Data Processor Tool

## Description
This tool is designed to process data files, specifically CSV format, using the xHarbour programming language. It reads configuration from an `config.ini` file, processes data from an `input` directory, and generates a summary report in an `output` directory.

## Prerequisites
- xHarbour environment
- Compiling xHarbour code

## Usage
1. Create an `input` directory and place your CSV files in it.
2. Create a `config.ini` file in the root directory with configuration settings:
   ```ini
   delimiter=,
   encoding=UTF-8
   output_dir=./output
   ```
3. Run the main program:
   ```bash
   xharbour main.prg
   ```
4. Check the `output` directory for the generated `report.txt`.

## Configuration
- `delimiter`: The delimiter used in CSV files (default: `,`).
- `encoding`: The encoding of the input files (default: `UTF-8`).
- `output_dir`: The directory where the report will be saved (default: `./output`).

## Features
- Reads CSV files from the `input` directory.
- Parses data based on specified delimiter.
- Generates a text report with statistics and sample data.

## License
This tool is provided as-is for educational and utility purposes.
