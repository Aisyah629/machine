import stackless
import time
import sys
import random
import queue
import threading
import os

class StreamProcessor:
    def __init__(self, num_workers=5, buffer_size=100):
        self.num_workers = num_workers
        self.buffer_size = buffer_size
        self.input_channel = stackless.channel()
        self.output_channel = stackless.channel()
        self.result_channel = stackless.channel()
        self.workers = []
        self.running = False
        self.lock = threading.Lock()
        self.processed_count = 0
        self.error_count = 0

    def start(self):
        if self.running:
            return
        self.running = True
        self.processed_count = 0
        self.error_count = 0
        
        # Create worker tasklets
        for i in range(self.num_workers):
            tasklet = stackless.tasklet(self.worker_loop)(i)
            self.workers.append(tasklet)
            
        print(f"Stream processor started with {self.num_workers} workers.")
        
    def stop(self):
        self.running = False
        # Send poison pills to terminate workers gracefully
        for _ in self.workers:
            self.input_channel.send(None)
        
        print("Stream processor stopped.")
        print(f"Total processed: {self.processed_count}, Errors: {self.error_count}")
        
    def worker_loop(self, worker_id):
        while self.running:
            try:
                data = self.input_channel.receive()
                if data is None:
                    # Poison pill received, terminate worker
                    break
                    
                # Simulate data processing
                processed_data = self.process_data(data, worker_id)
                self.output_channel.send(processed_data)
                
            except Exception as e:
                print(f"Worker {worker_id} encountered error: {e}")
                self.error_count += 1
                
        print(f"Worker {worker_id} terminated.")
        
    def process_data(self, data, worker_id):
        # Simulate processing time
        time.sleep(random.uniform(0.01, 0.05))
        
        # Simulate data transformation
        if isinstance(data, dict):
            data['processed_by'] = worker_id
            data['processed_at'] = time.time()
            return data
        else:
            return {"value": data, "processed_by": worker_id, "processed_at": time.time()}
            
    def producer_loop(self, data_stream):
        for data in data_stream:
            if not self.running:
                break
            try:
                self.input_channel.send(data)
            except Exception as e:
                print(f"Producer error: {e}")
                break
                
        print("Producer loop finished.")
        
    def consumer_loop(self):
        while self.running:
            try:
                data = self.output_channel.receive()
                # Simulate writing results
                if data is not None:
                    self.processed_count += 1
            except Exception as e:
                print(f"Consumer error: {e}")
                break
                
        print("Consumer loop finished.")


def run_simulation():
    print("Starting Stackless Python Stream Processing Simulation...")
    
    # Initialize processor
    processor = StreamProcessor(num_workers=5, buffer_size=50)
    processor.start()
    
    # Simulate data stream
    data_stream = [f"data_{i}" for i in range(50)]
    
    # Start producer and consumer tasklets
    producer_tasklet = stackless.tasklet(processor.producer_loop)(data_stream)
    consumer_tasklet = stackless.tasklet(processor.consumer_loop)()
    
    # Run the event loop
    # Let the tasklets run until all data is processed
    iterations = 0
    while processor.running and iterations < 500: # Safety limit
        stackless.run()
        iterations += 1
        # Allow context switching
        stackless.schedule()
        
    # Check if still running, if so stop
    if processor.processed_count < len(data_stream):
        processor.stop()
        
    print("Simulation complete.")


if __name__ == "__main__":
    run_simulation()
