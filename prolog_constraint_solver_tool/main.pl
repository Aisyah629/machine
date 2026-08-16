% main.pl - Prolog Constraint Satisfaction Solver

:- module(constraint_solver, [solve/1, solve_all/1]).

:- use_module(library(clpfd)).

% solve/1: Solve a list of constraints and return the first solution
solve(Constraints) :-
    setup(Constraints, Variables, Domains),
    assign_domains(Domains, Variables),
    post_constraints(Constraints, Variables),
    label(Variables),
    !.

% solve_all/1: Solve a list of constraints and return all solutions
solve_all(Constraints) :-
    setup(Constraints, Variables, Domains),
    assign_domains(Domains, Variables),
    post_constraints(Constraints, Variables),
    label(Variables).

% setup/3: Extract variables and domains from constraints
setup(Constraints, Variables, Domains) :-
    findall(V, constraint_variable(Constraints, V), Variables),
    list_to_set(Variables, UniqueVariables),
    findall((V, Domain), (member(V, UniqueVariables), default_domain(V, Domain)), Domains).

% constraint_variable/2: Extract variables from a constraint
declare_variable(X) :-
    var(X),
    !,
    fail.
declare_variable(X) :-
    atomic(X).

constraint_variable(Constraints, Var) :-
    member(C, Constraints),
    extract_variables(C, Vars),
    member(Var, Vars).

extract_variables(Constraint, Vars) :-
    findall(V, (subterm(Term, Constraint), var(Term), V = Term), Vars).

% default_domain/2: Assign default domains to variables
default_domain(Var, 1..100).

% assign_domains/2: Assign domains to variables
assign_domains([], []).
assign_domains([(Var, Domain)|Rest], (Var ins Domain)|RestDomains) :-
    assign_domains(Rest, RestDomains).

% post_constraints/2: Post constraints on variables
post_constraints([], []).
post_constraints([C|Rest], Variables) :-
    post_constraint(C, Variables),
    post_constraints(Rest, Variables).

post_constraint(Constraint, _) :-
    % Post the constraint directly if it's a standard CLP(FD) constraint
    Constraint,
    !.

% label/1: Label variables to find solutions
label(Variables) :-
    label_variables(Variables).

label_variables([]).
label_variables([X|Rest]) :-
    ( var(X) -> X #= X ; true ), % Ensure X is a variable
    label([X]),
    label_variables(Rest).
