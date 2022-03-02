% airport(Name, ICAO, Country).
airport('Aeroporto Francisco Sá Carneiro', 'LPPR', 'Portugal').
airport('Aeroporto Humberto Delgado', 'LPPT', 'Portugal').
airport('Aeropuerto ADolfo Suárez Madrid-Barajas', 'LEMD', 'Spain').
airport('Aérport de Paris-Charles-de-Gaulle Roissy Airport', 'LFPG', 'France').
airport('Aeroporto Internazionale di Roma-Fiumicino', 'LIRF', 'Italy').

% company(ICAO, Name, Year, Country)
company('TAP', 'TAP Air Portugal', 1945, 'Portugal').
company('RYR', 'Ryanair', 1984, 'Ireland').
company('ARF', 'Société Air France S.A.', 1933, 'France').
company('BAW', 'British Airways', 1974, 'United Kingdom').

% flight(Designation, Origin, Destination, DepartureTime, Duration, Company).
flight('TP1923', 'LPPR', 'LPPT', 1115, 55, 'TAP').
flight('TP1968', 'LPPT', 'LPPR', 2235, 55, 'TAP').
flight('TP842', 'LPPT', 'LIRF', 1450, 195, 'TAP').
flight('TP843', 'LIRF', 'LPPT', 1935, 195, 'TAP').
flight('FR5483', 'LPPR', 'LEMD', 630, 105, 'RYR').
flight('TP5484', 'LEMD', 'LPPR', 1935, 105, 'RYR').
flight('AF1024', 'LFPG', 'LPPT', 940, 155, 'AFR').
flight('AF1025', 'LPPT', 'LFPG', 1310, 155, 'AFR').

% 1

short(Flight):-
    flight(Flight, _, _, _, Duration, _),
    Duration < 90.

% 2

shorter(Flight1, Flight2, Flight1):-
    flight(Flight1, _, _, _, Duration1, _),
    flight(Flight2, _, _, _, Duration2, _),
    Duration1 < Duration2.

shorter(Flight1, Flight2, Flight2):-
    flight(Flight1, _, _, _, Duration1, _),
    flight(Flight2, _, _, _, Duration2, _),
    Duration1 > Duration2.

% 3

addTime(Time1, Time2, Final):-
    Minutes1 is Time1 mod 100,
    Hours1 is Time1 div 100,
    Minutes2 is Time2 mod 100,
    Hours2 is Time2 div 100,
    NewMinutes is (Minutes1 + Minutes2) mod 60,
    NewHours is ((Hours1 + Hours2) + ((Minutes1 + Minutes2) div 60)) mod 24,
    Final is NewHours * 100 + NewMinutes.

arrivalTime(Flight, ArrivalTime):-
    flight(Flight, _, _, DepartureTime, Duration, _),
    Minutes is DepartureTime mod 100,
    Hours is DepartureTime div 100,
    NewMinutes is (Minutes + Duration) mod 60,
    NewHours is (Hours + ((Minutes + Duration) div 60)) mod 24,
    ArrivalTime is NewHours * 100 + NewMinutes.

% 4

operates(Company, Country):-
    flight(_, Origin, _, _, _, Company),
    airport(_, Origin, Country).
operates(Company, Country):-
    flight(_, _, Destination, _, _, Company),
    airport(_, Destination, Country).

getCountries(Company, Curr, Res):-
    operates(Company, Country),
    \+member(Country, Curr),!,
    getCountries(Company, [Country|Curr], Res).
getCountries(_, Res, Res).

countries(Company, ListOfCountries):-
    getCountries(Company, [], ListOfCountries).

% 5

getFlights(Curr):-
    flight(Flight1, _, Airport, _, _, _),
    flight(Flight2, Airport, _, DepartureTime, _, _),
    arrivalTime(Flight1, ArrivalTime),
    addTime(ArrivalTime, 30, Min),
    addTime(ArrivalTime, 90, Max),
    DepartureTime >= Min,
    DepartureTime =< Max,
    \+member(Flight1-Flight2, Curr), !,
    write(Airport), write(' - '), write(Flight1), write(' \\ '), write(Flight2), nl,
    getFlights([Flight1-Flight2|Curr]).
getFlights(_).

pairableFlights:- getFlights([]).

% 6
tripDays([_Last], _, FlightTimes, FlightTimes, Days, Days).

tripDays([From, To|Next], Time, Curr, FlightTimes, Counter, Days):-
    airport(_, ICAO1, From),
    airport(_, ICAO2, To),
    flight(Flight, ICAO1, ICAO2, DepartureTime, _, _),
    DepartureTime >= Time, !,
    arrivalTime(Flight, ArrivalTime),
    addTime(ArrivalTime, 30, NewTime),
    tripDays([To|Next], NewTime, [DepartureTime|Curr], FlightTimes, Counter, Days).
tripDays([From, To|Next], Time, Curr, FlightTimes, Counter, Days):-
    airport(_, ICAO1, From),
    airport(_, ICAO2, To),
    flight(Flight, ICAO1, ICAO2, DepartureTime, _, _),
    DepartureTime < Time, !,
    arrivalTime(Flight, ArrivalTime),
    addTime(ArrivalTime, 30, NewTime),
    NewCounter is Counter + 1,
    tripDays([To|Next], NewTime, [DepartureTime|Curr], FlightTimes, NewCounter, Days).

tripDays(Trip, Time, FlightTimes, Days):-
    tripDays(Trip, Time, [], Temp, 1, Days),
    myReverse(Temp, [], FlightTimes).

myReverse([], Res, Res).
myReverse([Curr|Next], CurrA, Res):-
    myReverse(Next, [Curr|CurrA], Res).

% 7

getSum([], Res, Res).
getSum([Curr|Next], CurrSum, Res):-
    NewCurr is Curr + CurrSum,
    getSum(Next, NewCurr, Res).

avgFlightLengthFromAirport(Airport, AvgLength):-
    findall(Duration, flight(_, Airport, _, _, Duration, _), Durations),
    getSum(Durations, 0, Sum),
    length(Durations, Length),
    AvgLength is Sum / Length.

% 8

mostInternational([], _, Res, Res).
mostInternational([Company-List|Next], Min, Curr, Res):-
    length(List, Min),
    mostInternational(Next, Min, [Company|Curr], Res).
mostInternational([Company-List|Next], Min, _, Res):-
    length(List, Length),
    Length > Min,
    mostInternational(Next, Length, [Company], Res).
mostInternational([_|Next], Min, Curr, Res):-
    mostInternational(Next, Min, Curr, Res).
mostInternational(ListOfCompanies):-
    setof(Company-Countries, (Flight, Origin, Destination, DepartureTime, Duration)^(flight(Flight, Origin, Destination, DepartureTime, Duration, Company),  countries(Company, Countries)), Temp),
    mostInternational(Temp, -1, [], ListOfCompanies).

% 9 - 10

:-use_module(library(lists)).

make_pairs([_], _, []).
make_pairs(L, P, [X-Y|Zs]):-
    select(X, L, L2),
    select(Y, L2, L3),
    G =.. [P, X, Y], G,
    make_pairs(L3, P, Zs).

make_pairs([], _, []).

make_pairs([_|Next], P, Zs):-
    make_pairs(Next, P, Zs).

dif_max_2(X, Y):- X < Y, X >= Y - 2.

% 11

getMax([], _, Res, Res).
getMax([Curr|Next], Max, _, Res):-
    length(Curr, Length),
    Length > Max,
    getMax(Next, Length, Curr, Res).
getMax([_|Next], Max, CurrMax, Res):-
    getMax(Next, Max, CurrMax, Res).

make_max_pairs(List, P, S):-
    findall(Elem, make_pairs(List, P, Elem), Temp),
    getMax(Temp, -1, [], S).
