% a)
count(Elem, [Elem|Next], Curr, Res):-
    NewCurr is Curr + 1,
    count(Elem, Next, NewCurr, Res).
count(_, _, Res, Res).

rle([], []).
rle([Elem|Next], [Elem-Res|List]):-
    count(Elem, [Elem|Next], 0, Res),
    append(P1, P2, [Elem|Next]),
    length(P1, Res),
    rle(P2, List).

% b)
fill(_, 0, []).
fill(Elem, N, [Elem|List]):-
    NewN is N - 1,
    fill(Elem, NewN, List).

un_rle([], []).
un_rle([Elem-N|Next], List):-
    fill(Elem, N, Temp),
    un_rle(Next, NextTemp),
    append(Temp, NextTemp, List).