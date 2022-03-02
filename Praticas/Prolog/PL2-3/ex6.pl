:-use_module(library(ordsets)).

leciona(algoritmos, adalberto).
leciona(base_dados, bernardete).
leciona(compiladores, capitolino).
leciona(estatistica, diogenes).
leciona(redes, ermelinda).
leciona(reedes, ermelinda).

frequenta(algoritmos, alberto).
frequenta(algoritmos, bruna).
frequenta(algoritmos, cristina).
frequenta(algoritmos, diogo).
frequenta(algoritmos, eduarda).

frequenta(base_dados, antonio).
frequenta(base_dados, bruno).
frequenta(base_dados, cristina).
frequenta(base_dados, duarte).
frequenta(base_dados, eduardo).

frequenta(compiladores, alberto).
frequenta(compiladores, bernardo).
frequenta(compiladores, clara).
frequenta(compiladores, diana).
frequenta(compiladores, eurico).

frequenta(estatistica, antonio).
frequenta(estatistica, bruna).
frequenta(estatistica, claudio).
frequenta(estatistica, duarte).
frequenta(estatistica, eva).

frequenta(redes, alvaro).
frequenta(redes, beatriz).
frequenta(redes, claudio).
frequenta(redes, diana).
frequenta(redes, eduardo).
frequenta(reedes, eduardo).


% a)
teachers(T):-
    findall(Teacher, leciona(_, Teacher), T).

% b)
teachers_d(T):-
    setof(Teacher, Course^leciona(Course, Teacher), T).

% c)
students_of(T, S):-
    setof(Student, Course^(leciona(Course, T), frequenta(Course, Student)), S).

% d)
teachers_of(S, T):-
    setof(Teacher, Course^(frequenta(Course, S), leciona(Course, Teacher)), T).

% e)
common_courses(S1, S2, C):-
    findall(Course, (frequenta(Course, S1), frequenta(Course, S2)), C).

% f)
more_than_one_course(L):-
    setof(Student, (Course1, Course2)^(frequenta(Course1, Student), frequenta(Course2, Student), Course1 \= Course2), L).

% g)
strangers(L):-
    setof(S1-S2, (Course1, Course2)^(frequenta(Course1, S1), frequenta(Course2, S2), S1 \= S2), L1),
    setof(S1-S2, Course^(frequenta(Course, S1), frequenta(Course, S2), S1 \= S2), L2),
    ord_subtract(L1, L2, L).

% h)
good_groups(L):-
    setof(S1-S2, (C1, C2)^(frequenta(C1, S1), frequenta(C1, S2), frequenta(C2, S1), frequenta(C2, S2), C1 \= C2, S1 \= S2), L).