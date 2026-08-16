# AspectJ Crosscutting Engine Tool

## Overview

This tool provides an aspect-oriented performance monitoring framework built using AspectJ. It demonstrates advanced cross-cutting concern management, including method execution timing, exception handling, and logging through aspects.

## Features

- **Method Execution Monitoring**: Automatically logs method entry, exit, and execution time for annotated methods.
- **Exception Tracking**: Captures and logs exceptions thrown by monitored methods.
- **Performance Metrics**: Collects performance metrics that can be exported or analyzed.
- **Extensible Architecture**: Easy to extend with additional aspects for different cross-cutting concerns.

## File Structure

- `main.java`: Main application code with annotated methods to be monitored.
- `PerformanceMonitor.java`: AspectJ aspect that handles performance monitoring.
- `ExceptionMonitor.java`: AspectJ aspect that handles exception monitoring.
- `Logger.java`: Utility class for logging messages.
- `README.md`: This documentation file.

## Prerequisites

- Java Development Kit (JDK) 8 or higher
- Maven
- AspectJ compiler (ajc)

## Setup

1. Clone the repository.
2. Navigate to the project directory.
3. Compile and run the project using Maven:
   ```bash
   mvn clean compile
   mvn exec:java -Dexec.mainClass="main.java"
   ```

## Usage

- Annotate methods with `@Monitor` to enable performance monitoring.
- Configure logging levels and metrics collection in the `Logger.java` and `PerformanceMonitor.java` files.

## License

This project is licensed under the MIT License.
