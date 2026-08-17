# Curry Data Extraction and Parsing Utility

This tool provides a functional data extraction and parsing utility written in Curry.

## Features

- Extract key-value pairs from string-based data formats.
- Filter and process extracted data using standard Curry list functions.
- Non-deterministic parsing to handle ambiguous formats.

## Usage

To use this tool, ensure the `Curry` interpreter is available in your environment.

```curry
:load main.cur
extractKeyValuePairs "key1=val1&key2=val2"
```

## License

MIT License
