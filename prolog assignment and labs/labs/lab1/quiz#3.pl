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

route( C ) :- condition( skyline, C ),condition( burma, C ),condition( fortune, C).

goodTempurature(D,mild) :- temperature(mild,D).
goodTempurature(D,cold) :- temperature(cold,D).


goSki(D,W) :- available(D), goodTempurature(D,X), route(green), wax(W,X).

