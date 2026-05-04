unit Unit3;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Grids, Buttons;

type
  TCouleur = (vf, re, bl, j, jk);
  TCarte = record
    Couleur: TCouleur;
    Chiffre: Integer;
  end;

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
    procedure placerUneCarte ;




  private

  public
    pn : integer ;
    difficulter : integer ;
    temps : integer ;
    tempsUno : integer ;
    DoubleP, CarteS, ObligationP : Boolean ;
  end;

var
  Form3: TForm3;

implementation

uses Unit2, Unit1 ;

{$R *.lfm}

{ TForm3 }
var
  UNO : TBitmap ;
  nCarte, DeckN1, DeckN2, DeckN3, DeckN4, DeckP : integer ;
  CarteW, CarteH, scale : integer ;
  CRect, VRect : TRect ;


procedure TForm3.FormCreate(Sender: TObject);
begin
  Form3.WindowState := wsFullScreen;
  DeckN1 := 0;
  DeckN2 := 0;
  DeckN3 := 0;
  DeckN4 := 0;
  DeckP := 0;
  randomize;
  Panel2.Hide;
  Panel3.Hide;
  Panel4.Hide;
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


procedure TForm3.Button2Click(Sender: TObject);
begin

end;

procedure TForm3.Button4Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm3.placerUneCarte ;
var
  SrcRect, DestRect : TRect ;
  scale : LongInt;
  CarteInfoC : integer ;
  CarteInfoN : integer ;
  c, n : integer ;
begin
  scale := 50;
  CarteInfoC := 0 ;
  CarteInfoN := 0 ;
  c := CarteInfoC ;
  n := CarteInfoN ;

  SrcRect := Rect(n * CarteW, c * CarteH, (n + 1) * CarteW, (c + 1) * CarteH);
  DestRect := Rect(nCarte * 64, 1, 1 + round(scale*1), 1 + round(scale*1.55));
  PaintBox3.Canvas.CopyRect(DestRect, UNO.Canvas, SrcRect);
  nCarte := nCarte + 1 ;

end;

end.

