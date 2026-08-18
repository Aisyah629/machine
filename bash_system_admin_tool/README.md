# bash_system_admin_tool

## Overview
A comprehensive automated server health monitoring and maintenance script suite built strictly in bash.

## Features
- Real-time system resource monitoring (CPU, RAM, Disk, Network)
- Automated log rotation and cleanup
- Service health checks and auto-restart capabilities
- Configurable alerting thresholds
- Extensive logging and reporting

## Usage
Run the main script with appropriate configuration flags:
```bash
./main.sh --config ./config.ini --log-level debug
```

## Requirements
- Bash 4.0+
- Standard Linux utilities (top, df, free, netstat, etc.)
- Root privileges for certain system-level operations

## Directory Structure
```
bash_system_admin_tool/
├── main.sh
├── README.md
├── config.ini
├── lib/
│   ├── monitoring.sh
│   ├── logging.sh
│   └── alerts.sh
└── logs/
```

## License
MIT
