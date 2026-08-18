import stackless
import queue
import threading

class AsyncTaskScheduler:
    def __init__(self, max_threads=10):
        self.task_queue = queue.Queue()
        self.channel = stackless.channel()
        self.max_threads = max_threads
        self.running = True
        self.workers = []
        
    def register_task(self, func, *args, **kwargs):
        future = Future()
        self.task_queue.put((func, args, kwargs, future))
        return future
    
    def start_workers(self):
        for i in range(self.max_threads):
            worker = Worker(self.task_queue, self.channel)
            self.workers.append(worker)
            stackless.tasklet(worker.run)()
        stackless.run()
    
    def shutdown(self):
        self.running = False
        for _ in self.workers:
            self.channel.send('SHUTDOWN')

class Future:
    def __init__(self):
        self.result = None
        self.ready = False
        self.channel = stackless.channel()
        
    def set_result(self, result):
        self.result = result
        self.ready = True
        self.channel.send(result)
        
    def get_result(self, timeout=None):
        if self.ready:
            return self.result
        return self.channel.receive(timeout=timeout)

class Worker:
    def __init__(self, task_queue, control_channel):
        self.task_queue = task_queue
        self.control_channel = control_channel
        
    def run(self):
        while True:
            try:
                func, args, kwargs, future = self.task_queue.get(timeout=0.1)
                try:
                    result = func(*args, **kwargs)
                    future.set_result(result)
                except Exception as e:
                    future.set_result(e)
            except queue.Empty:
                msg = self.control_channel.receive()
                if msg == 'SHUTDOWN':
                    break

def example_data_processing(data):
    return sum(x * 2 for x in data)

def example_io_simulation(filename):
    import time
    time.sleep(0.05)
    return f"Processed {filename}"

if __name__ == '__main__':
    scheduler = AsyncTaskScheduler(max_threads=5)
    
    test_data = [[1, 2, 3, 4, 5], [10, 20, 30], [7, 8, 9, 10]]
    files = ['log1.txt', 'log2.txt', 'log3.txt']
    
    futures = []
    for i in range(3):
        futures.append(scheduler.register_task(example_data_processing, test_data[i]))
        futures.append(scheduler.register_task(example_io_simulation, files[i]))
        
    scheduler.start_workers()
    
    for i, fut in enumerate(futures):
        print(f"Task {i} result: {fut.get_result()}")
    
    print("All tasks completed.")
