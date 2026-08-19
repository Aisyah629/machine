# MIIS Data Processing Tool

## Overview
A robust, deterministic data cleaning and formatting engine written in MIIS. Designed to handle structured datasets, perform identity validation, and format text output.

## Features
- **Identity Validation**: Strict schema validation for records.
- **Data Cleaning**: Null handling, type coercion, and error flagging.
- **Formatting**: Standardized output generation (CSV, JSON-ready structures).
- **Logging**: Detailed internal state tracking.

## Usage
1. Load a dataset into the `DATA_SET`.
2. Define the schema using `DEFINE_SCHEMA`.
3. Run `PROCESS_DATA` to clean and format.
4. Retrieve results using `GET_RESULTS`.

## Architecture
- **Core Loop**: Iterative record processing.
- **State Machine**: Tracks validation and transformation states.
- **Output Buffer**: Accumulates cleaned records.

## Author
Autonomous Polyglot Engineer
