:-use_module(library(between)).

% a)
print_n(S, 0).
print_n(S, N):- N > 0,
                write(S),
                New_N is N - 1,
                print_n(S, New_N).

% b)
print_string([]).
print_string([Curr|Next]) :- put_code(Curr), print_string(Next).
print_text(Text, Symbol, Padding):- write(Symbol),
                                    print_n(' ', Padding),
                                    print_string(Text),
                                    print_n(' ', Padding),
                                    write(Symbol).

% c)

print_topbot_banner(Symbol, Length):- print_n(Symbol, Length), nl.
print_middle_banner(Symbol, Length):- write(Symbol), print_n(' ', Length), write(Symbol), nl.
print_banner(Text, Symbol, Padding):- length(Text, Length),
                                      Spaces is Length + Padding + Padding,
                                      TopAndBottom is Spaces + 2,
                                      print_topbot_banner(Symbol, TopAndBottom),
                                      print_middle_banner(Symbol, Spaces).
                                      print_text(Text, Symbol, Padding), nl,
                                      print_middle_banner(Symbol, Spaces).
                                      print_topbot_banner(Symbol, TopAndBottom).
                                  
% d)
read_number(Curr, X) :- peek_code(10),
                        reverse(Curr, NewCurr),
                        number_codes(X, NewCurr), !, skip_line.
read_number(Curr, X) :- get_code(Y),
                        between(47, 58, Y), !,
                        read_number([Y|Curr], X). 
read_number(Curr, X) :- skip_line, fail.

read_number(X):- read_number([], X).

% e)
read_until_between(Min, Max, Value):- read_number(X), between(Min, Max, X), !.
read_until_between(Min, Max, Value):- read_until_between(Min, Max, Value).

% f)
read_string(Curr, X):- peek_code(10), !, reverse(Curr, X), skip_line.
read_string(Curr, X):- get_code(Y),
                       read_string([Y|Curr], X).
read_string(X):- read_string([], X).

% g)
banner:- write('Symbol? '),
         get_code(SymbolCode),
         char_code(Symbol, SymbolCode),
         peek_code(10),!, get_code(10),
         write('Padding? '),
         read_number(Padding),
         write('Text? '),
         read_string(Text),
         print_banner(Text, Symbol, Padding). 
banner:- skip_line, fail.

% h)

getMaxLength([], Max, Max).
getMaxLength([Curr|Next], CurrMax, Max):- length(Curr, CurrLength),
                                          CurrLength > CurrMax, !,
                                          getMaxLength(Next, CurrLength, Max).
getMaxLength([Curr|Next], CurrMax, Max):- getMaxLength(Next, CurrMax, Max).

print_text(Text, Symbol, LP, RP):- write(Symbol), print_n(' ', LP), print_string(Text), print_n(' ', RP), write(*), nl.

print_multi_bannerAux([], _ , _, _).
print_multi_bannerAux([Curr|Next], Symbol, Padding, Max):-length(Curr, Length),
                                                         Dif is Max - Length,
                                                         0 is mod(Dif, 2), !,
                                                         NewP is div(Dif, 2),
                                                         NewPadding is Padding + NewP,
                                                         print_text(Curr, Symbol, NewPadding, NewPadding),
                                                         print_multi_bannerAux(Next, Symbol, Padding, Max).
print_multi_bannerAux([Curr|Next], Symbol, Padding, Max):-length(Curr, Length),
                                                         Dif is Max-Length,
                                                         NewP is div(Dif, 2),
                                                         LP is Padding + NewP,
                                                         RP is Padding + NewP + 1,  
                                                         print_text(Curr, Symbol, LP, RP),
                                                         print_multi_bannerAux(Next, Symbol, Padding, Max).

print_multi_banner(List, Symbol, Padding):- getMaxLength(List, 0, Max),
                                            MiddleLength is 2*Padding + Max,
                                            TBLength is 2 + MiddleLength, 
                                            print_topbot_banner(Symbol, TBLength),
                                            print_middle_banner(Symbol, MiddleLength),
                                            print_multi_bannerAux(List, Symbol, Padding, Max),
                                            print_middle_banner(Symbol, MiddleLength),
                                            print_topbot_banner(Symbol, TBLength).

% i)
oh_christmas_tree(N, N, _).
oh_christmas_tree(CurrN, N, Padding):- print_n(' ', Padding),
                                       NumSym is 2*CurrN -1,
                                       print_n('*', NumSym), nl,
                                       NewP is Padding - 1,
                                       NewCurrN is CurrN + 1,
                                       oh_christmas_tree(NewCurrN, N, NewP).
                                          
oh_christmas_tree(N):- MaxL is 2*N-1,
                       BaseP is div(MaxL, 2),
                       oh_christmas_tree(1, N, BaseP),
                       print_n(' ', BaseP), write('*') ,nl.
