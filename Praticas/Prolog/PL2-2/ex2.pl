parent(Grace, Phill).
parent(Frank, Phill).
parent(Dede, Claire).
parent(Dede, Mitchell).
parent(Jay, Claire),
parent(Jay, Mitchell).
parent(Jay, Joe).
parent(Gloria, Joe).
parent(Gloria, Manny).
parent(Javier, Manny).
parent(Barb, Cameron).
parent(Barb, Pameron).
parent(Merle, Cameron).
parent(Merle, Pameron).
parent(Phill, Haley).
parent(Phill, Alex).
parent(Phill, Luke).
parent(Claire, Haley).
parent(Claire, Alex).
parent(Claire, Luke).
parent(Mitchell, Lily).
parent(Mitchell, Rexford).
parent(Cameron, Lily).
parent(Cameron, Rexford).
parent(Pameron, Calhoun).
parent(Bo, Calhoun).
parent(Dylan, George).
parent(Dylan, Poppy).
parent(Haley, George).
parent(Haley, Poppy).

% a)
ancestor(X, Y):- parent(X, Y).
ancestor(X, Y):- parent(X, Z),
                 ancestor(Z, Y).

% b)
descendant(X, Y):- ancestor(Y, X).