:- use_module(library(lists)).

female(grace).
female(dede).
female(claire).
female(haley).
female(poppy).
female(alex).
female(poppy).
female(lily).

male(mitchell).
male(frank).
male(phil).
male(jay).
male(dylan).
male(george).
male(luke).
male(frank).

parent(grace, phil).
parent(frank, phil).

parent(dede, claire).
parent(jay, claire).

parent(dede, mitchell).
parent(jay, mitchell).

parent(mitchell, lily).

parent(phil, haley).
parent(claire, haley).

parent(phil, alex).
parent(claire, alex).

parent(phil, luke).
parent(claire, luke).

parent(dylan, poppy).
parent(haley, poppy).

parent(dylan, george).
parent(haley, george).

father(X,Y) :- parent(X, Y), male(X).
mother(X,Y) :- parent(X, Y), female(X).
grandfather(X,Y) :- parent(X,Z), parent(Z,Y), male(X).
grandmother(X,Y) :- parent(X,Z), parent(Z,Y), female(X).
siblings(X,Y) :- parent(Z,X), parent(W,X),W==X, parent(Z,Y), parent(W,Y).
halfSiblings(X,Y) :- parent(P,X), parent(M,X), parent(W,Y), P==M, P==W, M==P, M==W.
uncle(X,Y) :- parent(Z,Y), siblings(X,Z).
cousins(X,Y) :- parent(Z,X), uncle(Z,Y).

% a)
children(Person, Children):- findall(Child, parent(Person, Child), Children).

% b)
children_of([], []).
children_of([Curr|Next], [Curr-Result|ListOfPairs]):- children(Curr, Result),
                                                      children_of(Next, ListOfPairs).

%c)
family(F):- findall(M, male(M), Males),
            findall(W, female(W), Females),
            append(Males, Females, F).
% d)
couple(M-F):- parent(M, Child), parent(F, Child), M \= F.

% e)
couples(List) :- setof(X, couple(X), List).

% f)
spouse_children(Person, S-C):- couple(Person-S), findall(X, (parent(Person, X), parent(S, X)), C).

% g)
immediate_family(Person, P-C):- findall(X, parent(X, Person), P), spouse_children(Person, C).

% h)
has_two(Person):- parent(Person, Child1), parent(Person, Child2), Child1 \= Child2.

parents_of_two(Parents):- findall(Parent, has_two(Parent), Parents).