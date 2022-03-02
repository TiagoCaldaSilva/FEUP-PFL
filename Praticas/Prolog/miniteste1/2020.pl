% jogo(Jornada, EquipaCasa, EquipaVisitante, Resultado).
jogo(1, sporting,porto, 1-2).
jogo(1, maritimo, bengica, 2-0).
jogo(2, sporting, benfica, 0-2).
jogo(2, porto, marritimo, 1-0).
jogo(3, maritimo, sporting, 1-1).
jogo(3, benfica, porto, 0-2).

% treinadores(Equipa, [[JornadaInicial-JornadaFinal]-NomeTreinador|Lista])
treinadores(porto, [[1-3]-sergio_conceicao]).
treinadores(sporting, [[1-2]-silas, [3-3]-ruben_amorim]).
treinadores(benfica, [[1-3]-bruno_lage]).
treinadores(maritimo, [[1-3]-jose_gomes]).

n_treinadores(Equipa, Numero):-
    treinadores(Equipa, List),
    length(List, Numero).

n_jornadas_treinador(Treinador, NumeroJornadas):-
        treinadores(_, List),
        append(_P1, [[Start-End]-Treinador|_P2], List),
        NumeroJornadas is End - Start + 1.

ganhou(Jornada, EquipaVencedora, EquipaDerrotada):-
    jogo(Jornada, EquipaVencedora, EquipaDerrotada, C-F),
    C > F.
ganhou(Jornada, EquipaVencedora, EquipaDerrotada):-
    jogo(Jornada, EquipaDerrotada, EquipaVencedora, C-F),
    C < F.

% 4 - c

% 5 - e

% 6
:- op(180, fx, o).
:- op(200, xfx, venceu).

o X venceu o Y:- ganhou(_, X, Y).

% 7
predX(N, N, _).
predX(N, A, B):-
    !,
    A \= B,
    A1 is A + sign(B - A),
    predX(N, A1, B).

/*
a)
O predicado predX vai ter sucesso quando o segundo parâmetro da função, A, alcançar o mesmo valor que o primeiro valor, N.
Nesse sentido ao valor de A, vai ser a cada iteração, adicionado 1 no caso de B ser superior a A, ou decrementado 1 no caso de A ser superior a B. Se A tiver o mesmo valor que B,
 a função falha (se não falhasse iria poderia entrar num ciclo infinito). Permite saber se N está entre [A, B].
Por outro lado, caso N não esteja instanciado, incialmente N vai ficar com o valor, ficando com valores cada vez mais próximos de B a cada Redo.

b)
O cut é verde, pois é um cut que serve par melhorar a eficiência do programa. Este cut serve para que não seja possível existir backtracking no caso da função falhar, ou seja, no caso de A ter o mesmo
 valor que B. Assim, se este cut não existisse, a função não iria falhar logo, e iria tentar por backtracking encontrar uma possível solução.
*/

% 8
always_win(End, End, Equipa):-
    jogo(End, Equipa, _, C-F),
    C > F.
always_win(End, End, Equipa):-
    jogo(End, _, Equipa, C-F),
    C < F.
always_win(Start, End, Equipa):-
    jogo(Start, Equipa, _, C-F),
    C > F,
    NewStart is Start + 1,
    always_win(NewStart, End, Equipa).
always_win(Start, End, Equipa):-
    jogo(Start, _, Equipa, C-F),
    C < F,
    NewStart is Start + 1,
    always_win(NewStart, End, Equipa).

treinador_bom(Treinador):-
    treinadores(Equipa, List),
    append(_P1, [[Start-End]-Treinador|_P2], List),
    always_win(Start, End, Equipa).

% 9
imprime_totobola(1, '1').
imprime_totobola(0, 'X').
imprime_totobola(-1, '2').

imprime_texto(X, 'vitoria da casa'):-
    X = 1.
imprime_texto(X, 'empate'):-
    X = 0.
imprime_texto(X, 'derrota da casa'):-
    X = -1.

imprime_jogos(Func, Curr):-
    jogo(J, E1, E2, C-F),
    \+member(J-E1/E2, Curr), !,
    X is sign(C - F),
    T =.. [Func, X, Text], T,
    write('Jornada '), write(J), write(': '), write(E1), write(' x '), write(E2), write(' - '), write(Text),nl,
    imprime_jogos(Func, [J-E1/E2|Curr]).
imprime_jogos(_, _).

imprime_jogos(F):-
    imprime_jogos(F, []).
    
% 10 - E

% 11 - E

% 12
getTreinadores([], []).
getTreinadores([[]|Next], Curr):-
    getTreinadores(Next, Curr).
getTreinadores([[_-Nome|NextL]|Next], [Nome|Curr]):-
    getTreinadores([NextL|Next], Curr).


lista_treinadores(L):-
    findall(List, treinadores(_Equipa, List), Temp),
    getTreinadores(Temp, L).

% 13
:-use_module(library(lists)).

getTreinadores2([], []).
getTreinadores2([[]|Next], Curr):-
    getTreinadores2(Next, Curr).
getTreinadores2([[[Start-End]-Nome|NextL]|Next], [Value-Nome|Curr]):-
    Value is End - Start + 1,
    getTreinadores2([NextL|Next], Curr).

duracao_treinadores(L):-
    findall(List, treinadores(_Equipa, List), Temp),
    getTreinadores2(Temp, Temp2),
    sort(Temp2, Temp3),
    reverse(Temp3, L).

% 14
getPascalLine([_], [1]).
getPascalLine([A1, A2|Next], [Value|Curr]):-
    Value is A1 + A2,
    getPascalLine([A2|Next], Curr).

pascal(1, [1]).
pascal(2, [1, 1]).
pascal(N, [1|L]):-
    PrevN is N - 1,
    pascal(PrevN, List),
    getPascalLine(List, L).
