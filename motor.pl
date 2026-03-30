:- module(motor, [
    recomendar/2,
    top_n/3,
    mostrar_recomendacoes/1,
    avaliar_musica/3
]).

:- use_module(musicas_db).

:- dynamic avaliacao/3.

avaliar_musica(Id, Dimensao, Nota) :-
    integer(Nota), Nota >= 1, Nota =< 5,
    musica(Id, _, _, _, _),
    retractall(avaliacao(Id, Dimensao, _)),
    assertz(avaliacao(Id, Dimensao, Nota)).

musicas_curtidas(Lista) :-
    findall(Id, (avaliacao(Id, gosto_geral, N), N >= 4), Lista).

generos_preferidos(Generos) :-
    musicas_curtidas(Curtidas),
    findall(G, (member(Id, Curtidas), musica(Id,_,_,_,G)), Generos).


conta_ocorrencias(_, [], 0) :- !.
conta_ocorrencias(X, [X|T], N) :-
    !, conta_ocorrencias(X, T, N1), N is N1 + 1.
conta_ocorrencias(X, [_|T], N) :-
    conta_ocorrencias(X, T, N).

genero_compativel(G, Lista) :-
    member(G, Lista), !.
genero_compativel(G, Lista) :-
    member(GP, Lista),
    (genero_similar(G, GP) ; genero_similar(GP, G)), !.

top_n(_, 0, []) :- !.
top_n([], _, []).
top_n([H|T], N, [H|Rest]) :-
    N > 0, N1 is N - 1, top_n(T, N1, Rest).


pontuar(Id, GenerosPref, Pontos, Razoes) :-
    musica(Id, _, _, _, Genero),
    
    % Gênero Idêntico
    conta_ocorrencias(Genero, GenerosPref, Ct),
    PtsIdentico is Ct * 20,
    
    % Gênero Similar (Bônus se não for idêntico)
    (   PtsIdentico =:= 0, genero_compativel(Genero, GenerosPref)
    ->  PtsGenero = 10, Razoes = ['gênero similar']
    ;   PtsGenero = PtsIdentico, 
        (PtsGenero > 0 -> Razoes = ['gênero preferido'] ; Razoes = [])
    ),
    Pontos is PtsGenero.


recomendar(Selecionadas, Recomendacoes) :-
    generos_preferidos(GenerosPref),
    findall(Pts-Id-Razoes,
        (   musica(Id,_,_,_,_),
            \+ member(Id, Selecionadas),
            pontuar(Id, GenerosPref, Pts, Razoes),
            Pts > 0
        ),
        Candidatos),
    msort(Candidatos, Ascendente),
    reverse(Ascendente, Recomendacoes).

mostrar_recomendacoes(Selecionadas) :-
    recomendar(Selecionadas, Recs),
    top_n(Recs, 5, Top5),
    nl, write('--- RECOMENDAÇÕES ---'), nl,
    forall(member(Pts-Id-Razoes, Top5), (
        musica(Id, Titulo, Artista, Album, Genero),
        format('~w pts | ~w - ~w (~w) [Razões: ~w]~n', [Pts, Titulo, Artista, Genero, Razoes])
    )).