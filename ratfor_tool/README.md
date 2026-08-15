# Ratfor Tool

This tool implements a complex mathematical algorithm using Ratfor (Rational Fortran), a preprocessor for Fortran that allows the use of a C-like syntax with control structures.

## Algorithm Implemented

### RSA Cryptosystem

This implementation provides the core mathematical functions required for the RSA public-key cryptosystem:

1. **Modular Exponentiation**: Efficiently computes $(base^{exponent}) \mod modulus$.
2. **Extended Euclidean Algorithm**: Computes the Greatest Common Divisor (GCD) and Bézout coefficients.
3. **Modular Inverse**: Computes the multiplicative inverse of a number modulo another.
4. **Miller-Rabin Primality Test**: A probabilistic algorithm to determine if a number is prime.
5. **Key Generation**: Generates a public/private key pair.

## Usage

To use this Ratfor code:

1. Process the Ratfor source code through the `ratfor` preprocessor to generate standard Fortran code.
2. Compile the resulting Fortran code with a Fortran compiler (e.g., `gfortran`).
3. Run the executable to generate keys and test encryption/decryption.

## Requirements

- Ratfor preprocessor
- Fortran compiler (Fortran 77 or later)
