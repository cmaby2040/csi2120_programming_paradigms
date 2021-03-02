% Example use
% open('3by3_inputdata.txt',read,F), readAll(F,L), close(F).
:- use_module(library(simplex)).
:- use_module(library(clpfd)).
% Read text file into list of strings and numbers
readAll( InStream, []) :-
    at_end_of_stream(InStream), !.

readAll( InStream, [W|L] ) :-
    readWordNumber( InStream, W ), !,
    %write(W), write(' '), % Just for sanity
    readAll( InStream, L ).

% read a white-space separated text or number
readWordNumber(InStream,W):-
	get_code(InStream,Char),
	checkCharAndReadRest(Char,Chars,InStream),
        codes2NumOrWord(W,Chars).
%create an array of just integers
select_integers([],[]).
select_integers([X|XS],[X|L]) :-
 integer(X),
 select_integers(XS,L).
select_integers([X|XS],L) :-
 \+integer(X),
 select_integers(XS,L).

%buildDemand([],[]).
buildDemand(['DEMAND'|L], T):- append(L,[],T).
buildDemand([_|L], T):- buildDemand(L,T).
%remove the last n elements from the list
without_last_n(L, N, []) :-
    length(L, N).
without_last_n([H|T], N, [H|T1]) :-
    without_last_n(T, N, T1).
%find the location of the Supply values in the txt file
supplyLocation(['SUPPLY'|_],0).
supplyLocation([_|L],N):- supplyLocation(L,N1),N is N1 +1.
%build the array of supply values at each nth term
buildSupply(L, N, R):-
    buildSupply(L, 1, N, [], R).
%helper method
buildSupply([], _, _, R, R).
buildSupply([X|L], I, N, A, R):-
    I =:= N,
    append(A, [X], A2),
    I2 is 1,
    buildSupply(L, I2, N, A2, R).

buildSupply([_|T], I, N, Acc, R):-
    I < N,
    I2 is I + 1,
    buildSupply(T, I2, N, Acc, R).
%removes the supply list elements from the list of integers
removeSupply(L, N, X):-
    integer(N) ,
    N > 0 ,
    removeSupply(L,1,N,X).
%helper method
removeSupply([], _ , _ , [] ) .
removeSupply( [X|Xs] , P , N , [X|Rs] ) :- 0 =\= P mod N ,
    P1 is P+1 , removeSupply(Xs,P1,N,Rs) .
removeSupply( [_|Xs] , P , N ,    Rs  ) :- 0 =:= P mod N ,
    P1 is P+1 , removeSupply(Xs,P1,N,Rs) .

%Convert list of codes into a number if possible to string otherwise
codes2NumOrWord(N,Chars) :-
    atom_codes(W,Chars),
    atom_number(W,N),!.

codes2NumOrWord(W,Chars) :-
    atom_codes(W,Chars).

% Source: Learn Prolog Now!
checkCharAndReadRest(10,[],_):-  !.

checkCharAndReadRest(32,[],_):-  !.

checkCharAndReadRest(9,[],_):-  !.
checkCharAndReadRest(-1,[],_):-  !.

checkCharAndReadRest(Char,[Char|Chars],InStream):-
         get_code(InStream,NextChar),
         checkCharAndReadRest(NextChar,Chars,InStream).


% this function only works for array that are even
listCosts([], [], _N).
listCosts([X|L], [[X2|X2s]|X2ss], N) :-
   list_prefix_n_suffix([X|L], [X2|X2s], N, E),
   listCosts(E, X2ss, N).

%this is a function that come from the cplfd library of the
%Swipl library that come when downloading the resource
list_prefix_n_suffix(Zs, Xs, N, Ys) :-
   list_prefix_n0_n_suffix(Zs, Xs, 0,N, Ys).

list_prefix_n0_n_suffix(Zs, Xs, N0,N, Ys) :-
   zcompare(Order, N0, N),
   rel_list_prefix_n0_n_suffix(Order, Zs, Xs, N0,N, Ys).

rel_list_prefix_n0_n_suffix(=, Ys, [], _,_, Ys).
rel_list_prefix_n0_n_suffix(<, [Z|Zs], [Z|Xs], N0,N, Ys) :-
   N1 #= N0 + 1,
   list_prefix_n0_n_suffix(Zs, Xs, N1,N, Ys).

% transportation:= this function is taken from the SWIProlog
% library(simplex)

test :- transportation([30,40,50],[40,20,60],[[6,8,10],[7,11,11],
                                              [4,5,12]],F),
    writeln(F),listCosts([1,2,3,4,5,6,7,8,9,10,11,12], L,4), writeln(L)
    %,writeln(N)
    .
%multiple the two lists
multiple_lists([],[],[]).
multiple_lists([X1|L1],[X2|L2],[X3|L3]):- multiple_lists(L1,L2,L3),
    X3 is (X1*X2).
%sum the final multiplied list
sum_list_([],0).
sum_list_([X|L],Cost) :- sum_list(L,C), Cost is C+X.


minimumTransportCost(InputFile,InitialFile,Cost):-
    open(InitialFile,read,Q),readAll(Q,_),
    open(InputFile,read,F), readAll(F,L),
    close(F),
    select_integers(L,Si),%writeln(Si),
    buildDemand(L,Demandarray),% writeln(Demandarray),%building the demand arrayfrom og list
    supplyLocation(L,N),%writeln(N),%finds the location of thesupply terms in the list
    buildSupply(Si,N,Supplyarray), %writeln(Supplyarray),
    %removes Supply values from the cost list
    removeSupply(Si,N,Si2),%writeln(Si2),
    %getting the length of the list
    length(Demandarray,Len),
    without_last_n(Si2,Len,FinalSi),%writeln(FinalSi),
    Rownumber is N-1,% this issue is here,
%    writeln(Rownumber),
    listCosts(FinalSi,CostArray,Rownumber),
 %   writeln(CostArray),
    transportation(Supplyarray,Demandarray,CostArray,Finalsol),
    writeln(" this is the final solution in a 2-D array"),writeln(Finalsol),
    listCosts(OneD,Finalsol,Rownumber), %writeln(OneD),
    multiple_lists(FinalSi,OneD,CostList),
    sum_list_(CostList,Cost)
    %,writeln(Cost),
    .

