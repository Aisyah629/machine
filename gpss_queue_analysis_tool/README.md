# GPSS Queue Analysis Tool

## Overview
This tool is a discrete-event simulation system designed for analyzing multi-server queue performance and resource utilization bottlenecks. It is built strictly using the General Purpose Simulation System (GPSS) programming language.

## Features
- Multi-server queue simulation
- Real-time resource utilization monitoring
- Bottleneck analysis and reporting
- Customizable arrival and service time distributions
- Efficient event management and time advancement

## File Structure
- `main.gpss`: The primary GPSS simulation code.
- `README.md`: This documentation file.

## Usage
1. Load `main.gpss` into your GPSS-compatible simulator.
2. Configure the simulation parameters as needed.
3. Run the simulation to analyze queue performance and resource utilization.

## Constraints
- This tool must be built strictly using GPSS.
- Do not target the `.github` directory.
- Ensure all GPSS code is valid and functional.

## Notes
- The simulation model uses GPSS blocks such as GENERATE, SEIZE, DEPART, ARRIVE, etc., to represent the queueing system.
- Resource utilization is tracked using appropriate GPSS attributes and monitors.
- Bottleneck identification is performed by analyzing queue lengths and server busy times.
