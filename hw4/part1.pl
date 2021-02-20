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

%rules

route(X,Y) :- flight(X,Y).
route(X, Y) :- findPath(X, Y, []).
findPath(X, Y, Path) :- flight(Z,X), not(member(Z, Path)), (findPath(Z, Y, [X|Path]); Y = Z).

