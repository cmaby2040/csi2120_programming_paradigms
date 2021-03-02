element(chlorine,'Cl').
element(helium,'He').
element(hydrogen,'H').
element(nitrogen,'N').
element(oxygen,'O').
/*
lookup(X) :- element(Y,X),write(X), write(" is the symbol for "), write(Y),!.
lookUp(S) :-
    write( 'Don\'t know the symbol: ' ), writeln(S), !, fail.

*/

canalOpen( saturday ).
canalOpen( monday ).
canalOpen( tuesday ).

raining( saturday ).

melting( saturday ).
melting( sunday ).
melting( monday ).

winterlude(X):- canalOpen(X),not(raining(X)),not(melting(X)),!.

secondLast(X,[X|[_|[]]]):-!.
secondLast(X,[_|L]):- secondLast(X,L).

addSecond([], 0).
addSecond( [_,B|R], S ) :- !,addSecond( R, RS ),S is RS + B.

addSecond( [_|R], S ) :-!,addSecond( R, S).



/*


lookUp(S) :-
    element( E, S ),
    write( S ),  write( ' is the symbol for: '), writeln(E), !.
lookup(X) :- not(element(Y,X)), write("Don't know the symbol: "),
write(Y).



elements :- writeln('Elements in the Periodic Table '),
    repeat,
    write('Symbol to look-up: '),
    read(S),
    not(lookUp(S)),
    writeln('Exiting'),
    !, fail.

*/
