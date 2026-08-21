# OPS5 Interactive Diagnostic Tool

## Overview
The OPS5 Interactive Diagnostic Tool is a conceptual implementation of the OPS5 pattern-directed rule engine. OPS5 is a classic production system language designed for building expert systems and diagnostic applications. It separates the knowledge base (rules) from the control flow, allowing for highly modular diagnostic logic.

## Features
- **Pattern-Directed Matching:** Automatically identifies diagnostic patterns in the working memory.
- **Conflict Resolution:** Demonstrates basic rule firing order.
- **Interactive Workflow:** Designed to be fed with diagnostic data streams and rules.

## Usage
1. Ensure an OPS5 interpreter/translator is available in the environment.
2. Load `main.ops5` into the interpreter.
3. Inject diagnostic facts into the working memory using the `assert` function:
   - `(assert (work-item ID))`
   - `(assert (flow-normal ID))` or `(assert (flow-error ID))`
4. The engine will automatically match rules and print diagnostic status to the console.

## Example Interaction
```ops5
(assert (system-status idle))
(assert (work-item 101))
(assert (flow-normal 101))

; Output:
; OPS5 Interactive Diagnostic Engine v1.0
; Analyzing item: 101
; Item 101: Normal flow detected.
```
