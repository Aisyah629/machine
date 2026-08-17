# Dataset Cleaning Tool

This tool is designed to automatically clean and format datasets.

## Features

- CSV Parsing
- Whitespace Normalization
- Deduplication

## Usage

Run the tool with an input file:

```bash
runhaskell main.hs data.csv
```

## Architecture

The tool uses a functional pipeline approach in Haskell to ensure immutability and safety.
