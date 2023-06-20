%Base de Conocimiento:

%Padres e Hijos
padreDe(abe, abbie).
padreDe(abe, homero).
padreDe(abe, herbert).
padreDe(clancy, marge).
padreDe(clancy, patty).
padreDe(clancy, selma).
padreDe(homero, bart).
padreDe(homero, hugo).
padreDe(homero, lisa).
padreDe(homero, maggie).

%Madres e Hijas
madreDe(edwina, abbie).
madreDe(mona, homero).
madreDe(gaby, herbert).
madreDe(jacqueline, marge).
madreDe(jacqueline, patty).
madreDe(jacqueline, selma).
madreDe(marge, bart).
madreDe(marge, hugo).
madreDe(marge, lisa).
madreDe(marge, maggie).
madreDe(selma, ling).

%tieneHijo/1
tieneHijo(UnaPersona):-
    padreDe(UnaPersona,_).
    
tieneHijo(UnaPersona):-
    madreDe(UnaPersona,_).

%hermanos/2
hermanos(UnaPersona,OtraPersona):-
    mismoPadre(UnaPersona, OtraPersona),
    mismaMadre(UnaPersona, OtraPersona),
    UnaPersona \= OtraPersona.

mismoPadre(UnaPersona, OtraPersona):-
    padreDe(UnPadre, UnaPersona),
    padreDe(UnPadre, OtraPersona).
mismaMadre(UnaPersona, OtraPersona):-
    madreDe(UnaMadre, UnaPersona),
    madreDe(UnaMadre, OtraPersona).

%medioHermanos/2
medioHermanos(UnaPersona, OtraPersona):-
    mismoPadre(UnaPersona,OtraPersona),
    UnaPersona\=OtraPersona,
    not(hermanos(UnaPersona, OtraPersona)).
medioHermanos(UnaPersona, OtraPersona):-
    mismaMadre(UnaPersona, OtraPersona),
    UnaPersona\=OtraPersona,
    not(hermanos(UnaPersona, OtraPersona)).

%tioDe/2
tioDe(UnaPersona, OtraPersona):-
    hermanos(UnaPersona, Hermano),
    padreDe(Hermano, OtraPersona).
tioDe(UnaPersona, OtraPersona):-
    hermanos(UnaPersona, Hermano),
    madreDe(Hermano, OtraPersona).
tioDe(UnaPersona, OtraPersona):-
    padreDe(UnPadre, OtraPersona),
    concuniado(UnPadre, UnaPersona).
tioDe(UnaPersona, OtraPersona):-
    madreDe(UnaMadre, OtraPersona),
    concuniado(UnaMadre, UnaPersona).

parejaDe(UnaPersona, OtraPersona):-
    padreDe(UnaPersona, UnHijo),
    madreDe(OtraPersona, UnHijo).
parejaDe(UnaPersona, OtraPersona):-
    madreDe(UnaPersona, UnHijo),
    padreDe(OtraPersona, UnHijo).

concuniado(UnaPersona, OtraPersona):-
    hermanos(UnaPersona,Hermano),
    parejaDe(OtraPersona, Hermano).

%abueloMultiple:

%cuñados (Si es el hermano o hermana de tu pareja o si es la pareja de tu hermano/hermana)
cuniados(UnaPersona, OtraPersona):-
    concuniado(UnaPersona, OtraPersona).
cuniados(UnaPersona, OtraPersona):-
    concuniado(OtraPersona, UnaPersona).

%suegros:
suegros(UnaPersona, OtraPersona):-
    parejaDeUnHijo(OtraPersona, UnaPersona).

%consuegros:
consuegros(UnaPersona, OtraPersona):-
    padreDe(UnaPersona, UnHijo),
    suegros(OtraPersona, UnHijo).
consuegros(UnaPersona, OtraPersona):-
    madreDe(UnaPersona, UnHijo),
    suegros(OtraPersona, UnHijo).

%yerno
yerno(UnaPersona, OtraPersona):-
    parejaDeUnHijo(UnaPersona, OtraPersona),
    padreDe(UnaPersona,_). %El problema es que dada la base de conocimiento sólo se puede determinar el género en base a si es padre o madre

%nuera
nuera(UnaPersona, OtraPersona):-
    parejaDeUnHijo(UnaPersona,OtraPersona),
    madreDe(UnaPersona,_).

parejaDeUnHijo(UnaPersona,OtraPersona):-
    padreDe(OtraPersona, UnaHija),
    parejaDe(UnaHija, UnaPersona).
parejaDeUnHijo(UnaPersona,OtraPersona):-
    madreDe(OtraPersona, UnaHija),
    parejaDe(UnaHija, UnaPersona).

%primos
primos(UnaPersona, OtraPersona):-
    tioDe(UnTio, UnaPersona),
    padreDe(UnTio, OtraPersona).
primos(UnaPersona, OtraPersona):-
    tioDe(UnTio, UnaPersona),
    madreDe(UnTio, OtraPersona).

%descendiente
descendiente(UnaPersona, PosibleDescendiente):-
    padreDe(UnaPersona, PosibleDescendiente).

descendiente(UnaPersona, PosibleDescendiente):-
    madreDe(UnaPersona, PosibleDescendiente).

descendiente(UnaPersona, PosibleDescendiente):-
    padreDe(UnaPersona, HijoDeUnaPersona),
    descendiente(HijoDeUnaPersona, PosibleDescendiente).

descendiente(UnaPersona, PosibleDescendiente):-
    madreDe(UnaPersona, HijoDeUnaPersona),
    descendiente(HijoDeUnaPersona, PosibleDescendiente).

