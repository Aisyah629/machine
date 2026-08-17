# Opal Data Extraction Tool

This tool provides a simple data extraction utility written in Opal.
It demonstrates parsing a simple text format (CSV-like) and extracting
structured data into records.

## Usage

Load the main.opal file and use the `DataExtractor` class.

### Example

    data = "name,age,city\nAlice,30,NYC\nBob,25,LA"
    extractor = DataExtractor.new()
    records = extractor.parse(data)
    puts records.first.name
