% a)
fatorialAux(N, F, F, N).
fatorialAux(N, F, R, Curr):- NewR is Curr * R,
                             NewCurr is Curr + 1,
                             fatorialAux(N, F, NewR, NewCurr).

fatorial(0, 1).
fatorial(N, F):- N > 0,
                 fatorialAux(N, F, 1, 1).

% b)
somaRecAux(N, Sum, Sum, N).
somaRecAux(N, Sum, R, Curr):- NewR is R + Curr,
                              NewCurr is Curr + 1,
                              somaRecAux(N, Sum, NewR, NewCurr).

somaRec(N, Sum):- somaRecAux(N, Sum, 0, 0).

% c)
fibAux(N, N, _F1, F, F).
fibAux(N, ActualN, F1, F2, F):- N > 0,
                                ActualN < N,
                                ActualF2 is F2 + F1,
                                ActN is ActualN + 1,
                                fibAux(N, ActN, F2, ActualF2, F).

fibonacci(0, 0).
fibonacci(N, F):- N > 0,
                   fibAux(N, 1, 0, 1, F).

% fibonacci(0, 1) .
% fibonacci(1, 1) . 
% fibonacci(N, F) :- N > 0, 

%                      N1 is N - 1,
%                      fibonacci(N1, F1),
%                      N2 is N - 2,
%                      fibonacci(N2, F2),
%                      F is F1 + F2 .

% d)
isPrimeAux(N, N).
isPrimeAux(N, CurrN):- N mod CurrN =\= 0,
                       NextN is CurrN + 1,
                       isPrimeAux(N, NextN).
                       
isPrime(N):- N > 1,
             isPrimeAux(N, 2).