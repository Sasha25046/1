:- dynamic known/2.
:- dynamic category_known/1.

start :-
    undo, 
    welcome,
    (identify_fruit(Fruit) -> 
        format('~nРезультат: Це об’єкт - ~w!~n', [Fruit]) ;
        writeln('~nНа жаль, об’єкт не знайдено за вашим описом.')
    ),
    undo.

welcome :-
    writeln('--- Експертна система визначення об’єктів на літеру "A" ---'),
    writeln('Будь ласка, відповідайте "y." (так) або "n." (ні).'),
    writeln('Для вибору категорії введіть цифру та крапку (напр. "1.").').


identify_fruit('Apple') :- 
    is_category(pome_fruit),      
    check('crisp texture'),
    check('common in Europe').

identify_fruit('Aronia (Chokeberry)') :- 
    is_category(pome_fruit), 
    check('dark purple color'),
    check('bitter taste').

identify_fruit('Apricot') :- 
    is_category(stone_fruit), 
    check('velvety skin'),
    check('orange color').

identify_fruit('Ambarella') :- 
    is_category(stone_fruit), 
    check('crunchy texture'),
    check('tropical origin').

identify_fruit('Avocado') :- 
    is_category(berry), 
    check('creamy texture'),
    check('high fat content').

identify_fruit('Acerola') :- 
    is_category(berry), 
    check('very high Vitamin C'),
    check('red color').

identify_fruit('Akee') :- 
    is_category(tropical_pod), 
    check('national fruit of Jamaica'),
    check('brain-like appearance').

identify_fruit('Abiu') :- 
    is_category(tropical_pod), 
    check('yellow skin'),
    check('sweet caramel-like taste').


is_category(Type) :-
    category_known(CurrentType), !, 
    Type == CurrentType.

is_category(Type) :-
    writeln('~nЯкий тип плоду?'),
    writeln('1. Pome fruit (зерняткові)'),
    writeln('2. Stone fruit (кісточкові)'),
    writeln('3. Berry (ягоди)'),
    writeln('4. Tropical pod (тропічні стручки)'),
    write('Ваш вибір: '),
    read(Choice),
    match_category(Choice, ChosenType),
    asserta(category_known(ChosenType)), 
    Type == ChosenType.

match_category(1, pome_fruit).
match_category(2, stone_fruit).
match_category(3, berry).
match_category(4, tropical_pod).


check(Question) :-
    known(Question, Answer), !, 
    Answer == yes.

check(Question) :-
    format('Does it have ~w? (y/n) ', [Question]),
    read(Response),
    (Response == y -> 
        asserta(known(Question, yes)) ; 
        asserta(known(Question, no)), fail).

undo :- 
    retractall(known(_, _)), 
    retractall(category_known(_)).