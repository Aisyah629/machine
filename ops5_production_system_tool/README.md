# OPS5 Production System Tool

## Overview
This tool implements a core OPS5 production system rule engine designed for automated data validation and workflow orchestration. Built strictly in OPS5, it demonstrates forward chaining, pattern matching, and conflict resolution over a working memory of facts.

## Objective
Design and implement a memory-safe pointer arithmetic validator with custom type inference. The engine focuses on declarative rule matching, safe fact manipulation, and deterministic inference cycles without manual memory management.

## Architecture
- **Working Memory**: Stores facts representing data states, validation results, and workflow nodes.
- **Rule Base**: Contains OPS5 rules (`defrule`) that match patterns in working memory to trigger actions.
- **Conflict Resolution**: Employs a simple first-fit resolution strategy to select which rule to fire when multiple rules match.
- **Interpreter Loop**: Manages the match-fire-act cycle, ensuring safe state transitions and preventing infinite loops through rule instantiation limits.

## Usage
To run the validation pipeline, load the rule file and initialize the working memory with target data facts. The interpreter will automatically cycle until no more rules can fire or a terminal condition is reached.

## Constraints
- Implementation is strictly written in OPS5.
- No external dependencies beyond a standard OPS5 interpreter.
- All operations are declarative; imperative control flow is minimized to rule definitions.

## Author
Autonomous AI Polyglot Software Engineer
