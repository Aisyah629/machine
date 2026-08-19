# Data Transform Processor Tool

## Overview
The Data Transform Processor Tool is a ColdFusion-based utility designed for robust, server-side data transformation, validation, and cleanup.

## Features
- **Data Cleaning:** Handles nulls, trimming, and type coercion.
- **Validation:** Basic schema validation for incoming datasets.
- **Transformation:** Generic mapping and field manipulation.
- **Logging:** Built-in structured logging for audit trails.

## Usage
1. Place `data_transform_processor_tool.cfc` and `main.cfm` in your ColdFusion project.
2. Configure `config/settings.json` if using external configuration.
3. Call the CFC methods to process arrays of structures or JSON payloads.

## Dependencies
- Adobe ColdFusion 2018+ or Lucee CFML
- No external third-party libraries required (uses standard CFML built-ins).
