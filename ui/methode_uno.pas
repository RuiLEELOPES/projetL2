{
 Auteur      : BENBEKHTI MELIANI Nadir
 CompteGit   : DarvogGit
 Date        : 04/05/2026
 Description : Unit créée pour gérer les différentes actions possibles dans une partie de UNO
}

unit Methode_UNO;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type
  TCouleur = (vr, re, bl, j, no);

  TCarte = record
    Couleur: TCouleur;
    Chiffre: Integer;
  end;

  PElementCarte = ^TElementCarte;

  TElementCarte = record
    Carte: TCarte;
    Suivant: PElementCarte;
  end;

  // Un deck sera une pile de cartes
  TDeck = record
    Sommet: PElementCarte;
    Taille: Integer;
  end;

  // Une main sera une liste chaînée de cartes
  TMain = record
    Debut: PElementCarte;
    Taille: Integer;
  end;

{============================== DÉCLARATIONS ==============================}

procedure InitialiserDeck(var Deck: TDeck);
procedure InitialiserMain(var Main: TMain);

procedure AjouterCarteDeck(var Deck: TDeck; Carte: TCarte);
procedure AjouterCarteMain(var Main: TMain; Carte: TCarte);
procedure AjouterCarteFinMain(var Main: TMain; Carte: TCarte);
procedure AjouterPlusieursCartesDeck(var Deck: TDeck; Couleur: TCouleur; Chiffre: Integer; Nombre: Integer);

function GenererDeckUno(var Deck: TDeck): Boolean;
function MelangerDeck(var Deck: TDeck): Boolean;

procedure AfficherCarte(Carte: TCarte);
procedure AfficherMain(Main: TMain);
procedure AfficherDeck(Deck: TDeck);

function CarteEstJouable(Carte: TCarte; CarteVerif: TCarte): Boolean;
function CarteEstJouableAvecCouleurForcee(Carte: TCarte; CarteVerif: TCarte; DerniereCouleurForcee: TCouleur): Boolean;

function PiocherCarte(var Deck: TDeck; var CarteSortie: TCarte): Boolean;
function JouerCarteMain(var Main: TMain; var CarteSortie: TCarte): Boolean;
function Jouerlabonnecarte(var Main: TMain; var CarteSortie: TCarte; var CarteVerif: TCarte): Boolean;
function JouerCarteAvecChoix(var MainJoueur: TMain; var CarteVerif: TCarte; Choix: Integer; var CarteSortie: TCarte): Boolean;
function JouerCartePrioriteNegative(var Main: TMain; var CarteSortie: TCarte; var CarteVerif: TCarte; DerniereCouleurForcee: TCouleur): Boolean;

function CreerMainChoixJouables(var MainJoueur: TMain; var MainChoix: TMain; var CarteVerif: TCarte): Boolean;
function RecupererCarteParNumero(var Main: TMain; Numero: Integer; var CarteSortie: TCarte): Boolean;
function EnleverCarteDeMain(var Main: TMain; CarteAEnlever: TCarte; var CarteSortie: TCarte): Boolean;

procedure EchangerMains(var Main1: TMain; var Main2: TMain);
procedure DetruireMain(var Main: TMain);
procedure DetruireDeck(var Deck: TDeck);

implementation

{============================== INIT ==============================}

procedure InitialiserDeck(var Deck: TDeck);
begin
  Deck.Sommet := nil;
  Deck.Taille := 0;
end;

procedure InitialiserMain(var Main: TMain);
begin
  Main.Debut := nil;
  Main.Taille := 0;
end;

{============================== AJOUTER ==============================}

procedure AjouterCarteDeck(var Deck: TDeck; Carte: TCarte);
var
  Nouveau: PElementCarte;
begin
  New(Nouveau);
  Nouveau^.Carte := Carte;
  Nouveau^.Suivant := Deck.Sommet;
  Deck.Sommet := Nouveau;
  Deck.Taille := Deck.Taille + 1;
end;

procedure AjouterCarteMain(var Main: TMain; Carte: TCarte);
var
  Nouveau: PElementCarte;
begin
  New(Nouveau);
  Nouveau^.Carte := Carte;
  Nouveau^.Suivant := Main.Debut;
  Main.Debut := Nouveau;
  Main.Taille := Main.Taille + 1;
end;

procedure AjouterCarteFinMain(var Main: TMain; Carte: TCarte);
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
      Temp := Temp^.Suivant;

    Temp^.Suivant := Nouveau;
  end;

  Main.Taille := Main.Taille + 1;
end;

procedure AjouterPlusieursCartesDeck(var Deck: TDeck; Couleur: TCouleur; Chiffre: Integer; Nombre: Integer);
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

{============================== GÉNÉRATION / MÉLANGE ==============================}

function GenererDeckUno(var Deck: TDeck): Boolean;
var
  Couleur: TCouleur;
  Chiffre: Integer;
begin
  InitialiserDeck(Deck);

  for Couleur := vr to j do
  begin
    for Chiffre := 1 to 9 do
      AjouterPlusieursCartesDeck(Deck, Couleur, Chiffre, 2);

    AjouterPlusieursCartesDeck(Deck, Couleur, -1, 2);
    AjouterPlusieursCartesDeck(Deck, Couleur, -2, 2);
    AjouterPlusieursCartesDeck(Deck, Couleur, -5, 2);
  end;

  AjouterPlusieursCartesDeck(Deck, no, -3, 4);
  AjouterPlusieursCartesDeck(Deck, no, -4, 4);

  GenererDeckUno := Deck.Taille = 104;
end;

function MelangerDeck(var Deck: TDeck): Boolean;
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

  SetLength(Cartes, Deck.Taille);

  Temp := Deck.Sommet;
  i := 0;

  while Temp <> nil do
  begin
    Cartes[i] := Temp^.Carte;
    Temp := Temp^.Suivant;
    i := i + 1;
  end;

  for i := High(Cartes) downto 1 do
  begin
    j := Random(i + 1);

    CarteTemp := Cartes[i];
    Cartes[i] := Cartes[j];
    Cartes[j] := CarteTemp;
  end;

  DetruireDeck(Deck);

  for i := 0 to High(Cartes) do
    AjouterCarteDeck(Deck, Cartes[i]);

  MelangerDeck := True;
end;

{============================== AFFICHAGE ==============================}

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

{============================== JOUER / PIOCHER ==============================}

function CarteEstJouable(Carte: TCarte; CarteVerif: TCarte): Boolean;
begin
  CarteEstJouable :=
    (Carte.Couleur = CarteVerif.Couleur) or
    (Carte.Chiffre = CarteVerif.Chiffre) or
    (Carte.Couleur = no);
end;

function CarteEstJouableAvecCouleurForcee(Carte: TCarte; CarteVerif: TCarte; DerniereCouleurForcee: TCouleur): Boolean;
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

function PiocherCarte(var Deck: TDeck; var CarteSortie: TCarte): Boolean;
var
  Temp: PElementCarte;
begin
  if Deck.Sommet = nil then
  begin
    PiocherCarte := False;
    Exit;
  end;

  Temp := Deck.Sommet;
  CarteSortie := Temp^.Carte;
  Deck.Sommet := Temp^.Suivant;
  Dispose(Temp);

  Deck.Taille := Deck.Taille - 1;

  PiocherCarte := True;
end;

function JouerCarteMain(var Main: TMain; var CarteSortie: TCarte): Boolean;
var
  Temp: PElementCarte;
begin
  if Main.Debut = nil then
  begin
    JouerCarteMain := False;
    Exit;
  end;

  Temp := Main.Debut;
  CarteSortie := Temp^.Carte;
  Main.Debut := Temp^.Suivant;
  Dispose(Temp);

  Main.Taille := Main.Taille - 1;

  JouerCarteMain := True;
end;

function Jouerlabonnecarte(var Main: TMain; var CarteSortie: TCarte; var CarteVerif: TCarte): Boolean;
var
  Temp, Prec: PElementCarte;
begin
  if Main.Debut = nil then
  begin
    Jouerlabonnecarte := False;
    Exit;
  end;

  Prec := nil;
  Temp := Main.Debut;

  while Temp <> nil do
  begin
    if CarteEstJouable(Temp^.Carte, CarteVerif) then
    begin
      CarteSortie := Temp^.Carte;

      if Prec = nil then
        Main.Debut := Temp^.Suivant
      else
        Prec^.Suivant := Temp^.Suivant;

      Dispose(Temp);
      Main.Taille := Main.Taille - 1;

      Jouerlabonnecarte := True;
      Exit;
    end;

    Prec := Temp;
    Temp := Temp^.Suivant;
  end;

  Jouerlabonnecarte := False;
end;

function JouerCartePrioriteNegative(var Main: TMain; var CarteSortie: TCarte; var CarteVerif: TCarte; DerniereCouleurForcee: TCouleur): Boolean;
var
  Temp, Prec: PElementCarte;
  CarteChoisie, PrecChoisie: PElementCarte;
begin
  CarteChoisie := nil;
  PrecChoisie := nil;

  if Main.Debut = nil then
  begin
    JouerCartePrioriteNegative := False;
    Exit;
  end;

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

  if CarteChoisie = nil then
  begin
    JouerCartePrioriteNegative := False;
    Exit;
  end;

  CarteSortie := CarteChoisie^.Carte;

  if PrecChoisie = nil then
    Main.Debut := CarteChoisie^.Suivant
  else
    PrecChoisie^.Suivant := CarteChoisie^.Suivant;

  Dispose(CarteChoisie);
  Main.Taille := Main.Taille - 1;

  JouerCartePrioriteNegative := True;
end;

{============================== CHOIX JOUEUR ==============================}

function CreerMainChoixJouables(var MainJoueur: TMain; var MainChoix: TMain; var CarteVerif: TCarte): Boolean;
var
  Temp: PElementCarte;
begin
  InitialiserMain(MainChoix);

  Temp := MainJoueur.Debut;

  while Temp <> nil do
  begin
    if CarteEstJouable(Temp^.Carte, CarteVerif) then
      AjouterCarteFinMain(MainChoix, Temp^.Carte);

    Temp := Temp^.Suivant;
  end;

  CreerMainChoixJouables := MainChoix.Taille > 0;
end;

function RecupererCarteParNumero(var Main: TMain; Numero: Integer; var CarteSortie: TCarte): Boolean;
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

function EnleverCarteDeMain(var Main: TMain; CarteAEnlever: TCarte; var CarteSortie: TCarte): Boolean;
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
        Main.Debut := Temp^.Suivant
      else
        Prec^.Suivant := Temp^.Suivant;

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

function JouerCarteAvecChoix(var MainJoueur: TMain; var CarteVerif: TCarte; Choix: Integer; var CarteSortie: TCarte): Boolean;
var
  MainChoix: TMain;
  CarteChoisie: TCarte;
begin
  if not CreerMainChoixJouables(MainJoueur, MainChoix, CarteVerif) then
  begin
    JouerCarteAvecChoix := False;
    Exit;
  end;

  if not RecupererCarteParNumero(MainChoix, Choix, CarteChoisie) then
  begin
    DetruireMain(MainChoix);
    JouerCarteAvecChoix := False;
    Exit;
  end;

  if EnleverCarteDeMain(MainJoueur, CarteChoisie, CarteSortie) then
  begin
    DetruireMain(MainChoix);
    JouerCarteAvecChoix := True;
    Exit;
  end;

  DetruireMain(MainChoix);
  JouerCarteAvecChoix := False;
end;

{============================== MÉMOIRE / UTILITAIRES ==============================}

procedure EchangerMains(var Main1: TMain; var Main2: TMain);
var
  Temp: TMain;
begin
  Temp := Main1;
  Main1 := Main2;
  Main2 := Temp;
end;

procedure DetruireMain(var Main: TMain);
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

procedure DetruireDeck(var Deck: TDeck);
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

end.
