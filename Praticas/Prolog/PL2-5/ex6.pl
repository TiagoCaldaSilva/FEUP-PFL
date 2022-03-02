:-op(500, xfx, exists_in).
Element exists_in List:- append(_, [Element|_], List).

:-op(450, fx, append).
:-op(500, xfx, to).
:-op(450, xfx, results).

append A to B  results [A|B]. 

:-op(450, fx, remove).
:-op(500, xfx, from).

remove Elem from List results Result:- append(P1, [Elem|P2], List), append(P1, P2, Result).

read_value(X):-
    repeat,
    write('write hello'),
    read(X),
    X = hello.