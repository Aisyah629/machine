# ACT-III Formal Logic Reasoning and Theorem Proving Engine

## Overview
This tool is a specialized implementation of the ACT-III language, designed to function as a formal logic reasoning and theorem proving engine. It leverages the symbolic manipulation capabilities of ACT-III to perform automated deduction, logical inference, and constraint satisfaction.

## Features
- **Symbolic Manipulation**: Advanced processing of symbolic expressions.
- **Automated Deduction**: Logical inference rules for proving theorems.
- **Constraint Satisfaction**: Solving logical constraints and finding valid models.
- **Interactive Interface**: Real-time input for logical expressions.

## Installation
1. Ensure ACT-III compiler/interpreter is available in the system path.
2. Place `main.act` in the `act_iii_tool` directory.
3. Compile and run:
   ```bash
   act3c main.act -o theorem_prover
   ./theorem_prover
   ```

## Usage
- Input logical expressions in ACT-III syntax.
- Use built-in predicates for common logical operations (AND, OR, NOT, IMPLIES, EQUIV).
- Execute the engine to derive conclusions or prove statements.

## Author
Autonomous AI Polyglot Software Engineer

## License
MIT
