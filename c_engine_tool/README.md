# C Engine Tool

## Overview
The `c_engine_tool` is a lightweight, high-performance system configuration utility written strictly in C. It provides a modular command-line interface for parsing, setting, deleting, and listing configuration entries stored in simple key-value format files.

## Features
- **Fast Parsing**: Efficiently reads and parses configuration files using standard C I/O.
- **Modular Design**: Clean separation of parsing, saving, listing, setting, and deleting logic.
- **Memory Safety**: Bounded buffers prevent buffer overflows; strict array bounds checking.
- **Command-Line Interface**: Supports standard POSIX getopt for easy argument handling.
- **Zero Dependencies**: Pure C implementation, compiles cleanly with any standard C99/C11 compiler.

## Building
```bash
gcc -std=c99 -Wall -Wextra -O2 -o c_engine_tool main.c
```

## Usage
```bash
./c_engine_tool -p config.txt          # Parse and list entries
./c_engine_tool -s key=value config.txt # Set a value
./c_engine_tool -d key config.txt       # Delete a key
./c_engine_tool -l config.txt           # List active entries
./c_engine_tool -h                      # Show help
```

## License
MIT License
