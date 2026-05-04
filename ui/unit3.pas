{
 Auteur      : LEE LOPES Rui, BENBEKHTI MELIANI Nadir
 CompteGit : RuiLEELOPES, DarvogGit
 Date        : 04/05/2026
 Description :
}

unit Unit3;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Grids, Buttons, Methode_UNO;  // utilisation de Methode_UNO
Type

  { TForm3 }

  TForm3 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    PaintBox1: TPaintBox;
    PaintBox2: TPaintBox;
    PaintBox3: TPaintBox;
    PaintBox4: TPaintBox;
    PaintBox5: TPaintBox;
    PaintBox6: TPaintBox;
    PaintBox7: TPaintBox;
    PaintBox8: TPaintBox;
    PaintBox9: TPaintBox;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;

    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ImageSet ;







  private

  public
    pn : integer ;
    difficulter : integer ;
    temps : integer ;
    tempsUno : integer ;
    DoubleP, CarteS, ObligationP : Boolean ;
    procedure CImage(Carte : TCarte ; var CRect : TRect);
    procedure remplir_main(main : Tmain ; PaintBox : TPaintBox) ;
    Procedure carteVV(Cartex : Tcarte ; PaintBox : TPaintBox);
    procedure Tirer7Carte(var Main: TMain; var Pioche: TDeck);
    procedure EcrireMainDansMemo(Main: TMain; Memo: TMemo);

  end;


var
  Form3: TForm3;
  Ordi1, Ordi2, Ordi3, Ordi4, JHumain : Tmain ;     // Les différents mains
  LeDeck, LeJeter : TDeck ;    //Le deck ou on tire et Le jeter ou on met les cartes déjà jouer.

implementation

uses Unit2, Unit1 ;

{$R *.lfm}

{ TForm3 }
var
  UNO : TBitmap ;
  CarteW, CarteH : integer ;


procedure TForm3.FormCreate(Sender: TObject);
begin
  Form3.WindowState := wsFullScreen;
  Panel2.Hide;
  Panel3.Hide;
  Panel4.Hide;
  ImageSet;
end;

procedure TForm3.FormShow(Sender: TObject);
begin
    if pn = 2 then
  begin
    Panel2.Show;
  end
  else if pn = 3 then
  begin
    Panel2.Show;
    Panel3.Show;
  end
  else if pn = 4 then
  begin
    Panel2.Show;
    Panel3.Show;
    Panel4.Show;
  end;

  if ObligationP = True then
  begin
    Button3.enabled := False ;
  end;
end;


procedure TForm3.ImageSet ;
begin
  UNO := TBitmap.Create ;
  UNO.LoadFromFile('Uno_cards_v3.bmp');
  CarteW := UNO.Width div 13 ;
  CarteH := UNO.Height div 5 ;
end;





procedure TForm3.CImage(Carte : TCarte ; var CRect : TRect);
var
   Couleur, NB : integer ;
begin
  Couleur := Ord(Carte.Couleur);
  Nb := Carte.Chiffre;


  if (Nb < 0) and (Couleur > 0)  then
  begin
    if (Nb = -1) then
    begin
      Nb := 1 ;
    end
    else if (Nb = -2) then
    begin
      Nb := 11 ;
    end
    else if (Nb = -5) then
    begin
      Nb := 12 ;
    end;
  end ;
  if (Nb = 0) then
  begin
    Nb := 10 ;
  end;
  CRect := Rect(Nb * CarteW, Couleur * CarteH, (Nb + 1) * CarteW, (Couleur + 1) * CarteH);

end;

procedure TForm3.remplir_main(main: TMain; PaintBox: TPaintBox);
var
  tempx: PElementCarte;
  SuRect, CoRect: TRect;
  i, Gap: Integer;
begin
  PaintBox.Canvas.Brush.Color := clWhite;
  PaintBox.Canvas.FillRect(PaintBox.ClientRect);

  tempx := main.Debut;
  i := 0;
  Gap := 50;

  while tempx <> nil do
  begin
    CImage(tempx^.Carte, SuRect);

    CoRect := Rect(i * Gap, 0, (i * Gap) + 40, 60);

    PaintBox.Canvas.CopyRect(CoRect, UNO.Canvas, SuRect);

    tempx := tempx^.Suivant;
    i := i + 1;
  end;
end;
procedure TForm3.EcrireMainDansMemo(Main: TMain; Memo: TMemo);
var
  Temp: PElementCarte;
  i: Integer;
begin
  Memo.Clear;

  Temp := Main.Debut;
  i := 1;

  while Temp <> nil do
  begin
    Memo.Lines.Add(
      IntToStr(i) +
      ' - Couleur = ' + IntToStr(Ord(Temp^.Carte.Couleur)) +
      ' | Chiffre = ' + IntToStr(Temp^.Carte.Chiffre)
    );

    Temp := Temp^.Suivant;
    i := i + 1;
  end;

  Memo.Lines.Add('Taille main = ' + IntToStr(Main.Taille));
end;
Procedure TForm3.carteVV(Cartex : Tcarte ; PaintBox : TPaintBox);
var
  SuRect : TRect ;
begin
  SuRect := Rect((1 * 55), 1, (1 * 55) + round(50 * 1), 1 + round(50 * 1.55));
  CImage(Cartex,SuRect);
  PaintBox.Canvas.CopyRect(PaintBox.ClientRect, UNO.Canvas, SuRect);

end;


// fonction de traducteur qui renvoie en array 2
procedure TForm3.Button1Click(Sender: TObject);
var
  CJ: TCarte;
  main : Tmain ;
begin



  CJ.Chiffre := 9;
  CJ.Couleur := re;
  InitialiserMain(main);
  AjouterCarteMain(main, CJ);
  AjouterCarteMain(main, CJ);
  AjouterCarteMain(main, CJ);


  remplir_main(main,  PaintBox1);
  carteVV(CJ, PaintBox3);
end;

procedure TForm3.Tirer7Carte(var Main: TMain; var Pioche: TDeck);
var
  CarteX: TCarte;
  i: Integer;
begin
  for i := 1 to 7 do
  begin
    if PiocherCarte(Pioche, CarteX) then
      AjouterCarteMain(Main, CarteX)
    else
      ShowMessage('Le deck est vide.');
  end;

end;

procedure TForm3.Button2Click(Sender: TObject);
var x : Integer;
begin
  Randomize;
  GenererDeckUno(LeDeck);

  for x := 0 to Random(5) +1 do  //melange plusieur fois
  MelangerDeck(LeDeck);

  // tirer les cepts carte de joueurs. Puis afficher les cartes.

  Tirer7Carte(JHumain,LeDeck);
  remplir_main(JHumain,PaintBox1);
  EcrireMainDansMemo(JHumain,Memo3);

  // vérifier si l'ordinateur est activf, si oui, piochre aussi.
  if panel1.Visible then
  begin
    Tirer7Carte(Ordi1,LeDeck);   //Puis afficher les cartes.
    remplir_main(Ordi1,PaintBox3);
     EcrireMainDansMemo(Ordi1,Memo1);
  end;
  if panel2.Visible then
  begin
    Tirer7Carte(Ordi2,LeDeck);
    remplir_main(Ordi2,PaintBox5);
     EcrireMainDansMemo(Ordi2,Memo2);
  end;
  if panel3.Visible then
  begin
    Tirer7Carte(Ordi3,LeDeck);
    remplir_main(Ordi3,PaintBox7);
  end;
    if panel4.Visible then
  begin
    Tirer7Carte(Ordi4,LeDeck);
    remplir_main(Ordi4,PaintBox9);
  end;
    Button2.Enabled:= False;
end;

procedure TForm3.Button4Click(Sender: TObject);
begin
  Application.Terminate;
  DetruireDeck(LeDeck);
  DetruireDeck(LeJeter);
  DetruireMain(JHumain);
  DetruireMain(ordi1);
  DetruireMain(ordi2);
  DetruireMain(ordi3);
  DetruireMain(ordi4);
end;


end.

