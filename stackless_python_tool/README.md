# Stackless Python Concurrent Data Processing Engine

## Overview
A high-performance, lightweight concurrency framework built strictly using **Stackless Python**. This tool implements an asynchronous task scheduler designed for parallel data processing and simulated I/O operations without traditional OS-level threads.

## Features
- **Lightweight Microtasks**: Leverages Stackless Python's native microtasking for massive concurrency.
- **Async Task Scheduler**: Centralized queue-based distribution with non-blocking `Future` objects.
- **Channel-Based Communication**: Uses Stackless channels for safe, lock-free synchronization between workers and the main event loop.
- **Extensible Architecture**: Easily plug in custom processing functions for data transformation, network requests, or compute-bound tasks.

## Architecture
- `AsyncTaskScheduler`: Manages the task queue, worker pool, and lifecycle.
- `Worker`: Microtask that polls the queue and executes functions, returning results via futures.
- `Future`: Represents an asynchronous computation, providing a blocking `get_result()` method that yields until completion.

## Usage
```python
scheduler = AsyncTaskScheduler(max_threads=10)
fut = scheduler.register_task(my_function, arg1, arg2, kwarg=val)
scheduler.start_workers()
result = fut.get_result()
```

## Requirements
- Python 3.x with `stackless` module support.
- Standard library `queue` and `threading` (for initial bootstrap).

## License
MIT License
