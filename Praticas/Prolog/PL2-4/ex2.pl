% flight(origin, destination, company, code, hour, duration) 
flight(porto, lisbon, tap, tp1949, 1615, 60). 
flight(lisbon, madrid, tap, tp1018, 1805, 75). 
flight(lisbon, paris, tap, tp440, 1810, 150). 
flight(lisbon, london, tap, tp1366, 1955, 165). 
flight(london, lisbon, tap, tp1361, 1630, 160). 
flight(porto, madrid, iberia, ib3095, 1640, 80). 
flight(madrid, porto, iberia, ib3094, 1545, 80). 
flight(madrid, lisbon, iberia, ib3106, 1945, 80). 
flight(madrid, paris, iberia, ib3444, 1640, 125). 
flight(madrid, london, iberia, ib3166, 1550, 145). 
flight(london, madrid, iberia, ib3163, 1030, 140). 
flight(porto, frankfurt, lufthansa, lh1177, 1230, 165).

% a)
get_all_nodes(ListOfAirports):- findall(Origin, flight(Origin, _, _, _, _, _), Result1),
                                findall(Destination, flight(_, Destination, _, _, _, _), Result2),
                                append(Result1, Result2, Temp),
                                sort(Temp, ListOfAirports).

get_all_nodes2(ListOfAirports):- setof(Airport, (A, B, C, D, E)^(flight(Airport, A, B, C, D, E); flight(A, Airport, B, C, D, E)), ListOfAirports).

% b)

count(Company, Counter):-
    findall(Company, (Origin, Destination, Code, Hour, Duration)^flight(Origin, Destination, Company, Code, Hour, Duration), Flights),
    length(Flights, Counter).

getMostDiversified([], _-CurrCompany, CurrCompany).
getMostDiversified([Curr|Next], CurrValue-_, Res):-
    count(Curr, Counter),
    Counter > CurrValue, !,
    getMostDiversified(Next, Counter-Curr, Res).
getMostDiversified([_|Next], Value, Res):-
    getMostDiversified(Next, Value, Res).

most_diversified(Company):-
    setof(Company, (Origin, Destination, Code, Hour, Duration)^flight(Origin, Destination, Company, Code, Hour, Duration), Companies),
    getMostDiversified(Companies, -1-none, Company).

% c)
:-use_module(library(lists)).

visited(_, []):- fail.
visited(City, [(City, _, _, _)|_]).
visited(City, [_|Next]):-
    visited(City, Next).

find_flights(Origin, Origin, Visited, Visited).

find_flights(Origin, Destination, Curr, [(Origin, Destination, Company, Code)|Curr]):-
    flight(Origin, Destination, Company, Code, _, _).

find_flights(Origin, Destination, Visited, Flights):-
    flight(Origin, Intermidiate, Company, Code, _, _),
    Intermidiate \= Destination,
    \+visited(Intermidiate, Visited),
    find_flights(Intermidiate, Destination, [(Origin, Intermidiate, Company, Code)|Visited], Flights).

find_flights(Origin, Destination, Flights):-
    find_flights(Origin, Destination, [], Temp),
    reverse(Temp, Flights).

% d)
find_flights_breadthAux([(Intermidiate, Path)|_], Destination, [(Intermidiate, Destination, Company, Code)|Path]):-
    flight(Intermidiate, Destination, Company, Code, _, _).

find_flights_breadthAux([(CurrentNode, Path)|ToVisit], Destination, Flights):-
    findall((Intermidiate, [(CurrentNode, Intermidiate, Company, Code)|Path]), 
            (flight(CurrentNode, Intermidiate, Company, Code, _, _),
             Intermidiate \= Destination,
             \+member((Intermidiate, [(CurrentNode, Intermidiate, Company, Code)|Path]), [(CurrentNode, Path)|ToVisit]), % não está nos a visitar
             \+visited(Intermidiate, Path)),
            Temp),
    append(ToVisit, Temp, NewToVisit),
    find_flights_breadthAux(NewToVisit, Destination, Flights).

% Direct
find_flights_breadth(Origin, Destination, [(Origin, Destination, Company, Code)]):-
    flight(Origin, Destination, Company, Code, _, _).

% Not direct
find_flights_breadth(Origin, Destination, Flights):-
    findall((Intermidiate, [(Origin, Intermidiate, Company, Code)|[]]), 
            (flight(Origin, Intermidiate, Company, Code, _, _),  
             Intermidiate \= Destination), 
            Temp),
    find_flights_breadthAux(Temp, Destination, NewTemp),
    reverse(NewTemp, Flights).

% e)
find_all_flights(Origin, Destination, ListOfFlights):-
    %findall(Flight, find_flights(Origin, Destination, Flight), ListOfFlights).
    findall(Flight, find_flights_breadth(Origin, Destination, Flight), ListOfFlights).

% f)
getLeast([], _, Res, Res).
getLeast([Curr|Next], -1, [], Res):-
    length(Curr, Length),
    getLeast(Next, Length, [Curr], Res).
getLeast([Curr|Next], Less, CurrRes, Res):-
    length(Curr, Less),
    getLeast(Next, Less, [Curr|CurrRes], Res).
getLeast([Curr|Next], Less, _, Res):-
    length(Curr, Length),
    Length < Less,
    getLeast(Next, Length, [Curr], Res).
getLeast([_|Next], Less, Curr, Res):-
    getLeast(Next, Less, Curr, Res).


find_flights_least_stops(Origin, Destination, ListOfFlights):-
    find_all_flights(Origin, Destination, Temp),
    getLeast(Temp, -1, [], ListOfFlights), !.

% g)
visits([], _).
visits([Curr|Next], Flight):-
    visited(Curr, Flight),
    visits(Next, Flight).

getFlightsWithStops(_, [], Res, Res).
getFlightsWithStops(Stops, [CurrFlight|NextFlights], CurrRes, Res):-
    visits(Stops, CurrFlight),
    getFlightsWithStops(Stops, NextFlights, [CurrFlight|CurrRes], Res).

getFlightsWithStops(Stops, [_|NextFlights], CurrRes, Res):-
    getFlightsWithStops(Stops, NextFlights, CurrRes, Res).

find_flight_stops(Origin, Destination, Stops, ListFlights):-
    find_all_flights(Origin, Destination, Temp),
    getFlightsWithStops([Origin|Stops], Temp, [], ListFlights).

% h)
find_circular_trip(0, Origin, [(PrevOrig, Origin, PrevComp, PrevCode)|Next], [(PrevOrig, Origin, PrevComp, PrevCode)|Next]).

find_circular_trip(MaxSize, Origin, [(PrevOrig, CurrentOrigin, PrevComp, PrevCode)|Next], Cycle):-
    MaxSize > 0,
    flight(CurrentOrigin, Intermidiate, Company, Code, _, _),
    NewMaxSize is MaxSize - 1,
    find_circular_trip(NewMaxSize, Origin, [(CurrentOrigin, Intermidiate, Company, Code), (PrevOrig, CurrentOrigin, PrevComp, PrevCode)|Next], Cycle).

find_circular_trip(MaxSize, Origin, Cycle):-
    flight(Origin, Intermidiate, Company, Code, _, _),
    NewMaxSize is MaxSize - 1,
    find_circular_trip(NewMaxSize, Origin, [(Origin, Intermidiate, Company, Code)], Temp),
    reverse(Temp, Cycle).

% i)
find_circular_trips(MaxSize, Origin, Cycles):-
    findall(Flight, find_circular_trip(MaxSize, Origin, Flight), Cycles).

% j)
verify_connectivity(_, [], []).
verify_connectivity(Node, [], [Curr|Next]):-
    find_flights(Node, Curr, _),
    verify_connectivity(Node, [], Next).
verify_connectivity(Node, [Curr|Next], Visited):-
    find_flights(Node, Curr, _),
    verify_connectivity(Node, Next, Visited).

verify_connectivity([], _).
verify_connectivity([Current|Next], Visited):-
    verify_connectivity(Current, Next, Visited),
    verify_connectivity(Next, [Current|Visited]).

strongly_connected(ListOfNodes):-
    verify_connectivity(ListOfNodes, []).

% k)

% l)
bridges(ListOfBriges):-
    setof((Origin, Destination, Company, Code),
            (Time, Duration, Flights1, Flights2)^(flight(Origin, Destination, Company, Code, Time, Duration),
             find_flights(Origin, Destination, Flights1),
             \+find_flights(Destination, Origin, Flights2)),
            ListOfBriges).

% m)
:-use_module(library(ordsets)).

% Node == Destination
timesInPath(Node, [(Origin, Node, _, _)|[]], _, 0).
% OK
timesInPath(_, [_Curr|[]], Res, Res).
% Central Node
timesInPath(Node, [(Node, Intermidiate, _, _)|Next], Curr, Res):-
    NewCurr is Curr + 1,
    timesInPath(Node, Next, NewCurr, Res).
% Not in path
timesInPath(Node, [(_, Intermidiate, _, _)|Next], Curr, Res):-
    timesInPath(Node, Next, Curr, Res).

nodeCount(_, [], Res, Res).
nodeCount(Node, [[(Node, Intermidiate, Cmp, C)|Others]|Next], Curr, Res):-
    nodeCount(Node, Next, Curr, Res).
nodeCount(Node, [Path|Next], Curr, Res):-
    timesInPath(Node, Path, 0, Value),
    NewCurr is Curr + Value,
    nodeCount(Node, Next, NewCurr, Res).

getCentral([], _, Res, _, Res).
getCentral([Curr|Next], Max, MaxList, Paths, Res):-
    nodeCount(Curr, Paths, 0, Max),
    getCentral(Next, Max, [(Max, Curr)|MaxList], Paths, Res).
getCentral([Curr|Next], Max, MaxList, Paths, Res):-
    trace,
    nodeCount(Curr, Paths, 0, Count),
    write((Count, Max)),nl,
    Count > Max,
    write(('1----', Count, Max)),nl,
    getCentral(Next, Count, [(Count, Curr)], Paths, Res).
getCentral([Curr|Next], Max, MaxList, Paths, Res):-
    getCentral(Next, Max, MaxList, Paths, Res).

central_betweeness(Node):-
    % get all shortest paths
    write(ShortestPaths),nl,
    setof(Origin, (Dst, Cmp, C, T, D)^flight(Origin, Dst, Cmp, C, T, D), From),
    setof(Destination, (O, Cmp, C, T, D)^flight(O, Destination, Cmp, C, T, D), To),
    ord_union(From, To, Nodes),
    getCentral(Nodes, -1, [], ShortestPaths, Node).


% n)
add_times(Time, Duration, FinalTime, 1):-
    Hours is Duration div 60,
    Minutes is Duration mod 60 ,
    TimeHours is (Time div 100) + Hours,
    TimeMinutes is (Time mod 100) + Minutes,
    
    FinalMinutes is TimeMinutes mod 60,
    AddHours is TimeMinutes div 60,

    FinalHours is TimeHours + AddHours,
    FinalHours >= 24,
    FinalHours2 is FinalHours mod 24,
    FinalTime is FinalHours2 * 100 + FinalMinutes.

add_times(Time, Duration, FinalTime, 0):-
    Hours is Duration div 60,
    Minutes is Duration mod 60 ,
    TimeHours is (Time div 100) + Hours,
    TimeMinutes is (Time mod 100) + Minutes,
    
    FinalMinutes is TimeMinutes mod 60,
    AddHours is TimeMinutes div 60,

    FinalHours is TimeHours + AddHours,
    FinalTime is FinalHours * 100 + FinalMinutes.

% o)
time_diff(Time1, Time2, Duration).
% 2130
% 2210
% ----
% 2320

% 2210
% 2130
% ----
% 0040

% 24-40=2320

% p)
waiting_time((_, Value, _, _, Time1, Duration), (Value, _, _, _, Time2, _), WaitingTime):-
    add_times(Time1, Duration, FinalTime, _),
    time_diff(FinalTime, Time2, WaitingTime).

% q)

% r)
