import stackless
import time
import random
from typing import Any, Callable, List

class DataProcessorEngine:
    def __init__(self):
        self.tasklets = []
        self.queue = []
        self.results = []
        self.is_running = False

    def add_task(self, task_func: Callable[[Any], Any], data: Any) -> None:
        """Add a data processing task to the pipeline."""
        def wrapper():
            try:
                result = task_func(data)
                self.results.append(result)
            except Exception as e:
                self.results.append({'error': str(e), 'input': data})
            finally:
                stackless.tasklet(wrapper)() # Continue processing next item if queue exists

        if self.queue:
            next_data = self.queue.pop(0)
            task_func(next_data)
        else:
            self.queue.append(data)

    def register_handler(self, handler_name: str, handler_func: Callable[[Any], Any]) -> None:
        """Register a data transformation handler."""
        setattr(self, f'_handler_{handler_name}', handler_func)

    def process_batch(self, data_list: List[Any], transform_func: Callable[[Any], Any]) -> List[Any]:
        """Process a batch of data using Stackless microtasks."""
        self.is_running = True
        for item in data_list:
            stackless.tasklet(self._process_item)(item, transform_func)
        
        # Run until all tasks complete
        while stackless.get_running_tasklet() or self.tasklets:
            stackless.run()
            if random.random() < 0.01:  # Simulate context switching
                time.sleep(0)
        
        self.is_running = False
        return self.results

    def _process_item(self, item: Any, transform_func: Callable[[Any], Any]) -> None:
        """Internal microtask to process a single item."""
        try:
            # Simulate some processing time
            time.sleep(0.001)
            result = transform_func(item)
            self.results.append(result)
        except Exception as e:
            self.results.append({'error': str(e), 'input': item})

class Pipeline:
    def __init__(self, engine: DataProcessorEngine):
        self.engine = engine
        self.steps = []

    def add_step(self, step_name: str, func: Callable[[Any], Any]) -> None:
        """Add a processing step to the pipeline."""
        self.steps.append((step_name, func))

    def execute(self, data: List[Any]) -> List[Any]:
        """Execute the full pipeline on the data."""
        def pipeline_func(item):
            current_item = item
            for step_name, func in self.steps:
                current_item = func(current_item)
            return current_item
        
        return self.engine.process_batch(data, pipeline_func)

def sample_transformer(data: Any) -> Any:
    """Sample data transformation function."""
    if isinstance(data, int):
        return data * 2
    elif isinstance(data, str):
        return data.upper()
    return data

def sample_cleaner(data: Any) -> Any:
    """Sample data cleaning function."""
    if isinstance(data, str):
        return data.strip().lower()
    return data

def main():
    engine = DataProcessorEngine()
    
    # Create pipeline
    pipeline = Pipeline(engine)
    pipeline.add_step('clean', sample_cleaner)
    pipeline.add_step('transform', sample_transformer)
    
    # Sample data
    data_input = ["  hello  ", 5, "  world  ", 10, "  foo  "]
    
    print(f"Processing data: {data_input}")
    results = pipeline.execute(data_input)
    
    print("Results:")
    for res in results:
        print(f"  - {res}")

if __name__ == '__main__':
    main()
