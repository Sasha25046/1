count_occurrences(_, [], 0).
count_occurrences(X, [X|T], N) :- 
    count_occurrences(X, T, N1), 
    N is N1 + 1, !.
count_occurrences(X, [_|T], N) :- 
    count_occurrences(X, T, N).

list_nub([], []).
list_nub([H|T], [H|T1]) :-
    delete(T, H, T2),
    list_nub(T2, T1).

get_statistics(List, Statistics) :-
    list_nub(List, Uniques),
    maplist(build_pair(List), Uniques, Statistics).

build_pair(FullList, Element, Element-Count) :-
    count_occurrences(Element, FullList, Count).

start :-
    nl, write('Введіть числа через пробіл (або stop):'), nl, write('> '),
    read_line_to_string(user_input, String),
    (   String == "stop" -> write('Вихід.'), nl, !
    ;   split_string(String, " ", " ", StrList),
        maplist(number_string, Numbers, StrList) ->
            get_statistics(Numbers, Res),
            format('Результат (Число-Кількість): ~w~n', [Res]),
            start
    ;   write('Помилка вводу!'), nl, start
    ).