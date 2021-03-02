addSecond([], 0).

addSecond( [_,X|L], T ) :-!,addSecond( L, TS ),	T is TS + X.

addSecond( [_|L], T ) :-!,addSecond( L, T).
