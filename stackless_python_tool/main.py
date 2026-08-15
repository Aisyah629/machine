import stackless

class StacklessTaskRunner:
    """A simple task runner utilizing Stackless Python microthreads."""
    def __init__(self):
        self.channel = stackless.channel()
        self.task_counter = 0

    def create_microtask(self, target, args=(), kwargs=None):
        """Schedule a new microtask."""
        if kwargs is None:
            kwargs = {}
        task = stackless.tasklet(target)(*args, **kwargs)
        self.task_counter += 1
        print(f"Created microtask #{self.task_counter}")
        return task

    def run_until_complete(self):
        """Run all scheduled microtasks until they are done."""
        print("Starting Stackless task execution...")
        while stackless.getcurrent().next:  # Checks if there are more ready tasks
            stackless.run()
        print("All microtasks completed.")

    def stop(self):
        """Stop the scheduler."""
        stackless.run()
        print("Scheduler stopped.")

def dummy_work(task_id, delay=0.1):
    """Simulates asynchronous work for a given task ID."""
    import time
    print(f"[Task {task_id}] Started.")
    time.sleep(delay)  # In real usage, this would yield to the scheduler
    print(f"[Task {task_id}] Finished.")
    # Note: For true Stackless concurrency, tasks would yield via channel.send/receive

def demo_concurrency():
    """Demonstrates basic Stackless concurrency concepts."""
    runner = StacklessTaskRunner()
    
    for i in range(5):
        runner.create_microtask(dummy_work, args=(i+1,))
        
    try:
        runner.run_until_complete()
    except Exception as e:
        print(f"Execution error: {e}")
    finally:
        runner.stop()

if __name__ == "__main__":
    print("Initializing Stackless Python Tool...")
    demo_concurrency()
    print("Tool execution complete.")
