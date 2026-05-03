program Project1;
TYPE
  TCouleur = (vr, ro, bl, j, no);

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
        Debut: PElementCarte;
        Taille: Integer;
      end;
    {==============================DECLARATION==============================}
VAR
  C1,C2,C3,C5,C6,CJ : TCarte;
  c : Integer;
  Deck : TDeck;
  Main : TMain;
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

procedure AjouterPlusieursCartesDeck(
  var Deck: TDeck;
  Couleur: TCouleur;
  Chiffre: Integer;
  Nombre: Integer
);
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

function CarteEstJouable(Carte: TCarte; CarteVerif: TCarte): Boolean;
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
{==============================TEST==============================}

begin
      C1.Chiffre:=9;
      C1.Couleur:= vr;

      C2.Chiffre:=-4;
      C2.Couleur:= no;

      C3.Chiffre:=-2;
      C3.Couleur:= ro;

      C5.Chiffre:= 8;
      C5.Couleur:= bl;

      C6.Chiffre:= 9;
      C6.Couleur:= ro;

      InitialiserDeck(Deck);
      AjouterCarteMain(Main,C1);
      AjouterCarteMain(Main,C2);
      AjouterCarteMain(Main,C3);
      AjouterCarteMain(Main,C1);
      c:= 0;





      readln();


end.

