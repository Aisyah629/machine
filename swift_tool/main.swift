import Foundation
import Dispatch

// Actor for thread-safe task management
actor TaskManager {
    private var tasks: [UUID: DispatchWorkItem] = [:]
    private var results: [UUID: Any?] = [:]
    private let queue = DispatchQueue(label: "com.swift.tool.executor")
    
    func submit(_ task: () -> Any?) async -> UUID {
        let id = UUID()
        let workItem = DispatchWorkItem {
            let result = task()
            self.results[id] = result
        }
        tasks[id] = workItem
        queue.async(execute: workItem)
        return id
    }
    
    func waitForCompletion(_ id: UUID) async -> Any? {
        if let workItem = tasks[id] {
            await workItem.perform()
        }
        return results[id]
    }
    
    func clear() async {
        tasks.removeAll()
        results.removeAll()
    }
}

// Example usage
@main
struct Main {
    static func main() async {
        let manager = TaskManager()
        
        // Submit parallel tasks
        let task1 = await manager.submit { 
            // Simulate some work
            Thread.sleep(forTimeInterval: 0.5)
            return "Result 1"
        }
        
        let task2 = await manager.submit { 
            // Simulate some work
            Thread.sleep(forTimeInterval: 0.3)
            return "Result 2"
        }
        
        let task3 = await manager.submit { 
            // Simulate some work
            Thread.sleep(forTimeInterval: 0.4)
            return "Result 3"
        }
        
        // Wait for results
        let result1 = await manager.waitForCompletion(task1)
        let result2 = await manager.waitForCompletion(task2)
        let result3 = await manager.waitForCompletion(task3)
        
        print("Task 1: \(result1 ?? "nil")")
        print("Task 2: \(result2 ?? "nil")")
        print("Task 3: \(result3 ?? "nil")")
        
        // Cleanup
        await manager.clear()
    }
}
