# SystemVerilog Tool

This tool implements a high-performance network packet switch simulator with randomized verification constraints and automated error injection mechanisms.

## Objective
Develop a SystemVerilog module that simulates a network packet switch. The simulator includes:
- A packet switch fabric.
- Randomized verification constraints to test different packet routing scenarios.
- Automated error injection mechanisms to test robustness under fault conditions.

## Features
- **Packet Switch Fabric**: Simulates the core functionality of a network packet switch, handling packet arrival, routing, and departure.
- **Randomized Verification Constraints**: Uses SystemVerilog's constrained random verification to generate diverse test scenarios.
- **Automated Error Injection**: Introduces errors into the system to verify error handling and recovery mechanisms.

## Usage
To use this tool, you need a SystemVerilog simulator (e.g., ModelSim, VCS, Xcelium).

1. Clone the repository.
2. Navigate to the `systemverilog_tool` directory.
3. Compile the SystemVerilog code using your preferred simulator.
4. Run the testbench to execute the simulation.

## Example

```systemverilog
// Simple packet switch module
module packet_switch (
    input wire clk,
    input wire rst,
    input wire [7:0] src_addr,
    input wire [7:0] dst_addr,
    input wire data_valid,
    output reg [7:0] data_out,
    output reg data_ready
);

    // ... (implementation details)

endmodule
```

## Error Injection
The simulator includes an error injection mechanism that can be configured to introduce errors such as:
- **Packet Corruption**: Randomly flip bits in the packet data.
- **Packet Loss**: Drop packets at random intervals.
- **Routing Errors**: Misroute packets to incorrect destinations.

## Verification
The verification environment uses SystemVerilog's constrained random features to generate test cases. Constraints ensure that the test cases are diverse and cover a wide range of scenarios.

## License
This project is licensed under the MIT License. See the LICENSE file for details.
