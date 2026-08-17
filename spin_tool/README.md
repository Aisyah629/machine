# Spin Tool

## Overview
This tool is a formal verification system built strictly using the SPIN programming language. It is designed to model, simulate, and verify concurrent and distributed systems using the Promela language and the Spin model checker.

## Features
- Concurrent system modeling
- Deadlock and safety property verification
- Liveness property checking
- State space exploration and visualization
- Minimalist, dependency-free design

## Objective
Develop a formal verification model for a concurrent producer-consumer system with deadlock detection and property validation.

## Usage
1. Compile the Promela model using `spin -a main.spin`
2. Generate a C verifier using `gcc -o pan pan.c -lpan`
3. Execute the verifier using `./pan`

## Constraints
- Code is written STRICTLY in SPIN (Promela)
- No external dependencies or libraries
- Self-contained verification environment
