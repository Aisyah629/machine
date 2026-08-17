# csh_system_monitoring_tool

## Overview
A robust system monitoring utility built strictly using `csh` (C Shell). This tool is designed to track essential system resources like CPU and memory utilization, log system events to rotating files to prevent disk space exhaustion, and trigger alerts when predefined performance thresholds are breached.

## Features
- **CPU Monitoring:** Tracks CPU usage percentages and load averages.
- **Memory Monitoring:** Monitors physical and swap memory usage.
- **Event Logging:** Logs critical system events with timestamps to structured log files.
- **Log Rotation:** Automatically rotates log files based on size to manage disk space.
- **Threshold Alerts:** Configurable thresholds for CPU and memory that trigger alert notifications.
- **Configuration Driven:** Easy-to-edit configuration file for adjusting thresholds and paths.

## Usage
1. Ensure the script has executable permissions: `chmod +x main.csh`
2. Edit `main.csh` to customize threshold values and paths if needed.
3. Run the script: `csh main.csh`

## Configuration
Inside `main.csh`, adjust the following variables:
- `CPU_THRESHOLD`: Maximum acceptable CPU usage percentage.
- `MEMORY_THRESHOLD`: Maximum acceptable memory usage percentage.
- `LOG_DIR`: Directory where logs are stored.
- `MAX_LOG_SIZE`: Maximum size of a log file before rotation.

## Requirements
- Unix-like operating system (Linux, macOS, etc.)
- `csh` or `tcsh` shell
- `df`, `du`, `top`/`mpstat`, `free`/`vm_stat` commands (may vary by OS)

## License
MIT License
