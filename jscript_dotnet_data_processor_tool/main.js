import System;
import System.IO;
import System.Text;
import System.Collections.Generic;

namespace DataProcessingTool {
    public class DataProcessor {
        public static function ProcessData(inputData: String): String {
            if (String.IsNullOrEmpty(inputData)) {
                return "Error: Input data is empty.";
            }

            try {
                // Example: Parse JSON-like string and extract keys
                var result = new StringBuilder();
                var lines = inputData.Split(new String[] {"\n"}, StringSplitOptions.RemoveEmptyEntries);
                for (var line in lines) {
                    if (line.Trim().StartsWith("{")) {
                        result.AppendLine("Detected JSON object.");
                        // Further parsing logic can be added here
                    } else if (line.Trim().StartsWith("[")) {
                        result.AppendLine("Detected JSON array.");
                    } else {
                        result.AppendLine("Processed line: " + line.Trim());
                    }
                }
                return result.ToString();
            } catch (ex as Exception) {
                return "Error processing data: " + ex.Message;
            }
        }
    }
}

// Main entry point
public class MainClass {
    public static function Main(args: Array<String>): void {
        var data = @"{
  "name": "John",
  "age": 30,
  "city": "New York"
}";
        var output = DataProcessingTool.DataProcessor.ProcessData(data);
        Console.WriteLine(output);
    }
}
