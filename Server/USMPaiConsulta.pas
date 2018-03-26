unit USMPaiConsulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, USMPai, Data.FMTBcd, Datasnap.Provider,
  Data.DB, Data.SqlExpr;

type
  TSMPaiConsulta = class(TSMPai)
    SQLDSConsulta: TSQLDataSet;
    DSPConsulta: TDataSetProvider;
    procedure DSServerModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SMPaiConsulta: TSMPaiConsulta;

implementation

uses
  USMConexao;

{$R *.dfm}

procedure TSMPaiConsulta.DSServerModuleCreate(Sender: TObject);
begin
  inherited;
  SQLDSConsulta.SQLConnection := SMConexao.ConexaoBD;
end;

end.
