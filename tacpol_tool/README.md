# TACPOL Tool

## Overview
The `tacpol_tool` is a comprehensive environment for implementing and executing Constraint Logic Programming (CLP) applications using the TACPOL programming language.

## Purpose
TACPOL is designed for declarative programming where the programmer specifies what the solution should look like rather than how to find it. This tool focuses on the efficient resolution of complex constraint satisfaction problems (CSPs) and constraint optimization problems (COPs).

## Usage
1. Navigate to the `tacpol_tool` directory.
2. Place your TACPOL source code files (`.tcl` or `.tac`) in the root directory.
3. To execute a program:
   ```bash
   ./main.tcl solution_file.pl
   ```
4. For optimization problems, use the `-o` flag:
   ```bash
   ./main.tcl -o optimal_value.pl
   ```

## File Structure
- `main.tcl`: The main executable script that initializes the constraint engine, parses the input file, and runs the solver.
- `solver_module.tcl`: Core implementation of the constraint propagation and backtracking algorithm.
- `library.tcl`: Standard constraint definitions (arithmetic, global constraints, etc.).

## Key Features
- **Constraint Propagation**: Implements arc consistency and path consistency algorithms to reduce search space.
- **Lazy Clause Generation**: Integrates LCG (Lazy Clause Generation) techniques for hybrid CP/ SAT solving.
- **Domain Splitting**: Advanced domain splitting strategies for efficient backtracking.
- **Debugging Support**: Built-in tools for inspecting constraint states and variable domains.

## Constraints Supported
- **Arithmetic Constraints**: `=`, `\=`, `<`, `\<`, `<=`, `\>=`, `>`, `\>`.
- **Boolean Constraints**: `and`, `or`, `not`, `xor`.
- **Global Constraints**: `all_different`, `cumulative`, `element`, `table`.
- **Set Constraints**: Union, intersection, difference, subset relations.

## Development
To add new constraints, implement a module in `library.tcl` following the `define_global_constraint/3` interface.

## License
Proprietary
