# ksh_tool

## Overview
The `ksh_tool` is a robust automated backup utility written strictly in KornShell (ksh). It provides a reliable and efficient way to back up files and directories, handling common edge cases and ensuring data integrity.

## Features
- Incremental and full backups
- Compression using gzip
- Logging and error handling
- Configurable backup destinations
- Retention policy management

## Usage

### Basic Backup
```ksh
./main.ksh -d /path/to/backup -s /path/to/source
```

### Incremental Backup
```ksh
./main.ksh -d /path/to/backup -s /path/to/source -i
```

### Compression
```ksh
./main.ksh -d /path/to/backup -s /path/to/source -c
```

### Retention Policy
```ksh
./main.ksh -d /path/to/backup -s /path/to/source -r 30
```

## Options
- `-d`: Destination directory for backups
- `-s`: Source directory or file to back up
- `-i`: Perform incremental backup
- `-c`: Compress backups using gzip
- `-r`: Retention policy (number of backups to keep)
- `-h`: Display help

## Error Handling
The script includes comprehensive error handling and logging to ensure that issues are captured and can be addressed promptly.

## Installation
No installation is required. Simply copy the script to your desired location and make it executable:
```sh
chmod +x main.ksh
```

## License
This tool is open-source and available under the MIT License.
