unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckGroup1: TCheckGroup;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    ScrollBox1: TScrollBox;
    ScrollBox2: TScrollBox;
    ScrollBox3: TScrollBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form2: TForm2;
  p : integer ;
  OrdiSet : TPanel ;
  OrdiLabel : TLabel ;
  OrdiType : TComboBox ;

implementation

uses Unit1, Unit3 ;

{$R *.lfm}

{ TForm2 }

procedure TForm2.Button1Click(Sender: TObject);

begin
  p := p + 1 ;

  if p = 4 then
  begin
    Button1.enabled := False ;
  end
  else
  begin
    Button2.enabled := True ;
    OrdiSet := TPanel.Create(ScrollBox1) ;
    OrdiSet.Parent := ScrollBox1 ;
    OrdiSet.Height := 48 ;
    OrdiSet.width := 376 ;
    Ordiset.Top := 8 + p*72 ;
    Ordiset.Left := 8 ;

    OrdiLabel := TLabel.Create(OrdiSet) ;
    OrdiLabel.Parent := OrdiSet ;
    OrdiLabel.Left := 16 ;
    OrdiLabel.Top := 8 ;
    OrdiLabel.Caption := 'Joueur ' + IntToStr(p + 1);

    OrdiType := TComboBox.Create(OrdiSet) ;
    OrdiType.Parent := OrdiSet ;
    OrdiType.Height := 28 ;
    OrdiType.width := 144 ;
    OrdiType.Left := 176 ;
    OrdiType.Top := 8 ;
    OrdiType.TextHint := 'choisir une mode' ;
    OrdiType.Items.Add('Passif') ;
    OrdiType.Items.Add('Agressif') ;
    OrdiType.Items.Add('Stratégique') ;

  end;

end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  if p > 0 then
  begin
    ScrollBox1.Controls[ScrollBox1.ControlCount - 1].Free ;
    p := p - 1 ;
    Button1.enabled := True ;
    if p = 1 then
    begin
      Button2.enabled := False ;
      p := 0
    end;
  end;
end;

procedure TForm2.Button3Click(Sender: TObject);
var
  i, j, n : integer ;
  App : boolean ;
  Ctrl : TControl ;
begin
  App := True ;

  if (ComboBox2.ItemIndex = -1) or (ComboBox3.ItemIndex = -1) or (ComboBox4.ItemIndex = -1) then
  begin
    App := False;
  end;

  for i := 0 to p do
  begin
    Ctrl := ScrollBox1.Controls[i];
        if (TComboBox(1 + TPanel(Ctrl).Controls[i]).ItemIndex = -1) then
      begin
        App := False ;
        Break;
      end;
    end;

  if App = False then
  begin
    showmessage('Sélectionner tous les éléments.')
  end
  else
  begin
    Form3.show ;
    n :=  0 ;
    for j := 0 to ScrollBox1.ControlCount - 1 do
    begin
      n := n + 1 ;
    end;

    Form2.hide ;
    Form1.hide ;
    Form3.pn := n ;
  end;


end;



procedure TForm2.FormCreate(Sender: TObject);
begin
  p := 0;
    OrdiSet := TPanel.Create(ScrollBox1) ;
    OrdiSet.Parent := ScrollBox1 ;
    OrdiSet.Height := 48 ;
    OrdiSet.width := 376 ;
    Ordiset.Top := 8 + p*72 ;
    Ordiset.Left := 8 ;

    OrdiLabel := TLabel.Create(OrdiSet) ;
    OrdiLabel.Parent := OrdiSet ;
    OrdiLabel.Left := 16 ;
    OrdiLabel.Top := 8 ;
    OrdiLabel.Caption := 'Joueur ' + IntToStr(p + 1);

    OrdiType := TComboBox.Create(OrdiSet) ;
    OrdiType.Parent := OrdiSet ;
    OrdiType.Height := 28 ;
    OrdiType.width := 144 ;
    OrdiType.Left := 176 ;
    OrdiType.Top := 8 ;
    OrdiType.TextHint := 'choisir une mode' ;
    OrdiType.Items.Add('Passif') ;
    OrdiType.Items.Add('Agressif') ;
    OrdiType.Items.Add('Stratégique') ;


    Combobox2.Items.Add('Fascile') ;
    Combobox2.Items.Add('Normal') ;
    Combobox2.Items.Add('Difficile') ;

    Combobox3.Items.Add('15s') ;
    Combobox3.Items.Add('30s') ;
    Combobox3.Items.Add('60s') ;
    Combobox3.Items.Add('120s') ;

    Combobox4.Items.Add('3s') ;
    Combobox4.Items.Add('5s') ;
    Combobox4.Items.Add('10s') ;
    Combobox4.Items.Add('15s') ;

end;

end.

