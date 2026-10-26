% Opcion 2 - Logica Matematica / Prolog
% Sebastián es el único nombre personal; los demás nombres y parentescos son ficticios.

% ----- Arbol genealogico de ejemplo -----
mujer(marta).
mujer(ana).
mujer(elena).
mujer(sofia).

hombre(roberto).
hombre(sebastian).
hombre(diego).
hombre(luis).

% progenitor(PadreOMadre, HijoOHija)
progenitor(roberto, sebastian).
progenitor(marta, sebastian).
progenitor(roberto, ana).
progenitor(marta, ana).
progenitor(roberto, diego).
progenitor(marta, diego).
progenitor(sebastian, luis).
progenitor(elena, luis).
progenitor(sebastian, sofia).
progenitor(elena, sofia).

padre(Padre, Hijo) :- hombre(Padre), progenitor(Padre, Hijo).
madre(Madre, Hijo) :- mujer(Madre), progenitor(Madre, Hijo).

% En hijo/2 e hija/2, el primer argumento es el hijo o hija.
hijo(Hijo, Progenitor) :- hombre(Hijo), progenitor(Progenitor, Hijo).
hija(Hija, Progenitor) :- mujer(Hija), progenitor(Progenitor, Hija).

abuelo(Abuelo, Nieto) :- hombre(Abuelo), progenitor(Abuelo, Progenitor), progenitor(Progenitor, Nieto).
abuela(Abuela, Nieto) :- mujer(Abuela), progenitor(Abuela, Progenitor), progenitor(Progenitor, Nieto).

% once/1 evita repetir una relacion si comparten ambos progenitores.
hermano(X, Y) :- hombre(X), X \= Y, once((progenitor(P, X), progenitor(P, Y))).
hermana(X, Y) :- mujer(X), X \= Y, once((progenitor(P, X), progenitor(P, Y))).

tio(Tio, Sobrino) :- hombre(Tio), progenitor(P, Sobrino), hermano(Tio, P).
tia(Tia, Sobrino) :- mujer(Tia), progenitor(P, Sobrino), hermana(Tia, P).
sobrino(Sobrino, TioOTia) :- hombre(Sobrino), (tio(TioOTia, Sobrino) ; tia(TioOTia, Sobrino)).
sobrina(Sobrina, TioOTia) :- mujer(Sobrina), (tio(TioOTia, Sobrina) ; tia(TioOTia, Sobrina)).

% ----- Grafo dirigido del ejercicio -----
arco(a, b).
arco(a, c).
arco(a, d).
arco(c, d).

% camino(Inicio, Fin, ListaDeVertices).
% La primera regla encuentra arcos directos; la segunda, caminos de varios arcos.
camino(X, Y, [X, Y]) :- arco(X, Y).
camino(X, Y, [X | Resto]) :-
    arco(X, Z),
    camino(Z, Y, Resto).

% Consultas sugeridas:
% ?- abuelo(Abuelo, luis).
% ?- abuela(Abuela, luis).
% ?- tia(Tia, luis).
% ?- tio(Tio, luis).
% ?- sobrino(Persona, diego).
% ?- sobrina(Persona, ana).
% ?- camino(X, d, Y).
% Las soluciones de camino(X,d,Y), en orden Prolog, son:
% X = a, Y = [a,d] ; X = c, Y = [c,d] ; X = a, Y = [a,c,d].
