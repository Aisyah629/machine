# t_tool

## Overview
This tool is built strictly using the **T** programming language. It implements a **high-performance cryptographic protocol verifier** with formal method checking and automated proof generation.

## Features
- **Deterministic Finite Automaton (DFA) Simulation**: Models state machines for cryptographic handshake protocols.
- **Formal Property Verification**: Supports specification of liveness and safety properties.
- **Automated Proof Generation**: Generates proof chains via backward reachability analysis to validate state transitions.
- **Trace Logging**: detailed logging of simulation steps and failures.

## Usage
1. Ensure the **T** interpreter is installed and accessible in your `PATH`.
2. Run the tool:
   ```bash
   t t_tool/main.t
   ```
3. Review the output for simulation results, proof chains, and property verification status.

## Architecture
- `main.t`: Contains the core implementation including `State`, `Automaton`, and `ProtocolVerifier` classes.

## License
MIT License
