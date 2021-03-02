
% --------
% book( Title, Authors, Publisher, Year, CallNumber )
% --------

book(
  'The craft of Prolog',
  'R. A. O''Keefe',
  'MIT Press',
  1990,
  'QA 76.73 .P76 O38 1990'
).
book(
  'Programming in Prolog',
  'W. F. Clocksin, C. S. Mellish',
  'Springer',
  2003,
  'QA 76.73 .P76 C57 2003'
).
book(
  'Prolog for programmers',
  'F. Kluzniak, S. Szpakowicz',
  'Academic Press',
  1985,
  'QA 76.73 .P76 K58 1985'
).
book(
  'Prolog programming for artificial intelligence',
  'I. Bratko',
  'Addison-Wesley',
  2001,
  'Q 336 .B74 2001'
).

% --------
% reader( CardNumber, Name )
% --------

reader( 1234567, 'James Brown' ).
reader( 2345678, 'Jacques Brun' ).
reader( 3456789, 'Giacomo Bruno' ).

% --------
% checkedOut( CardNumber, CallNumber )
% --------

checkedOut( 1234567, 'QA 76.73 .P76 C57 2003' ).
checkedOut( 3456789, 'Q 336 .B74 2001' ).

%question 2
%!  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
parent(jack,joe).
parent(jack,karl).
parent(marie,anne).
parent(joe,anne).
parent(marie,paul).
parent(joe,paul).
parent(marie,sylvie).
parent(bruno,sylvie).
parent(anne,zach).
parent(tim,zach).
parent(sam,tim).
parent(emma,tim).
parent(josee,sam).
parent(gilles,sam).
female(marie).
female(sylvie).
female(anne).
female(emma).
female(josee).
male(karl).
male(jack).
male(joe).
male(bruno).
male(paul).
male(tim).
male(zach).
male(sam).
male(gilles).

gmp(x,y) :- parent(z,y),male(z), parent(x,z),female(x).


% question #3 quiz
% Decision to go skiing

% trail conditions
condition( skyline, green ).
condition( burma, green ).
condition( fortune, green ).
condition( mcclosky, red ).

% no time tuesday thursday CSI2120
available( monday ).
available( wednesday ).
available( friday ).

% high temperatures
temperature( mild, monday ).
temperature( mild, tuesday ).
temperature( verycold, wednesday ).
temperature( cold, thursday ).
temperature( warm, friday ).

% available wax
wax( green, verycold ).
wax( blueExtra, mild ).
wax( red, warm ).

route( Col ) :- condition( skyline, Col ),
		condition( burma, Col ),
		condition( fortune, Col ).

% hard-wired lights
connected(L) :- fuse(L, F),
		ok(F).

% plugged in lights
connected(L) :- plug(L,S),
                fuse(S,F),
                ok(F).


goSki(D,W) :- avilable(D),temperature(mild,D),wax(W,
