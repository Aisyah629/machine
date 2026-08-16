# Genie Tool

## Overview
This tool provides a complete, functional development environment for **Genie**, a statically-typed object-oriented programming language designed to seamlessly interact with GNOME libraries (GTK, GObject, etc.). It enables developers to rapidly build cross-platform GUI applications using declarative syntax and robust signal-slot architecture.

## Key Features
- 🛠️ **Full Genie Compiler Integration**: Supports `.gs` source compilation, linking, and execution.
- 💥 **Signal-Slot Event Handling**: Native implementation of the GNOME signal system for clean decoupled event handling.
- 🧱 **Declarative Widget Layout**: Built-in helpers for constructing complex UI hierarchies efficiently.
- 🔧 **Dependency Management**: Automated resolution of `gtk+-3.0`/`gtk4` and `glib-2.0` dependencies.
- ⚡ **Reactive Data Binding**: Lightweight observer pattern implementation for UI state synchronization.

## Getting Started
1. Clone the repository.
2. Ensure GNOME/GTK development libraries are installed (`sudo apt install libgtk-3-dev` or equivalent).
3. Use the provided build script to compile and run examples.
4. Refer to `main.gs` for core functionality.

## Architecture
- `main.gs`: Entry point and core application logic.
- `widgets/`: Reusable UI component implementations.
- `signals/`: Event dispatcher and handler registry.
- `ui/`: Layout managers and declarative builders.

## License
MIT License
