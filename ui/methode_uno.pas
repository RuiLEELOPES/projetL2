{
 Auteur      : BENBEKHTI MELIANI Nadir
 CompteGit : DarvogGit
 Date        : 04/05/2026
 Description : Unit créée pour gérer les differentes action possible dans une partie de UNO
}

unit Methode_UNO;

{$mode ObjFPC}{$H+}

interface
 TYPE
  TCouleur = (vr, re, bl, j, no);

  TCarte = record
    Couleur: TCouleur;
    Chiffre: Integer;
  end;

PElementCarte = ^TElementCarte;  //Cellule de liste chainé qui seras une carte

    TElementCarte = record
      Carte: TCarte;
      Suivant: PElementCarte;
    end;
                                 //Un deck seras une PILE de carte(cellule)
    TDeck = record
        Sommet: PElementCarte;
        Taille: Integer;
      end;

    TMain = record      //Une main qui seras une liste chainé de carte(cellule)
uses
  Classes, SysUtils;

procedure InitialiserDeck(var Deck: TDeck);
procedure InitialiserMain(var Main: TMain);
procedure AjouterCarteDeck(var Deck: TDeck; Carte: TCarte);
procedure AjouterCarteMain(var Main: TMain; Carte: TCarte);
procedure AjouterPlusieursCartesDeck(var Deck: TDeck;Couleur: TCouleur;Chiffre: Integer;Nombre: Integer);
function GenererDeckUno(var Deck: TDeck): Boolean;
procedure AfficherCarte(Carte: TCarte);
procedure AfficherMain(Main: TMain);
procedure AfficherDeck(Deck: TDeck);
function PiocherCarte(var Deck: TDeck; var CarteSortie: TCarte): Boolean;
 function JouerCarteMain(var Main: TMain; var CarteSortie: TCarte): Boolean;
 procedure AjouterCarteFinMain(var Main: TMain; Carte: TCarte);
implementation
function Jouerlabonnecarte(var Main: TMain; var CarteSortie: TCarte; var CarteVerif: TCarte): Boolean;
procedure EchangerMains(var Main1: TMain; var Main2: TMain);
procedure DetruireMain(var Main: TMain);
procedure DetruireDeck(var Deck: TDeck);
function CreerMainChoixJouables(var MainJoueur: TMain;var MainChoix: TMain;var CarteVerif: TCarte): Boolean;
function RecupererCarteParNumero(var Main: TMain;numero: Integer; var CarteSortie: TCarte): Boolean;
function EnleverCarteDeMain(var Main: TMain;CarteAEnlever: TCarte;var CarteSortie: TCarte): Boolean;
function MelangerDeck(var Deck: TDeck): Boolean;
function JouerCarteAvecChoix(var MainJoueur: TMain;var CarteVerif: TCarte;Choix: Integer;var CarteSortie: TCarte): Boolean;
function CarteEstJouableAvecCouleurForcee(Carte: TCarte;CarteVerif: TCarte;DerniereCouleurForcee: TCouleur): Boolean;
function JouerCartePrioriteNegative(var Main: TMain;var CarteSortie: TCarte;var CarteVerif: TCarte;DerniereCouleurForcee: TCouleur): Boolean;
 {==============================FONCTION==============================}

//INIT
procedure InitialiserDeck(var Deck: TDeck);   //init deck
begin
  Deck.Sommet := nil;
  Deck.Taille := 0;
end;

procedure InitialiserMain(var Main: TMain); //init main
begin
  Main.Debut := nil;
  Main.Taille := 0;
end;


//AJOUTER
procedure AjouterCarteDeck(var Deck: TDeck; Carte: TCarte);   //  ajouter une carte au deck
var
  Nouveau: PElementCarte;
begin
  New(Nouveau);              // On crée une nouvelle case mémoire
  Nouveau^.Carte := Carte;   // On met la carte dedans

  Nouveau^.Suivant := Deck.Sommet; // L'ancien sommet passe après
  Deck.Sommet := Nouveau;          // La nouvelle carte devient le sommet

  Deck.Taille := Deck.Taille + 1;  // On augmente la taille du deck
end;

procedure AjouterCarteMain(var Main: TMain; Carte: TCarte);     //Ajouter une carte main
var
  Nouveau: PElementCarte;
begin
  New(Nouveau);              // On crée une nouvelle case mémoire
  Nouveau^.Carte := Carte;   // On met la carte dedans

  Nouveau^.Suivant := Main.Debut; // L'ancienne première carte passe après
  Main.Debut := Nouveau;          // La nouvelle carte devient la première

  Main.Taille := Main.Taille + 1; // On augmente la taille de la main
end;

procedure AjouterPlusieursCartesDeck(var Deck: TDeck;Couleur: TCouleur;Chiffre: Integer;Nombre: Integer);//Permet d'ajouter plusieur carte en meme temps
var
  i: Integer;
  Carte: TCarte;
begin
  for i := 1 to Nombre do
  begin
    Carte.Couleur := Couleur;
    Carte.Chiffre := Chiffre;

    AjouterCarteDeck(Deck, Carte);
  end;
end;

function GenererDeckUno(var Deck: TDeck): Boolean; //genere le deck
var
  Couleur: TCouleur;
  Chiffre: Integer;
begin
  InitialiserDeck(Deck);

  // Cartes de couleur : vr, re, bl, j
  for Couleur := vr to j do
  begin
    // Cartes chiffres 1 à 9
    // 2 cartes de chaque chiffre par couleur
    for Chiffre := 1 to 9 do
    begin
      AjouterPlusieursCartesDeck(Deck, Couleur, Chiffre, 2);
    end;

    // Cartes spéciales de couleur
    AjouterPlusieursCartesDeck(Deck, Couleur, -1, 2);
    AjouterPlusieursCartesDeck(Deck, Couleur, -2, 2);
    AjouterPlusieursCartesDeck(Deck, Couleur, -5, 2);
  end;

  // Cartes noires
  AjouterPlusieursCartesDeck(Deck, no, -3, 4);
  AjouterPlusieursCartesDeck(Deck, no, -4, 4);

  GenererDeckUno := Deck.Taille = 104;
end;

function CarteEstJouable(Carte: TCarte; CarteVerif: TCarte): Boolean;

//AFFICHER

procedure AfficherCarte(Carte: TCarte);
begin
  write('Couleur = ', Ord(Carte.Couleur));
  writeln(' | Chiffre = ', Carte.Chiffre);
end;

procedure AfficherMain(Main: TMain);
var
  Temp: PElementCarte;
  i: Integer;
begin
  if Main.Debut = nil then
  begin
    writeln('Main vide.');
    Exit;
  end;

  Temp := Main.Debut;
  i := 1;

  while Temp <> nil do
  begin
    write(i, ' - ');
    AfficherCarte(Temp^.Carte);

    Temp := Temp^.Suivant;
    i := i + 1;
  end;

  writeln('Taille main = ', Main.Taille);
end;

procedure AfficherDeck(Deck: TDeck);
var
  Temp: PElementCarte;
  i: Integer;
begin
  if Deck.Sommet = nil then
  begin
    writeln('Deck vide.');
    Exit;
  end;

  Temp := Deck.Sommet;
  i := 1;

  while Temp <> nil do
  begin
    write(i, ' - ');
    AfficherCarte(Temp^.Carte);

    Temp := Temp^.Suivant;
    i := i + 1;
  end;

  writeln('Taille deck = ', Deck.Taille);
end;
//JOUER ET PIOCHEZ

function CarteEstJouable(Carte: TCarte; CarteVerif: TCarte): Boolean;   //simplifier le triple condition en une fioction lisible
begin
  CarteEstJouable :=
    (Carte.Couleur = CarteVerif.Couleur) or
    (Carte.Chiffre = CarteVerif.Chiffre) or
    (Carte.Couleur = no);
end;

function PiocherCarte(var Deck: TDeck; var CarteSortie: TCarte): Boolean; //verifie si il a pue piochez et pioche
var
  Temp: PElementCarte;
begin
  // Si le deck est vide, on ne peut pas piocher
  if Deck.Sommet = nil then
  begin
    PiocherCarte := False;
    Exit;
  end;

  // On garde l'adresse de la carte du sommet
  Temp := Deck.Sommet;

  // On copie la carte du sommet dans CarteSortie
  CarteSortie := Temp^.Carte;

  // Le sommet devient la carte suivante
  Deck.Sommet := Temp^.Suivant;

  // On libère la mémoire de l'ancien sommet
  Dispose(Temp);

  // On diminue la taille du deck
  Deck.Taille := Deck.Taille - 1;

  // La pioche a réussi
  PiocherCarte := True;
end;

function JouerCarteMain(var Main: TMain; var CarteSortie: TCarte): Boolean; // verifie si il a pue jouez et joue
 //fonction de debeugage de main  me permet juste de faire joué une seul main
var
  Temp: PElementCarte;
begin
  // Si la main est vide, on ne peut pas jouer
  if Main.Debut = nil then
  begin
    JouerCarteMain := False;
    Exit;
  end;

  // On garde l'adresse de la première carte
  Temp := Main.Debut;

  // On copie la carte jouée dans CarteSortie
  CarteSortie := Temp^.Carte;

  // Le début de la main devient la carte suivante
  Main.Debut := Temp^.Suivant;

  // On libère la mémoire de l'ancienne carte
  Dispose(Temp);

  // On diminue la taille de la main
  Main.Taille := Main.Taille - 1;

  // La carte a bien été jouée
  JouerCarteMain := True;
end;

procedure AjouterCarteFinMain(var Main: TMain; Carte: TCarte);   //utilisez pour triez les mains temporaire
var
  Nouveau, Temp: PElementCarte;
begin
  New(Nouveau);
  Nouveau^.Carte := Carte;
  Nouveau^.Suivant := nil;

  if Main.Debut = nil then
  begin
    Main.Debut := Nouveau;
  end
  else
  begin
    Temp := Main.Debut;

    while Temp^.Suivant <> nil do
    begin
      Temp := Temp^.Suivant;
    end;

    Temp^.Suivant := Nouveau;
  end;

  Main.Taille := Main.Taille + 1;
end;

function Jouerlabonnecarte(var Main: TMain; var CarteSortie: TCarte; var CarteVerif: TCarte): Boolean; //cherche la premiere bonne carte

var
  Temp, Prec: PElementCarte;
begin
  // Si la main est vide, on ne peut pas jouer
  if Main.Debut = nil then
  begin
    Jouerlabonnecarte := False;
    Exit;
  end;

  Prec := nil;
  Temp := Main.Debut;          //on crée une main temporaire pour pas corrompre la premiere

  // On cherche la première bonne carte dans la main
  while Temp <> nil do
  begin
    // Une carte est jouable si elle a la même couleur,
    // le même chiffre, ou si c'est une carte noire
    if CarteEstJouable(Temp^.Carte,CarteVerif) then
    begin
      // On enregistre la carte trouvée
      CarteSortie := Temp^.Carte;

      // Si la carte trouvée est la première de la main
      if Prec = nil then
      begin
        Main.Debut := Temp^.Suivant;
      end
      else
      begin
        Prec^.Suivant := Temp^.Suivant;
      end;

      // On libère la mémoire
      Dispose(Temp);

      // On diminue la taille de la main
      Main.Taille := Main.Taille - 1;

      // On a trouvé et joué une carte
      Jouerlabonnecarte := True;
      Exit;
    end;

    // On avance dans la main
    Prec := Temp;
    Temp := Temp^.Suivant;
  end;

  // Si on arrive ici, aucune carte n'était jouable
  Jouerlabonnecarte := False;
end;

procedure EchangerMains(var Main1: TMain; var Main2: TMain);  //échangé les main si la carte échange est pos
var
  Temp: TMain;
begin
  Temp := Main1;
  Main1 := Main2;
  Main2 := Temp;
end;

procedure DetruireMain(var Main: TMain); //permet de detruire une main  pour economisé de la RAM
var
  Temp: PElementCarte;
begin
  while Main.Debut <> nil do
  begin
    Temp := Main.Debut;
    Main.Debut := Main.Debut^.Suivant;
    Dispose(Temp);
  end;

  Main.Taille := 0;
end;
//FAIRE JOUER LE JOUEUR  {Trouver un meilleur nom}

procedure DetruireDeck(var Deck: TDeck); //pour liberez de la mémoire lors du mélange du deck
var
  Temp: PElementCarte;
begin
  while Deck.Sommet <> nil do
  begin
    Temp := Deck.Sommet;
    Deck.Sommet := Deck.Sommet^.Suivant;
    Dispose(Temp);
  end;

  Deck.Taille := 0;
end;
function CreerMainChoixJouables(var MainJoueur: TMain;var MainChoix: TMain;var CarteVerif: TCarte): Boolean;
var
  Temp: PElementCarte;
begin
  InitialiserMain(MainChoix);

  Temp := MainJoueur.Debut;

  while Temp <> nil do
  begin
    if CarteEstJouable(Temp^.Carte, CarteVerif) then
    begin
      AjouterCarteFinMain(MainChoix, Temp^.Carte);
    end;

    Temp := Temp^.Suivant;
  end;

  CreerMainChoixJouables := MainChoix.Taille > 0;
end;

function RecupererCarteParNumero(var Main: TMain;numero: Integer; var CarteSortie: TCarte): Boolean;
 //avec la main temporaire on va cherché une des cartes
  //jouble avec un numéro un peu comme un tab[2] = deuxieme carte jouable
var
  Temp: PElementCarte;
  i: Integer;
begin
  if (Numero < 1) or (Numero > Main.Taille) then
  begin
    RecupererCarteParNumero := False;
    Exit;
  end;

  Temp := Main.Debut;
  i := 1;

  while i < Numero do
  begin
    Temp := Temp^.Suivant;
    i := i + 1;
  end;

  CarteSortie := Temp^.Carte;
  RecupererCarteParNumero := True;
end;

function EnleverCarteDeMain(var Main: TMain;CarteAEnlever: TCarte;var CarteSortie: TCarte): Boolean;
//Avec l'adresse de la carte a enlever , on la supprime de la main
var
  Temp, Prec: PElementCarte;
begin
  Temp := Main.Debut;
  Prec := nil;

  while Temp <> nil do
  begin
    if (Temp^.Carte.Couleur = CarteAEnlever.Couleur) and
       (Temp^.Carte.Chiffre = CarteAEnlever.Chiffre) then
    begin
      CarteSortie := Temp^.Carte;

      if Prec = nil then
      begin
        Main.Debut := Temp^.Suivant;
      end
      else
      begin
        Prec^.Suivant := Temp^.Suivant;
      end;

      Dispose(Temp);
      Main.Taille := Main.Taille - 1;

      EnleverCarteDeMain := True;
      Exit;
    end;

    Prec := Temp;
    Temp := Temp^.Suivant;
  end;

  EnleverCarteDeMain := False;
end;

 function MelangerDeck(var Deck: TDeck): Boolean; //melange le deck
var
  Cartes: array of TCarte;
  Temp: PElementCarte;
  i, j: Integer;
  CarteTemp: TCarte;
begin
  if Deck.Taille <= 1 then
  begin
    MelangerDeck := True;
    Exit;
  end;

  // 1. Copier les cartes du deck dans un tableau
  SetLength(Cartes, Deck.Taille);

  Temp := Deck.Sommet;
  i := 0;

  while Temp <> nil do
  begin
    Cartes[i] := Temp^.Carte;
    Temp := Temp^.Suivant;
    i := i + 1;
  end;

  // 2. Mélange Fisher-Yates
  for i := High(Cartes) downto 1 do
  begin
    j := Random(i + 1);

    CarteTemp := Cartes[i];
    Cartes[i] := Cartes[j];
    Cartes[j] := CarteTemp;
  end;

  // 3. Détruire l'ancien deck
  DetruireDeck(Deck);

  // 4. Reconstruire le deck mélangé
  for i := 0 to High(Cartes) do
  begin
    AjouterCarteDeck(Deck, Cartes[i]);
  end;

  MelangerDeck := True;
end;

function JouerCarteAvecChoix(var MainJoueur: TMain;var CarteVerif: TCarte;Choix: Integer;var CarteSortie: TCarte): Boolean;
//on simule maintenant toute les action nécessaire pour fair joué
var
  MainChoix: TMain;
  CarteChoisie: TCarte;
begin
  // On crée la main temporaire des cartes jouables
  if not CreerMainChoixJouables(MainJoueur, MainChoix, CarteVerif) then
  begin
    JouerCarteAvecChoix := False;
    Exit;
  end;

  // On récupère la carte choisie dans MainChoix
  if not RecupererCarteParNumero(MainChoix, Choix, CarteChoisie) then
  begin
    DetruireMain(MainChoix);
    JouerCarteAvecChoix := False;
    Exit;
  end;

  // On enlève cette carte de la vraie main du joueur
  if EnleverCarteDeMain(MainJoueur, CarteChoisie, CarteSortie) then
  begin
    DetruireMain(MainChoix);
    JouerCarteAvecChoix := True;
    Exit;
  end;

  DetruireMain(MainChoix);
  JouerCarteAvecChoix := False;
end;

//PROGRAMME DE DECISION
function CarteEstJouableAvecCouleurForcee(Carte: TCarte;CarteVerif: TCarte;DerniereCouleurForcee: TCouleur): Boolean; //Permet de priorisé les cartes spéciales
var
  CouleurAVerifier: TCouleur;
begin
  if CarteVerif.Couleur = no then
    CouleurAVerifier := DerniereCouleurForcee
  else
    CouleurAVerifier := CarteVerif.Couleur;

  CarteEstJouableAvecCouleurForcee :=
    (Carte.Couleur = CouleurAVerifier) or
    (Carte.Chiffre = CarteVerif.Chiffre) or
    (Carte.Couleur = no);
end;

function JouerCartePrioriteNegative(var Main: TMain;var CarteSortie: TCarte;var CarteVerif: TCarte;DerniereCouleurForcee: TCouleur): Boolean; //La fonction d'action de l'ordinateur agréssif
var
  Temp, Prec: PElementCarte;
  CarteChoisie, PrecChoisie: PElementCarte;
begin
  CarteChoisie := nil;
  PrecChoisie := nil;

  // Si la main est vide
  if Main.Debut = nil then
  begin
    JouerCartePrioriteNegative := False;
    Exit;
  end;

  // Première recherche : carte négative jouable
  Temp := Main.Debut;
  Prec := nil;

  while Temp <> nil do
  begin
    if (Temp^.Carte.Chiffre < 0) and
       CarteEstJouableAvecCouleurForcee(Temp^.Carte, CarteVerif, DerniereCouleurForcee) then
    begin
      CarteChoisie := Temp;
      PrecChoisie := Prec;
      Break;
    end;

    Prec := Temp;
    Temp := Temp^.Suivant;
  end;

  // Deuxième recherche : carte normale jouable
  if CarteChoisie = nil then
  begin
    Temp := Main.Debut;
    Prec := nil;

    while Temp <> nil do
    begin
      if CarteEstJouableAvecCouleurForcee(Temp^.Carte, CarteVerif, DerniereCouleurForcee) then
      begin
        CarteChoisie := Temp;
        PrecChoisie := Prec;
        Break;
      end;

      Prec := Temp;
      Temp := Temp^.Suivant;
    end;
  end;

  // Aucune carte jouable
  if CarteChoisie = nil then
  begin
    JouerCartePrioriteNegative := False;
    Exit;
  end;

  // On sauvegarde la carte jouée
  CarteSortie := CarteChoisie^.Carte;

  // On enlève la carte de la main
  if PrecChoisie = nil then
  begin
    Main.Debut := CarteChoisie^.Suivant;
  end
  else
  begin
    PrecChoisie^.Suivant := CarteChoisie^.Suivant;
  end;

  Dispose(CarteChoisie);
  Main.Taille := Main.Taille - 1;

  JouerCartePrioriteNegative := True;
end;

end.

