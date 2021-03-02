zeroNodes(nil,nil) :- !.

zeroNodes(t(0,L,R),t(1,LT,RT)) :- 
    zeroNodes(L,LT),
    zeroNodes(R,Rt), !.
        
zeroNodes(t(Key,L,R),t(Key,LT,RT)) :-
    zeroNodes(L,LT),
    zeroNodes(R,RT).
