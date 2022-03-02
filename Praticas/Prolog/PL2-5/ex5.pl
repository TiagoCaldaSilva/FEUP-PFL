:-op(500, xfx, then).
:-op(450, fx, if).
:-op(450, xfx, else).

if X then Y else _:- X, Y.
if _ then _ else Z:- Z.

% if (2 > 3) then write('hello\n') else write('goodbye\n').
