% Main file for Prolog Reasoning Engine Tool
% This file contains the knowledge base and rules for the reasoning engine.

% Facts
parent(john, mary).
parent(mary, ann).
parent(john, tom).
parent(tom, lisa).
parent(mary, bob).

% Rules
grandparent(X, Z) :-
    parent(X, Y),
    parent(Y, Z).

sibling(X, Y) :-
    parent(Z, X),
    parent(Z, Y),
    X \= Y.

uncle(X, Y) :-
    sibling(X, Z),
    parent(Z, Y).

ancestor(X, Y) :-
    parent(X, Y).
ancestor(X, Y) :-
    parent(X, Z),
    ancestor(Z, Y).

% Query predicates for reasoning
all_grandparents(GP, GD) :-
    grandparent(GP, GD),
    writeln(['Grandparent:', GP, 'Grandchild:', GD]).

all_siblings(S1, S2) :-
    sibling(S1, S2),
    writeln(['Sibling1:', S1, 'Sibling2:', S2]).

all_uncles(U, N) :-
    uncle(U, N),
    writeln(['Uncle:', U, 'Nephew/Niece:', N]).

all_ancestors(Ancestor, Descendant) :-
    ancestor(Ancestor, Descendant),
    writeln(['Ancestor:', Ancestor, 'Descendant:', Descendant]).

% Main query engine
run_reasoning_engine :-
    writeln('Running Grandparent Queries:'),
    all_grandparents(_, _),
    writeln(''),
    writeln('Running Sibling Queries:'),
    all_siblings(_, _),
    writeln(''),
    writeln('Running Uncle Queries:'),
    all_uncles(_, _),
    writeln(''),
    writeln('Running Ancestor Queries:'),
    all_ancestors(_, _).

% Entry point
start :-
    run_reasoning_engine,
    writeln('Reasoning engine completed.').
