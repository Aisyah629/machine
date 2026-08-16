# JEAN Tool - Concurrent Task Scheduler

This tool is a distributed task scheduler built strictly using the **JEAN** programming language. It demonstrates concurrency, distributed communication, and task management patterns.

## Features

- **Distributed Architecture**: Supports multiple scheduler nodes communicating via message passing.
- **Concurrent Execution**: Handles multiple tasks simultaneously within a node.
- **Status Monitoring**: Nodes broadcast their status (IDLE/EXECUTING) via heartbeat signals.
- **Task Queueing**: Efficiently manages incoming and active tasks.

## Files

- `main.jean`: The core implementation of the scheduler system.

## Usage

To run this tool, execute the JEAN runtime with the provided source:

```bash
jean main.jean
```

## Language Specification

This tool is written exclusively in **JEAN**. It utilizes:
- Records for data structures (`Task`, `Result`)
- Enums for state management (`Status`)
- System definitions for component encapsulation
- Message-passing ports for inter-node communication
- Concurrent behaviors using `spawn` and `yield`
