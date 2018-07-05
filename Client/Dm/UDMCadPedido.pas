unit UDMCadPedido;

interface

uses
  System.SysUtils,
  System.Classes,
  UDMPaiCadastro,
  Data.DB,
  Datasnap.DBClient,
  Datasnap.DSConnect,
  Dialogs,
  //---//
  ClassPedido,
  ClassPedido_Item,
  ClassPedido_Prazos,
  ClassPessoa_Endereco,
  UDMConexao,
  ClassPessoa, ClassSituacao;

type
  TDMCadPedido = class(TDMPaiCadastro)
    CDSPedido_Prazos: TClientDataSet;
    CDSPedido_Item: TClientDataSet;
    CDSPedido_PessoaEndereco: TClientDataSet;
    CloneCDSPedido_Item: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure CDSPedido_ItemBeforePost(DataSet: TDataSet);
    procedure CDSPedido_PrazosBeforePost(DataSet: TDataSet);
    procedure CDSCadastroAfterOpen(DataSet: TDataSet);
    procedure CDSCadastroBeforePost(DataSet: TDataSet);
    procedure CDSPedido_ItemAfterOpen(DataSet: TDataSet);
    procedure CDSPedido_ItemAfterPost(DataSet: TDataSet);
    procedure CDSPedido_ItemAfterDelete(DataSet: TDataSet);
    procedure CDSCadastroNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
    FlagCalculandoValores: Boolean;
    FClassPedido_Prazos:   TClassPedido_Prazos;
    FClassPedido_Item:     TClassPedido_Item;

    procedure CarregaEndereco(Codigo: Integer);
    procedure CalcularValorPedidoItem;
    procedure TotalizaPedido;

    //--Validates
    procedure ValidateCDSCadastro_PESSOA(Sender: TField);
    procedure ValidateCDSCadastro_DESCONTOPERC(Sender: TField);
    procedure ValidateCDSCadastro_DESCONTOVLR(Sender: TField);
    procedure ValidateCDSCadastro_SITUACAO(Sender: TField);
    procedure ValidateCDSPedidoItem_QTD_VLRBRUTO(Sender: TField);
    procedure ValidateCDSPedidoItem_CODIGO_ITEM(Sender: TField);

  public
    { Public declarations }
  end;

var
  DMCadPedido: TDMCadPedido;

implementation

uses
  ClassHelper, ClassItem, Constantes;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMCadPedido.CDSCadastroAfterOpen(DataSet: TDataSet);
begin
  inherited;

  CarregaEndereco(CDSCadastro.FieldByName('CODIGO_PESSOA').AsInteger);

  //--Validates--
  CDSCadastro.FieldByName('CODIGO_PESSOA').OnValidate       := ValidateCDSCadastro_PESSOA;
  CDSCadastro.FieldByName('DESCONTOPERC_PEDIDO').OnValidate := ValidateCDSCadastro_DESCONTOPERC;
  CDSCadastro.FieldByName('DESCONTOVLR_PEDIDO').OnValidate  := ValidateCDSCadastro_DESCONTOVLR;
  CDSCadastro.FieldByName('SITUACAO_PEDIDO').OnValidate     := ValidateCDSCadastro_SITUACAO;

  //Abre os DataSetsDetalhe ***Deprecated***
  //AbreFilhos;
end;

procedure TDMCadPedido.CDSCadastroBeforePost(DataSet: TDataSet);
begin
  inherited;
  if CDSCadastro.FieldByName('VLRDESCONTO_PEDIDO').Value
    > CDSCadastro.FieldByName('VLRBRUTO_PEDIDO').Value then
  begin
    ShowMessage('O Valor de Desconto não pode ser maior que o Valor Bruto do Pedido!');
    Abort;
  end;
end;

procedure TDMCadPedido.CDSCadastroNewRecord(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('TIPO_PEDIDO').AsInteger := 0;
  DataSet.FieldByName('CONDICAOPAG_PEDIDO').AsInteger := 0;
end;

procedure TDMCadPedido.CDSPedido_ItemAfterDelete(DataSet: TDataSet);
begin
  inherited;
  CDSCadastro.Edit;
  TotalizaPedido;
end;

procedure TDMCadPedido.CDSPedido_ItemAfterOpen(DataSet: TDataSet);
begin
  inherited;
  CloneCDSPedido_Item.CloneCursor(CDSPedido_Item, True);
  CDSPedido_Item.FieldByName('QTD_PEDITEM').OnValidate          := ValidateCDSPedidoItem_QTD_VLRBRUTO;
  CDSPedido_Item.FieldByName('VLRUNITBRUTO_PEDITEM').OnValidate := ValidateCDSPedidoItem_QTD_VLRBRUTO;
  CDSPedido_Item.FieldByName('CODIGO_ITEM').OnValidate          := ValidateCDSPedidoItem_CODIGO_ITEM;
  end;


procedure TDMCadPedido.CDSPedido_ItemAfterPost(DataSet: TDataSet);
begin
  inherited;
  TotalizaPedido;
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

  with DataSet, TClassPedido_Prazos do
  begin

    if (UpdateStatus = usInserted) and
        ((FieldByName(CampoChave).IsNull)) then
      FieldByName(CampoChave).AsInteger := DMConexao.ProximoCodigo(TabelaPrincipal);

    if ((FieldByName('DIAS_PEDPRAZO').AsInteger <> 0) or
        (not FieldByName('DIAS_PEDPRAZO').IsNull)) then
    begin
      FieldByName('VENCIMENTO_PEDPRAZO').AsDateTime := CDSCadastro.FieldByName('DTEMISSAO_PEDIDO').AsDateTime +
                                                         FieldByName('DIAS_PEDPRAZO').AsInteger;
    end else
    begin
      ShowMessage('Não é permitido atribuir Prazo 0!');
      Cancel;
      Delete;
      Abort;
    end;
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

  CDSPedido_Prazos.DataSetField := TDataSetField(CDSCadastro.FieldByName('SQLDSPedido_Prazos'));
  CDSPedido_Prazos.AdicionarCampos;
  FClassPedido_Prazos.ConfigurarPropriedadesDoCampo(CDSPedido_Prazos);
  CDSPedido_Prazos.ConfigurarProviderFlags([TClassPedido_Item.CampoChave]);

  CDSPedido_Item.DataSetField := TDataSetField(CDSCadastro.FieldByName('SQLDSPedido_Item'));
  CDSPedido_Item.AdicionarCampos;
  FClassPedido_Item.ConfigurarPropriedadesDoCampo(CDSPedido_Item);
  CDSPedido_Item.ConfigurarProviderFlags([TClassPedido_Item.CampoChave]);

  // Flags
  FlagCalculandoValores := False;
end;


procedure TDMCadPedido.ValidateCDSPedidoItem_CODIGO_ITEM(Sender: TField);
begin
  ValidateDescricao(Sender.AsInteger, TClassItem, ['REFERENCIA_ITEM', 'DESCRICAO_ITEM', 'UNIDADE_ITEM'], CDSPedido_Item);
end;

procedure TDMCadPedido.ValidateCDSPedidoItem_QTD_VLRBRUTO(Sender: TField);
begin
  CalcularValorPedidoItem;
end;

procedure TDMCadPedido.ValidateCDSCadastro_DESCONTOPERC(Sender: TField);
begin
  if ((CDSCadastro.FieldByName('DESCONTOPERC_PEDIDO').Value < 0)
  or (CDSCadastro.FieldByName('DESCONTOPERC_PEDIDO').Value > 100)) then
  begin
    ShowMessage('O Percentual de Desconto deve estar entre 0 e 100!');
    Abort;
  end;

  TotalizaPedido;
end;
procedure TDMCadPedido.ValidateCDSCadastro_DESCONTOVLR(Sender: TField);
begin
  TotalizaPedido;
end;

procedure TDMCadPedido.CalcularValorPedidoItem;
begin
  CDSPedido_item.FieldByName('VLRTOTBRUTO_PEDITEM').AsCurrency   := CDSPedido_item.FieldByName('VLRUNITBRUTO_PEDITEM').AsCurrency *
                                                                    CDSPedido_item.FieldByName('QTD_PEDITEM').AsCurrency;

  CDSPedido_Item.FieldByName('VLRUNITLIQUIDO_PEDITEM').AsCurrency := (CDSPedido_Item.FieldByName('VLRUNITBRUTO_PEDITEM').AsCurrency -
                                                                      ((CDSPedido_Item.FieldByName('VLRUNITBRUTO_PEDITEM').AsCurrency *
                                                                        CDSCadastro.FieldByName('DESCONTOPERC_PEDIDO').AsCurrency) / 100));

  CDSPedido_Item.FieldByName('VLRTOTLIQUIDO_PEDITEM').AsCurrency := CDSPedido_Item.FieldByName('VLRUNITLIQUIDO_PEDITEM').AsCurrency *
                                                                      CDSPedido_Item.FieldByName('QTD_PEDITEM').AsCurrency;

  CDSPedido_Item.FieldByName('VLRTOTBRUTO_PEDITEM').AsCurrency := CDSPedido_Item.FieldByName('VLRUNITBRUTO_PEDITEM').AsCurrency *
                                                                    CDSPedido_Item.FieldByName('QTD_PEDITEM').AsCurrency;


end;

procedure TDMCadPedido.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FClassPedido_Prazos.Free;
  CDSPedido_Prazos.Close;

  FClassPedido_Item.Free;
  CDSPedido_Item.Close;
end;

procedure TDMCadPedido.ValidateCDSCadastro_PESSOA(Sender: TField);
begin
  ValidateDescricao(Sender.AsInteger, TClassPessoa, CDSCadastro);
  CarregaEndereco(Sender.AsInteger);
end;

procedure TDMCadPedido.ValidateCDSCadastro_SITUACAO(Sender: TField);
begin
  ValidateDescricao(Sender.AsInteger, TClassSituacao, ['DESCRICAO_SITUACAO'], CDSCadastro);
end;

procedure TDMCadPedido.TotalizaPedido;
var
  TotalBruto, TotalDesconto, TotalLiquido: Currency;
begin
  if FlagCalculandoValores then
    Exit;

  FlagCalculandoValores := True;
  try
    TotalBruto    := 0;
    TotalDesconto := 0;
    TotalLiquido  := 0;

    CloneCDSPedido_Item.First;
    while not CloneCDSPedido_Item.Eof do
    begin
      // Calculando Valores Pedido_Item
      TotalLiquido := (CloneCDSPedido_Item.FieldByName('VLRTOTBRUTO_PEDITEM').AsCurrency -
                      ((CloneCDSPedido_Item.FieldByName('VLRTOTBRUTO_PEDITEM').AsCurrency *
                       CDSCadastro.FieldByName('DESCONTOPERC_PEDIDO').AsCurrency) / 100));

      // Calculando Valores Pedido
      TotalBruto    := TotalBruto + CloneCDSPedido_Item.FieldByName('VLRTOTBRUTO_PEDITEM').AsCurrency;
      TotalDesconto := TotalDesconto + ((CloneCDSPedido_Item.FieldByName('VLRTOTBRUTO_PEDITEM').AsCurrency *
                                         CDSCadastro.FieldByName('DESCONTOPERC_PEDIDO').AsCurrency) / 100);

      CloneCDSPedido_Item.Next;
    end;

    // Atribuindo Totalização do Pedido para os DBEdit
    TotalDesconto := TotalDesconto + CDSCadastro.FieldByName('DESCONTOVLR_PEDIDO').AsCurrency;;
    CDSCadastro.FieldByName('VLRBRUTO_PEDIDO').AsCurrency    := TotalBruto;
    CDSCadastro.FieldByName('VLRDESCONTO_PEDIDO').AsCurrency := TotalDesconto;
    CDSCadastro.FieldByName('VLRLIQUIDO_PEDIDO').AsCurrency  := TotalBruto - TotalDesconto;
  finally
    FlagCalculandoValores := False;
  end;
end;

procedure TDMCadPedido.CarregaEndereco(Codigo: Integer);
begin
  with CDSPedido_PessoaEndereco, TClassPessoa_Endereco do
  begin
    Close;
    Data := DMConexao.ExecuteReader(SQLBaseConsulta + ' WHERE PESSOA_ENDERECO.CODIGO_PESSOA = ' + IntToStr(Codigo));
    Open;
    First;

    if CDSCadastro.State in [dsInsert, dsEdit] then
      CDSCadastro.FieldByName('CODIGO_ENDERECO').AsInteger := CDSPedido_PessoaEndereco.FieldByName('CODIGO_ENDERECOPESSOA').AsInteger;
  end;
end;

end.
