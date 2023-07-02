%Cada participante está en un nivel
%Cada nivel implica ciertas tareas
%Cada tarea consiste en buscar "x" objeto en "y" ciudad

%tareas = functor del tipo -> buscar(objeto, ciudad)
%tarea -> predicado de aridad 2 que tiene el nivel y la tarea

%nivelActual -> Predicado
%            -> aridad 2
%            -> (Persona, Nivel)

%Idioma de c/ Ciudad:
%idioma -> Predicado
%       -> aridad 2
%       -> (Ciudad, Idioma)

%Idioma de c/ persona:
%habla -> Predicado
%      -> aridad 2
%      -> (Persona, Idioma)

%Plata actual de c/ persona:
%capitalActual -> Predicado
%              -> aridad 2
%              -> (Persona, CapitalActual)

%Base de conociemiento:

%Tarea:
tarea(basico,buscar(libro,jartum)).
tarea(basico,buscar(arbol,patras)).
tarea(basico,buscar(roca,telaviv)).
tarea(intermedio,buscar(arbol,sofia)).
tarea(intermedio,buscar(arbol,bucarest)).
tarea(avanzado,buscar(perro,bari)).
tarea(avanzado,buscar(flor,belgrado)).

%NivelActual:
nivelActual(pepe,basico).
nivelActual(lucy,intermedio).
nivelActual(juancho,avanzado).

%Idioma:
idioma(alejandria,arabe).
idioma(jartum,arabe).
idioma(patras,griego).
idioma(telaviv,hebreo).
idioma(sofia,bulgaro).
idioma(bari,italiano).
idioma(bucarest,rumano).
idioma(belgrado,serbio).

%Habla:
habla(pepe,bulgaro).
habla(pepe,griego).
habla(pepe,italiano).
habla(juancho,arabe).
habla(juancho,griego).
habla(juancho,hebreo).
habla(lucy,griego).


%CapitalActual:
capital(pepe,1200).
capital(lucy,3000).
capital(juancho,500).

%Punto 1:
destinoPosible(UnaPersona, UnaCiudad):-
    nivelActual(UnaPersona, UnNivel),
    tarea(UnNivel, buscar(_, UnaCiudad)).

idiomaUtil(UnNivel, UnIdioma):-
    tarea(UnNivel, buscar(_, UnDestino)),
    idioma(UnDestino, UnIdioma).

%Punto 2:
excelenteCompaniero(UnParticipante, OtroParticipante):-
    nivelActual(UnParticipante, UnNivel),
    nivelActual(OtroParticipante,_),
    UnParticipante \= OtroParticipante,
    forall(idiomaUtil(UnNivel, UnIdioma), habla(OtroParticipante, UnIdioma)).

%Punto 3:
interesante(UnNivel):-
    nivelActual(_, UnNivel),
    forall(tarea(UnNivel, buscar(UnaCosa,_)), estaViva(UnaCosa)).
interesante(UnNivel):-
    idiomaUtil(UnNivel, italiano).

estaViva(arbol).
estaViva(perro).
estaViva(flor).

%Punto 4:
complicado(UnParticipante):-
    nivelActual(UnParticipante, UnNivel),
    complicadoSegunNivel(UnParticipante, UnNivel).

complicadoSegunNivel(UnParticipante, UnNivel):-
    not(hablaIdiomaDelNivel(UnParticipante, UnNivel)).
complicadoSegunNivel(UnParticipante, UnNivel):-
    capitalParaNivel(UnNivel, UnCapital),
    capitalMenorA(UnParticipante, UnCapital).

capitalParaNivel(basico, 500).
capitalParaNivel(UnNivel, 1500):-
    UnNivel \= basico.

capitalMenorA(UnParticipante, UnMonto):-
    capital(UnParticipante, CapitalActual),
    CapitalActual<UnMonto.

hablaIdiomaDelNivel(UnParticipante, UnNivel):-
    idiomaUtil(UnNivel, UnIdioma),
    habla(UnParticipante, UnIdioma).

%Punto 5:
homogeneo(UnNivel):-
    tarea(UnNivel, buscar(UnaCosa,_)),
    forall(tarea(UnNivel, buscar(ObjetoABuscar,_)), esLaMisma(UnaCosa, ObjetoABuscar)).

esLaMisma(Valor1, Valor1).