# Lite-C Interactive Diagnostic and Visualization Tool

## Overview
This tool is a **Lite-C** application designed for real-time system diagnostics and data visualization. It monitors a simulated system state, detects anomalies, and renders a dynamic visualization of system metrics (CPU, Memory, Network) using a simple canvas-based approach.

## Features
1. **Interactive Diagnostic**: Real-time monitoring of simulated system parameters.
2. **Anomaly Detection**: Identifies and flags critical system states (e.g., high CPU usage).
3. **Visualization**: Renders a dynamic dashboard showing system metrics as visual elements.
4. **User Interface**: Includes buttons to start/stop monitoring and reset diagnostics.

## Prerequisites
- **Lite-C Compiler**: Ensure you have the Lite-C environment set up.
- **Graphics Library**: Requires the Lite-C graphics module for canvas rendering.

## Usage
1. Compile the script: `litec main.lc`
2. Run the executable: `main.exe`
3. Use the on-screen buttons to control the diagnostic session.

## Code Structure
- **main.lc**: Entry point, initializes the environment, sets up the UI, and runs the main loop.
- **DiagnosticEngine**: Core logic for monitoring and anomaly detection.
- **VisualizationEngine**: Handles drawing metrics and UI elements.

## License
MIT License
