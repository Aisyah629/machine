# Text Cleaning Tool

This tool provides automated dataset cleaning and text formatting capabilities.

It leverages SPARK (Ada with Design by Contract) for high-assurance processing, ensuring data integrity and correctness through formal verification.

## Features

- Remove leading/trailing whitespace
- Normalize internal whitespace sequences
- Remove special characters (configurable)
- Convert case (upper/lower)
- Deduplicate lines

## Usage

Compile the `main.adb` file with an ADA/SPARK compiler (e.g., GNAT).

```bash
gnatmake main.adb
./main
```

## Design by Contract

This implementation uses SPARK contracts to guarantee:
- Input array bounds validity
- Output array bounds safety
- Character set verification

## License

MIT License
