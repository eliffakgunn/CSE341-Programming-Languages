%deletes the last elementt of list
deleteLastElm([X|Y], Z) :- deleteLastElm2(Y, Z, X).            
deleteLastElm2([], [], _).
deleteLastElm2([A1|Y], [A0|Z], A0) :- deleteLastElm2(Y, Z, A1).

%takes list and creates all possibilities
list([K|Kr]) :- last(Kr,X), deleteLastElm(Kr,Kl), foreach(list2([K|Kl],[+,-,*,/],[K,O|Kt]), (doOperations([K,O|Kt], X) , (Flag is 1); !)), not(Flag=0), !.
list2([K|Kr],S,[K,O|Kt]) :- member(O,S), list2(Kr,S,Kt).
list2([K],_,[K]).

%doOperations calculates equations, then checks output
doOperations(List, X) :- expression(V,List,[]), check(X,V,List),!.
check(X,V,List) :- X=V -> writeln(List),!.

%calculates expressions
expression(Result, List, LastList) :- calculate(Result, List, LastList).
expression(Sum, List, LastList) :- calculate(Result1, List, ['+'|Left]), expression(Result2, Left, LastList), Sum is Result1 + Result2. %yoruma alinca bir sey degismedi sanki

calculate(Result, List, LastList) :- splitList(Result, List, LastList).
calculate(TotalResult, List, LastList) :- splitList(Result1, List, ['/'|Left]), calculate(Result2, Left, LastList), Result2 =\= 0, TotalResult is Result1 / Result2.
calculate(TotalResult, List, LastList) :- splitList(Result1, List, ['*'|Left]), calculate(Result2, Left, LastList), TotalResult is Result1 * Result2.
calculate(TotalResult, List, LastList) :- splitList(Result1, List, ['-'|Left]), calculate(Result2, Left, LastList), TotalResult is Result1 - Result2.
calculate(TotalResult, List, LastList) :- splitList(Result1, List, ['+'|Left]), calculate(Result2, Left, LastList), TotalResult is Result1 + Result2.

splitList(Result, [Result|LastList], LastList).