// SOL Data Processing Tool
// This file provides core functionality for data processing in SOL.

// Function to filter even numbers from a list of integers
function filter_even(numbers: list[int]): list[int] {
    let result = list[int]();
    for (let i in numbers) {
        if (i % 2 == 0) {
            result.append(i);
        }
    }
    return result;
}

// Function to filter odd numbers from a list of integers
function filter_odd(numbers: list[int]): list[int] {
    let result = list[int]();
    for (let i in numbers) {
        if (i % 2 != 0) {
            result.append(i);
        }
    }
    return result;
}

// Function to sum all numbers in a list
function sum_numbers(numbers: list[int]): int {
    let total = 0;
    for (let i in numbers) {
        total += i;
    }
    return total;
}

// Function to calculate the average of numbers in a list
function average_numbers(numbers: list[int]): float {
    if (numbers.length == 0) {
        return 0.0;
    }
    let total = sum_numbers(numbers);
    return total / numbers.length;
}

// Function to find the maximum number in a list
function find_max(numbers: list[int]): int {
    if (numbers.length == 0) {
        return 0;
    }
    let max = numbers[0];
    for (let i in numbers) {
        if (i > max) {
            max = i;
        }
    }
    return max;
}

// Function to find the minimum number in a list
function find_min(numbers: list[int]): int {
    if (numbers.length == 0) {
        return 0;
    }
    let min = numbers[0];
    for (let i in numbers) {
        if (i < min) {
            min = i;
        }
    }
    return min;
}

// Function to sort a list of numbers in ascending order
function sort_numbers(numbers: list[int]): list[int] {
    let sorted = list[int](numbers);
    let n = sorted.length;
    for (let i in range(0, n)) {
        for (let j in range(0, n - i - 1)) {
            if (sorted[j] > sorted[j + 1]) {
                let temp = sorted[j];
                sorted[j] = sorted[j + 1];
                sorted[j + 1] = temp;
            }
        }
    }
    return sorted;
}

// Function to remove duplicates from a list of numbers
function remove_duplicates(numbers: list[int]): list[int] {
    let unique = list[int]();
    for (let i in numbers) {
        if (!unique.contains(i)) {
            unique.append(i);
        }
    }
    return unique;
}

// Function to transform a list of numbers by applying a function
function transform(numbers: list[int], func: function(int): int): list[int] {
    let transformed = list[int]();
    for (let i in numbers) {
        transformed.append(func(i));
    }
    return transformed;
}

// Example usage
function main() {
    let data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    print("Original data: " + data);
    print("Even numbers: " + filter_even(data));
    print("Odd numbers: " + filter_odd(data));
    print("Sum: " + sum_numbers(data));
    print("Average: " + average_numbers(data));
    print("Max: " + find_max(data));
    print("Min: " + find_min(data));
    print("Sorted: " + sort_numbers(data));
    print("Unique: " + remove_duplicates(data));
    let squared = transform(data, function(x): int { return x * x; });
    print("Squared: " + squared);
}
