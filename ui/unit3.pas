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
    procedure FormShow(Sender: TObject);
    procedure placerUneCarte ;



  private

  public
    pn : integer ;
    difficulter : integer ;
    temps : integer ;
    tempsUno : integer ;
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
  CarteW, CarteH : integer ;


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
  UNO.LoadFromFile('Uno_cards_v3.bmp');
  CarteW := UNO.Width div 13 ;
  CarteH := UNO.Height div 5 ;

  for i := 0 to 6 do
  begin
    scale := 50;
  CarteInfoC := random(4) ;
  CarteInfoN := random(12) ;
  if (CarteInfoC = 12) and (CarteInfoN = 0) or (CarteInfoC = 0) and (CarteInfoN = 0) then
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
  if (CarteInfoC = 12) and (CarteInfoN = 0) or (CarteInfoC = 0) and (CarteInfoN = 0) then
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


  if pn >= 1 then
  begin
  scale := 50;
  CarteInfoC := random(4) ;
  CarteInfoN := random(12) ;
  if (CarteInfoC = 12) and (CarteInfoN = 0) or (CarteInfoC = 0) and (CarteInfoN = 0) then
  begin
    CarteInfoC := random(4) ;
    CarteInfoN := random(12) ;
  end;
  c := CarteInfoC ;
  n := CarteInfoN ;
  SrcRect := Rect(n * CarteW, c * CarteH, (n + 1) * CarteW, (c + 1) * CarteH);
  DestRect := Rect(DeckN2 * 55, 1, DeckN2 * 55 + round(scale*1), 1 + round(scale*1.55));
  PaintBox5.Canvas.CopyRect(DestRect, UNO.Canvas, SrcRect);
  DeckN2 := DeckN2 + 1;
  end;
  if pn >= 2 then
  begin
  scale := 50;
  CarteInfoC := random(4) ;
  CarteInfoN := random(12) ;
  if (CarteInfoC = 12) and (CarteInfoN = 0) or (CarteInfoC = 0) and (CarteInfoN = 0) then
  begin
    CarteInfoC := random(4) ;
    CarteInfoN := random(12) ;
  end;
  c := CarteInfoC ;
  n := CarteInfoN ;
  SrcRect := Rect(n * CarteW, c * CarteH, (n + 1) * CarteW, (c + 1) * CarteH);
  DestRect := Rect(DeckN3 * 55, 1, DeckN3 * 55 + round(scale*1), 1 + round(scale*1.55));
  PaintBox7.Canvas.CopyRect(DestRect, UNO.Canvas, SrcRect);
  DeckN3 := DeckN3 + 1;
  end;
  if pn >= 3 then
  begin
  scale := 50;
  CarteInfoC := random(4) ;
  CarteInfoN := random(12) ;
  if (CarteInfoC = 12) and (CarteInfoN = 0) or (CarteInfoC = 0) and (CarteInfoN = 0) then
  begin
    CarteInfoC := random(4) ;
    CarteInfoN := random(12) ;
  end;
  c := CarteInfoC ;
  n := CarteInfoN ;
  SrcRect := Rect(n * CarteW, c * CarteH, (n + 1) * CarteW, (c + 1) * CarteH);
  DestRect := Rect(DeckN4 * 55, 1, DeckN4 * 55 + round(scale*1), 1 + round(scale*1.55));
  PaintBox9.Canvas.CopyRect(DestRect, UNO.Canvas, SrcRect);
  DeckN4 := DeckN4 + 1;
  end;


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

