# PEARL Tool

This tool is built using the PEARL programming language (Procedure and Event-oriented Abstract Language for Real-Time systems).

## Purpose

This tool implements a real-time embedded system simulation and task scheduling environment using PEARL. It demonstrates the language's capabilities in defining tasks, events, and managing real-time execution flow.

## Features

- **Task Definition**: Declares periodic and aperiodic tasks.
- **Event Handling**: Manages event queues and priority-based scheduling.
- **Simulation Loop**: Runs a simplified discrete-event simulation cycle.
- **Status Output**: Prints task execution logs and scheduling decisions.

## File Structure

- `main.pl` (or `main.pl_` as per PEARL conventions, but stored as `.pl` for generic access)

## Usage

Compile and run the PEARL code using a compliant PEARL compiler (e.g., PEARL-2016 compliant toolchain). Due to the strict real-time typing and task declaration syntax, a standard compiler is required to process the `TASK` and `EVENT` declarations effectively.

## Notes on PEARL

PEARL is a real-time systems programming language developed in Germany. It emphasizes structured programming, data types, and explicit task scheduling, making it ideal for safety-critical embedded applications like automotive and industrial control systems.
