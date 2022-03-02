%class(Course, ClassType, DayOfWeek, Time, Duration) 
class(pfl, t, '1 Seg', 11, 1).
class(pfl, t, '4 Qui', 10, 1).
class(pfl, tp, '2 Ter', 10.5, 2).

class(lbaw, t, '1 Seg', 8, 2).
class(lbaw, tp, '3 Qua', 10.5, 2).

class(ltw, t, '1 Seg', 10, 1).
class(ltw, t, '4 Qui', 11, 1).
class(ltw, tp, '5 Sex', 8.5, 2).

class(fsi, t, '1 Seg', 12, 1).
class(fsi, t, '4 Qui', 12, 1).
class(fsi, tp, '3 Qua', 8.5, 2).

class(rc, t, '4 Qui', 8, 2).
class(rc,  tp,  '5  Sex',  10.5,  2).

% a)
same_day(UC1, UC2):-
    class(UC1, _, Day, _, _),
    class(UC2, _, Day, _, _).

% b)
daily_courses(Day, Courses):-
    findall(Course, class(Course, _, Day, _, _), Courses).

% c)
short_classes(L):-
    findall(Course-(DayOfWeek/Time), (class(Course, _ClassType, DayOfWeek, Time, Duration), Duration < 2), L).

% d)
course_classes(Course, Classes):-
    findall(DayOfWeek/Hour-ClassType, class(Course, ClassType, DayOfWeek, Hour, _), Classes).

% e)
courses(L):-
    setof(Course, (Type, Day, Time, Duration)^class(Course, Type, Day, Time, Duration), L).

% f)
writeSchedule([]).
writeSchedule([Curr|Next]):-
    write(Curr), nl,
    writeSchedule(Next).
schedule:-
    setof((Day, Time, Course, Type, Duration), class(Course, Type, Day, Time, Duration), L),
    writeSchedule(L).

% g)
convert('1 Seg', seg).
convert('2 Ter', ter).
convert('3 Qua', qua).
convert('4 Qui', qui).
convert('5 Ser', sex).

writeSchedule2([]).
writeSchedule2([(Day, Time, Type, Duration)|Next]):-
    convert(Day, NewDay),
    write((NewDay, Time, Type, Duration)), nl,
    writeSchedule2(Next).

schedule2:-
    setof((Day, Time, Course, Type, Duration), class(Course, Type, Day, Time, Duration), L),
    writeSchedule2(L).

% h)
find_class:-
    write('Day: '),
    read(Day), nl,
    write('Time: '),
    read(Time), nl,
    class(Course, _, Day, Time, Duration),
    write(Course-Time/Duration).
