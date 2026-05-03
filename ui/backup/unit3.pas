unit Unit3;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Grids, Buttons;

type

  { TForm3 }

  TForm3 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
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
    procedure FormCreate(Sender: TObject);
    procedure placerUneCarte ;



  private

  public

  end;

var
  Form3: TForm3;

implementation

uses Unit2, Unit1 ;

{$R *.lfm}

{ TForm3 }
var
  UNO : TBitmap ;
  nCarte, DeckN1, DeckP : integer ;
  CarteW, CarteH : integer ;


procedure TForm3.FormCreate(Sender: TObject);
begin
  Form3.WindowState := wsFullScreen;
  DeckN1 := 0;
  DeckP := 0;
  randomize;
end;

procedure TForm3.Button1Click(Sender: TObject);
var
  SrcRect, DestRect : TRect ;
  scale : LongInt;
  CarteInfoC : integer ;
  CarteInfoN : integer ;
  c, n, i : integer ;
begin

  UNO := TBitmap.Create ;
  UNO.LoadFromFile('C:\Users\User\Documents\clone\projetL2\ui\Uno_cards_v3.bmp');
  CarteW := UNO.Width div 13 ;
  CarteH := UNO.Height div 5 ;

  for i := 0 to i 6 do
  begin
    scale := 50;
  CarteInfoC := random(4) ;
  CarteInfoN := random(12) ;
  if (CarteInfoC = 12) and (CarteInfoN = 0) then
  begin
    CarteInfoC := random(4) ;
    CarteInfoN := random(12) ;
  end;
  c := CarteInfoC ;
  n := CarteInfoN ;

  SrcRect := Rect(n * CarteW, c * CarteH, (n + 1) * CarteW, (c + 1) * CarteH);
  DestRect := Rect(DeckN1 * 55, 1, DeckN1 * 55 + round(scale*1), 1 + round(scale*1.55));
  PaintBox3.Canvas.CopyRect(DestRect, UNO.Canvas, SrcRect);
  DeckN1 := DeckN1 + 1;

  CarteInfoC := random(4) ;
  CarteInfoN := random(12) ;
  if (CarteInfoC = 12) and (CarteInfoN = 0) then
  begin
    CarteInfoC := random(4) ;
    CarteInfoN := random(12) ;
  end;
  c := CarteInfoC ;
  n := CarteInfoN ;
  scale := 100 ;
  SrcRect := Rect(n * CarteW, c * CarteH, (n + 1) * CarteW, (c + 1) * CarteH);
  DestRect := Rect(DeckP * 110, 1, DeckP * 110 + round(scale*1), 1 + round(scale*1.55));
  PaintBox1.Canvas.CopyRect(DestRect, UNO.Canvas, SrcRect);
  DeckP := DeckP + 1;
  end;


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

