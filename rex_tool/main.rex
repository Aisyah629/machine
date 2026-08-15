! /usr/bin/env rex

// Rex Tool - Main Entry Point

// Define a simple class to demonstrate object-oriented features in Rex
class Greeter {
    property name;

    // Constructor
    define constructor(name) {
        self.name = name;
    }

    // Method to greet
    define greet() {
        print "Hello, " + self.name + "!";
    }
}

// Create an instance of the Greeter class
var myGreeter = Greeter("Rex User");

// Call the greet method
myGreeter.greet();
