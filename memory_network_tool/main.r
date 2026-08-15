#!/usr/bin/env Rscript
# Memory-Network Protocol Simulator Main Entry Point

# Source modules
source('modules/memory_module.R')
source('modules/network_module.R')
source('modules/simulator.R')

# Main simulation runner
run_simulation <- function() {
  cat("=== Memory-Network Protocol Simulator ===\n")
  cat("Initializing simulator...\n")
  
  # Create and initialize simulator
  sim <- new_simulator()
  sim$initialize()
  
  cat("Simulator initialized successfully.\n")
  cat("Running simulation...\n\n")
  
  # Run simulation
  sim$run()
  
  cat("\nSimulation completed.\n")
  cat("=== End of Simulation ===\n")
}

# Run the simulation
if (!interactive()) {
  run_simulation()
}
