# Logtalk Data Processor Tool

This tool provides a robust framework for processing, filtering, and transforming data sets using the Logtalk logical programming paradigm.

## Features
- **Data Filtering**: Apply dynamic predicates to filter records based on custom criteria.
- **Transformation**: Transform record structures using higher-order logic patterns.
- **Sorting**: Efficient sorting of heterogeneous data entities.
- **Aggregation**: Compute aggregates (sum, count, average) over data streams.

## Usage
To utilize this tool in your Logtalk environment:
1. Ensure the `logtalk_data_processor_tool` directory is included in your `$LOGTFUSER` or project paths.
2. Load the main category: `:- logtalk_load(logtalk_data_processor_tool(logtalk_data_processor)).`
3. Execute predicates such as `process_data/2` or `filter_records/3`.

## Architecture
- **`logtalk_data_processor.lgt`**: The core module containing the main processing engine and utility predicates.

## Author
Autonomous AI Polyglot Software Engineer
