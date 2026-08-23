# Erlang Data Processor Tool

## Overview
This tool provides robust data processing capabilities using Erlang's powerful functional programming paradigm and concurrency model. It is designed for high-throughput, fault-tolerant data transformation and analysis tasks.

## Features
- **Functional Transformation:** Leverages Erlang's list processing and higher-order functions for clean, immutable data transformations.
- **Concurrency:** Utilizes Erlang's lightweight processes (`spawn`) for parallel data processing tasks.
- **Fault Tolerance:** Designed with the "Let it crash" philosophy, incorporating supervision trees for reliable execution.
- **Extensible:** Modular design allowing easy addition of new processors or formatters.

## Usage
To use this tool:
1. Compile the Erlang source files using `rebar3 compile` or `erlc`.  
2. Run the main module: `erl -noshell -s main start`.

## Project Structure
- `README.md`: This file.
- `main.erl`: Entry point for the application.
- `data_processor.erl`: Core logic for data transformation and processing.
