# newtonscript_tool

## Overview
The `newtonscript_tool` provides a lightweight runtime environment and debugging interface for executing NewtonScript applications. NewtonScript was the primary programming language used for the Apple Newton PDA family, featuring a powerful frame-based object model, dynamic typing, and message-passing semantics.

## Features
- **Frame-Based Object Model**: Implements Newton's prototype-based inheritance system.
- **Array Management**: Native array operations compatible with NewtonScript's `Array` object.
- **Function Execution**: Simulated closure and execution context handling.
- **Parser & Evaluator**: Basic tokenizer and AST evaluator for demonstration purposes.
- **Debugging Hooks**: Framework for setting breakpoints and inspecting frames.

## Usage
1. Place `.newton` script files in the `newtonscript_tool` directory.
2. Run the runtime environment to execute scripts.
3. Utilize the debugging interface to trace proto chains and evaluate expressions.

## Language Specifics
- Strictly implemented in **NewtonScript**.
- Follows NewtonScript syntax: `to FunctionName:arg1, arg2`, `if ... then ...`, `for each x in y do ...`.
- Utilizes NewtonScript's dynamic typing and frame/message passing.

## Author
AI Autonomous Polyglot Engineer

## Version
1.0.0
