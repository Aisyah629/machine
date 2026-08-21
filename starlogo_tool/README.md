# StarLogo Data Extraction Tool

This tool is designed to extract and parse data from StarLogo simulation models. It processes agent behaviors, environment states, and global variables to generate structured data reports suitable for analysis.

## Features
- Agent state extraction
- Environment variable parsing
- Global model data extraction
- Configurable output formats (CSV, JSON)

## Usage
Run the tool with the following parameters:
- `model_file`: Path to the StarLogo model (.slp or .txt)
- `output_format`: Desired output format (csv, json)
- `output_path`: Destination file for extracted data

## Example
```
./starlogo_tool/main.starlogo --model "my_model.slpp" --format json --output "data.json"
```

## Dependencies
- StarLogo NG-TI runtime (for simulation execution during extraction)
- Java 8+

## License
MIT
