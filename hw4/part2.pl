%knowledge base

flight(istanbul,izmir).
flight(istanbul,antalya).
flight(istanbul,gaziantep).
flight(istanbul,ankara).
flight(istanbul,van).
flight(istanbul,rize).
flight(izmir,isparta).
flight(izmir,istanbul).
flight(isparta,burdur).
flight(isparta,izmir).
flight(burdur,isparta).
flight(antalya,istanbul).
flight(antalya,konya).
flight(antalya,gaziantep).
flight(konya,antalya).
flight(konya,ankara).
flight(gaziantep,istanbul).
flight(gaziantep,antalya).
flight(ankara,istanbul).
flight(ankara,konya).
flight(ankara,van).
flight(van,istanbul).
flight(van,ankara).
flight(van,rize).
flight(rize,istanbul).
flight(rize,van).
flight(edirne,edremit).
flight(edremit,erzincan).
flight(edremit,edirne).
flight(erzincan,edremit).

distance(istanbul,izmir,328.80).
distance(istanbul,antalya,482.75).
distance(istanbul,gaziantep,847.42).
distance(istanbul,ankara,351.50).
distance(istanbul,van,1262.37).
distance(istanbul,rize,967.79).
distance(izmir,isparta,308.55).
distance(izmir,istanbul,328.80).
distance(isparta,burdur,24.60).
distance(isparta,izmir,308.55).
distance(burdur,isparta,24.60).
distance(antalya,istanbul,482.75).
distance(antalya,konya,192.28).
distance(antalya,gaziantep,592.33).
distance(konya,antalya,192.28).
distance(konya,ankara,227.34).
distance(gaziantep,istanbul,847.42).
distance(gaziantep,antalya,592.33).
distance(ankara,istanbul,351.50).
distance(ankara,konya,227.34).
distance(ankara,van,920.31).
distance(van,istanbul,1262.37).
distance(van,ankara,920.31).
distance(van,rize,373.01).
distance(rize,istanbul,967.79).
distance(rize,van,373.01).
distance(edirne,edremit,235.33).
distance(edremit,erzincan,1066.26).
distance(edremit,edirne,235.33).
distance(erzincan,edremit,1066.26).

%rules

sroute(X,Y,Dist) :- path(X,Y,Dist,[]).
path(X,Y,Dist,Z) :- distance(X,Y,Dist), not(X=Y).
path(X,Y,Dist,Z) :- distance(X,T,D1), not(member(X,Z)), not(T=X), path(T,Y,D2,[X|Z]), Dist is D1 + D2.

member(A, [A|_]).       
member(A, [_|T]) :- member(A, T).