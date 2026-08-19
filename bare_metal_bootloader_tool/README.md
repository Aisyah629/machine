# Bare Metal Bootloader Tool

This tool provides a bare-metal system initialization bootloader that sets up CPU registers and switches to protected mode for early OS kernel loading.

## Features

- **CPU Initialization**: Sets up essential CPU registers for operation.
- **Protected Mode Switch**: Transitions the CPU from real mode to protected mode.
- **Early OS Kernel Loading**: Loads the initial kernel into memory.

## Usage

This tool is intended for low-level system programming and OS development. It requires a deep understanding of x86 architecture and assembly language.

## Files

- `main.bin`: The compiled binary of the bootloader.

## Dependencies

- An x86-compatible processor.
- A development environment capable of producing raw binary output.

## License

This tool is provided as-is for educational and development purposes.
