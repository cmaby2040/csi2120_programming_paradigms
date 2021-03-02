seriesNM(1,M,Y):- Y is (M + 9/M)/2.
seriesNM(N,M,Y) :- N>0, N1 is N-1, seriesNM(N1,M,Y1), Y is (Y1+9/Y1)/2.



