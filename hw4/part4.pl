:-style_check(-singleton).

%element
element(E,S) :- member(E,S).

%union
union(S1,S2,S3) :- unionSet(S1,S2,S3).
unionSet(S1,S2,S3) :- union2(S1,S3), union2(S2,S3), isUnion(S1,S2,S3).
union2(S1,S2) :- foreach(element(X,S1), element(X,S2)).
isUnion(S1,S2,S3):- foreach(element(X,S3), element(X,S1); element(X,S2)).  

%intersect     
intersect(S1,S2,S3) :- isIntersect(S1,S2,S3).
isIntersect(S1,S2,S3) :- intersect2(S1,S2,X), equivalent(X,S3).
intersect2([],[],[]) :- true,!.
intersect2([],_,[]) :- true,!.	  
intersect2(_,[],[]) :-true,!.
intersect2([E|S1], S2, [E|S3]):- element(E, S2), !, intersect2(S1, S2, S3).
intersect2([_|S1], S2, S3):- intersect2(S1, S2, S3).

%equivalent
equivalent(S1, S2) :- isEquivalent(S1, S2), isEquivalent(S2, S1).
isEquivalent([],_) :- true, !.
isEquivalent([E|S1],S2):- isEquivalent(S1,S2), element(E,S2).

