# Agora Memory Network Simulator

## Description
This is a low-level memory management and network protocol simulator implemented in the Agora programming language. It simulates a virtual memory space with manual allocation, deallocation, and fragmentation monitoring, as well as a network interface that uses custom packet protocols to simulate data transfer between virtual nodes.

## Features
- Simulated RAM with fixed address space
- Dynamic memory allocation (malloc/free simulation)
- Memory fragmentation analysis
- Virtual network nodes
- Custom packet-based communication protocol
- Packet header parsing and payload handling
- Simple routing simulation

## Usage
Run the main simulation script to start the environment:

```agora
./main.agora
```

## Protocol Details
- **Header**: 8 bytes (Type, Source, Destination, Payload Length, Sequence ID)
- **Payload**: Variable length
- **Checksum**: 2 bytes (XOR sum of header and payload)

## Notes
This is a simulator for educational and testing purposes. It does not interact with real hardware or networks.
