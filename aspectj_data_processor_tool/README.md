# AspectJ Data Processor Tool

This tool implements a modular data processing pipeline using the AspectJ language. It demonstrates the power of Aspect-Oriented Programming (AOP) by cross-cutting concerns like logging, validation, and transformation across data processing operations.

## Features

- **Logging Aspect**: Automatically logs all data processing steps.
- **Validation Aspect**: Validates data integrity before processing.
- **Transformation Aspect**: Applies transformations to data fields.
- **Pipeline Orchestrator**: Coordinates the data processing stages.

## Usage

Compile and run the tool to process sample data through the defined pipeline.

## Architecture

- `DataProcessor.java`: The core data processor interface and implementation.
- `LoggingAspect.aj`: Captures logs for all data processing methods.
- `ValidationAspect.aj`: Validates data before processing.
- `TransformationAspect.aj`: Transforms data during processing.

## Dependencies

- AspectJ Compiler (ajc)
- Java Development Kit (JDK) 8 or higher

## License

MIT
