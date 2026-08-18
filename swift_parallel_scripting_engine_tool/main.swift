import Foundation

// Define a simple actor for managing shared state
actor TaskQueue {
    private var tasks: [() -> Void] = []
    private let queue = DispatchQueue(label: "task.queue")
    
    func addTask(_ task: @escaping () -> Void) {
        queue.async {
            self.tasks.append(task)
        }
    }
    
    func processAll() {
        queue.async {
            for task in self.tasks {
                task()
            }
            self.tasks.removeAll()
        }
    }
}

// Define a concurrent worker pool
struct WorkerPool {
    private let workers: [DispatchQueue]
    private let taskQueue = TaskQueue()
    
    init(count: Int) {
        workers = (0..<count).map { _ in DispatchQueue(label: "worker.pool") }
    }
    
    func submit(_ task: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let worker = workers.randomElement()!
            worker.async {
                taskQueue.addTask(task)
            }
        }
    }
    
    func start() {
        taskQueue.processAll()
    }
}

// Main function to demonstrate usage
func main() {
    let workerPool = WorkerPool(count: 8)
    
    for i in 0..<100 {
        workerPool.submit {
            print("Task \(i) is executing on worker \(Thread.current.name ?? "Unknown")")
        }
    }
    
    workerPool.start()
}

main()
