# SiMPLE Logic Parser Tool

## Overview
The SiMPLE Logic Parser Tool is a dedicated development environment for building, testing, and deploying rule-based inference engines. It provides a complete toolkit for defining logical rules, parsing complex statements, and executing automated deduction sequences.

## Features
- **Modular Rule Definition**: Define facts, rules, and logical operators in a clean, structured format.
- **Automated Deduction Engine**: Built-in recursive inference engine that resolves logical queries against a defined knowledge base.
- **Statement Verification**: Instantly verify the validity of logical statements and proofs.
- **SiMPLE Native**: Entirely coded in SiMPLE, leveraging its strict typing and declarative syntax for maximum reliability.

## Usage
1. Create a new rule set file with the `.sml` extension.
2. Load the knowledge base using the `LOAD_KB` directive.
3. Execute the `INFER` command to run logical deduction.
4. Use `VERIFY` to check the validity of specific queries.

## Structure
- `main.simple`: Core parsing and execution engine.
- `README.md`: This documentation file.

## Installation
Copy the `simple_logic_parser_tool` directory into your workspace. Ensure your environment has the SiMPLE interpreter available.
