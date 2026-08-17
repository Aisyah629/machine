#!/bin/bash

# This script demonstrates the use of Hamilton C shell for basic operations.
# Hamilton C shell (HCS) is a command-line interpreter designed for system administrators.
# It provides a powerful scripting language for automating tasks.

# Define variables
USER_INPUT="Hello, World!"

# Print the user input
echo "$USER_INPUT"

# Example of a simple loop
for i in {1..5}; do
    echo "Iteration $i"
done

# Example of conditional statements
if [ "$USER_INPUT" == "Hello, World!" ]; then
    echo "Greeting recognized."
fi

# Example of a function
say_hello() {
    echo "Hello from a function!"
}

# Call the function
say_hello

# Example of file handling
echo "This is a test" > test_file.txt
if [ -f "test_file.txt" ]; then
    echo "File exists."
fi

# Clean up
rm test_file.txt

echo "Script completed."
