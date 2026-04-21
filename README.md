sudo apt update && sudo apt install ghc -y
runhaskell task1.hs
4 1 3 1 2
0 -5 2 -5 10
1 2 3 4
10 20 30 5
7 7 7 7


sudo apt update && sudo apt install swi-prolog -y
swipl task1.pl
start.
4 1 3 1 2
0 -5 2 -5 10
1 2 3 4
10 20 30 5
7 7 7 7


Завдання 1.2


runhaskell task2.hs


swipl task2.pl
start.

Завдання 2
cd "2 задача"

runhaskell task2.hs

swipl task2.pl
start.

1 2 3 4 5 6 7 8
1 2 3 4 5 6 7 8 9 10
10 20
1 2 3 4 5 6

Завдання 3
cd "3 задача"
ghci Automaton.hs
main

swipl Automaton.pl

ab
b
aab
bb
a
c

Приклади інших граматик 3 завдання


1 
exampleAuto :: Automaton
exampleAuto = Automaton {
    states = [0, 1, 2],
    transitions = [
        ((0, 'a'), 1),
        ((1, 'a'), 1),
        ((1, 'b'), 2),
        ((2, 'b'), 2)
    ],
    startState = 0,
    finalStates = [2]
}

start_state(0).

final_state(2).

trans(0, a, 1).
trans(1, a, 1).
trans(1, b, 2).
trans(2, b, 2).


2

exampleAuto :: Automaton
exampleAuto = Automaton {
    states = [0, 1],
    transitions = [
        ((0, 'a'), 1), 
        ((1, 'a'), 0), 
        ((0, 'b'), 0), 
        ((1, 'b'), 1)
    ],
    startState = 0,
    finalStates = [0]
}

Пролог
start_state(0).
final_state(0).

trans(0, a, 1).
trans(1, a, 0).
trans(0, b, 0).
trans(1, b, 1).

3
exampleAuto :: Automaton
exampleAuto = Automaton {
    states = [0, 1, 2, 3],
    transitions = [
        ((0, 'x'), 1),
        ((1, 'y'), 1),
        ((1, 'z'), 2),
        ((2, 'z'), 2), 
        ((0, 'y'), 3), 
        ((0, 'z'), 3)
    ],
    startState = 0,
    finalStates = [2]
}


Пролог
start_state(0).
final_state(2).

trans(0, x, 1).
trans(1, y, 1).
trans(1, z, 2).
trans(2, z, 2).
trans(0, y, 3).
trans(0, z, 3).
trans(3, x, 3). trans(3, y, 3). trans(3, z, 3).


cd "4 задача"
ghci Terminal.hs
main

swipl Terminal.pl

1 приклад
rule(a, [b]).
rule(b, [c]).
rule(c, [a]). 

[ ("A", [NT "B"]), ("B", [NT "C"]), ("C", [NT "A"]) ]

2 приклад
rule(s, [a, b]). % b - термінал
rule(a, [s]).

[ ("S", [NT "A", T "b"]), ("A", [NT "S"]) ]

3 приклад
rule(x, [a, x]).
rule(x, [y]).
rule(y, [b]).


[ ("X", [T "a", NT "X"]), ("X", [NT "Y"]), ("Y", [T "b"]) ]

4 приклад

rule(s, [a]).
rule(s, [b]).
rule(a, [s]).
rule(b, [s]).

[ ("S", [NT "A"]), ("S", [NT "B"]), ("A", [NT "S"]), ("B", [NT "S"]) ]