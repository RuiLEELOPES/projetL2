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
  nCarte : integer ;


procedure TForm3.FormCreate(Sender: TObject);
begin
  Form3.WindowState := wsFullScreen;
  nCarte := 0 ;
end;

procedure TForm3.Button1Click(Sender: TObject);
var
  CarteW, CarteH : integer ;
  SrcRect, DestRect : TRect ;
  scale : LongInt;
  CarteInfoC : integer ;
  CarteInfoN : integer ;
begin
  scale := 50;
  UNO := TBitmap.Create ;
  UNO.LoadFromFile('C:\Users\User\Documents\clone\projetL2\ui\Uno_cards_v3.bmp');
  CarteW := UNO.Width div 13 ;
  CarteH := UNO.Height div 5 ;


  CarteInfoC := 3 ;
  CarteInfoN := 5 ;
  SrcRect := Rect(CarteInfoN * CarteW, CarteInfoC * CarteH, (CarteInfoN + 1) * CarteW, (CarteInfoC + 1) * CarteH);
  DestRect := Rect(nCarte * 64, 1, 1 + round(scale*1), 1 + round(scale*1.55));
  PaintBox3.Canvas.CopyRect(DestRect, UNO.Canvas, SrcRect);
  nCarte := 1 ;

  SrcRect := Rect(2 * CarteW, 2 * CarteH, (2 + 1) * CarteW, (2 + 1) * CarteH);
  DestRect := Rect(nCarte * 64, 1, 64 + round(scale*1), 1 + round(scale*1.55));
  PaintBox3.Canvas.CopyRect(DestRect, UNO.Canvas, SrcRect);
  nCarte := 2 ;

  SrcRect := Rect(3 * CarteW, 3 * CarteH, (3 + 1) * CarteW, (3 + 1) * CarteH);
  DestRect := Rect(nCarte * 64, 1, 128 + round(scale*1), 1 + round(scale*1.55));
  PaintBox3.Canvas.CopyRect(DestRect, UNO.Canvas, SrcRect);

end;

end.

