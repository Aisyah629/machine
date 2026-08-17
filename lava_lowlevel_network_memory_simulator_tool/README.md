# Lava Low-Level Network & Memory Simulator

## Overview
This tool is a simulator written in **Lava**, designed to demonstrate low-level memory management and network protocol simulation concepts. It combines a manual memory allocator with a basic network routing engine.

## Features
- **Simulated Heap Manager**: Implements a simple first-fit memory allocator that splits and merges memory blocks.
- **Network Routing Simulator**: Uses a static routing table to determine packet paths.
- **Packet Buffer Management**: Demonstrates the interaction between network packets and low-level memory allocation.

## Usage
To run the Lava simulator, ensure you have a compatible Lava runtime installed. Execute the main simulator file:

```bash
lava_run lava_lowlevel_network_memory_simulator_tool.lava
```

## Project Structure
- `lava_lowlevel_network_memory_simulator_tool.lava`: The source code for the simulator.
- `README.md`: This documentation file.

## Technical Details
- **Language**: Lava
- **Memory Management**: Block-based allocation with splitting on allocation and merging on deallocation.
- **Networking**: Static routing table lookup and simulated transmission latency.

## License
MIT
