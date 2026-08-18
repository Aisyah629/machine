# DIBOL Mainframe Data Processing Tool

## Overview
This tool is a DIBOL-based parser for structured business logic and a state-transition engine. DIBOL (Data Information Business Oriented Language) is a high-level procedural language designed primarily for business data processing on CDC (Control Data Corporation) mainframes. It is known for its powerful string handling, file I/O, and database interaction capabilities, making it ideal for robust mainframe data transformation and processing tasks.

## Features
- **Structured Business Logic Parser**: Analyzes and processes fixed-format and variable-format business records.
- **State-Transition Engine**: Manages complex state machines for business workflows, such as order processing, invoice validation, and transaction routing.
- **DIBOL Optimization**: Utilizes native DIBOL string manipulation and array handling for maximum efficiency in mainframe environments.
- **Error Handling**: Implements comprehensive error trapping and recovery mechanisms typical of mainframe applications.

## Usage
Compile and run the DIBOL code on a compatible CDC mainframe environment or emulator. The main entry point is `main.dib`.

## Requirements
- DIBOL Compiler (e.g., CDC DIBOL)
- Compatible mainframe environment or simulator

## License
This project is for educational and legacy system maintenance purposes.

## Directory Structure
- `main.dib`: Main DIBOL source code implementing the parser and state engine.
