% a
double(X, Y):- Y is X*2.

map(_Func, [], []).
map(Func, [Curr|Next], [RCurr|RNext]):-
    G =.. [Func, Curr, RCurr],
    G,
    map(Func, Next, RNext). 

% b
sum(A, B, S):- S is A+B.

fold(_Func, F, [], F).
fold(Func, Init, [Curr|Next], F):-
    G =.. [Func, Init, Curr, R],
    G,
    fold(Func, R, Next, F).

% c
even(X):- 0 =:= X mod 2.
separate([], _Func, [], []).
separate([Curr|Next], Func, [Curr|YNext], No):-
    G =.. [Func, Curr],
    G, !,
    separate(Next, Func, YNext, No).

separate([Curr|Next], Func, Yes, [Curr|NoNext]):-
    separate(Next, Func, Yes, NoNext).

% d
ask_execute:-
    write('Insira o que deseja executar'), nl,
    read(Exec),
    Exec.