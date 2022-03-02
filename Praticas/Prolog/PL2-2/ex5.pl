% a)
list_sizeAux([], Size, Size).
list_sizeAux([H|T], Size, CurrSize):- NewCurrSize is CurrSize + 1,
                                      list_sizeAux(T, Size, NewCurrSize).

list_size(List, Size):- list_sizeAux(List, Size, 0).

% b)
list_sumAux([], Sum, Sum).
list_sumAux([H|T], Sum, CurrSum):- NextSum is CurrSum + H,
                                   list_sumAux(T, Sum, NextSum).
list_sum(List, Sum):- list_sumAux(List, Sum, 0).

% c)
list_prodAux([]; Prod, Prod).
list_prodAux([H|T], Prod, Curr):- NewCurr is Curr * H,
                                  list_prodAux(T, Prod, NewCurr).

list_prod(List, Prod): list_prodAux(List, Prod, 1).

% d)
inner_productAux([], [], []).
inner_productAux([H1|T1], [H2|T2],  [ Curr | Tail]):- Curr is H1 * H2,
                                                      inner_productAux(T1, T2, Tail).

inner_product(List1, List2, Sum):- inner_productAux(List1, List2, Result),
                                   list_sum(Result, Sum).
% e)
countAux(Elem, [], N, N).
countAux(H, [H|T], N, CurrN):- NextN is CurrN + 1,
                               countAux(H, T, N, NextN).
countAux(Elem, [H|T], N, CurrN):- countAux(Elem, T, N, CurrN).
count(Elem, List, N):-countAux(Elem, List, N, 0).
