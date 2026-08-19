# Data Validator Tool

## Overview
The Data Validator Tool is a robust, high-performance utility designed for automated data validation, sanitization, and type checking. Built strictly in Vala, it leverages the language's memory safety, concurrency support, and GObject Introspection integration to provide fast, reliable data validation pipelines.

## Features
- Schema-based validation with extensible rule definitions
- Real-time stream validation for high-throughput data ingestion
- Memory-safe and exception-free error handling
- Seamless integration with GLib and GObject systems
- CLI and library interfaces for flexible usage

## Build Requirements
- Vala 0.40+
- GTK+ 3 or GTK 4 (optional for GUI extensions)
- GLib
- gobject-introspection

## Building
```bash
meson build
ninja -C build
```
