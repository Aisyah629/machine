# JCL Validation Tool

## Overview
The JCL Validation Tool is a static analysis engine designed to validate JCL (Job Control Language) syntax, check for unused datasets, and verify JCL resource constraints before batch submission. This tool ensures that JCL scripts are syntactically correct and adhere to system resource limits, thereby preventing common mainframe errors.

## Features
- **JCL Syntax Validation**: Checks for correct JCL syntax and structure.
- **Unused Dataset Detection**: Identifies datasets that are defined but not used in the JCL.
- **Resource Constraint Verification**: Ensures JCL resource usage complies with system limits.

## Usage
To use the JCL Validation Tool, run the main.jcl file with your JCL script. The tool will analyze the script and report any issues found.

## Requirements
- Mainframe environment capable of executing JCL.

## License
This tool is provided as-is without warranty.
