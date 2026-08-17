# Seed7 Expression Evaluator Tool

## Overview
This tool implements a robust expression parser and evaluator in Seed7, optimized for algebraic syntax and dynamic typing. It supports standard arithmetic operations, variable substitution, and function evaluation.

## Features
- Parse and evaluate mathematical and logical expressions
- Support for variables and constants
- Function evaluation
- Error handling for invalid syntax and runtime errors

## Usage
To use the expression evaluator, include the seed7 file `main.sd` in your Seed7 program and call the appropriate functions to parse and evaluate expressions.

## Example
```seed7
$ include "std/io.s7i";
$ include "main.sd";

const proc: main is func
  local
    var expression: expr is "";
    var integer: result is 0;
  begin
    expr := parseExpression("2 + 3 * 4");
    result := evaluateExpression(expr);
    writeln("Result: ", result);
  end func;
```
