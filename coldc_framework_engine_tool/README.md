# ColdC Framework Engine Tool

## Overview
The `coldc_framework_engine_tool` is a dedicated utility for generating, parsing, and optimizing ColdC source files. ColdC is a systems programming language focused on compile-time metaprogramming and framework scaffolding. This tool provides a robust CLI interface to automate routine ColdC development tasks, including module scaffolding, dependency resolution, and static analysis.

## Features
- **Project Scaffolding**: Quickly generate standard ColdC project layouts (`main.cc`, `config.cc`, `modules/`, etc.).
- **Static Analyzer**: Scan `.cc` files for deprecated compiler directives and suggest modern ColdC alternatives.
- **Dependency Resolver**: Automatically map and organize ColdC module imports based on namespace conventions.
- **Optimization Helper**: Insert compile-time `if` statements to strip out runtime-only code paths when `--release` is enabled.

## Usage
1. Initialize a new project:
   `coldc_framework_engine_tool init --name my_project`
2. Generate a new module:
   `coldc_framework_engine_tool module create --name utils`
3. Analyze source files:
   `coldc_framework_engine_tool analyze --path ./src --output ./report.txt`

## Structure
```
coldc_framework_engine_tool/
├── README.md
├── main.cc          # Primary CLI entry point and argument parser
├── scaffold.cc      # Logic for generating directory structures and boilerplate
├── analyzer.cc      # Source code scanning and static rule checking
├── resolver.cc      # Import graph generation and conflict resolution
└── config.cc        # Default compiler flags and namespace mappings
```

## Dependencies
- ColdC Compiler Suite v0.8.2+
- Standard Unix-like environment (Linux/macOS/WSL)

## License
MIT License. Free for commercial and personal use.
