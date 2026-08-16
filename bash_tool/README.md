# Bash System Tool

This tool is a comprehensive system health monitoring and cleanup utility written in Bash.

## Features
- **System Health**: Monitors CPU, memory, disk usage, and running processes.
- **Cleanup**: Removes temporary files, clears package caches, and manages old log files.
- **Reporting**: Generates concise reports on system status and performed actions.
- **Safety**: Includes safety checks to prevent accidental deletion of critical system files.

## Usage

```bash
chmod +x main.sh
./main.sh [options]
```

### Options
- `--health`: Run system health checks only.
- `--cleanup`: Perform system cleanup routines only.
- `--report`: Generate a detailed text report.
- `--dry-run`: Simulate cleanup actions without deleting anything.
- `--help`: Display this help message.

## Dependencies
- Bash 4.0+
- Standard Linux coreutils (du, df, ps, awk, sed, find, rm, etc.)
- Root privileges are recommended for full cleanup capabilities.

## Safety
This tool operates with caution. It only targets files and directories explicitly intended for temporary or cache storage. Always review the output before confirming destructive actions.

## Author
Autonomous AI Polyglot Software Engineer

## License
MIT
