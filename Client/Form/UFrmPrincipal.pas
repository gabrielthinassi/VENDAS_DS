unit UFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls, Vcl.ComCtrls, UFrmCadItem;

type
  TFrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    mnCadastros: TMenuItem;
    mmStatus: TMenuItem;
    mnUtilitarios: TMenuItem;
    mnConfiguracoes: TMenuItem;
    mmPessoa: TMenuItem;
    mmLancamentos: TMenuItem;
    mmPedido: TMenuItem;
    pnlFundo: TPanel;
    pnlBot: TPanel;
    mmItem: TMenuItem;
    procedure mmStatusClick(Sender: TObject);
    procedure mnConfiguracoesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mmPessoaClick(Sender: TObject);
    procedure mmPedidoClick(Sender: TObject);
    procedure mmItemClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

uses Funcoes, UFrmCadStatus, UFrmConfigServidorAplicacao, UDMConexao, UFrmCadPessoa, UFrmCadPedido;

procedure TFrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(DMConexao);
  Action := caFree;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  DMConexao := TDMConexao.Create(Self);
end;

procedure TFrmPrincipal.mmItemClick(Sender: TObject);
begin
  FrmCadItem := TFrmCadItem(CriaForm(Self, FrmCadItem, TFrmCadItem, False, Sender));
end;

procedure TFrmPrincipal.mmPedidoClick(Sender: TObject);
begin
  FrmCadPedido := TFrmCadPedido(CriaForm(Self, FrmCadPedido, TFrmCadPedido, False, Sender));
end;

procedure TFrmPrincipal.mmPessoaClick(Sender: TObject);
begin
  FrmCadPessoa := TFrmCadPessoa(CriaForm(Self, FrmCadPessoa, TFrmCadPessoa, False, Sender));
end;

procedure TFrmPrincipal.mmStatusClick(Sender: TObject);
begin
  FrmCadStatus := TFrmCadStatus(CriaForm(Self, FrmCadStatus, TFrmCadStatus, False, Sender));
end;

procedure TFrmPrincipal.mnConfiguracoesClick(Sender: TObject);
begin
  FrmConfigServidorAplicacao := TFrmConfigServidorAplicacao(CriaForm(Self, FrmConfigServidorAplicacao, TFrmConfigServidorAplicacao, False, Sender));
end;

end.
