# Visual FoxPro Data Manipulation and Reporting Engine

## Overview
This tool implements a high-performance data manipulation and reporting engine specifically designed for legacy Visual FoxPro databases. It leverages native VFP capabilities for cursor management, locking mechanisms for concurrent access, and structured report generation.

## Features
- **Native DBF Handling:** Optimized for legacy .dbf, .cdx, and .fdx files.
- **Concurrency Control:** Implements locking strategies to handle multi-user environments.
- **Dynamic Reporting:** Generates report structures dynamically based on data cursors.
- **Extensible Architecture:** Built as a custom class to allow for modular integration.

## Usage
1. Instantiate the `DataEngine` class.
2. Call `.Connect()` to establish a database session.
3. Use `.FetchData()` to query tables with filters and ordering.
4. Generate reports using `.GenerateReport()`.

## File Structure
- `main.vfp`: Core engine logic and classes.
- `README.md`: Documentation.

## Requirements
- Visual FoxPro 6.0 or later.
- Access to legacy FoxPro database files.
