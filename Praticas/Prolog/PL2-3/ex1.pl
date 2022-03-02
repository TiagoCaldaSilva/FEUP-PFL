s(1).
s(2):-!.
s(3).

% a) s(X) => X = 1 e X=2 não dava mais nenhum após isso
% b)
/* S(X), S(Y) 
X=1 e Y=1
X=1 e Y=2,
X=2 e Y=2 (ele tenta refazer o S(Y) mas devido ao cut não consegue então vai tentar refazer o X=2)
X=2 e Y=1 (como refez o X, vai refazer o Y doi início)
X=2 e Y=2
Ao tentar refazer ele vai falhar a tentar refazer S(Y) e como S(X) também já encontrou o Cut,
 não vai encontrar mais respostas possíveis e então ele falha e devolve no
*/
% c)
/* S(X), !, S(Y)
X=1 e Y=1
X=1 e Y=2
Depois não permite fazer backtracking, por isso todas
 as repostas possíveis só vão conseguir resolver os valores
 de Y, não conseguimos voltar para refazer S(X)
*/
% d)
/* S(X), S(Y), !
X=1 e Y=1
Não permitia refazer, assim que encontra uma resposta válida não faz backtracking
*/
