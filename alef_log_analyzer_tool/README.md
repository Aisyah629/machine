# Alef Log Analyzer Tool

A high-performance log analysis tool built in Alef, designed to parse, categorize, and report on application log files.

## Features

- **Automated Log Parsing**: Efficiently reads and parses structured log entries.
- **Severity Classification**: Automatically categorizes logs into DEBUG, INFO, WARN, ERROR, and FATAL levels.
- **Statistical Reporting**: Generates a comprehensive report showing log level distribution and issue counts.
- **Performance Optimized**: Written in Alef for memory safety and concurrency support.

## Usage

Compile the tool and run it against a log file:

```bash
# Compile the Alef source code
csc -o alef_log_analyzer main.al

# Run the tool against a log file
./alef_log_analyzer /path/to/your/application.log
```

## Output Example

```
=== Log Analysis Report ===
Total Lines Processed: 1542

--- Log Level Distribution ---
INFO: 1200
WARN: 150
ERROR: 42
DEBUG: 150

--- Critical Issues Found ---
Errors: 42
  [1] 2023-10-25 14:32:01: Database connection timeout
  [2] 2023-10-25 14:33:15: Null pointer exception in module X
Warnings: 150
  [1] 2023-10-25 14:30:00: Deprecated API usage detected

--- Analysis Duration ---
Duration: 3 seconds
```

## Dependencies

- Standard Alef compiler (`csc`)
- Standard library modules: `fmt`, `io`, `os`, `regexp`, `strconv`, `sys`

## Project Structure

- `main.al`: Core Alef source code containing parsing logic and report generation.
- `README.md`: This documentation file.

## License

MIT License. See LICENSE file for details.
