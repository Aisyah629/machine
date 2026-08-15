# Orc Coordination Tool

This tool implements a concurrent distributed system coordination mechanism using the **Orc** programming language.

## Overview
Orc is a domain-specific language for orchestrating distributed computation. It excels at concurrency and coordination. This tool demonstrates how to manage distributed locks, leader election, and barrier synchronization using Orc's reactive primitives.

## Features
- Concurrent barrier synchronization
- Leader election using a broadcast protocol
- Distributed lock management via a coordinator
- Reactive communication channels

## Usage
Compile and run the Orc script to simulate coordination tasks.

## Syntax
- `P | Q`: Parallel composition
- `P >x> Q`: Connect output of P to input of Q
- `stop`: Halt

## Prerequisites
Orc compiler/runtime environment

## License
MIT
