% Types de crime
crime_type(assassinat).
crime_type(vol).
crime_type(escroquerie).
 

% Faits
suspect(john).
suspect(mary).
suspect(alice).
suspect(bruno).
suspect(sophie).

has_motive(john, vol).
has_motive(mary, assassinat).
has_motive(alice, escroquerie).

was_near_crime_scene(john, vol).
was_near_crime_scene(mary, assassinat).

has_fingerprint_on_weapon(john, vol).
has_fingerprint_on_weapon(mary, assassinat).

has_bank_transaction(alice, escroquerie).
has_bank_transaction(bruno, escroquerie).

owns_fake_identity(sophie, escroquerie).



% Règles
% Règle pour le vol : un suspect est coupable s'il a un motif, était près de la scène et a ses empreintes sur l'arme
is_guilty(Suspect, vol) :-
    suspect(Suspect),
    crime_type(vol),
    has_motive(Suspect, vol),
    was_near_crime_scene(Suspect, vol),
    has_fingerprint_on_weapon(Suspect, vol).

% Règle pour l'assassinat : un suspect est coupable s'il a un motif, était près de la scène et a ses empreintes ou une identification par témoin
is_guilty(Suspect, assassinat) :-
    suspect(Suspect),
    crime_type(assassinat),
    has_motive(Suspect, assassinat),
    was_near_crime_scene(Suspect, assassinat),
    (   has_fingerprint_on_weapon(Suspect, assassinat)
    ;   eyewitness_identification(Suspect, assassinat)
    ).
   

% Règle pour l'escroquerie : un suspect est coupable s'il a un motif et une transaction bancaire, ou possède une fausse identité
is_guilty(Suspect, escroquerie) :-
    suspect(Suspect),
    crime_type(escroquerie),
    (   has_motive(Suspect, escroquerie),
        has_bank_transaction(Suspect, escroquerie)
    ;   has_bank_transaction(Suspect, escroquerie)
    ;   owns_fake_identity(Suspect, escroquerie)
    ).

% Entrée principale
main(Suspect, CrimeType):-
    (   crime_type(CrimeType),
        suspect(Suspect),
        is_guilty(Suspect, CrimeType) ->
        write(Suspect), write(' est coupable de '), write(CrimeType), nl
    ;   write(Suspect), write(' n\'est pas coupable de '), write(CrimeType), nl
    ).

% Prédicat pour gérer l'absence de témoin (optionnel, si nécessaire)
eyewitness_identification(_, _) :- fail. % Par défaut, aucun témoin
