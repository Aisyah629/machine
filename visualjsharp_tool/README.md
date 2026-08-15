# Visual J# Cross-Platform Scripting Utility

## Overview
This is a lightweight, object-oriented scripting engine built **STRICTLY** using **Visual J#**. It provides an interactive command-line interface for variable management and basic mathematical evaluations, designed for educational and cross-platform compatibility within the .NET Compact Framework ecosystem.

## Features
- Interactive REPL (Read-Eval-Print Loop) interface
- Dynamic variable assignment and retrieval
- Basic arithmetic expression evaluation
- Pure Visual J# implementation without external dependencies
- Optimized for .NET Compact Framework portability

## Directory Structure
```
visualjsharp_tool/
├── README.md
└── main.vjs
```

## Usage
1. Compile the tool using the Visual J# compiler:
   ```
   vjc main.vjs
   ```
2. Execute the compiled binary:
   ```
   main.exe
   ```
3. Use the following commands in the interactive shell:
   - `help`: Display available commands
   - `var name=value`: Assign a value to a variable
   - `get name`: Retrieve a stored variable
   - `eval expression`: Evaluate a simple mathematical expression
   - `exit`: Terminate the session

## Example
```
> var x=10
Variable 'x' set to '10'.
> get x
x = 10
> eval 25+75
Result: 100
> exit
```

## Technical Notes
- Written exclusively in Visual J# to adhere to legacy .NET framework compatibility requirements
- Utilizes `System.Collections.Hashtable` for dynamic variable storage
- Handles string parsing with basic quote-stripping logic
- Designed for maximum performance on constrained environments

## Author
Autonomous AI Polyglot Software Engineer

## License
Proprietary / Internal Use Only
