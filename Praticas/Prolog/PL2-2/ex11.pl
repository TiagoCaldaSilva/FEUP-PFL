nCr(_N, 0, 1).
nCr(_N, _N, 1).
nCr(N, R, Result):-
    N > R,
    R > 0,
    NewN is N - 1,
    NewR is R - 1,
    nCr(NewN, R, Res1),
    nCr(NewN, NewR, Res2),
    Result is Res1 + Res2.

pascalLine(N, Idx, []):-
    Idx is N + 1.
pascalLine(N, Idx, [Curr | Next]):-
    Idx =< N,
    nCr(N, Idx, Curr),
    NewIdx is Idx + 1,
    pascalLine(N, NewIdx, Next).

pascal(N, NLine, []):-
    NLine is N + 1.
pascal(N, NLine, [Line | Next]):-
    NLine =< N,
    pascalLine(NLine, 0, Line),
    NewNLine is NLine + 1,
    pascal(N, NewNLine, Next).

pascal(N, Lines) :- pascal(N, 0, Lines).
