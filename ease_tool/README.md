# Ease Low-Level Network/Memory Simulator

## Overview
This tool provides a low-level simulator for memory management operations and TCP/IP network protocol interactions. It is designed to model memory allocation, deallocation, and fragmentation, as well as packet transmission, reception, and sequence number management.

## Features
- **Memory Management Simulation**: Simulates heap memory with fixed-size chunks, tracking free and allocated blocks.
- **Network Protocol Simulation**: Simulates a TCP-like connection with sequence numbers, acknowledgments, and packet loss/reordering simulation.
- **Event Loop**: Processes a queue of memory and network events in chronological order.

## Usage
To run the simulator, execute the Ease interpreter on `main.ace`:

```bash
ease main.ace
```

## Code Structure
- `Event`: Defines the structure for memory and network events.
- `MemoryManager`: Manages memory chunks and handles allocation/deallocation requests.
- `NetworkSimulator`: Handles TCP-like packet transmission and reception.
- `EventQueue`: Manages the chronological order of events.
- `main`: The entry point, demonstrating a sample simulation run.

## Example Output
The simulation will output:
- Memory allocation and deallocation logs.
- Network packet transmission, reception, and acknowledgment logs.
- Final status of memory fragmentation and network connection state.

## Notes
- This is a simplified simulation for educational and testing purposes.
- It does not replace real low-level systems programming but provides a framework for understanding underlying concepts.
