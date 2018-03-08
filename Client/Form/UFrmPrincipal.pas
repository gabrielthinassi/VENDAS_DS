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
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

uses Funcoes, UFrmCadStatus, UFrmConfigServidorAplicacao, UDMConexao;

procedure TFrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(DMConexao);
  Action := caFree;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  DMConexao := TDMConexao.Create(Self);
end;

procedure TFrmPrincipal.mmStatusClick(Sender: TObject);
begin
  //FrmCadStatus := TFrmCadStatus(CriaForm(Self, FrmCadStatus, TFrmCadStatus, False, Sender));

  FrmCadStatus := TFrmCadStatus.Create(Self);
  FrmCadStatus.ShowModal;
end;

procedure TFrmPrincipal.mnConfiguracoesClick(Sender: TObject);
begin
  FrmConfigServidorAplicacao := TFrmConfigServidorAplicacao(CriaForm(Self, FrmConfigServidorAplicacao, TFrmConfigServidorAplicacao, False, Sender));
end;

end.
