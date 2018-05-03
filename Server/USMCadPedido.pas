unit USMCadPedido;

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
  USMPaiCadastro,
  Data.FMTBcd,
  Datasnap.Provider,
  Data.DB,
  Data.SqlExpr,
  //---//
  ClassDataSet,
  ClassPedido,
  ClassPedido_Item,
  ClassPedido_Prazos,
  ClassPessoa_Endereco;

type
  TSMCadPedido = class(TSMPaiCadastro)
    SQLDSPedido_Prazos: TSQLDataSet;
    SQLDSPedido_Item: TSQLDataSet;
    dsLink: TDataSource;
    SQLDSPessoa_Endereco: TSQLDataSet;
    procedure SQLDSPedido_PrazosAfterOpen(DataSet: TDataSet);
    procedure SQLDSPedido_ItemAfterOpen(DataSet: TDataSet);
    procedure SQLDSPessoa_EnderecoAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  protected
    procedure DSServerModuleCreate_Filho(Sender: TObject); override;
  public
    { Public declarations }
  end;

var
  SMCadPedido: TSMCadPedido;

implementation

{$R *.dfm}

{ TSMCadPedido }

procedure TSMCadPedido.DSServerModuleCreate_Filho(Sender: TObject);
begin
  inherited;
  FClasseFilha := TClassPedido;

  SQLDSPedido_Prazos.DataSource   := nil;
  SQLDSPedido_Item.DataSource     := nil;
  SQLDSPessoa_Endereco.DataSource := nil;

  SQLDSPedido_Prazos.CommandText := TClassPedido_Prazos.SQLBaseCadastro;
  TClassPedido_Prazos.CriarParametros(SQLDSPedido_Prazos);
  SQLDSPedido_Prazos.DataSource := dsLink;

  SQLDSPedido_Item.CommandText := TClassPedido_Item.SQLBaseCadastro;
  TClassPedido_Item.CriarParametros(SQLDSPedido_Item);
  SQLDSPedido_Item.DataSource := dsLink;

  SQLDSPessoa_Endereco.CommandText := TClassPessoa_Endereco.SQLBaseCadastro;
  TClassPessoa_Endereco.CriarParametros(SQLDSPessoa_Endereco);
  SQLDSPessoa_Endereco.DataSource := dsLink;



end;

procedure TSMCadPedido.SQLDSPedido_ItemAfterOpen(DataSet: TDataSet);
begin
  inherited;
  SQLDSPedido_Item.ConfigurarProviderFlags([TClassPedido_Item.CampoChave]);
end;

procedure TSMCadPedido.SQLDSPedido_PrazosAfterOpen(DataSet: TDataSet);
begin
  inherited;
  SQLDSPedido_Prazos.ConfigurarProviderFlags([TClassPedido_Prazos.CampoChave]);
end;

procedure TSMCadPedido.SQLDSPessoa_EnderecoAfterOpen(DataSet: TDataSet);
begin
  inherited;
  //SQLDSPessoa_Endereco.ConfigurarProviderFlags([TClassPessoa_Endereco.CampoChave]);

end;

end.
