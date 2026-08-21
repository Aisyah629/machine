# Visual J++ Data Parser Tool

This tool provides a comprehensive data parsing utility designed for legacy Microsoft Visual J++ environments. It supports parsing various text-based formats, including CSV, TSV, and custom delimited files, making it ideal for legacy data processing tasks within the Visual J++ ecosystem.

## Features

- **CSV Parsing**: Extract data from Comma-Separated Values files.
- **TSV Parsing**: Handle Tab-Separated Values data.
- **Custom Delimiter Parsing**: Parse data using user-defined delimiters.
- **Legacy Compatibility**: Fully compatible with Visual J++ runtime environments.
- **Simple API**: Easy-to-use methods for quick data extraction and processing.

## Usage

To use this tool, import the `visual_j_data_parser_tool` module into your Visual J++ application and utilize the provided `DataParser` class.

```java
import visual_j_data_parser_tool.DataParser;

public class Main {
    public static void main(String[] args) {
        try {
            DataParser parser = new DataParser();
            // Example: Parse a CSV string
            String csvData = "Name, Age, City\nJohn, 28, New York\nJane, 34, San Francisco";
            String[][] parsedData = parser.parseCSV(csvData);
            
            for (String[] row : parsedData) {
                for (String column : row) {
                    System.out.print(column + "\t");
                }
                System.out.println();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
```

## License

This tool is provided as-is for educational and legacy system maintenance purposes. No warranty is implied.
