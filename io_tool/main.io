// Io Tool - Main Scripting Utility
// Implements a lightweight object-oriented scripting environment

// Define the Io object model for the tool
Tool := Object clone do(
    name := "Io Tool"
    version := "1.0.0"
    purpose := "Lightweight object-oriented scripting utility"
)

// Create a processor object to handle script execution and data manipulation
Processor := Object clone do(
    result := List clone
    
    process := method(input, text, output)
        // Convert input to uppercase as a demonstration
        upper := text asString toUpper
        // Append processed data to results
        result append(list(upper))
        // Return the processed string
        return upper
    end
    
    printResults := method()
        foreach(result, line |
            println("Processed: " , line)
        )
    end
    
    reset := method(
        result := List clone
    )
    end
)

// Instantiate the processor and run a demo sequence
proc := Processor clone
proc2 := Processor clone

println("=== Io Tool Scripting Utility ===")
println("Tool: " , Tool name)
println("Version: " , Tool version)
println("Purpose: " , Tool purpose)
println("")

// Demonstrate core functionality
input1 := "hello scripting world"
input2 := "prototype based objects"
input3 := "dynamic metaprogramming"

println("Running processing pipeline...")
proc process(input1, "hello scripting world", "output1")
proc2 process(input2, "prototype based objects", "output2")

println("Executing batch processing...")
foreach(list("dynamic metaprogramming", "lightweight runtime"), text |
    proc2 process("batch", text, "batch_out")
)

// Output results
proc printResults
proc2 printResults

// Demonstrate reset capability
println("")
println("Resetting processor...")
proc2 reset
proc2 printResults

println("")
println("Scripting utility execution complete.")
