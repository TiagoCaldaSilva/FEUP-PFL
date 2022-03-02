% player(Name, UserName, Age).
player('Danny', 'Best Player Ever', 27).
player('Annie', 'Worst Player Ever', 24).
player('Harry', 'A-Star Player', 26).
player('Manny', 'The Player', 14).
player('Jonny', 'A Player', 16).

% game(Name, Categories, MinAge).
game('5 ATG', [action, adventure, open-world, multiplayer], 18).
game('Carrier Shift: Game Over', [action, fps, multiplayer, shooter], 16).
game('Duas Botas', [action, free, strategy, moba], 12).

%played(Player, Game, HoursPLayed, PercentUnlocked)
:-dynamic played/4.

played('Best Player Ever', '5 ATG', 3, 83).
played('Worst Player Ever', '5 ATG', 52, 9).
played('The Player', 'Carrier Shift: Game Over', 44, 22).
played('A Player', 'Carrier Shift: Game Over', 48, 24).
played('A-Star Player', 'Duas Botas', 37, 16).
played('Best Player Ever', 'Duas Botas', 33, 22).

% 1
achievedALot(Player):-
    played(Player, _, _, PercentUnlocked),
    PercentUnlocked >= 80.

% 2
isAgeAppropriate(Name, Game):-
    player(Name, _, PlayerAge),
    game(Game, _, MinAge),
    PlayerAge >= MinAge.

% 3
timePlayingGames(_, [], [], SumTimes, SumTimes).
timePlayingGames(Player, [Curr|Next], [Hours|ListOfTimes], CurrSum, SumTimes):-
    played(Player, Curr, Hours, _),
    NewCurr is CurrSum + Hours,
    timePlayingGames(Player, Next, ListOfTimes, NewCurr, SumTimes).
timePlayingGames(Player, [_|Next], [0|ListOfTimes], CurrSum, SumTimes):-
    timePlayingGames(Player, Next, ListOfTimes, CurrSum, SumTimes).

timePlayingGames(Player, Games, ListOfTimes, SumTimes):-
    timePlayingGames(Player, Games, ListOfTimes, 0, SumTimes).

% 4
find_games(Cat, Visited):-
    game(Name, List, MinAge),
    append(_P1, [Cat|_P2], List),
    \+member(Name, Visited), !,
    write(Name), write(' ('), write(MinAge), write(')'), nl,
    find_games(Cat, [Name|Visited]).
find_games(_, _).

listGamesOfCategory(Cat):-
    find_games(Cat, []).

% 5
updatePlayer(Player, Game, Hours, Percentage):-
    retract((played(Player, Game, PrevHours, PrevPercentage))), !,
    NewH is Hours + PrevHours,
    NewP is Percentage + PrevPercentage,
    assertz(played(Player, Game, NewH, NewP)).
% Caso retract falhe por o player Player não jogar o jogo Game
updatePlayer(Player, Game, Hours, Percentage):-
    assertz(played(Player, Game, Hours, Percentage)).

% 6
:-use_module(library(between)).
getGames(Player, Visited, [Game|Games]):-
    played(Player, Game, Hour, _),
    Hour < 10,
    \+member(Game, Visited), !,
    getGames(Player, [Game|Visited], Games).
getGames(_, _, []).

fewHours(Player, Games):-
    getGames(Player, [], Games).

% 7
ageRange(MinAge, MaxAge, Players):-
    findall(Name, (player(Name, _, Age), between(MinAge, MaxAge, Age)), Players).

% 8
getSum([], Sum, Sum).
getSum([Curr|Next], CurrSum, Sum):-
    NewSum is CurrSum + Curr,
    getSum(Next, NewSum, Sum).
averageAge(Game, AverageAge):-
    findall(Age, (player(_, Player, Age), played(Player, Game, _, _)), Ages),
    length(Ages, Length),
    getSum(Ages, 0, Sum),
    AverageAge is Sum / Length.

% 9
getMostEffective([], _, Res, Res).
getMostEffective([Player-Ratio|Next], BestRatio, _, Res):-
    Ratio > BestRatio,
    getMostEffective(Next, Ratio, [Player], Res).
getMostEffective([Player-BestRatio|Next], BestRatio, CurrP, Res):-
    getMostEffective(Next, BestRatio, [Player|CurrP], Res).
getMostEffective([_|Next], BestRatio, CurrP, Res):-
    getMostEffective(Next, BestRatio, CurrP, Res).
    
mostEffectivePlayers(Game, Players):-
    findall(Player-Ratio, (played(Player, Game, Hours, Percentage), Ratio is Percentage / Hours), Temp),
    getMostEffective(Temp, -1, [], Players), !.

% 10
aux(Username, Age):-
    played(Username, Game, _, _),
    game(Game, _, MinAge),
    MinAge > Age.

whatDoesItDo(Username) :-
    player(_, Username, Age), !,
    \+aux(Username, Age).
/***  
 * A função começa por selecionar um jogador, com Nome Y, username X e idade Z e vai verificar se esse jogador não jogou nenhum jogo 'ilegalmente', ou seja,
 *  um jogo cuja idade mínima seja superior à que esse jogador possui. Caso não tenha jogado o predicado sucede. Por outro lado, caso X não tenha sido passado como parâmetro, o predicado vai
 *  devolver em X um player se o primeiro player que encontrar não tiver jogado 'ilegalmente', falha caso o primeiro jogador encontrado tenha jogado 'ilegalmente'.
 * O cut é um red cut, pois vai fazer com que o predicado só verifique as condições para o primeiro jogador encontrado, não fazendo as verificações para os outros.
 */

% 11
/***
 * [O1/O2-Dist)|List], sendo que O1 seria sempre inferior a O2, ou seja, se quisessmos saber a distancia entre i e j, com i > j, iriamos procurar pela distância de j-i.
 *  Nesta matriz não seriam guardados os valores em que O1 = O2, pois nesse caso a distância é sempre 0.
 */

% 12
:-use_module(library(lists)).
matrix([1/2-8, 1/3-8, 1/4-7, 1/5-7, 2/3-2, 2/4-4, 2/5-4, 3/4-3, 3/5-3, 4/5-1]).
areClose(DMax, M, Pares):-
    findall(P2/P1, (select(P1/P2-D, M, _), D =< DMax), Pares).

% 13
/**
 * Uma possível estrutura para guardar um denograma podia ser a seguinte:
 *  node(Id, L, R). 
 * Sendo que Id seria o identificador do nó, L seria um ramo da esquerda e R seria o ramo da direita. 
 * Estes ramos poderiam conter outros nós ou conter folhas:
 *  folha(Nome). 
 * node(0, node(1, folha(niger), folha(india)), folha(irlanda))
 **/

den(node(0, node(1, node(2, node(4, node(6, folha(australia), node(7, node(8, folha(staHelena), folha(anguila)), folha(georgiaSul))), folha(reinoUnido)), node(5, folha(servia), folha(franca))), node(3, node(9, folha(niger), folha(india)), folha(irlanda))), folha(brasil))).
teste(node(0, folha(a), folha(b))).
% 14
altura(F,folha(F), 0).
altura(F, node(_, L, _), A):-
    altura(F, L, AL), !,
    A is AL + 1.
altura(F, node(_, _, R), A):-
    altura(F, R, AR),!,
    A is 1 + AR.

getNode(node(ID, L, R), ID, node(ID, L, R)).
getNode(node(_, L, _), ID, N):- getNode(L, ID, N).
getNode(node(_, _, R), ID, N):- getNode(R, ID, N).

hasFolha(folha(Folha), Folha):- !.
hasFolha(node(_, L, _), Folha):-
    hasFolha(L, Folha).
hasFolha(node(_, _, R), Folha):-
    hasFolha(R, Folha).

distance(F1, F2, D, Dist):-
    getNode(D, _,  N),
    hasFolha(N, F1),
    hasFolha(N, F2),
    altura(F1, N, D1),
    altura(F2, N, D2),
    Dist is max(D1, D2).
