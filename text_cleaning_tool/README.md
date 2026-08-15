# Text Cleaning Tool (Stateflow)

This tool implements a state-machine driven text cleaning and formatting pipeline using Simulink Stateflow semantics.

## Purpose
- Automate dataset cleaning tasks via state transitions.
- Standardize text formatting through a multi-stage processing pipeline.

## Stages
1. **Preprocess**: Initial data ingestion and format detection.
2. **Trimming**: Removal of leading/trailing whitespace.
3. **Normalizing**: Standardization of line endings and character encoding.
4. **Final**: Output generation and readiness for export.

## How to Use
- Define input data triggers the 'DataReceived' event.
- Monitor state transitions in the Stateflow chart to track cleaning progress.
- Request export via 'ExportRequested' event to retrieve clean text.
