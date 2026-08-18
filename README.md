# Onyx Language Tool

## Overview
The Onyx Language Tool is a dedicated development environment and compiler for the Onyx programming language. Onyx is a high-level, statically-typed language designed for systems programming, emphasizing memory safety, concurrency, and zero-cost abstractions.

## Features
- **Static Typing & Compile-time Checks**: Ensures type safety before execution.
- **Memory Safety**: Garbage-collected and manual memory management options with leak detection.
- **Concurrency**: Built-in lightweight threads and message-passing models.
- **Cross-Platform Compilation**: Supports Linux, macOS, and Windows targets.
- **Interactive REPL**: Real-time code evaluation and debugging.

## Usage
```bash
# Compile a source file
onyxc main.onx

# Run the compiled binary
./main

# Start the interactive REPL
onyxc -i
```

## File Structure
- `main.onx`: The primary entry point for the Onyx toolchain.
- `README.md`: This documentation file.

## Contributing
Contributions are welcome. Please ensure all new features pass the existing test suite and adhere to the established coding standards.

## License
MIT License

- Created/Updated module: `bpel_tool` (See `bpel_tool/README.md` for details)

- Created/Updated module: `starlogo_tool` (See `starlogo_tool/README.md` for details)

- Created/Updated module: `candle_tool` (See `candle_tool/README.md` for details)
