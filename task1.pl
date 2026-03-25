% --- Логіка задачі ---

move_min_to_front([], []).
move_min_to_front(List, Result) :-
    min_list(List, Min),
    split_min(List, Min, Mins, Others),
    append(Mins, Others, Result).

split_min([], _, [], []).
split_min([H|T], Min, [H|Mins], Others) :-
    H =:= Min, !,
    split_min(T, Min, Mins, Others).
split_min([H|T], Min, Mins, [H|Others]) :-
    H =\= Min,
    split_min(T, Min, Mins, Others).

% --- Блок для зручного вводу ---

start :-
    nl, write('--- Задача 1: Мінімум у початок ---'), nl,
    write('Введіть числа через пробіл (наприклад: 4 1 3 1 2) або stop:'), nl,
    write('> '),
    h_flush,
    read_line_to_string(user_input, String),
    (   String == "stop" -> write('Вихід.'), nl, !
    ;   String == "" -> start
    ;   split_string(String, " ", " ", StrList),
        (   maplist(number_string, Numbers, StrList) -> 
                move_min_to_front(Numbers, Res),
                format('Результат: ~w~n', [Res])
            ;   write('Помилка: вводьте тільки числа через пробіл!'), nl
        ),
        start
    ).

h_flush :- current_output(Out), flush_output(Out).