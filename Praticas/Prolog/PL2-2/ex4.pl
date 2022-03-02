a) [ a | [b, c, d] ] -> [a, b, c, d]
b) [ a | b, c, d ] -> A cauda da lista tem de ser uma lista
c) [ a | [b | [c, d] ] ] -> [a, b, c, d]
d) [H|T] = [pfl, lbaw, redes, ltw] => H = pfl
                                      T = [lbaw, redes, ltw]
e) [H|T] = [lbaw, ltw] => H = lbaw
                          T = [ltw]
f) [H|T] = [leic] => H = lieic
                     T = []
g) [H|T] = [] => Erro, para usar o pipe a lista não pode estar vazia
h) [H|T] = [leic, [pfl, ltw, lbaw, redes]] => H = leic
                                              T = [pfl, ltw, lbaw, redes]
i) [H|T] = [leic, two] => H = leic
                          T = [two]
j) [Inst, feup] = [gram, LEIC] => Inst é uma variável e fica com o valor de gram
                                  LEIC é variável, ficava com o valor de feup 
k) [One, Two | Tail] = [1, 2, 3, 4] => One = 1
                                       Two = 2
                                       Tail = [3, 4]
l) [One, Two | Tail] = [leic | Rest] => One = leic
                                        Rest = [Two | Tail]