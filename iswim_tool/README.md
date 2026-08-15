# ISWIM Tool

**ISWIM** (Programming Language For Mathematics) is a theoretical functional programming language developed by Peter Landin. This tool is dedicated to exploring the theoretical foundations of functional programming, specifically focusing on combinatory logic, lambda calculus, and symbolic computation.

## Features

- **Combinatory Logic Evaluation**: Implements a basic evaluator for combinatory logic expressions.
- **Lambda Calculus Simulation**: Simulates reduction steps in lambda calculus.
- **Symbolic Computation**: Provides a framework for symbolic manipulation of expressions.
- **Theoretical Exploration**: Allows users to experiment with abstract functional concepts in a structured environment.

## Usage

To use the ISWIM tool, you can load the main script and begin experimenting with combinatory logic expressions and lambda calculus reductions.

### Example

```iswim
let
  S = \x y z . x z (y z)
  K = \x y . x
  I = K K
in
  I 42
end
```

This tool is intended for educational and research purposes, providing insights into the history and theory of functional programming.
