module main {
    // Chapel Parallel Programming Tool
    use IO;

    proc main() {
        writeln("Hello from Chapel!");
        writeln("Chapel tool initialized successfully.");
        
        // Example of Chapel's domain-based parallelism
        var A: [1..100] real;
        
        // Parallel loop using Chapel's built-in parallelism
        coforall loc in Locales do
            on loc {
                // Each locale handles a portion of the work
                coforall i in 1..#100 {
                    A[i] = i * i;
                }
            }
        
        writeln("Computation completed across locales.");
    }
}
