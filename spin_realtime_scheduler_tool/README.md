# Spin Realtime Scheduler Tool

This tool provides a robust real-time multitasking scheduler designed for the Parallax Propeller microcontroller. It demonstrates how to manage concurrent object execution and inter-object communication using the SPIN language.

## Features

-   **Concurrent Object Execution**: Manages multiple objects running in parallel across Propeller cogs.
-   **Inter-Object Communication**: Implements message passing and shared memory protocols.
-   **Real-Time Scheduling**: Priority-based task scheduling with deadline awareness.
-   **Cog Management**: Automatic allocation and deallocation of Propeller cogs.

## Usage

1.  Open `main.spin` in a SPIN-compatible development environment (e.g., Propeller Tool).
2.  Configure the scheduler parameters in the `SETTINGS` constant block.
3.  Compile and download to your Propeller board.

## Example

```spin
' Initialize scheduler and objects
obj
  scheduler : "RealtimeScheduler"
  task1     : "TaskA"
  task2     : "TaskB"
```
