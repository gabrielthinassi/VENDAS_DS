unit UDMCadPedido;

interface

uses
  System.SysUtils,
  System.Classes,
  UDMPaiCadastro,
  Data.DB,
  Datasnap.DBClient,
  Datasnap.DSConnect,
  //---//
  ClassPedido,
  ClassPedido_Item,
  ClassPedido_Prazos,
  ClassPessoa_Endereco,
  UDMConexao,
  ClassPessoa;

type
  TDMCadPedido = class(TDMPaiCadastro)
    CDSPedido_Prazos: TClientDataSet;
    CDSPedido_Item: TClientDataSet;
    CDSPedido_PessoaEndereco: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure CDSPedido_ItemBeforePost(DataSet: TDataSet);
    procedure CDSPedido_PrazosBeforePost(DataSet: TDataSet);
    procedure CDSCadastroAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    FClassPedido_Prazos:   TClassPedido_Prazos;
    FClassPedido_Item:     TClassPedido_Item;
    procedure Validate_PedidoPessoa(Sender: TField);
    procedure CarregaEndereco(Codigo: Integer);

  public
    { Public declarations }
    procedure TotalizaPedido;
  end;

var
  DMCadPedido: TDMCadPedido;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMCadPedido.CDSCadastroAfterOpen(DataSet: TDataSet);
begin
  inherited;
  CDSPedido_Prazos.DataSetField := TDataSetField(CDSCadastro.FieldByName('SQLDSPedido_Prazos'));
  FClassPedido_Prazos.ConfigurarPropriedadesDoCampo(CDSPedido_Prazos);

  CDSPedido_Item.DataSetField := TDataSetField(CDSCadastro.FieldByName('SQLDSPedido_Item'));
  FClassPedido_Item.ConfigurarPropriedadesDoCampo(CDSPedido_Item);

  //CDSPedido_PessoaEndereco.DataSetField := TDataSetField(CDSCadastro.FieldByName('SQLDSPessoa_Endereco'));

  //--Validates--
  CDSCadastro.FieldByName('CODIGO_PESSOA').OnValidate := Validate_PedidoPessoa;
  CarregaEndereco(CDSCadastro.FieldByName('CODIGO_PESSOA').AsInteger);

  //Abre os DataSetsDetalhe
  AbreFilhos;
end;

procedure TDMCadPedido.CDSPedido_ItemBeforePost(DataSet: TDataSet);
begin
  inherited;
  with DataSet, TClassPedido_Item do
  begin
    if (UpdateStatus = usInserted) and
        ((FieldByName(CampoChave).IsNull)) then
      FieldByName(CampoChave).AsInteger := DMConexao.ProximoCodigo(TabelaPrincipal);
  end;
end;

procedure TDMCadPedido.CDSPedido_PrazosBeforePost(DataSet: TDataSet);
begin
  inherited;
  inherited;
  with DataSet, TClassPedido_Prazos do
  begin
    if (UpdateStatus = usInserted) and
        ((FieldByName(CampoChave).IsNull)) then
      FieldByName(CampoChave).AsInteger := DMConexao.ProximoCodigo(TabelaPrincipal);
  end;
end;

procedure TDMCadPedido.DataModuleCreate(Sender: TObject);
begin
  FClasseFilha := TClassPedido;

  FClassPedido_Prazos := TClassPedido_Prazos.Create;
  FClassPedido_Item := TClassPedido_Item.Create;

  DSPCCadastro.ServerClassName := 'TSMCadPedido';
  CDSCadastro.ProviderName := 'DSPCCadastro';

  inherited;
end;

procedure TDMCadPedido.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FClassPedido_Prazos.Free;
  CDSPedido_Prazos.Close;

  FClassPedido_Item.Free;
  CDSPedido_Item.Close;
end;

procedure TDMCadPedido.Validate_PedidoPessoa(Sender: TField);
begin
  ValidateDescricao(Sender.AsInteger, TClassPessoa, CDSCadastro);
  CarregaEndereco(Sender.AsInteger);
end;

procedure TDMCadPedido.CarregaEndereco(Codigo: Integer);
begin
  with CDSPedido_PessoaEndereco, TClassPessoa_Endereco do
  begin
    Close;
    Data := DMConexao.ExecuteReader(SQLBaseConsulta + ' WHERE PESSOA_ENDERECO.CODIGO_PESSOA = ' + IntToStr(Codigo));
    Open;
  end;
end;

procedure TDMCadPedido.TotalizaPedido;
var
  TotalBruto, TotalLiquido: Currency;
begin
  TotalBruto      := 0;
  TotalLiquido    := 0;



end;

end.





