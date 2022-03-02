data(one).
data(two).
data(three).
cut_test_a(X):- data(X).
cut_test_a('five').
cut_test_b(X):- data(X), !.
cut_test_b('five').
cut_test_c(X, Y):- data(X), !, data(Y).
cut_test_c('five', 'five').

/*
true - dá sempre verdadeiro
fail - falha e provoca backtracking
*/
% a)
/* cut_test_a(X), write(X), nl, fail. => ciclo baseado em falha
Gera todas as possibilidades para cut_test_a, escreve na consola e faz backtracking
one
two
three
'five'
*/

% b)
/*  cut_test_b(X), write(X), nl, fail.
one
Encontra uma possível resposta para data(X) e como depois passa pelo Cut não conseguimos
 voltar para trás, uma vez passando pelo Cut não permite fazer backtracking
*/

% c)
/* cut_test_c(X, Y), write(X-Y), nl, fail.
one-one
one-two
one-three
Cut vai impedir de refazermos o valor para X, portanto quando ele esgota o data(Y), não permite refazer X
*/