# Swift Parallel Script Tool

## Overview
This tool is designed for automated dataset cleaning and text formatting using Swift's parallel scripting capabilities. It leverages `Dispatch` and `Sendable` protocols to ensure safe and efficient parallel processing of text data.

## Features
- **Parallel Execution**: Utilizes Swift's concurrency features for parallel processing.
- **Clean Dataset**: Removes duplicates and formats text.
- **Safe Operations**: Ensures thread safety with `Sendable`.

## Usage
1. Define cleaning tasks in the `tasks` array.
2. Call `processDataset` with your dataset.
3. Results will be returned in a cleaned and formatted state.

## Example
```swift
let input = ["  Hello World  ", "  Hello World  ", "Goodbye World"]
let output = processDataset(dataset: input, tasks: tasks)
```
