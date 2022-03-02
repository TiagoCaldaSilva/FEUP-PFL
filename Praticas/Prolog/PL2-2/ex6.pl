% a)
invertAux([], L, L).
invertAux([H|T], List2, Curr):- append([H], Curr, NewCurr),
                                invertAux(T, List2, NewCurr).
invert(List1, List2):- invertAux(List1, List2, []).

% b)
del_oneAux(H, [H|T], List2, Curr):- append(Curr, T, List2).
del_oneAux(Elem, [H|T], List2, Curr):- append(Curr, [H], NewCurr),
                                       del_oneAux(Elem, T, List2, NewCurr).

del_one(Elem, List1, List2):- del_oneAux(Elem, List1, List2, []).

% c)
del_allAux(Elem, [], List2, List2).
del_allAux(H, [H|T], List2, Curr):- del_allAux(H, T, List2, Curr).
del_allAux(Elem, [H|T], List2, Curr):- append(Curr, [H], NewCurr),
                                       del_allAux(Elem, T, List2, NewCurr).

del_all(Elem, List1, List2):- del_allAux(Elem, List1, List2, []).

% d)
del_all_list([], List2, List2).
del_all_list([H|T], List1, List2):- del_all(H, List1, Curr),
                                    del_all_list(T, Curr, List2).

% e)
del_dupsAux([], List2, List2).
del_dupsAux([H|T], List2, Curr):- del_all(H, T, NewT),
                                  append(Curr, [H], NewCurr),
                                  del_dupsAux(NewT, List2, NewCurr).
del_dups(List1, List2):- del_dupsAux(List1, List2, []).

% f)
list_permAux([], L2).
list_permAux([H|T], L2):- member(H, L2),
                          list_permAux(T, L2).

list_perm(L1, L2):- length(L1, Length1),
                    length(L2, Length2),
                    Length1 =:= Length2,
                    list_permAux(L1, L2).

% g)
replicateAux(0, _, List, List).
replicateAux(Amount, Elem, List, Curr):-NewAmount is Amount - 1,
                                        replicateAux(NewAmount, Elem, List, [Elem|Curr]).

replicate(Amount, Elem, List):- replicateAux(Amount, Elem, List, []).

% h)
intersperseAux(_, [], List2, List2).
intersperseAux(Elem, [H|T], List2, Curr):- append(Curr, [H, Elem], NewCurr),
                                            intersperseAux(Elem, T, List2, NewCurr).

intersperse(Elem, List1, List2):-intersperseAux(Elem, List1, List2, []).

% i)
insert_elemAux(0, List1, Elem, NewCurr, Curr):- append(Curr, [Elem | List1], NewCurr).
insert_elemAux(Index, [H|T], Elem, List2, Curr):- NewIndex is Index - 1,
                                                  append(Curr, [H], NewCurr),
                                                  insert_elemAux(NewIndex, T, Elem, List2, NewCurr).

insert_elem(Index, List1, Elem, List2):- insert_elemAux(Index, List1, Elem, List2, []).

% j)
% delete_elem(Index, List1, Elem, List2)

% k)
replaceAux([Old|T], 0, Old, New, NewCurr, Curr):- append(Curr, [New|T], NewCurr).
replaceAux([H|T], Index, Old, New, List2, Curr):- NewIndex is Index - 1,
                                                  append(Curr, [H], NewCurr),
                                                  replaceAux(T, NewIndex, Old, New, List2, NewCurr).
replace(List1, Index, Old, New, List2):- replaceAux(List1, Index, Old, New, List2, []).