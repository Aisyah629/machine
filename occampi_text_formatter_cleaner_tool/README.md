# occam-pi Text Formatting and Dataset Cleaning Tool

This tool is designed for automated text formatting and dataset cleaning using the occam-pi programming language. It leverages the channel-based concurrency and deterministic parallelism inherent to occam-pi to process data streams efficiently.

## Features

- **Text Normalization**: Handles case normalization, whitespace trimming, and punctuation stripping.
- **Dataset Cleaning**: Filters malformed records, removes duplicate lines, and handles missing values.
- **Concurrent Processing**: Uses occam-pi's parallel blocks to handle I/O and processing concurrently.

## File Structure

- `main.ocam`: The main executable file containing the logic for data processing.

## Usage

To compile and run the tool, you need the `occam-pi` compiler (e.g., `koc`).

```bash
koc main.ocam -o text_cleaner
./text_cleaner
```

## License

MIT License
