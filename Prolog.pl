% Abre a pasta(que contém o arquivo) no terminal, digita prolog ou swipl, depois "consult(nomeDoArquivo)", 
% assim podemos realizar consultas chamando as funções pelo seu nome 
% Exemplo: menorDeDois(2,3,X).. X -> Variável para retornar o resultado.

% VARIAVEL ANONIMA É AQUELA QUE APARECE APENAS UMA VEZ

% Prolog é bom para fazer buscas no espaço definido pelo programador

% VANTAGENS DA PROGRAMÇÃO LÓGICA
% - Maior abstração: 
%  -Programas menores
%  -Fáceis de escrever e de manter

% DESVANTAGENS 
%  - Menos eficiente (Devido a maior abstração)
%  - Um determinado problema pode ter mais de uma resposta
%  - Não existe distinção entre o que é entrada e saída de processamento
%  - Não é adequado para processamento numério intensivo

% CORTE
% O corte elimina decições alternativas a serem executadas
% Com o corte podemos fazer otimizações ao evitar testes contrários em cláusulas diferentes. Reduzindo assim
% a quantidade de verificações que precisa ser feita.


% BACKTRACKING
% É uma estratégia de busca de alternativas possíveis para uma solução, semelhante a uma busca em
% profundidade. Essa estratégia consiste em prever a existência de soluções não analisadas no processo de
% busca da solução.

% 1) Recebe dois valores e retorna o menor
menorDeDois(A, B, A) :-
    A =< B, !.
menorDeDois(_, B, B).

% 2) Recebe três valores e retorna o menor
menorDetres(A, B, C, D) :-
    menorDeDois(A, B, E),
    menorDeDois(E, C, D).

% 3) Recebe um numero natural e retorna o seu fatoria
fatorial(0,1) :- !.
fatorial(N, Fat) :-
    Nmenos1 is N-1,
    fatorial(Nmenos1, FatNmenos1),
    Fat is N * FatNmenos1.

% 4) Recebe um número inteiro positivo n e retorna o n-ésimo elemento da sequência de Fibonacci
fibonacci(1, 1) :- !.
fibonacci(2, 1) :- !.
fibonacci(N, F) :-
    N1 is N-1,
    fibonacci(N1, F1),
    N2 is N-2,
    fibonacci(N2, F2),
    F is F1 + F2.

% 5) Recebe uma lista e um número inteiro positivo n para retornar o n-ésimo elemento da lista
elemento(1, [C|_], C) :- !.
elemento(N, [_|R], E) :-
    N1 is N-1,
    elemento(N1, R, E).

% 6) Recebe uma lista e um elemento qualquer e verifica se o elemento pertence à lista
pertence(C, [C|_]).
pertence(E, [_|R]) :-
    pertence(E, R).


% 7) Recebe uma lista qualquer e retorna o número de elementos na lista
nroElementos([], 0).
nroElementos([_|R], N) :-
    nroElementos(R, NR),
    N is 1 + NR.


% 8) Recebe uma lista de números e retorna o maior
maior([E], E).
maior([C|R], C) :-
    maior(R, MR),
    C >= MR, !.
maior([_|R], MR) :-
    maior(R, MR).

% ------ OU -------

maior2([E], E).
maior2([C|R], M) :-
    maior2(R, MR),
    maiorDeDois(C, MR, M).

% 9) Recebe um elemento e uma lista qualquer, retorna o número de ocorrências do elemento na lista
nroOcorrencias(C, [C|R], Qtd) :- !,
    nroOcorrencias(C, R, NOCR),
    Qtd is 1 + NOCR.
nroOcorrencias(E, [_|R], Qtd) :-
    nroOcorrencias(E, R, Qtd).
nroOcorrencias(_, [], 0).

% 10) Recebe um elemento e uma lista e verifica se existe uma única ocorrência do elemento na lista
unicaOcorrencia(C, [C|R]) :- !,
    not(pertence(C, R)).
unicaOcorrencia(E, [_|R]) :-
    unicaOcorrencia(E, R).

% 11) Recebe um número e uma lista de números, retorna uma lista com os números que são maiores que o fornecido
maioresQue(N, [C|R], [C|Outros]) :-
    C > N, !,
    maioresQue(N, R, Outros).
maioresQue(N, [_|R], Outros) :-
   maioresQue(N, R, Outros). 
maioresQue(_, [], []).

% 12) Recebe duas listas quaisquer e retorna um terceira lista com os elementos da primeira no início e os elementos da segunda no fim
concatena([C|R], L2, [C|Outros]) :-
    concatena(R, L2, Outros).
concatena([], L, L).

% 13) Recebe um elemento e uma lista e retorna a lista sem a primeira ocorrência do elemento
remove(C, [C|R], R) :- !.
remove(E, [C|R], [C|RsemE]) :-
    remove(E, R, RsemE).

% 14) Recebe uma lista e retorna a lista sem o último elemento
removeUltimo([_], []).
removeUltimo([C|R], [C|Outros]) :-
    removeUltimo(R, Outros).

% 15) Recebe um elemento e uma lista e retorna a lista sem todas as ocorrencias do elemento recebido
removeTodos(_, [], []) :- !.
removeTodos(C, [C|R], RsemC) :- !,
    removeTodos(C, R, RsemC).
removeTodos(E, [C|R], [C|RsemE]) :-
    removeTodos(E, R, RsemE).

% 16) Recebe uma lista e retorna outra lista sem repetição de elementos
removeRepetidos([C|R], [C|Outros]) :-
    removeTodos(C, R, RsemC),
    removeRepetidos(RsemC, Outros).
removeRepetidos([], []).
   

% 17) Recebe um elemento e uma lista e retorna a lista sem a ultima ocorrencia do elemento
removeUltimaOcorrencia(E, [E|R], RsemE, sim) :- 
    removeUltimaOcorrencia(E, R, RsemE, nao).
removeUltimaOcorrencia(E, [E|R], [E|RsemE], sim) :- 
    removeUltimaOcorrencia(E, R, RsemE, sim), !.
removeUltimaOcorrencia(E, [C|R], [C|RsemE], Removeu) :- 
    removeUltimaOcorrencia(E, R, RsemE, Removeu).
removeUltimaOcorrencia(E, [E], [], sim).

% 18) Recebe uma lista e retorna a soma de todos os elementos da lista
somaElementos([], 0) :- !.
somaElementos([C|R], X) :-
    somaElementos(R, N1),
    X is C + N1.

% 19) Recebe uma lista e retorna a media aritmetica dos elementos da lista
media(Lista, X):-
    somaElementos(Lista, N1),
    nroElementos(Lista, N2),
    X is N1 / N2.

% 20) Retorna o penultimo elemento de uma lista recebida como entrada
penultimo([P,_], P) :- !.
penultimo([_|R], X) :-
    penultimo(R, X).

% 21) Recebe um elemento e uma lista e insere um elemento no fim da lista
insereFim(N, [], [N]) :- !.
insereFim(N, [C|R], [C|Resultado]) :-
    insereFim(N, R, Resultado).

% 22) Recebe um número inteiro n positivo e retorna a lista [1,-1,2,-2,3,-3, ...,n,-n]
geraSeq(1, [1,-1]):- !.
geraSeq(E, Lista) :-
    Emenos1 is E - 1,
    geraSeq(Emenos1, X),
    N1 is E,
    N2 is E * -1,
    concatena(X, [N1,N2], Lista).


% 23) Recebe uma lista e retorna outra, que contém os mesmos elementos da primeira, em ordem invertida
inverte([],[]) :- !.
inverte([C|R], Lista) :-
    inverte(R, Outros),
    concatena(Outros, [C], Lista).


% 24) Recebe uma lista e retorna o último elemento da lista
ultimoElemento([E], E) :- !.
ultimoElemento([_|R], X) :-
    ultimoElemento(R, X).

% 25) Recebe duas listas e retorna outra lista com os elementos das listas originais intercalados.
intercala([E], [F], [E,F]) :- !.
intercala([], [E], [E]) :- !.
intercala([E], [], [E]) :- !.
intercala([C|R], [X|Y], Lista) :-
    intercala(R, Y, Outros),
    concatena([C,X], Outros, Lista).

% 26) Recebe duas listas sem elementos repetidos e retorna uma lista com os elementos que são comuns às duas
interseccao([C|R], L, [C|Outros]) :-
    pertence(C, L),
    interseccao(R, L, Outros), !.
interseccao([_|R], L, Lista) :-
    interseccao(R, L, Lista).
interseccao([], _, []).
