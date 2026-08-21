# Hop Text Formatter and Dataset Cleaning Tool

## Overview

The Hop Text Formatter and Dataset Cleaning Tool is designed to automate the process of cleaning and formatting text data and datasets. It provides a set of functions for removing duplicates, trimming whitespace, converting text to uppercase or lowercase, and formatting lines. The tool is built using the Hop programming language.

## Features

- **Data Cleaning**:
  - **Remove Leading and Trailing Whitespace**: Trims whitespace from each line.
  - **Remove Duplicate Lines**: Removes duplicate lines while preserving the original order.
  - **Remove Empty Lines**: Filters out empty lines.
  - **Convert to Lowercase**: Converts all text to lowercase.
  - **Convert to Uppercase**: Converts all text to uppercase.

- **Text Formatting**:
  - **Capitalize Words**: Capitalizes the first letter of each word.
  - **Format Lines**: Formats lines to a specified maximum line length.

- **Pipeline Orchestrator**:
  - **Run Pipeline**: Combines cleaning and formatting into a single pipeline.

## Usage

### Command-Line Interface

To run the tool from the command line, use the following command:

```bash
hop main.hop input.txt output.txt
```

Replace `input.txt` with the path to your input file and `output.txt` with the path to your output file.

### Configuration

The tool reads its configuration from a file specified in the `config.json` file. If no configuration file is provided, it defaults to standard settings.

## Development

### Prerequisites

- Hop programming language installed.

### Running Tests

To run tests for the tool, execute the following command:

```bash
hop run-tests
```

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
