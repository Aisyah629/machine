import fortress_formal_verification_tool::Core
import fortress_formal_verification_tool::Analysis
import fortress_formal_verification_tool::Optimization

module fortress_formal_verification_tool
    def main(args : Seq[String]) : Int
        var exitCode : Int = 0
        
        try
            // Parse command line arguments
            var inputFile : String = args(0)
            var outputFile : String = if (args.length > 1) args(1) else ""
            
            // Load the Fortress source file
            var source : String = Core.loadFile(inputFile)
            if (source.isEmpty)
                println("Error: Could not load source file: " + inputFile)
                exitCode = 1
                return exitCode
            end
            
            // Perform syntax and type checking
            var diagnostics : Seq[Diagnostics] = Analysis.checkSyntaxAndTypes(source)
            if (diagnostics.nonEmpty)
                println("Diagnostics:")
                for (diag : Diagnostics in diagnostics)
                    println("- " + diag.message + " at line " + diag.line)
                end
                exitCode = 1
                return exitCode
            end
            
            // Perform optimization
            var optimizedSource : String = Optimization.optimize(source)
            
            // Save the optimized source to the output file
            if (outputFile.nonEmpty)
                Core.writeFile(outputFile, optimizedSource)
                println("Optimized source written to: " + outputFile)
            else
                println("Optimized source:")
                println(optimizedSource)
            end
            
            println("Verification and optimization completed successfully.")
            
        catch (e : Exception)
            println("An error occurred: " + e.message)
            exitCode = 1
        end
        
        exitCode
    end
end
