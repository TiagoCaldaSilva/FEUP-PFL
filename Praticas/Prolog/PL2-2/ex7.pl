% a)
list_append([], L2, L2).
list_append([H|T], L2, [H|NewL3]):-
    list_append(T, L2, NewL3).

% b)
list_member(Elem, List):-
    list_append(_X, [Elem|_S], List).
% c)
list_last(List, Last):-
    append(_P1, [Last], List).
% d)
list_nth(N, List, Elem):-
    append(P1, [Elem|_P2], List),
    length(P1, N).

% e)
list_append([L1|[]], L1).
list_append([L1|L2], Res):-
    list_append(L1, Temp, Res),
    list_append(L2, Temp).

% f)
list_del(List, Elem, Res):-
    append(Part1, [Elem|Part2], List),
    append(Part1, Part2, Res).

% g)
list_before(First, Second, List):-
    append(_P1, [First|P2], List),
    append(_P3, [Second|_P4], P2).

% h)
list_replace_one(X, Y, List1, List2):-
    append(P1, [X|P2], List1),
    append(P1, [Y|P2], List2).

% i)
list_repeated(X, List):-
    append(_P1, [X|P2], List),
    append([X|_P3], _P4, P2).

% j)
list_slice(List1, Index, Size, List2):-
    append(P1, P2, List1),
    length(P1, Index),
    append(List2, P4, P2),
    length(List2, Size).

% k)
list_shift_rotate(List1, N, List2):-
    append(P1, P2, List1),
    length(P1, N),
    append(P2, P1, List2).