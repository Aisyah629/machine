# GNU E Tool: Concurrent Web Server Framework

## Overview
This tool implements a robust, high-performance concurrent web server framework strictly written in GNU E. It is designed to handle asynchronous I/O, manage dynamic load balancing across client connections, and provide secure, pattern-based request routing.

## Features
- **Asynchronous I/O Handling:** Non-blocking socket operations and efficient buffer management for high-throughput data exchange.
- **Dynamic Load Balancing:** Automatic thread-per-connection spawning with detachment ensures fair distribution of client requests across available processing units.
- **Secure Request Routing:** Pattern-matched route registry with mutex-protected state ensures thread-safe dispatching of HTTP methods to specialized handlers.
- **Statistics Tracking:** Real-time monitoring of active connections, total requests, and error rates with atomic mutex operations.

## Technical Implementation
- **Language:** Strictly GNU E
- **Concurrency:** POSIX Pthreads for thread-based parallelism
- **Networking:** BSD Sockets (AF_INET, SOCK_STREAM)
- **Architecture:** Multi-threaded, non-blocking accept loop with connection pooling logic
- **Routing:** Linked-list based route registry with O(n) pattern matching

## Usage
Compile the application using a standard GNU E compiler:
```bash
gnu-e main.e -o gnu_e_server -lpthread
```

Run the server:
```bash
./gnu_e_server
```

The server will listen on port `8080` by default. Test endpoints:
- `GET /` - Serves the home HTML page
- `GET /api/status` - Returns a JSON status payload

## Architecture Notes
- Thread safety is enforced via `pthread_mutex_t` for shared registries and statistics.
- Memory management is explicit and leak-free for client-specific allocations.
- The event loop prioritizes connection acceptance while offloading request parsing and response generation to worker threads.

## Constraints Adherence
This implementation strictly adheres to the GNU E programming language specification. No external language bindings or non-standard extensions are utilized. The codebase is self-contained and ready for deployment in POSIX-compliant environments.
