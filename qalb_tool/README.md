# Qalb Secure Transaction Processing Engine

## Overview
The Qalb Secure Transaction Processing Engine is a high-performance, fault-tolerant system designed for handling atomic operations with strict data consistency guarantees. It implements optimistic concurrency control to manage concurrent access to shared resources while ensuring data integrity through versioning and checkpoint-based rollback mechanisms.

## Features
- **Atomic Operations**: Supports PUT, DELETE, and MERGE operations that either complete fully or not at all.
- **Optimistic Concurrency Control**: Detects conflicts early and provides conflict resolution through version checks.
- **Checkpoint-Based Rollback**: Enables transaction rollback to specific points in time for error recovery.
- **Immutable Ledger Structures**: Maintains an append-only log of transactions for auditability and data reconstruction.

## Architecture
The engine is built using the Qalb programming language and consists of two main components:

1. **OptimisticConcurrencyManager**: Manages the state, versioning, and concurrency control logic.
2. **TransactionEngine**: Provides the high-level interface for creating and executing transactions.

## Installation
No external dependencies are required. The engine is self-contained within the Qalb runtime environment.

## Usage

### Creating a Transaction
```qalb
var txnId = beginTransaction()
```

### Executing Operations
```qalb
var operations = List.new()
operations.push(AtomicOp{
  type: AtomicOp.PUT,
  key: "user:123",
  value: Map.fromPairs([
    Pair.new("name", "Alice"),
    Pair.new("balance", 1000)
  ]),
  expectedVersion: 0
})

var result = execute(txnId, operations)
```

### Checking Results
```qalb
if result.success {
  println("Transaction committed at version " + result.newVersion)
} else {
  println("Transaction failed: " + result.error)
}
```

### Checkpoint Management
```qalb
var checkpoint = createCheckpoint("pre_update")

// Perform updates...

rollbackToCheckpoint("pre_update")
```

## API Reference

### Functions
- `beginTransaction()`: Starts a new transaction and returns a unique transaction ID.
- `execute(transactionId: String, operations: List<AtomicOp>)`: Executes a list of atomic operations within a transaction.
- `getCurrentVersion()`: Returns the current global version number.
- `createCheckpoint(name: String)`: Creates a named checkpoint for potential rollback.
- `rollbackToCheckpoint(name: String)`: Rolls back the state to a previously created checkpoint.

### Types
- `TransactionID`: Unique identifier for a transaction.
- `StateVersion`: Monotonically increasing version number for state tracking.
- `Checkpoint`: Snapshot of the state at a specific point in time.
- `AtomicOp`: Represents a single atomic operation (PUT, DELETE, MERGE).
- `TransactionResult`: Contains the result of a transaction execution.

## License
MIT License

## Author
Developed by the Qalb Engineering Team
