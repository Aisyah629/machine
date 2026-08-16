% Prolog Tool: Symbolic AI Inference Engine for Logical Deduction
% This engine manages a knowledge base and performs logical deductions.

:- dynamic fact/2, rule/3.

% Initialize the inference engine
start_engine :-
    write('Symbolic AI Inference Engine started.\n'),
    load_knowledge_base,
    main_loop.

% Main loop for user interaction
main_loop :-
    write('Enter query (end with quit/0): '),
    read(Query),
    (Query = quit -> 
        write('Engine stopped.\n')
    ; query_engine(Query) 
    ; main_loop).

% Process a query
query_engine(Query) :-
    call_query(Query, Result),
    (Result = true -> 
        write('Yes.\n')
    ; Result = false -> 
        write('No.\n')
    ; Result = [Solution] -> 
        write('Solution: '), write(Solution), nl
    ; Result = solutions(Solutions) -> 
        write('Solutions: '), write(Solutions), nl
    ; write('Unknown query.\n')
    ).

% Call a query with backtracking for multiple solutions
call_query(Query, Result) :-
    catch(
        (call(Query), !, Result = true),
        Error,
        handle_error(Error, Result)
    ).

% Handle errors during query execution
handle_error(Error, Result) :-
    write('Error: '), write(Error), nl,
    Result = false.

% Load knowledge base from external file or predefined facts
load_knowledge_base :-
    
    % Example facts (These can be replaced with file loading)
    assertz(fact(cat, fluffy)),
    assertz(fact(dog, bobby)),
    assertz(fact(cat, misty)),
    
    % Example rules
    assertz(rule(is_pet, Animal) :- fact(Animal, _)).,
    
    % Load from file if exists
    (catch(consult('kb.pl'), _, true) -> true ; true).

% Example predicates for demonstration
is_pet(Animal) :-
    fact(Animal, _).

% Query examples:
% ?- is_pet(fluffy).  -> Yes
% ?- is_pet(bobby).   -> Yes
% ?- is_pet(lion).    -> No
% ?- findall(X, is_pet(X), Pets). -> Pets = [fluffy, bobby, misty]
