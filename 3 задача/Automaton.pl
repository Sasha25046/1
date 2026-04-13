start_state(0).
final_state(0).

trans(0, a, 1).
trans(1, a, 0).
trans(0, b, 0).
trans(1, b, 1).

accepts(S, [], S).
accepts(S, [Char|Chars], Last) :-
    trans(S, Char, S1),
    accepts(S1, Chars, Last).

solve_automaton(W_String, ResultString) :-
    string_chars(W_String, W),
    start_state(S0),
    
    between(0, 5, LX), length(X, LX),
    accepts(S0, X, S1),
    
    accepts(S1, W, S2),
    
    between(0, 5, LY), length(Y, LY),
    accepts(S2, Y, Sf),
    
    final_state(Sf),
    
    append(X, W, Temp),
    append(Temp, Y, FullList),
    string_chars(ResultString, FullList), 
    !. 


main :-
    nl, write('=== Перевірка автомата (Prolog) ==='), nl,
    write('Введіть слово w для пошуку xwy або exit для виходу:'), nl,
    loop.

loop :-
    write('Input w = '),
    flush_output,
    read_line_to_string(user_input, Input),
    (   Input == "exit" -> 
            write('Бувай!'), nl, !
    ;   Input == "" -> 
            loop
    ;   (   solve_automaton(Input, Result) ->
                format('Знайдено слово xwy: ~w~n', [Result])
            ;   format('Слово ~w неможливе в цьому автоматі.~n', [Input])
        ),
        nl,
        loop
    ).

:- initialization(main).