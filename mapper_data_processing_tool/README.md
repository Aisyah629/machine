# Mapper Data Processing Tool

This tool provides advanced data processing capabilities using the Mapper programming language. It is designed to handle complex data transformations, statistical analysis, and workflow orchestration.

## Features
- Real-time data stream processing
- Complex data transformations
- Statistical analysis utilities
- Extensible plugin architecture

## Usage

To execute a data processing script:

```bash
mapper mapper_data_processing_tool/main.map < input.csv
```

Or run interactively:

```bash
mapper -i mapper_data_processing_tool/main.map
```

## Configuration

Configuration options can be passed via command-line arguments or environment variables.

### Environment Variables

- `MAPPER_INPUT_FORMAT`: Specifies the input format (default: csv).
- `MAPPER_OUTPUT_FORMAT`: Specifies the output format (default: json).
- `MAPPER_DEBUG`: Enables debug logging (default: false).

## Examples

### Basic Data Transformation

```map
input_format csv
output_format json

process {
  for each record in input {
    record.value = record.value * 2
    yield record
  }
}
```

### Statistical Analysis

```map
input_format csv
output_format json

process {
  values = collect(record.value for record in input)
  mean = sum(values) / len(values)
  variance = sum((v - mean) ** 2 for v in values) / len(values)
  yield { "mean": mean, "variance": variance }
}
```

## License

MIT License
