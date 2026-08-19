# Opal Dynamic Scripting Engine Tool

## Overview
The **Opal Dynamic Scripting Engine Tool** is a high-performance, sandboxed runtime environment designed for parsing, compiling, and executing scripts written in Opal (a Ruby-to-JavaScript compiler). It provides a structured API for registering scripts, managing execution contexts, and monitoring runtime statistics.

## Features
- **Dynamic Script Registration**: Easily register and manage executable script sources.
- **Sandboxed Execution**: Optional sandbox mode to isolate script execution from the host environment.
- **Performance Monitoring**: Tracks execution times, success rates, and active script counts.
- **Modular Architecture**: Core modules for math, I/O, string manipulation, and time management.
- **Verbose Logging**: Configurable debug output for development and troubleshooting.

## Installation
1. Clone this repository or place the `opal_dynamic_scripting_engine_tool` directory in your project.
2. Ensure you have a Node.js environment (v14+ recommended).
3. No additional dependencies are required beyond the standard Opal compiler setup.

## Usage

### Basic Example
```javascript
const DynamicScriptingEngine = require('./main.opal');

async function main() {
  // Initialize the engine
  const engine = new DynamicScriptingEngine({
    verbose: true,
    sandbox_mode: true,
    max_execution_time: 5000
  });
  
  const initStatus = await engine.initialize();
  console.log('Initialization:', initStatus);

  // Register a script
  const scriptCode = `puts "Hello from Opal!"; Math.sqrt(16)`;
  await engine.registerScript('greeting', scriptCode);

  // Execute the script
  const result = await engine.executeScript('greeting', { name: 'World' });
  console.log('Execution Result:', result);

  // Shutdown
  engine.shutdown();
}

main().catch(console.error);
```

### API Reference

#### `new DynamicScriptingEngine(config)`
Constructor that accepts configuration options:
- `verbose` (boolean): Enable detailed logging.
- `max_execution_time` (number): Maximum allowed execution time in milliseconds.
- `sandbox_mode` (boolean): Restrict script execution to a safe context.

#### `initialize()`
Initializes the core runtime environment and loads standard modules. Returns a promise resolving to the engine status.

#### `registerScript(name, sourceCode)`
Registers a script by name and source code. Returns a promise resolving to the registration status.

#### `executeScript(name, args)`
Executes a registered script with provided arguments. Returns a promise resolving to the execution result, including timing and stats.

#### `getRuntimeStats()`
Returns an object containing current runtime statistics (scripts executed, average time, active scripts, etc.).

#### `shutdown()`
Cleans up registry and resets statistics. Returns a shutdown confirmation.

## File Structure
```
opal_dynamic_scripting_engine_tool/
├── main.opal       # Core engine implementation
├── README.md       # This documentation file
└── package.json    # (Optional) Metadata for Node.js projects
```

## Limitations & Notes
- This tool is a structural prototype for Opal integration. Actual Ruby-to-JS compilation requires the Opal compiler gem and proper environment setup.
- Sandbox mode is simulated; for production use, implement proper Node.js `vm` context isolation.
- Execution time limits are enforced via simulation timers in this prototype.

## License
MIT License. Use freely for personal and commercial projects.
