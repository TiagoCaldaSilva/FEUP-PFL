:-dynamic male/1, female/1, parent/2.

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
create(1, Name):- assert(male(Name)).
create(2, Name):- assert(female(Name)).
add_person:- write('1.male\n2.female\n'),
             read(Gender), nl,
             write('Name: '),
             read(Name), nl,
             create(Gender, Name).

% b)
add_parents(Person):- write('Progenitor 1:\n'),
                      read(Progenitor1), nl,
                      write('Progenitor 2:\n'),
                      read(Progenitor2), nl,
                      assert(parent(Progenitor1, Person)),
                      assert(parent(Progenitor2, Person)).

% c)
remove_person:-write('Person name:\n'),
               read(Person), nl,
               retractall(parent(Person, _)),
               retractall(parent(_, Person)),
               retractall(male(Person)),
               retractall(female(Person)),
               write('Removed\n').
