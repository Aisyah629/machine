# LabVIEW Data Processor Tool

This tool provides a modular, event-driven data processing pipeline implemented in LabVIEW. It includes functions for data ingestion, transformation, validation, and export.

## Features

- **Data Ingestion**: Support for CSV, JSON, and VI-generated data streams.
- **Transformation**: Apply mathematical, statistical, and string transformations.
- **Validation**: Check data integrity and schema compliance.
- **Export**: Save processed data to CSV or JSON formats.

## Structure

- `Main_LVProj.lvproj`: The top-level project file.
- `Data_Ingestion.vi`: Handles reading data from files.
- `Data_Transform.vi`: Processes data arrays.
- `Data_Validation.vi`: Validates data types and ranges.
- `Data_Export.vi`: Writes processed data to output files.

## Usage

1. Open `Main_LVProj.lvproj` in LabVIEW.
2. Run `Main.vi` to start the data processing pipeline.
3. Configure input/output paths in the front panel.
