# Machine Code Tool

## Overview
A low-level instruction decoder and binary execution simulator designed for educational and debugging purposes. This tool implements a minimalistic 32-bit bytecode architecture with a comprehensive instruction set, hardware registers, virtual memory, and a runtime execution trace logger.

## Architecture Specifications
- **Word Size**: 32-bit
- **Endianness**: Little-endian
- **Instruction Format**: 8-bit opcode, 4-bit operand size field, 20-bit immediate/data payload
- **Register File**: 16 general-purpose registers (R0-R15) + 6 special registers (Base, Stack, IP, Accumulator, GPRs, Flags)
- **Memory Space**: 64KB virtual RAM
- **Execution Trace**: Circular buffer logging up to 1024 instruction cycles

## Instruction Set
| Opcode | Mnemonic | Description |
|--------|----------|-------------|
| 0x00   | NOP      | No operation |
| 0x01   | HALT     | Terminate execution |
| 0x02   | MOV      | Move data between registers |
| 0x03   | ADD      | Register addition |
| 0x04   | SUB      | Register subtraction |
| 0x05   | MUL      | Register multiplication |
| 0x06   | DIV      | Integer division |
| 0x07   | AND      | Bitwise AND |
| 0x08   | OR       | Bitwise OR |
| 0x09   | NOT      | Bitwise NOT |
| 0x0A   | SHL      | Shift left |
| 0x0B   | SHR      | Shift right |
| 0x0C   | CMP      | Compare operands |
| 0x0D   | JMP      | Unconditional jump |
| 0x0E   | JEQ      | Jump if equal |
| 0x0F   | JNE      | Jump if not equal |
| 0x10   | JLT      | Jump if less than |
| 0x11   | JGT      | Jump if greater than |
| 0x12   | PUSH     | Push to stack |
| 0x13   | POP      | Pop from stack |
| 0x14   | CALL     | Subroutine call |
| 0x15   | RET      | Return from subroutine |
| 0x16   | INP      | Input from port |
| 0x17   | OUT      | Output to port |
| 0x18   | LOAD     | Load from memory |
| 0x19   | STORE    | Store to memory |
| 0x1A   | INC      | Increment register |
| 0x1B   | DEC      | Decrement register |
| 0x1C   | NEG      | Negate value |
| 0x1D   | XOR      | Bitwise XOR |
| 0x1E   | SHC      | Rotate left |
| 0x1F   | SHR_S    | Arithmetic shift right |

## Execution Flow
1. **Initialization**: Registers cleared, memory zeroed, IP/SP set, flags reset
2. **Fetch**: Read next instruction from memory at IP, increment IP
3. **Decode**: Extract opcode, operand size, and immediate data
4. **Execute**: Perform operation, update flags, handle control flow
5. **Trace**: Log opcode and IP to execution buffer for debugging
6. **Loop**: Repeat until HALT or execution error

## Trace Logging
The simulator maintains a circular trace buffer capturing:
- Instruction opcode executed
- Instruction pointer value at execution
- Cycle counter and elapsed time metrics
- Register state snapshots (optional)

## Usage Example
```assembly
;; Load base address and immediate value
MOV R0, #0x1000
MOV R1, #0x00000042

;; Perform arithmetic
ADD R2, R0, R1
CMP R2, #0x1042
JEQ match_found
MOV R3, #FAILURE
JMP done
match_found:
MOV R3, #SUCCESS
done:
HALT
```

## Debugging Features
- Step-by-step instruction execution
- Register dump at any cycle
- Memory breakpoint support
- Execution trace export
- Cycle-accurate timing simulation

## System Requirements
- Compatible with any environment supporting raw binary execution
- Minimal I/O abstraction layer for hardware simulation
- Portable bytecode format for cross-platform debugging

## License & Distribution
Designed for educational hardware simulation and low-level software debugging. Not intended for production deployment.
