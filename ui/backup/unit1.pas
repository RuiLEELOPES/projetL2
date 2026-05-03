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
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

uses Unit2 ;

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

end.

