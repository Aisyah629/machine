import Foundation
import Dispatch

struct CleanTask: Sendable {
    let name: String
    let operation: (String) -> String
}

// Parallel Cleaning Pipeline
let tasks: [CleanTask] = [
    CleanTask(name: "Remove Duplicates") { text in
        // Logic to remove duplicates
        return text
    },
    CleanTask(name: "Trim Whitespace") { text in
        return text.trimmingCharacters(in: .whitespacesAndNewlines)
    }
]

// Function to process the dataset
func processDataset(dataset: [String], tasks: [CleanTask]) -> [String] {
    var cleanDataset = dataset
    for task in tasks {
        cleanDataset = cleanDataset.map { task.operation($0) }
    }
    return cleanDataset
}

// Main execution
let inputDataset = ["  Hello World  ", "  Hello World  ", "Goodbye World"]
let output = processDataset(dataset: inputDataset, tasks: tasks)
print("Cleaned Dataset: \(output)")
