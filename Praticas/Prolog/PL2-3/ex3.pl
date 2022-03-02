immature(X):- adult(X), !, fail.
immature(X).
adult(X):- person(X), !, age(X, N), N >=18.
adult(X):- turtle(X), !, age(X, N), N >=50.
adult(X):- spider(X), !, age(X, N), N>=1.
adult(X):- bat(X), !, age(X, N), N >=5.

/*
Red - Influencia o resultado
Green - Não influencia o resultado, apenas usado para eficiência
*/

% immature(X):- adult(X), !, fail. => Red => Versão do not, só conseguimos passar para baixo de adult(X) falhar
% adult(X):- person(X), !, age(X, N), N >=18. => Green
% adult(X):- turtle(X), !, age(X, N), N >=50. => Green
% adult(X):- spider(X), !, age(X, N), N>=1.   => Green
% adult(X):- bat(X), !, age(X, N), N >=5.     => Green
/*
Se temos alguém de uma espécie ele vai entrar nessa espécie por isso person(X) não vai ter mais do que um resultado
Não é preciso testar de novo se o X é de outra espécie, é só uma questão de eficiência
Espécie de switch, case para X
switch(X):
    case person:
    [...]
    case turlte:
    [...]
    case spider:
    [...]
    case bat:
    [...]
*/