rule(s, [a, s]).
rule(s, [b, a]).
rule(a, [d]).
rule(a, [s, a]).
rule(b, [b]). 


last_element([H], H).
last_element([_|T], Last) :- last_element(T, Last).

direct_right_link(A, B) :-
    rule(A, RHS),
    last_element(RHS, B),
    rule(B, _). 

path_right(A, B, _) :- direct_right_link(A, B).
path_right(A, B, Visited) :-
    direct_right_link(A, C),
    \+ member(C, Visited),
    path_right(C, B, [C|Visited]).

is_right_recursive(A) :- path_right(A, A, []).


main :-
    nl, write('=== Аналізатор граматики (Prolog) ==='), nl,
    write('Команди: "run" - знайти всі, "exit" - вихід.'), nl,
    loop.

loop :-
    nl, write('command > '),
    flush_output,
    read_line_to_string(user_input, Input),
    (   Input == "exit" -> 
            write('До зустрічі!'), nl, !
    ;   Input == "run" -> 
            ( setof(X, is_right_recursive(X), List) ->
                format('Знайдено праворекурсивні нетермінали: ~w~n', [List])
            ;   write('Праворекурсивних нетерміналів не виявлено.'), nl
            ),
            loop
    ;   write('Невідома команда. Спробуй "run" або "exit".'), nl,
        loop
    ).

:- initialization(main).