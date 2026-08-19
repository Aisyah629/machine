import Foundation

// MARK: - Data Processing Model
struct Record {
    let id: String
    let value: Double
    let category: String
    let processed: Bool
}

// MARK: - Processor Engine
class DataProcessor {
    private let logger = Logger(category: "DataProcessor")
    
    func process(input: [String]) throws -> [Record] {
        logger.info("Starting data processing pipeline...")
        var processedRecords: [Record] = []
        
        for line in input {
            guard let record = parse(line: line) else {
                logger.warning("Skipping malformed line: \(line)")
                continue
            }
            processedRecords.append(applyTransformations(record))
        }
        
        logger.info("Processing complete. Records processed: \(processedRecords.count)")
        return processedRecords
    }
    
    private func parse(line: String) -> Record? {
        let components = line.split(separator: ",").map(String.init)
        guard components.count >= 3,
              let id = components.first,
              let value = Double(components[1]),
              let category = components[2] else {
            return nil
        }
        return Record(id: id, value: value, category: category, processed: true)
    }
    
    private func applyTransformations(_ record: Record) -> Record {
        // Example transformation: normalize value by category
        let normalizedValue = record.value * (record.category == "premium" ? 1.5 : 1.0)
        return Record(id: record.id, value: normalizedValue, category: record.category, processed: true)
    }
}

// MARK: - Logger
class Logger {
    private let category: String
    
    init(category: String) {
        self.category = category
    }
    
    func info(_ message: String) {
        print("[INFO][\(category)] \(message)")
    }
    
    func warning(_ message: String) {
        print("[WARN][\(category)] \(message)")
    }
    
    func error(_ message: String) {
        print("[ERROR][\(category)] \(message)")
    }
}

// MARK: - CLI Entry Point
@main
struct CLI {
    static func main() {
        let arguments = CommandLine.arguments
        guard arguments.count >= 2 else {
            print("Usage: swift-data-processor-tool --input <file> --output <file>")
            return
        }
        
        let processor = DataProcessor()
        let inputFile = arguments[1]
        
        do {
            let content = try String(contentsOfFile: inputFile, encoding: .utf8)
            let lines = content.split(separator: "\n").map(String.init)
            let results = try processor.process(input: lines)
            
            let output = results.map { "\($0.id),\($0.value),\($0.category)" }.joined(separator: "\n")
            try output.write(toFile: arguments[2], atomically: true, encoding: .utf8)
            print("Successfully processed data. Output saved to \(arguments[2])")
        } catch {
            print("Failed to process data: \(error.localizedDescription)")
        }
    }
}
