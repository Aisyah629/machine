# KSH Data Processor Tool

A robust, POSIX-compliant data processing utility written strictly in KornShell (ksh).

## Features
- Stream-based line processing
- Field extraction and filtering
- CSV parsing support
- In-place transformation
- Verbose logging

## Usage

`./ksh_data_processor_tool/main.ksh [OPTIONS] <input_file>`

## Options
- `-f <field>` : Select specific field(s) to output (1-based index)
- `-d <delimiter>` : Set delimiter (default: whitespace)
- `-v` : Enable verbose mode
- `-h` : Show help message
