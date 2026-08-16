# CMS EXEC TOOL

## Overview
The CMS EXEC TOOL is a deterministic state machine executor with dynamic script compilation and memory-safe execution. It serves as a lightweight runtime for executing control scripts written in the CMS EXEC language. Designed for environments requiring strict determinism and reliability, it is ideal for embedded systems, automation workflows, and critical process control.

## Features

- **Deterministic State Machines:** Ensures predictable behavior through explicit state transitions and guards.
- **Dynamic Script Compilation:** Parses and compiles scripts at runtime, allowing for flexible and adaptable workflows.
- **Memory-Safe Execution:** Custom memory allocator prevents buffer overflows and memory corruption.
- **Lightweight and Portable:** Minimal dependencies and efficient design suitable for constrained environments.
- **Extensible API:** Provides a robust C API for integrating with other applications.

## Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/cms-exec-tool.git
   cd cms-exec-tool
   ```

2. **Compile the tool:**
   ```bash
   gcc -o cms_exec main.cms -lm
   ```

3. **Run the tool:**
   ```bash
   ./cms_exec <script_file>
   ```

## Usage

### Writing a CMS EXEC Script

A CMS EXEC script consists of states and transitions. Here is a simple example:

```cms
// Define a start state
state start {
    entry: print("Starting process...");
    transition condition="always" to="process";
}

// Define a processing state
state process {
    entry: perform_work();
    transition condition="work_done" to="finish";
}

// Define a finish state
state finish {
    entry: print("Process complete.");
}
```

### Integrating with the API

You can integrate the CMS EXEC runtime into your C applications using the provided API functions:

```c
#include "cms_exec.h"

int main() {
    // Create a state machine
    state_machine_t *machine = create_state_machine();
    
    // Parse a script
    script_parser_t *parser = parse_script(script_buffer, script_size);
    
    // Compile the script into the machine
    compiler_t *compiler = compile_script(parser, machine);
    
    // Execute the compiled machine
    if (compiler->error_occurred) {
        fprintf(stderr, "Error: %s\n", compiler->error_message);
    } else {
        run_machine(machine);
    }
    
    // Cleanup
    destroy_compiler(compiler);
    destroy_state_machine(machine);
    
    return 0;
}
```

## Configuration

- `MAX_STATE_COUNT`: Maximum number of states in a single machine (default: 1024).
- `MAX_STACK_SIZE`: Maximum stack size for execution context (default: 4096).
- `MAX_SCRIPT_SIZE`: Maximum size of a script file (default: 1MB).

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

## Contributing

Contributions are welcome! Please submit a pull request or open an issue for suggestions and improvements.

## Acknowledgments

- Inspired by the need for deterministic execution in control systems.
- Built with performance and safety in mind.
