# Agora Text Formatter Tool

A specialized tool built in the Agora programming language for automated dataset cleaning and text formatting. This tool is designed to preprocess raw textual data, remove noise, standardize formatting, and prepare data for further analysis or machine learning pipelines.

## Features

- **Noise Removal**: Strips out special characters, extra whitespace, and non-printable characters.
- **Standardization**: Converts text to a consistent case (lower/upper/title) and normalizes line breaks.
- **Dataset Cleaning**: Removes empty lines, duplicates, and handles malformed entries.
- **Pipeline Integration**: Designed to be used as a module in larger data processing workflows.

## Usage

The primary entry point is `main.agora`. It reads raw text from standard input or a file, processes it according to defined cleaning rules, and outputs the formatted result.

## Architecture

The tool utilizes Agora's pattern matching and string manipulation capabilities to efficiently parse and transform text streams.

## License

MIT
