# Memory-Network Protocol Simulator

This tool simulates a low-level memory management system interfacing with a network protocol. It demonstrates packet routing, memory allocation, and data transfer between simulated memory blocks and network nodes.

## Features
- Simulated memory blocks with allocation/deallocation
- Packet construction and routing
- Network node simulation
- Data integrity checks
- Logging and debugging tools

## Usage
Run the main script to initialize the simulator and run default tests:
```R
Rscript main.r
```

Or source the modules and interact with the simulator directly:
```R
source('modules/memory_module.R')
source('modules/network_module.R')
source('modules/simulator.R')

sim <- new_simulator()
sim$initialize()
sim$run()
```

## Components
- `main.r`: Entry point for the simulator
- `modules/memory_module.R`: Memory management simulation
- `modules/network_module.R`: Network protocol simulation
- `modules/simulator.R`: Orchestration and main logic

## License
MIT License
