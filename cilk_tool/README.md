# Cilk Parallel Task Scheduling Framework

This tool provides a high-performance parallel task scheduling and multi-threaded computation framework built strictly with Cilk. Cilk is designed to enable developers to harness the power of multicore processors through simple task parallelism constructs.

## Features

- **Parallel Task Execution:** Utilizes Cilk's built-in task parallelism to distribute workloads across available CPU cores.
- **Efficient Load Balancing:** Automatically balances the workload across threads to maximize performance.
- **Scalable Architecture:** Easily scalable to accommodate additional parallel tasks.

## Usage

Compile and run the Cilk code using a Cilk-compatible compiler (e.g., GCC with Cilk extensions).

```bash
gcc -fcilkplus -o cilk_tool main.cilk
./cilk_tool
```

## License

This project is open source.
