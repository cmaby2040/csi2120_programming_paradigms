city(ottawa,ontario).
city(guelph,ontario).
city(kingston,ontario).
city(gatineau,quebec).
city(montreal,quebec).
team(ravens,ottawa).
team(ggs,ottawa).
team(gryphons,guelph).
team(queens,kingston).
team(torrents,gatineau).
team(stingers,montreal).
sport(annie,lacrosse).
sport(paul,crosscountry).
sport(suzy,ski).
sport(robert,basketball).
sport(tom,lacrosse).
sport(tim,ski).
sport(annie,ski).
sport(joe,basketball).
sport(robert,basketball).
sport(jane,basketball).
sport(marie,crosscountry).
sport(suzy,crosscountry).
sport(jack,ski).
sport(simon,lacrosse).
player(annie,gryphons).
player(tom,torrents).
player(jane,stingers).
player(marie,ggs).
player(joe,ravens).
player(jack,queens).
player(simon,ravens).
player(suzy,torrents).
player(paul,ggs).
player(marie,ggs).
player(simon,gryphons).

bag(2,4,1).
bag(3,5,2).
bag(7,8,2).
bag(4,3,1).
bag(5,2,4).
bag(2,1,4).
bag(2,2,4).
bag(7,3,5).
bag(7,3,3).
%part 1 : finished
myAnswer :- setof(N,sport(N,basketball),Y),writeln(Y),
    setof(A,B^(city(B,ontario),team(A,B)),L), writeln(L),
    setof(C,D^E^(sport(C,D),sport(C,E),E \= D), F), writeln(F),
    findall([G|I],(sport(G,I),team(H,ottawa),player(G,H)),Q),writeln(Q),
    setof([W|R],Z^(sport(W,R),team(Z,ottawa),player(W,Z)),K), writeln(K).

%part 2: not finished have to draw this out.
intrest(X) :- sport(X,ski).

intrest(X) :- sport(X,S),
    S\= ski,
    player(X,T),
    team(T,C),
    city(C,quebec).
name(joe).
name(jane).
citizen(jane).
citizen(joe).
adult(jane).
voter(X):-
name(X),
citizen(X),
adult(X).

%part 3: done

area([[Ax|Ay]|[[Bx|By]|[[Cx|Cy]|[]]]],A):-
   A is 0.5*(((Bx-Ax)*(Cy-Ay))-((Cx-Ax)*(By-Ay))).

%part 4: check that is is a member and then toggle the insertion
%part A:
skip([X|XS],Y,Zs):- member(X,Y),skip(XS,Y,Zs,1).

skip([X|XS],Y,Zs):- \+member(X,Y),skip([X|XS],Y,Zs,0).
skip([],_,[],_).
%four cases where each element can be first where toggle on to off
skip([X|Xs],Ys,[X|Zs],1):- member(X,Ys),skip(Xs,Ys,Zs,0).
%secong no toggle here at all
skip([X|Xs],Ys,[X|Zs],1):- \+member(X,Ys),skip(Xs,Ys,Zs,1).
%third no toggle remain off
skip([X|Xs],Ys,Zs,0):- \+member(X,Ys),skip(Xs,Ys, Zs,0).
%toggle to on start adding after
skip([X|Xs],Ys,Zs,0):- member(X,Ys),skip(Xs,Ys,Zs,1).

turn(L, TL, Output) :- turn(L, TL, [], Output).

turn([], _, Output, Output).

turn([Head|Tail], Toggle, Acc, Output) :- not(member(Head,Toggle)),
                                          turn(Tail, Toggle, [Head|Acc], Output).

turn([Head|Tail], Toggle, Acc, Output) :- member(Head, Toggle),
                                           forward(Tail, Toggle,[Head|Acc], Output).

forward([], _, Output, Output).

forward([Head|Tail], Toggle, Acc, Output) :- not(member(Head, Toggle)),
                                             append(Acc,[Head] , AccNew),
                                  forward(Tail, Toggle, AccNew, Output).

forward([Head|Tail], Toggle, Acc, Output) :- member(Head, Toggle),
append(Acc, [Head], AccNew),
                                              turn2(Tail, Toggle, AccNew,[], Output).
%deals with the case where the list is
turn2([Head|Tail],Toggle,Acc,Acc2,Output):-not(member(Head,Toggle)),
                                         turn2(Tail,Toggle,Acc,[Head|Acc2],Output).

turn2([Head|Tail],Toggle,Acc,Acc2,Output):-member(Head,Toggle),
                                         append(Acc,[Head|Acc2],NewAcc),
                                         forward(Tail,Toggle,NewAcc,Output).



%part 5: done
%part A:
%! building the tree
treeEx(X) :-
X = t(73,
      t(31,
        t(5,nil,nil),nil),
      t(101,
        t(83,nil,
          t(97,nil,nil)),nil)).

single(T,L):-single(T, [], L).
%Base case, no root of the tree
single(t(_, nil, nil), L, L):- !.
%Search the tree unil a single node is found
single(t(_, Left, Right), L, LL):-
       single(Right, L, LI),
       single(Left, LI, LL).
%loop throught the left side of the tree with one child case.
single(t(Root,Left,nil),L,[Root|LL]):- single(Left,L,LL).
%loop through the right side of the tree with one child case.
single(t(Root,nil,Right),L,[Root|LL]):- single(Right,L,LL).

%part B:

%base case:
%where the leaf node is true.
singleFill(t(Root,nil,nil),_,t(Root,nil,nil)):-!.

%left is full add num on the right side.
singleFill(t(Root,Left,nil),Num,t(Root,LeftPlus,t(Num,nil,nil))):-
singleFill(Left,Num,LeftPlus).
%right has node fill left side with node.
singleFill(t(Root,nil,Right),Num,t(Root,t(Num,nil,nil),RightPlus)):-
singleFill(Right,Num,RightPlus).

%case where no nodes need to be added.
singleFill(t(Root,Left,Right),Num, t(Root,LeftPlus,RightPlus)):-
singleFill(Left,Num,LeftPlus),
%single(t(Root,Left,Right),Num,):-
singleFill(Right,Num,RightPlus).
