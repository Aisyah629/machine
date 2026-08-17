# Interactive CSP Diagnostic Tool

An interactive diagnostic and visualization tool built in CSP (Communicating Sequential Processes) to help developers and systems architects visualize, simulate, and debug concurrent processes.

## Features
- **Process Topology Visualization:** ASCII-based rendering of process graphs.
- **Event Stream Diagnostics:** Real-time simulation of synchronous events and message passing.
- **Deadlock & Starvation Detection:** Identifies structural issues in CSP specifications.
- **Interactive Input:** Allows users to define processes, channels, and connections interactively.

## Usage
1. Compile the tool (assuming a CSP compiler environment is set up, e.g., FDR or a custom CSP-to-C++ transpiler).
2. Run the tool to enter the interactive diagnostic mode.
3. Input your CSP process definitions or select a pre-loaded configuration.
4. Use the visualization commands to step through the state space and inspect event traces.

## File Structure
- `main.csp`: The core CSP specification and simulation logic for the diagnostic tool.

## Example Interaction
User inputs:
```
Process A = input -> output -> STOP
Process B = input -> output -> STOP
Channels: input, output
Connect A.output to B.input
```

Tool outputs a process graph and allows the user to run a simulation, displaying the trace of events.
