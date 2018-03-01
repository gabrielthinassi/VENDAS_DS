unit UFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TFrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    mnCadastros: TMenuItem;
    mmStatus: TMenuItem;
    mnUtilitarios: TMenuItem;
    mnConfiguracoes: TMenuItem;
    procedure mmStatusClick(Sender: TObject);
    procedure mnConfiguracoesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

uses Funcoes, UFrmCadStatus, UFrmConfigServidorAplicacao;

procedure TFrmPrincipal.mmStatusClick(Sender: TObject);
begin
  FrmCadStatus := TFrmCadStatus(CriaForm(Self, FrmCadStatus, TFrmCadStatus, False, Sender));
end;

procedure TFrmPrincipal.mnConfiguracoesClick(Sender: TObject);
begin
  FrmConfigServidorAplicacao := TFrmConfigServidorAplicacao(CriaForm(Self, FrmConfigServidorAplicacao, TFrmConfigServidorAplicacao, False, Sender));
end;

end.
