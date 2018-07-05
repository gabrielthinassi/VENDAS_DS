unit USMCadPessoa;

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
  Data.FMTBcd,
  Data.DB,
  Datasnap.Provider,
  Data.SqlExpr,
  USMPaiCadastro,
  //-------------------//
  ClassHelper,
  ClassPessoa,
  ClassPessoa_Endereco;

type
  TSMCadPessoa = class(TSMPaiCadastro)
    dsLink: TDataSource;
    SQLDSPessoa_Endereco: TSQLDataSet;
    procedure SQLDSPessoa_EnderecoAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  protected
    procedure DSServerModuleCreate_Filho(Sender: TObject); override;
  public
    { Public declarations }
  end;

var
  SMCadPessoa: TSMCadPessoa;

implementation

{$R *.dfm}

{ TSMCadPessoa }

procedure TSMCadPessoa.DSServerModuleCreate_Filho(Sender: TObject);
begin
  inherited;
  FClasseFilha := TClassPessoa;

  SQLDSPessoa_Endereco.CommandText := TClassPessoa_Endereco.SQLBaseCadastro;
  TClassPessoa_Endereco.CriarParametros(SQLDSPessoa_Endereco);
  SQLDSPessoa_Endereco.DataSource := dsLink;
end;

procedure TSMCadPessoa.SQLDSPessoa_EnderecoAfterOpen(DataSet: TDataSet);
begin
  inherited;
  TClassPessoa_Endereco.ConfigurarPropriedadesDoCampo(SQLDSPessoa_Endereco);
  SQLDSPessoa_Endereco.ConfigurarProviderFlags([TClassPessoa_Endereco.CampoChave]);

  {with FClasseFilha, DataSet do
    begin
      ConfigurarProviderFlags([CampoChave]);
    end;
  }
end;

end.
