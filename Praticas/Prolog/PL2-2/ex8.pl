:-use_module(library(lists)).
:-[ex1].

% a)
list_to(0, []).
list_to(N, List):-
    NewN is N - 1,
    list_to(NewN, Front),
    append(Front, [N], List).

% b)
list_from_to(Sup, Sup, [Sup]).
list_from_to(Inf, Sup, [Inf|Next]):-
    Inf < Sup,
    NewInf is Inf + 1,
    list_from_to(NewInf, Sup, Next).
list_from_to(Sup, Inf, List):-
    list_from_to(Inf, Sup, Temp),
    reverse(Temp, List).

% c)
list_from_step(Sup, _Step, Sup, [Sup]).
list_from_step(Inf, Step, Sup, [Inf|Next]):-
    Inf < Sup,
    NewInf is Inf + Step,
    list_from_step(NewInf, Step, Sup, Next).
list_from_step(_Inf, _Step, _Sup, []).

% d)
list_from_stepp(Inf, Step, Sup, List):-
    Inf < Sup,
    list_from_step(Inf, Step, Sup, List).
list_from_stepp(Sup, Step, Inf, List):-
    list_from_step(Inf, Step, Sup, Temp),
    reverse(Temp, List).

% e)
primes(1, []).
primes(N, List):-
    NewN is N - 1,
    \+ isPrime(N),
    primes(NewN, List).
primes(N, List):-
    NewN is N - 1,
    primes(NewN, Front),
    append(Front, [N], List).

% f)
fibs(0, [0]).
fibs(N, List):-
    N > 0,
    NewN is N - 1,
    fibonacci(N, F),
    fibs(NewN, Front),
    append(Front, [F], List).
