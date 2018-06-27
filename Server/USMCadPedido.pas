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
  Datasnap.DbClient,
  Data.DB,
  Data.SqlExpr,
  // ---//
  ClassHelper,
  ClassPedido,
  ClassPedido_Item,
  ClassPedido_Prazos,
  ClassPessoa_Endereco;

type
  TSMCadPedido = class(TSMPaiCadastro)
    SQLDSPedido_Prazos: TSQLDataSet;
    SQLDSPedido_Item: TSQLDataSet;
    dsLink: TDataSource;
    procedure SQLDSPedido_PrazosAfterOpen(DataSet: TDataSet);
    procedure SQLDSPedido_ItemAfterOpen(DataSet: TDataSet);
    procedure DSPCadastroBeforeUpdateRecord(Sender: TObject; SourceDS: TDataSet;
      DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind;
      var Applied: Boolean);
  private
    procedure GetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: String); override;
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

procedure TSMCadPedido.GetTableName(Sender: TObject; DataSet: TDataSet;
  var TableName: String);
begin
  if (DataSet = SQLDSPedido_Item) then
    TableName := TClassPedido_Item.TabelaPrincipal
  else if (DataSet = SQLDSPedido_Prazos) then
    TableName := TClassPedido_Prazos.TabelaPrincipal;
end;

procedure TSMCadPedido.DSPCadastroBeforeUpdateRecord(Sender: TObject;
  SourceDS: TDataSet; DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind;
  var Applied: Boolean);
begin
  inherited;
  if UpdateKind = ukInsert then
  begin
    with SourceDS do
      if SourceDS = SQLDSPedido_Item then
      begin
        Edit;
        FieldByName('CODIGO_PEDIDO').AsInteger := DataSetField.DataSet.FieldByName('CODIGO_PEDIDO').AsInteger;
        post;
      end else
      if SourceDS = SQLDSPedido_Prazos then
      begin
        Edit;
        FieldByName('CODIGO_PEDIDO').AsInteger := DataSetField.DataSet.FieldByName('CODIGO_PEDIDO').AsInteger;
        post;
      end;
  end;
end;

procedure TSMCadPedido.DSServerModuleCreate_Filho(Sender: TObject);
begin
  inherited;
  FClasseFilha := TClassPedido;

  SQLDSPedido_Prazos.DataSource := nil;
  SQLDSPedido_Item.DataSource := nil;

  SQLDSPedido_Prazos.CommandText := TClassPedido_Prazos.SQLBaseCadastro;
  TClassPedido_Prazos.CriarParametros(SQLDSPedido_Prazos);
  SQLDSPedido_Prazos.DataSource := dsLink;

  SQLDSPedido_Item.CommandText := TClassPedido_Item.SQLBaseCadastro;
  TClassPedido_Item.CriarParametros(SQLDSPedido_Item);
  SQLDSPedido_Item.DataSource := dsLink;
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

end.
