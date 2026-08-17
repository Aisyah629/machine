# RPG Business Logic Tool

## Overview
This tool is designed to process complex business logic, handle legacy data formats, and generate structured financial and operational reports using IBM RPG (Report Program Generator). It provides a robust framework for batch processing and sequential file manipulation.

## Features
- Legacy system integration for mainframe-style data processing
- High-performance batch processing engine
- Automated financial report generation
- Sequential and relative file manipulation
- Modular logic for easy customization and extension

## Installation
1. Clone this repository.
2. Open the main program file (`main.rpgle`) in your preferred RPG IDE.
3. Compile using your standard IBM i or RPG compiler settings.

## Usage
Run the batch job through your system's job scheduler or execute directly via the command line:
```
CALL PGM(RPG_BUSINESS_LOGIC)
```

## Configuration
Edit the `main.rpgle` source to update file paths, report formats, and business rules according to your specific environment.

## License
This project is open-source and available for modification and distribution.
