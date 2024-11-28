% Определяем коллекции
collect(fauna).
collect(flora).
collect(cosmos).
collect(sport).

solve(WolfCollect, NifCollect, NafCollect, NufCollect) :-
    % Генерация всех возможных коллекций
    collect(WolfCollect), 
    collect(NifCollect),
    collect(NafCollect),
    collect(NufCollect),
    
    % Убедимся, что все коллекции уникальны
    all_different([WolfCollect, NifCollect, NafCollect, NufCollect]),
    
    % Определим порядок сидения
    sitting_order([wolf, nif, naf, nuf]), 

    % Условия:
    % Ниф сидит справа от Нафа
    right_of(nif, naf), 
    
    % Нуф сидит напротив Нафа
    opposite(nuf, naf),
    
    % Привязываем персонажей к их коллекциям
    assigned_collections([wolf, nif, naf, nuf], [WolfCollect, NifCollect, NafCollect, NufCollect]).

% Определяем порядок сидения
sitting_order([X, Y, Z, W]) :- 
    member(X, [wolf, nif, naf, nuf]),
    member(Y, [wolf, nif, naf, nuf]),
    member(Z, [wolf, nif, naf, nuf]),
    member(W, [wolf, nif, naf, nuf]),
    all_different([X, Y, Z, W]).

% Определяем, кто сидит справа
right_of(Nif, Naf) :- 
    sitting_order([_, Naf, Nif, _]).

% Определяем, кто сидит напротив
opposite(Nuf, Naf) :- 
    sitting_order([Naf, _, _, Nuf]).

% Забота о уникальности
all_different([]).
all_different([H|T]) :- \+ member(H, T), all_different(T).

% Привязываем персонажей к их коллекциям
assigned_collections([], []).
assigned_collections([P|Ps], [C|Cs]) :- 
    collected(P, C),
    assigned_collections(Ps, Cs).

% Определяем коллекции для персонажей
collected(wolf, fauna).
collected(nif, flora).
collected(naf, cosmos).
collected(nuf, sport).

?- solve(WolfCollect, NifCollect, NafCollect, NufCollect).