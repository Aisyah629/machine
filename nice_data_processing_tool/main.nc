package com.example.dataprocessor;

import static nice.Io.*;
import static nice.collections.Iterable.*;

public class Main {

    public static void main(String[] args) {
        println("Starting Nice Data Processing Tool...");
        
        // Example data processing pipeline
        List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
        
        // Filter even numbers
        List<int> evens = filter(numbers, i -> i % 2 == 0);
        println("Even numbers: " + evens);
        
        // Transform (square the numbers)
        List<int> squared = map(evens, i -> i * i);
        println("Squared evens: " + squared);
        
        // Aggregate (sum)
        int total = fold(squared, 0, (acc, i) -> acc + i);
        println("Total sum: " + total);
        
        println("Data processing complete.");
    }
}
