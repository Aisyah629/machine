#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

// Function to calculate the sum of two integers
int add(int a, int b) {
    return a + b;
}

// Function to print a greeting message
void greet(const char* name) {
    printf("Hello, %s! Welcome to the C Tool.\n", name);
}

// Function to reverse a string
void reverse_string(char* str) {
    int length = strlen(str);
    int i, j;
    char temp;
    
    for (i = 0, j = length - 1; i < j; i++, j--) {
        temp = str[i];
        str[i] = str[j];
        str[j] = temp;
    }
}

// Function to generate a random number between min and max
int random_number(int min, int max) {
    return min + rand() % (max - min + 1);
}

int main() {
    // Seed the random number generator
    srand(time(NULL));
    
    // Test add function
    printf("Sum: %d\n", add(5, 10));
    
    // Test greet function
    greet("User");
    
    // Test reverse_string function
    char str[] = "Hello, World!";
    printf("Original: %s\n", str);
    reverse_string(str);
    printf("Reversed: %s\n", str);
    
    // Test random_number function
    printf("Random number: %d\n", random_number(1, 100));
    
    return 0;
}
