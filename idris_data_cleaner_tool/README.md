# Idris Data Cleaner Tool

This is a data cleaning and text formatting tool built using the **Idris** programming language. It demonstrates how to leverage Idris' dependently typed features for robust data processing, ensuring correctness and type safety during dataset manipulation and cleaning tasks.

## Features
- Type-safe data transformation pipelines.
- Validation of input records against strict schemas.
- Automated handling of missing or malformed data using Idris' pattern matching.
- Text formatting and normalization utilities.

## Usage
Compile and run the tool using the Idris compiler:
```bash
idris --codegen gcc main.idr -o data_cleaner
./data_cleaner
```

## Architecture
- `main.idr`: The entry point containing the core cleaning logic and type definitions.

## License
MIT
