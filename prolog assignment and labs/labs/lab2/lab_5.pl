flight(montreal, chicoutimi, 15:30, 16:15).
flight(montreal, sherbrooke, 17:10, 17:50).
flight(montreal, sudbury, 16:40, 18:45).
flight(northbay, kenora, 13:10, 14:40).
flight(ottawa, montreal, 12:20, 13:10).
flight(ottawa, northbay, 11:25, 12:20).
flight(ottawa, thunderbay, 19:00, 20:30).
flight(ottawa, toronto, 10:30, 11:30).
flight(sherbrooke, baiecomeau, 18:40, 20:05).
flight(sudbury, kenora, 20:15, 21:55).
flight(thunderbay, kenora, 20:00, 21:55).
flight(toronto, london, 13:15, 14:05).
flight(toronto, montreal, 12:45, 14:40).
flight(windsor, toronto, 8:50, 10:10).

arrival(flight(X,Y),Z):- flight(X,Y,Z,_).

sum_int(1,1).
sum_int(N,X):- N1 is N-1, sum_int(N1,X1), X is X1 +N.


seriesNM(0,M,Y):- Y is M.
seriesNM(N,M,Y):- N>0, N1 is N-1, seriesNM(N1,M,Y1), Y is (Y1+9/Y1)/2.




















/*sum_int(1,1).
sum_int(N,X) :- N>=0, N1 is N-1, sum_int(N1,X1), X is X1+N.

seriesNM(1,M,Y):- Y is (M + 9/M)/2.
seriesNM(N,M,Y) :- N>0, N1 is N-1, seriesNM(N1,M,Y1), Y is (Y1+9/Y1)/2.
*/

