#!/usr/bin/env python3
import asyncio
import collections
import time
import threading
from enum import Enum
from dataclasses import dataclass, field
from typing import Dict, List, Optional, Callable, Any
from concurrent.futures import ThreadPoolExecutor

class TaskStatus(Enum):
    PENDING = "pending"
    RUNNING = "running"
    COMPLETED = "completed"
    FAILED = "failed"
    BLOCKED = "blocked"

@dataclass
class Message:
    id: str
    payload: Any
    status: TaskStatus = TaskStatus.PENDING
    created_at: float = field(default_factory=time.time)
    priority: int = 0

class MessageQueue:
    def __init__(self, maxsize: int = 0):
        self.queue = collections.deque()
        self.lock = threading.Lock()
        self.condition = threading.Condition(self.lock)
        self.maxsize = maxsize

    def put(self, msg: Message):
        with self.condition:
            if self.maxsize > 0 and len(self.queue) >= self.maxsize:
                self.condition.wait()
            self.queue.append(msg)
            self.condition.notify_all()

    def get(self) -> Optional[Message]:
        with self.condition:
            while not self.queue:
                self.condition.wait()
            msg = self.queue.popleft()
            self.condition.notify_all()
            return msg

class DeadlockDetector:
    def __init__(self):
        self.resource_graph: Dict[str, List[str]] = {}
        self.process_resources: Dict[str, str] = {}
        self.lock = threading.Lock()

    def acquire(self, process_id: str, resource_id: str):
        with self.lock:
            if resource_id not in self.resource_graph:
                self.resource_graph[resource_id] = []
            self.resource_graph[resource_id].append(process_id)
            self.process_resources[process_id] = resource_id

    def release(self, process_id: str):
        with self.lock:
            resource_id = self.process_resources.get(process_id)
            if resource_id and resource_id in self.resource_graph:
                if process_id in self.resource_graph[resource_id]:
                    self.resource_graph[resource_id].remove(process_id)
                del self.process_resources[process_id]

    def detect_cycle(self) -> Optional[List[str]]:
        visited = set()
        rec_stack = set()
        path = []
        with self.lock:
            for node in self.resource_graph:
                if node not in visited:
                    if self._dfs(node, visited, rec_stack, path):
                        return path
        return None

    def _dfs(self, node: str, visited: set, rec_stack: set, path: list) -> bool:
        visited.add(node)
        rec_stack.add(node)
        path.append(node)
        for neighbor in self.resource_graph.get(node, []):
            if neighbor not in visited:
                if self._dfs(neighbor, visited, rec_stack, path):
                    return True
            elif neighbor in rec_stack:
                path.append(neighbor)
                return True
        path.pop()
        rec_stack.remove(node)
        return False

class AsyncTaskExecutor:
    def __init__(self, queue: MessageQueue, detector: DeadlockDetector):
        self.queue = queue
        self.detector = detector
        self.tasks: Dict[str, asyncio.Task] = {}
        self.status_map: Dict[str, TaskStatus] = {}
        self.lock = asyncio.Lock()
        self.running = True

    async def execute(self, msg: Message, handler: Callable):
        async with self.lock:
            msg.status = TaskStatus.RUNNING
            self.status_map[msg.id] = msg.status
            self.detector.acquire(f"task_{msg.id}", msg.payload.get("resource_id", "default"))
        try:
            await asyncio.wait_for(handler(msg), timeout=5.0)
            async with self.lock:
                msg.status = TaskStatus.COMPLETED
                self.status_map[msg.id] = msg.status
                self.detector.release(f"task_{msg.id}")
        except asyncio.TimeoutError:
            async with self.lock:
                msg.status = TaskStatus.FAILED
                self.status_map[msg.id] = msg.status
                self.detector.release(f"task_{msg.id}")
        except Exception as e:
            async with self.lock:
                msg.status = TaskStatus.FAILED
                self.status_map[msg.id] = msg.status
                self.detector.release(f"task_{msg.id}")

    def get_status(self, task_id: str) -> Optional[TaskStatus]:
        return self.status_map.get(task_id)

class QueueMonitor:
    def __init__(self, queue: MessageQueue, executor: AsyncTaskExecutor):
        self.queue = queue
        self.executor = executor
        self.detector = executor.detector
        self.monitoring = True
        self.threads = []

    def start(self):
        t = threading.Thread(target=self._process_loop, daemon=True)
        t.start()
        t2 = threading.Thread(target=self._detect_deadlocks, daemon=True)
        t2.start()
        self.threads = [t, t2]

    def stop(self):
        self.monitoring = False
        for t in self.threads:
            t.join()

    def _process_loop(self):
        loop = asyncio.new_event_loop()
        asyncio.set_event_loop(loop)
        while self.monitoring:
            try:
                msg = self.queue.get()
                if not msg:
                    continue
                async def run_task(m):
                    await self.executor.execute(m, self._default_handler)
                loop.create_task(run_task(msg))
            except Exception as e:
                print(f"Queue processing error: {e}")
            time.sleep(0.01)
        loop.close()

    def _detect_deadlocks(self):
        while self.monitoring:
            cycle = self.detector.detect_cycle()
            if cycle:
                print(f"DEADLOCK DETECTED: {cycle}")
            time.sleep(1.0)

    def _default_handler(self, msg: Message):
        time.sleep(0.1)

if __name__ == "__main__":
    q = MessageQueue(maxsize=100)
    detector = DeadlockDetector()
    executor = AsyncTaskExecutor(q, detector)
    monitor = QueueMonitor(q, executor)
    monitor.start()
    for i in range(5):
        q.put(Message(id=f"msg_{i}", payload={"resource_id": "res_A"}))
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        monitor.stop()
        print("Monitoring stopped.")
