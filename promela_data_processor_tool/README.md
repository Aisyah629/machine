# Promela Data Processing Tool

This tool is a Promela-based utility for modeling and verifying data processing workflows. Promela (Process Meta Language) is used alongside the SPIN model checker to define processes that handle data ingestion, transformation, and validation.

## Features
- **Concurrent Data Ingestion**: Models multiple data sources processing in parallel.
- **Transformation Pipeline**: Defines state transitions for data cleaning and transformation steps.
- **Validation & Output**: Verifies data integrity before finalizing output records.
- **Deadlock Detection**: Utilizes SPIN to ensure no deadlocks occur during concurrent data processing.

## Usage
To run the model checker:
```bash
spin -a main.pml
gcc -o pan pan.c
./pan
```
