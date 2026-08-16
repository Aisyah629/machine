# Prolog Constraint Solver Tool

## Description
This tool provides a Prolog-based constraint satisfaction solver. It allows users to define variables, domains, and constraints, and then finds valid solutions that satisfy all constraints.

## Features
- Define variables and their domains
- Set up constraints (arithmetic, comparison, etc.)
- Solve constraint satisfaction problems
- Find all possible solutions or a single solution

## Usage
To use this tool, load the Prolog source file and call the `solve/1` predicate with your constraints.

## Example
```prolog
% Example usage in Prolog
?- solve([X #= Y + Z, X #\= 5, Y #\= 1, Z #\= 2, X #> 0]).
```
