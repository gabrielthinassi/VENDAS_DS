unit USMRelatorio;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  USMPai,
  USMConexao,
  Data.DB,
  Data.SqlExpr;

type
  TSMRelatorio = class(TSMPai)
    procedure DSServerModuleCreate(Sender: TObject);
    procedure DSServerModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    //SMConexao: TSMConexao;
    MeuSQLConnection: TSQLConnection;
  public
    { Public declarations }
  end;

var
  SMRelatorio: TSMRelatorio;

implementation

{$R *.dfm}

procedure TSMRelatorio.DSServerModuleCreate(Sender: TObject);
begin
  inherited;
  MeuSQLConnection := SMConexao.ConexaoBD;
end;

procedure TSMRelatorio.DSServerModuleDestroy(Sender: TObject);
begin
  inherited;
  MeuSQLConnection := nil;
end;

end.
