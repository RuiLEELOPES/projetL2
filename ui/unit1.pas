{
 Auteur      : LEE LOPES Rui
 CompteGit : RuiLEELOPES
 Date        : 04/05/2026
 Description :
}


unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

uses Unit2, Unit5,  Methode_UNO ;

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  Form1.WindowState := wsFullScreen; ;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  form2.show;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Form4.Show;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Application.Terminate ;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  Deck : TDeck ;
  temps : PElementCarte ;
  i : integer ;
begin
  i := 0;
  InitialiserDeck(Deck);
  GenererDeckUno(Deck);
  temps := Deck.Sommet ;
  while temps <> nil do
  begin
    memo1.lines.Append(IntToStr(i) + ' - ');

    memo1.lines.append('Couleur = ' + IntToStr(Ord(temps^.Carte.Couleur)) + ' | Chiffre = ' + IntToStr(temps^.Carte.Chiffre));

    temps := temps^.Suivant;
    i := i + 1;
  end;

  memo1.lines.append('Taille deck = ' + IntToStr(Deck.Taille));
end;

end.

