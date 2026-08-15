% SISAL Program
% This program generates a sequence of numbers using functional dataflow paradigm.
% It demonstrates basic SISAL syntax for functions, loops (fold), and array construction.

function double(x: integer) returns (integer)
    return x * 2;
end double;

function main() returns (integer)
    % Define an array of integers
    declare A: array[1..10] of integer;
    
    % Initialize the array with values 1 to 10
    for I in 1..10 return I end;
    
    % Apply the double function to each element using fold/map concept
    declare B: array[1..10] of integer;
    for I in 1..10 return double(A[I]) end;
    
    % Return the last element as a simple result for demonstration
    return B[10];
end main;
