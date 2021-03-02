sum_int(1,1).

sum_int(N,X) :- 
	N > 1,
	NN is N-1,
    sum_int( NN, Y ),
    X is Y + N.
    
sum_int(1,1).

sum_int(N,X) :- N>0, NN is N-1, sum_int(NN,X1), X is X1 + N