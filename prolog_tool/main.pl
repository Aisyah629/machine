% main.pl - Prolog Tool Entry Point

:- module(main, [run/0, greet/1, factorial/2, member/2]).

:- initialization(run).

% run/0: Main execution predicate
greet :-
    write('Hello from the Prolog Tool!\n'),
    fail.
greet.

% run/0: Main execution predicate
run :-
    format('~n=== Prolog Tool Initialized ===~n~n'),
    
    % Example 1: Factorial Calculation
    format('~n--- Factorial Example ---~n'),
    factorial(5, F),
    format('factorial(5) = ~d~n', [F]),
    
    % Example 2: List Membership
    format('~n--- List Membership Example ---~n'),
    member(X, [a, b, c]),
    format('member found: ~w~n', [X]),
    fail.

member(X, [X|_]).
member(X, [_|T]) :- member(X, T).

factorial(0, 1).
factorial(N, Result) :-
    N > 0,
    N1 is N - 1,
    factorial(N1, SubResult),
    Result is N * SubResult.
