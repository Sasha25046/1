
split_from_end(List, Result) :-
    reverse(List, RevList),
    group_elements(RevList, 1, Groups),
    reverse(Groups, Result).

group_elements([], _, []).
group_elements(List, N, [FinalPart|RestGroups]) :-
    take_and_reverse(N, List, Part, Rest),
    reverse(Part, FinalPart), 
    N1 is N + 1,
    group_elements(Rest, N1, RestGroups).

take_and_reverse(0, Rest, [], Rest) :- !.
take_and_reverse(_, [], [], []) :- !.
take_and_reverse(N, [H|T], [H|Part], Rest) :-
    N1 is N - 1,
    take_and_reverse(N1, T, Part, Rest).


start :-
    nl, write('--- Задача 2: Розбиття з кінця (Prolog) ---'), nl,
    write('Введіть числа (наприклад: 1 2 3 4 5 6) або stop:'), nl,
    write('> '), h_flush,
    read_line_to_string(user_input, String),
    (   String == "stop" -> write('Вихід.'), nl, !
    ;   split_string(String, " ", " ", StrList),
        (   maplist(number_string, Numbers, StrList) -> 
                split_from_end(Numbers, Res),
                format('Результат: ~w~n', [Res])
            ;   write('Помилка вводу!'), nl
        ),
        start
    ).

h_flush :- current_output(Out), flush_output(Out).