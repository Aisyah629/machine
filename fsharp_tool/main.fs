namespace FunctionalTransformation

/// A module providing robust, type-safe functional data transformations.
module Transformer =
    /// Applies a transformation function to a list of items, returning a new list.
    /// This function is pure and does not mutate the input list.
    let inline map (f: 'T -> 'U) (input: seq<'T>) : 'U list =
        List.map f input

    /// Filters a sequence of items based on a predicate function.
    let inline filter (predicate: 'T -> bool) (input: seq<'T>) : 'T list =
        List.filter predicate input

    /// Reduces a sequence of items to a single value using a combining function.
    let inline reduce (combining: 'T -> 'T -> 'T) (input: seq<'T>) : 'T =
        List.reduce combining input

    /// Chains multiple transformation functions together.
    /// Functions are applied from left to right.
    let inline pipe (x: 'T) (f: 'T -> 'U) : 'U =
        f x

    /// A higher-order function that creates a composition of functions.
    /// (f << g) x = f (g x)
    let inline compose (f: 'B -> 'C) (g: 'A -> 'B) : 'A -> 'C =
        fun x -> f (g x)

    /// Example usage and demonstration.
    let main () =
        // Define a list of integers
        let numbers = [1; 2; 3; 4; 5; 6; 7; 8; 9; 10]

        // Define a transformation: square the number
        let square (x: int) : int =
            x * x

        // Define a filter: keep even numbers
        let isEven (x: int) : bool =
            x % 2 = 0

        // Define a reduction: sum the numbers
        let add (a: int) (b: int) : int =
            a + b

        // 1. Map: Square all numbers
        let squared = Transformer.map square numbers
        printfn "Squared: %A" squared

        // 2. Filter: Keep even numbers from the squared list
        let evenSquared = Transformer.filter isEven squared
        printfn "Even Squared: %A" evenSquared

        // 3. Reduce: Sum the even squared numbers
        let sum = Transformer.reduce add evenSquared
        printfn "Sum of Even Squared: %d" sum

        // 4. Composition: Compose a function that squares then adds 1
        let squareThenAddOne = Transformer.compose (fun x -> x + 1) square
        let result = squareThenAddOne 3 // (3*3) + 1 = 10
        printfn "Composed Result (3): %d" result

// Entry point for the tool
[<EntryPoint>]
let main argv =
    Transformer.main()
    0 // Return an integer exit code
