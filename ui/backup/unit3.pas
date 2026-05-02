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

procedure TForm3.FormCreate(Sender: TObject);
begin

end;

procedure TForm3.Button1Click(Sender: TObject);
var
  CarteW, CarteH : integer ;
  SrcRect, DestRect : TRect ;
begin
  UNO := TBitmap.Create ;
  UNO.LoadFromFile('C:\Users\User\Downloads\ui\Uno_cards_v2.bmp');
  CarteW := UNO.Width div 13 ;
  CarteH := UNO.Height div 5 ;
  SrcRect := Rect(2 * CarteW, 1 * CarteH, (2 + 1) * CarteW, (1 + 1) * CarteH);
  DestRect := Rect(70, 50, 70 + CarteW, 50 + CarteH);
  Canvas.CopyRect(DestRect, UNO.Canvas, SrcRect);

end;

end.

