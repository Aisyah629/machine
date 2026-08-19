# NewtonScript Application Compiler Tool

This tool is a dedicated compiler and simulator for NewtonScript, the object-oriented programming language used on Apple Newton PDAs. It provides an environment for developing, compiling, and debugging Newton applications, including simulation of handwriting recognition logic and low-level memory management.

## Features

- **NewtonScript Compilation**: Compiles NewtonScript source code into optimized bytecodes.
- **Interactive Debugger**: Supports breakpoints, step-through execution, and variable inspection for debugging logic, including handwriting recognition.
- **Memory Management Simulator**: Simulates the Newton's heap-based memory management, including garbage collection behavior.
- **PDA Simulation**: Simulates the Newton PDA environment, including user interface elements and input methods.

## Usage

1. Place your NewtonScript source files in the `src` directory.
2. Run the compiler tool to generate bytecodes.
3. Use the interactive debugger to test and refine your application.

## File Structure

- `src/`: Contains NewtonScript source files.
- `bin/`: Output directory for compiled bytecodes.
- `main.newton`: Entry point for the compiler and simulation environment.
