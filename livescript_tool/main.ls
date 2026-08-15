// LiveScript: Functional Programming Utility

// Define a list of numbers
numbers = [1, 2, 3, 4, 5]

// Function to square each number using map
square = (x) -> x * x
squared = numbers.map square
console.log 'Squared numbers:', squared

// Function to filter even numbers
evenFilter = (x) -> x % 2 is 0
evens = numbers.filter evenFilter
console.log 'Even numbers:', evens

// Function to sum numbers using reduce
sum = (acc, x) -> acc + x
total = numbers.reduce sum
console.log 'Sum of numbers:', total

// Pattern matching example
match = (x) ->
  switch x
    when 1
      'One'
    when 2
      'Two'
    when 3
      'Three'
    else
      'Other'

console.log match 2
