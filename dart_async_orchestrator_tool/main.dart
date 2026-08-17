import 'dart:async';
import 'dart:isolate';

/// Represents a unit of work to be executed by the orchestrator.
class OrchestratedTask {
  final String id;
  final Future<void> Function() function;
  final bool isCpuBound;
  final Duration? timeout;

  OrchestratedTask({
    required this.id,
    required this.function,
    this.isCpuBound = false,
    this.timeout,
  });
}

/// A result container for completed tasks.
class TaskResult {
  final String taskId;
  final bool success;
  final String? error;
  final DateTime completedAt;

  TaskResult({
    required this.taskId,
    required this.success,
    this.error,
    required this.completedAt,
  });
}

/// The main orchestrator class managing asynchronous tasks and isolates.
class AsyncOrchestrator {
  final List<OrchestratedTask> _pendingTasks;
  final List<TaskResult> _completedTasks;
  final Map<String, Isolate> _isolates;
  final StreamController<TaskResult> _resultStreamController;

  /// Creates a new AsyncOrchestrator instance.
  AsyncOrchestrator() : _pendingTasks = [], _completedTasks = [], _isolates = {}, _resultStreamController = StreamController.broadcast() {
    _resultStreamController.onCancel = () {
      _cleanup();
    };
  }

  /// Creates a new task.
  ///
  /// [function] is the async function to execute.
  /// [isCpuBound] indicates if the task should run in an isolate.
  /// [timeout] is an optional timeout for the task.
  OrchestratedTask createTask(Future<void> Function() function, {bool isCpuBound = false, Duration? timeout}) {
    final task = OrchestratedTask(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      function: function,
      isCpuBound: isCpuBound,
      timeout: timeout,
    );
    _pendingTasks.add(task);
    return task;
  }

  /// Runs a specific task.
  ///
  /// Returns a [TaskResult] indicating the outcome.
  Future<TaskResult> run(OrchestratedTask task) async {
    try {
      if (task.isCpuBound) {
        return await _runInIsolate(task);
      } else {
        return await _runAsync(task);
      }
    } catch (e, st) {
      print('Error executing task ${task.id}: $e\n$st');
      final result = TaskResult(
        taskId: task.id,
        success: false,
        error: e.toString(),
        completedAt: DateTime.now(),
      );
      _completedTasks.add(result);
      _resultStreamController.add(result);
      return result;
    }
  }

  /// Runs a task in a separate isolate.
  Future<TaskResult> _runInIsolate(OrchestratedTask task) async {
    final receivePort = ReceivePort();
    final isolate = await Isolate.spawn(_taskIsolateEntrypoint, {
      'function': _wrapTaskForIsolate(task),
      'receivePort': receivePort.sendPort,
    });
    
    _isolates[task.id] = isolate;

    // Wait for the response
    final response = await receivePort.first;
    
    await isolate.kill(priority: Isolate.immediate);
    _isolates.remove(task.id);

    return TaskResult(
      taskId: task.id,
      success: response['success'],
      error: response['error'],
      completedAt: DateTime.now(),
    );
  }

  /// Entrypoint for tasks running in isolates.
  static void _taskIsolateEntrypoint(Map<String, dynamic> args) {
    final sendPort = args['receivePort'] as SendPort;
    final wrappedFunction = args['function'] as Future<void> Function();
    
    try {
      wrappedFunction();
      sendPort.send({'success': true, 'error': null});
    } catch (e) {
      sendPort.send({'success': false, 'error': e.toString()});
    }
  }

  /// Wraps a task function to be isolatable.
  Future<void> Function() _wrapTaskForIsolate(OrchestratedTask task) {
    return task.function;
  }

  /// Runs a task asynchronously on the main isolate.
  Future<TaskResult> _runAsync(OrchestratedTask task) async {
    try {
      Future<void> futureTask = task.function();
      
      if (task.timeout != null) {
        await futureTask.timeout(task.timeout!);
      } else {
        await futureTask;
      }

      final result = TaskResult(
        taskId: task.id,
        success: true,
        completedAt: DateTime.now(),
      );
      _completedTasks.add(result);
      _resultStreamController.add(result);
      return result;
    } catch (e, st) {
      print('Async task $task.id failed: $e\n$st');
      final result = TaskResult(
        taskId: task.id,
        success: false,
        error: e.toString(),
        completedAt: DateTime.now(),
      );
      _completedTasks.add(result);
      _resultStreamController.add(result);
      return result;
    }
  }

  /// Gets a stream of task results.
  Stream<TaskResult> get resultStream => _resultStreamController.stream;

  /// Cleans up resources.
  void _cleanup() {
    for (final isolate in _isolates.values) {
      isolate.kill(priority: Isolate.immediate);
    }
    _isolates.clear();
    _resultStreamController.close();
  }

  /// Disposes the orchestrator.
  void dispose() {
    _cleanup();
  }
}

void main() async {
  final orchestrator = AsyncOrchestrator();

  // Example 1: Async Task
  print('Starting Async Task...');
  final asyncTask = orchestrator.createTask(() async {
    await Future.delayed(Duration(seconds: 2));
    print('Async Task completed.');
    return;
  }, isCpuBound: false);

  await orchestrator.run(asyncTask);

  // Example 2: CPU Bound Task (Simulated)
  print('Starting CPU Bound Task...');
  final cpuBoundTask = orchestrator.createTask(() async {
    // Simulate heavy computation
    var sum = 0;
    for (var i = 0; i < 100000000; i++) {
      sum += i;
    }
    print('CPU Bound Task result: $sum');
    return;
  }, isCpuBound: true);

  await orchestrator.run(cpuBoundTask);

  // Example 3: Error Handling
  print('Starting Error Task...');
  final errorTask = orchestrator.createTask(() async {
    throw Exception('Simulated error');
  }, isCpuBound: false);

  await orchestrator.run(errorTask);

  // Listen to results stream
  orchestrator.resultStream.listen((result) {
    print('Result received: Task ${result.taskId} - Success: ${result.success}');
  });

  // Wait a bit to allow stream listeners to process
  await Future.delayed(Duration(seconds: 1));

  orchestrator.dispose();
  print('Orchestrator disposed.');
}
