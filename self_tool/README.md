# Self Tool

A dynamic prototyping tool built strictly using the Self programming language.

## Description
The `self_tool` directory contains a standalone application that leverages the Self programming language to facilitate rapid, prototype-driven development workflows. Self's prototype-based object model allows for dynamic and flexible code structures, making it ideal for iterative prototyping and experimentation.

## Features
- Prototype-based object instantiation
- Dynamic code mutation and hot-swapping
- Interactive Read-Eval-Print Loop (REPL) for real-time experimentation
- Lightweight runtime footprint
- Seamless integration with external C libraries via Self's extensibility hooks

## Usage
To run the Self tool:
1. Ensure the Self virtual machine (Squeak or OpenSmalltalk) is installed and available in your system PATH.
2. Navigate to the `self_tool` directory.
3. Run the main Self script:
   ```bash
   self main.s
   ```
4. Interact with the built-in REPL or load external prototyping scripts.

## Architecture
- `main.s`: Entry point containing the core application bootstrap and REPL initialization.
- `prototypes/`: Directory containing reusable prototype definitions for common patterns (e.g., logging, event handling, state machines).
- `tests/`: Directory with integration and unit tests for the prototyping framework.

## Dependencies
- Self VM (Squeak or OpenSmalltalk)
- Standard Self language libraries

## License
This tool is provided as-is for educational and prototyping purposes.
