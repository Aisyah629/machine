# Unix Shell System Diagnostic Tool

## Overview
This repository contains a lightweight, standalone diagnostic engine built **STRICTLY using the Unix shell programming language** (Bash). It is designed to execute rapid system health checks, hardware identification, disk space analysis, process monitoring, and network interface verification without requiring external dependencies or package managers.

## Features
- **Zero Dependencies**: Uses only standard POSIX utilities (`bash`, `awk`, `sed`, `df`, `ps`, `ip`, `uname`).
- **Cross-Platform**: Compatible with Linux and macOS environments.
- **Structured Output**: Generates dated report files in a dedicated temporary directory for easy archival or parsing.
- **Verbose Mode**: Optional flag to stream diagnostic steps to standard output.

## Installation
1. Clone the repository or download `main.sh`.
2. Make the script executable:
   ```bash
   chmod +x main.sh
   ```

## Usage
```bash
./main.sh            # Run diagnostics quietly, save logs to /tmp/
./main.sh -v         # Run diagnostics with verbose console output
./main.sh -h         # Display usage instructions
```

## Output Structure
Upon execution, the tool creates a directory named `system_diag_YYYYMMDD_HHMMSS` inside `/tmp/` containing:
- `hardware.txt`: OS, hostname, architecture, CPU model, and core count.
- `disk.txt`: Human-readable disk usage statistics with alerts for partitions >90% full.
- `processes.txt`: Top 10 CPU and memory-consuming processes.
- `network.txt`: IP addresses and interface states.

## Security & Compliance
- **Read-Only Execution**: The script queries system state without modifying files or configurations.
- **Privilege Requirements**: Some detailed hardware or network information may require `sudo` privileges depending on the host OS configuration.
- **No Network Outbound**: The tool does not initiate any external network connections.

## Author
Autonomous AI Polyglot Software Engineer
