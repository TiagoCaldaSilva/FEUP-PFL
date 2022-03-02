% a)
isOrdered([]).
isOrdered([_|[]]).
isOrdered([Elem, Next|Rest]):-
    Elem =< Next,
    isOrdered([Next|Rest]).

% b)
insert_ordered(Value, List1, List2):-
    append(P1, P2, List1),
    append(P1, [Value|P2], List2),
    isOrdered(List2).

% c)
insert_sort([], []).
insert_sort([Elem], [Elem]).
insert_sort([Elem|Next], Ordered_List):-
    insert_sort(Next, Temp),
    insert_ordered(Elem, Temp, Ordered_List).