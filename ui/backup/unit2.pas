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
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Panel1: TPanel;
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

implementation

uses Unit1, Unit3 ;

{$R *.lfm}

{ TForm2 }

procedure TForm2.Button1Click(Sender: TObject);
var
  OrdiSet : TPanel ;
  OrdiLabel : TLabel ;
  OrdiType : TComboBox ;
begin
  p := p + 1 ;
  if p > 4 then
  begin
    showmessage('impossible d"ajouter un joueur : le max de joueur atteint !')
  end
  else
  begin
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
  end;
end;

procedure TForm2.Button3Click(Sender: TObject);
var
  i : integer ;
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
        if (TComboBox(TPanel(Ctrl).Controls[i]).ItemIndex = -1) then
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
    //Form3.show ;
  end;


end;



procedure TForm2.FormCreate(Sender: TObject);
begin
  p := 0;

    Combobox1.Items.Add('Passif') ;
    Combobox1.Items.Add('Agressif') ;
    Combobox1.Items.Add('Stratégique') ;

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

