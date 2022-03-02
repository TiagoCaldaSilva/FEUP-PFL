:-use_module(library(lists)).

% a

my_arg(Idx, Func, Arg):-
    Idx > 0,
    Func =.. G,
    nth0(Idx, G, Arg).

myFunctor(Term, Name, Arity):-
    var(Term), !,
    length(List, Arity),
    Term =.. [Name|List].

myFunctor(Term, Name, Arity):-
    Term =.. G,
    length(G, Length),
    Arity is Length - 1,
    nth0(0, G, Name).

% b
getArgs(Curr, Curr, Term, [Args|[]]):-
    arg(Curr, Term, Args).
getArgs(Curr, Arity, Term, [CurrArg|Args]):-
    arg(Curr, Term, CurrArg),
    NewCurr is Curr + 1,
    getArgs(NewCurr, Arity, Term, Args).

univ(Term, [Name|Args]):-
    var(Term), !,
    length(Args, Arity),
    functor(Term, Name, Arity),
    getArgs(1, Arity, Term, Args).

univ(Term, [Name|Args]):-
    functor(Term, Name, Arity),
    getArgs(1, Arity, Term, Args).

% c
:- op(400, xfx, univ).