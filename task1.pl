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