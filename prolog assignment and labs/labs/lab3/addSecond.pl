addSecond([], 0).

addSecond( [_,B|R], S ) :- !,addSecond( R, RS ),S is RS + B.


addSecond( [_|R], S ) :-!,addSecond( R, S).

/*
maxmin([],,):-!.
maxmin([X|List],Min,Max):- maxmin2(List,X,X,Min,Max),!.
maxmin2([],Max,Min,Min,Max). % base case
maxmin2(List,H1,H2,Min,Max):-
*/


oddEven([],[]):-!.
oddEven([X|L],['even'|L2]):- mod(X,2) =:= 0,oddEven( L,L2).

oddEven([X|L],['odd'|L2]):- not(mod(X,2)=:= 0),oddEven( L,L2).




reverseDrop(L,Out):-reverseDrop(L,0,[],Out).
reverseDrop([],_,R,R):-!.
reverseDrop([X|L],0,Acc,Out):-reverseDrop(L,1,[X|Acc],Out).
reverseDrop([_|L],1,Acc,Out):-reverseDrop(L,0,Acc,Out).

addAlternate(L,S) :- addAlternate(L,0,p,S).


addAlternate([],S,_,S).

addAlternate([H|T],A,p,S) :- !,
	AA is A + H,
	addAlternate(T,AA,m,S).

addAlternate([H|T],A,m,S) :- !,
	AA is A - H,
        addAlternate(T,AA,p,S).

color(red).
color(green).
color(blue).

queation1:-setof([X,Y,Z],(color(X),color(Y),color(Z)),L),writeln(L).

leafNodes(T,L):-leafNodes(T,[],L).
leafNodes(t(nil,_,_),L,L):-!.
leafNodes(t(Num,nil,nil),L,[Num|L]):-!.
leafNodes(t(num,Left,Right),L,LL):-leafNodes(Left,L,Li),
	leafNodes(Right,Li,LL).

bag(2,4,1).
bag(3,5,2).
bag(7,8,2).
bag(4,3,1).
bag(5,2,4).
bag(2,1,4).
bag(2,2,4).
bag(7,3,5).
bag(7,3,3).

turn(elgin,wellington).
turn(elgin,catherine).
turn(elgin,laurier).
turn(qed,laurier).
turn(qed,bank).
turn(bank,qed).
turn(bank,sommerset).
turn(bank,gladstone).
turn(bank,wellington).

grade(nick,8).
grade(rachel,4).
grade(peter,3).
grade(monica,7).
grade(samantha,4).

:- dynamic product/3.
maketable :- L=[0,1,2,3,4,5,6,7,8,9],
member(X,L),
member(Y,L),
Z is X*Y,
assertz(product(X,Y,Z)),
fail.
:- dynamic letter/2.
alphabet([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z]).
% add a rule for each letter queried
letter(A, B):-
alphabet(C),
letter(A, C, B),
asserta(letter(A,B)). % Add a new fact
letter(A, [A|_], 1). % boundary case, letter matches
letter(A, [B|C], D):-
\+(A=B), % letter does not match, keep searching
letter(A, C, E),
D is E+1. % Count on the way out of the recursion

score( 'Emma', 'FIFA18', 3 ).
score( 'Benjamin', 'Minecraft', 387 ).
score( 'Liam', 'The Legend of Zelda', 2200 ).
score( 'Ethan', 'Super Mario Odyssey', 15100 ).
score( 'Ava', 'Minecraft', 410 ).
score( 'Liam', 'Minecraft', 222 ).
score( 'Ava', 'The Legend of Zelda', 1900 ).


countGames([],_,0):-!.
countGames( [O|T], G, C ) :-O\==G, countGames(T,G,C).
countGames( [G|T], G, C ) :- countGames(T,G,C1),C is C1+1.
