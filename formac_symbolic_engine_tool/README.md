# FORMAC Symbolic Engine Tool

## Description
This tool implements a symbolic computation engine for automated matrix algebra and polynomial simplification, built strictly using the FORMAC programming language. FORMAC (Formula Compiler) is designed for high-performance symbolic and numerical computation.

## Features
- **Symbolic Differentiation**: Automatically compute derivatives of symbolic expressions.
- **Matrix Operations**: Perform matrix multiplication, inversion, and eigenvalue computation.
- **Polynomial Simplification**: Simplify and expand polynomial expressions.
- **Equation Solving**: Solve simple systems of linear equations.

## Usage
Compile the `main.frac` file using a FORMAC compiler and run the resulting executable. 

### Example Code Structure
```frac
C MATRIX A(3,3), B(3,3), C(3,3)
C DATA A=1,2,3,4,5,6,7,8,9, 1,0,1,0,1,0,1,0,1, 0,1,0,1,0,1,0,1,0
C COMPUTE B = INV(A)
C MULTIPLY C BY A AND B
``` 

## Constraints
- This tool must be built strictly using the FORMAC programming language.
- No external dependencies or libraries are permitted beyond standard FORMAC runtime.

## License
MIT
