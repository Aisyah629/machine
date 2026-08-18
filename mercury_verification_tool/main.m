%-:- Module main.

-module(main).

-interface.

-import_module io.

-import_module list.

-import_module int.

-import_module string.

-import_module bool.


% Define a simple data type for expressions
type expr.
    :- func expr(int) = expr.
    :- func expr(string, list(expr)) = expr.
    :- func expr(string, expr, expr) = expr.


% Predicate to simplify expressions
pred simplify(expr::in, expr::out, io::di, io::uo) is det.

simplify(expr(Int), expr(Int), !IO) :-
    io.write_string("Simplified: ", !IO),
    io.write(Int, !IO),
    io.write_string("\n", !IO).

simplify(expr(Op, Args), Result, !IO) :-
    ( Op = "+" ->
        ( Args = [expr(A), expr(B)] ->
            Result = expr(A + B)
        ;
            Result = expr(Op, Args)
        )
    ;
        Result = expr(Op, Args)
    ),
    io.write_string("Simplified: ", !IO),
    io.write(Result, !IO),
    io.write_string("\n", !IO).

simplify(expr(Op, Left, Right), Result, !IO) :-
    ( Op = "+" ->
        ( Left = expr(AL), Right = expr(AR) ->
            Result = expr(AL + AR)
        ;
            Result = expr(Op, Left, Right)
        )
    ;
        Result = expr(Op, Left, Right)
    ),
    io.write_string("Simplified: ", !IO),
    io.write(Result, !IO),
    io.write_string("\n", !IO).


% Predicate to evaluate expressions
pred evaluate(expr::in, int::out, io::di, io::uo) is det.

evaluate(expr(Int), Result, !IO) :-
    Result = Int,
    io.write_string("Evaluated: ", !IO),
    io.write(Int, !IO),
    io.write_string("\n", !IO).

evaluate(expr("+", [expr(L), expr(R)]), Result, !IO) :-
    Result = L + R,
    io.write_string("Evaluated: ", !IO),
    io.write(Result, !IO),
    io.write_string("\n", !IO).

evaluate(expr("+", expr(L), expr(R)), Result, !IO) :-
    Result = L + R,
    io.write_string("Evaluated: ", !IO),
    io.write(Result, !IO),
    io.write_string("\n", !IO).


% Main predicate
main(!IO) :-
    io.print_string("Mercury Verification Tool\n", !IO),
    io.print_string("=========================\n\n", !IO),

    % Example expression: 5 + 3
    Example1 = expr("+", expr(5), expr(3)),
    io.print_string("Expression: 5 + 3\n", !IO),
    io.print_string("Simplification:\n", !IO),
    simplify(Example1, Simp1, !IO),
    io.print_string("\n", !IO),

    io.print_string("Evaluation:\n", !IO),
    evaluate(Example1, Eval1, !IO),
    io.print_string("\n", !IO),

    % Example expression: (10 + 20) + 5
    Example2 = expr("+", expr("+", expr(10), expr(20)), expr(5)),
    io.print_string("Expression: (10 + 20) + 5\n", !IO),
    io.print_string("Simplification:\n", !IO),
    simplify(Example2, Simp2, !IO),
    io.print_string("\n", !IO),

    io.print_string("Evaluation:\n", !IO),
    evaluate(Example2, Eval2, !IO),
    io.print_string("\n", !IO),

    io.print_string("Verification complete.\n", !IO).
