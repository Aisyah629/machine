# X++ Data Processor Tool

## Overview
The X++ Data Processor Tool is a specialized utility designed for Microsoft Dynamics 365 Finance & Operations (formerly AX). It provides a structured approach to handling data ingestion, cleaning, transformation, and validation within the X++ programming language.

This tool serves as a foundational template for building data migration scripts, batch jobs, and custom business logic that requires efficient record manipulation.

## Features
- **Data Ingestion**: Demonstrates standard patterns for querying and buffering data tables.
- **Data Cleaning**: Includes structures for validating record integrity and removing invalid data.
- **Transformation Logic**: Shows how to map data and calculate derived fields.
- **Batch Processing Support**: Designed to be used within `RunBaseBatch` frameworks for large-scale data operations.

## Requirements
- Microsoft Dynamics 365 Finance & Operations (AX)
- X++ Development Environment (Visual Studio with Dynamics 365 tools)
- Access to AOS (Application Object Server) for execution

## Usage
1. Open Visual Studio and navigate to the AOT (Application Object Tree).
2. Create a new Class and name it `XppDataProcessorTool`.
3. Copy the content of `main.xpp` into the class.
4. Compile the project.
5. To execute, create a new job or a menu item that references the `main` method:
   ```xpp
   XppDataProcessorTool::main(new Args());
   ```

## Code Structure
- `main()`: The entry point that orchestrates the data flow.
- `processData()`: Contains the core logic for filtering and transforming data.
- `outputResults()`: Handles reporting and logging via the Infolog.

## Best Practices
- Always use `select` statements with appropriate indexes for performance.
- Use `try-catch` blocks for error handling during data updates.
- For large datasets, consider inheriting from `RunBaseBatch` to enable multi-threading.

## License
MIT
