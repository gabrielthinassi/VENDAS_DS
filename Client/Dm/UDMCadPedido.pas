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
  ClassPessoa;

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
  private
    { Private declarations }
    FlagCalculandoValores: Boolean;
    FClassPedido_Prazos:   TClassPedido_Prazos;
    FClassPedido_Item:     TClassPedido_Item;

    procedure CarregaEndereco(Codigo: Integer);
    procedure CalcularValorBruto;
    procedure CalculaValores;

    //--Validates
    procedure Validate_PedidoPessoa(Sender: TField);
    procedure Validate_CDSCadastro_DESCONTOPERC_PEDIDO(Sender: TField);
    procedure Validate_CDSCadastro_DESCONTOVLR_PEDIDO(Sender: TField);
    procedure Validate_CDSPedido_Item_QTD_PEDITEM(Sender: TField);
    procedure Validate_CDSPedido_Item_VLRUNITBRUTO_PEDITEM(Sender: TField);
    procedure Validate_CDSPedido_Item_CODIGO_ITEM(Sender: TField);

  public
    { Public declarations }
  end;

var
  DMCadPedido: TDMCadPedido;

implementation

uses
  ClassHelper;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMCadPedido.CDSCadastroAfterOpen(DataSet: TDataSet);
begin
  inherited;

  CarregaEndereco(CDSCadastro.FieldByName('CODIGO_PESSOA').AsInteger);

  //--Validates--
  CDSCadastro.FieldByName('CODIGO_PESSOA').OnValidate       := Validate_PedidoPessoa;
  CDSCadastro.FieldByName('DESCONTOPERC_PEDIDO').OnValidate := Validate_CDSCadastro_DESCONTOPERC_PEDIDO;
  CDSCadastro.FieldByName('DESCONTOVLR_PEDIDO').OnValidate  := Validate_CDSCadastro_DESCONTOVLR_PEDIDO;

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

procedure TDMCadPedido.CDSPedido_ItemAfterOpen(DataSet: TDataSet);
begin
  inherited;
  CloneCDSPedido_Item.CloneCursor(CDSPedido_Item, True);
  CDSPedido_Item.FieldByName('QTD_PEDITEM').OnValidate          := Validate_CDSPedido_Item_QTD_PEDITEM;
  CDSPedido_Item.FieldByName('VLRUNITBRUTO_PEDITEM').OnValidate := Validate_CDSPedido_Item_VLRUNITBRUTO_PEDITEM;
  CDSPedido_Item.FieldByName('CODIGO_ITEM').OnValidate          := Validate_CDSPedido_Item_CODIGO_ITEM;
  end;


procedure TDMCadPedido.CDSPedido_ItemAfterPost(DataSet: TDataSet);
begin
  inherited;
  CalculaValores;
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

  CDSPedido_Prazos.DataSetField := TDataSetField(CDSCadastro.FieldByName('SQLDSPedido_Prazos'));
  CDSPedido_Prazos.AdicionarCampos;
  FClassPedido_Prazos.ConfigurarPropriedadesDoCampo(CDSPedido_Prazos);

  CDSPedido_Item.DataSetField := TDataSetField(CDSCadastro.FieldByName('SQLDSPedido_Item'));
  CDSPedido_Item.AdicionarCampos;
  FClassPedido_Item.ConfigurarPropriedadesDoCampo(CDSPedido_Item);

  // Flags
  FlagCalculandoValores := False;
end;


procedure TDMCadPedido.Validate_CDSPedido_Item_CODIGO_ITEM(Sender: TField);
begin
  ValidateCampos(Sender.AsInteger, TClassPedido_Item, CDSPedido_Item);
end;

procedure TDMCadPedido.Validate_CDSPedido_Item_QTD_PEDITEM(Sender: TField);
begin
  CalcularValorBruto;
end;
procedure TDMCadPedido.Validate_CDSPedido_Item_VLRUNITBRUTO_PEDITEM(Sender: TField);
begin
  CalcularValorBruto;
end;
procedure TDMCadPedido.Validate_CDSCadastro_DESCONTOPERC_PEDIDO(Sender: TField);
begin
  if ((CDSCadastro.FieldByName('DESCONTOPERC_PEDIDO').Value < 0)
  or (CDSCadastro.FieldByName('DESCONTOPERC_PEDIDO').Value > 100)) then
  begin
    ShowMessage('O Percentual de Desconto deve estar entre 0 e 100!');
    Abort;
  end;

  CalculaValores;
end;
procedure TDMCadPedido.Validate_CDSCadastro_DESCONTOVLR_PEDIDO(Sender: TField);
begin
  CalculaValores;
end;

procedure TDMCadPedido.CalcularValorBruto;
begin
  CDSPedido_item.FieldByName('VLRTOTBRUTO_PEDITEM').AsCurrency   := CDSPedido_item.FieldByName('VLRUNITBRUTO_PEDITEM').AsCurrency *
                                                                      CDSPedido_item.FieldByName('QTD_PEDITEM').AsCurrency;
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

procedure TDMCadPedido.CalculaValores;
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
      if not (CloneCDSPedido_Item.State in [dsEdit, dsInsert]) then
        CloneCDSPedido_Item.Edit;

      // Calculando Valores Pedido_Item
      CloneCDSPedido_Item.FieldByName('VLRUNITLIQUIDO_PEDITEM').AsCurrency := (CloneCDSPedido_Item.FieldByName('VLRUNITBRUTO_PEDITEM').AsCurrency -
                                                                         ((CloneCDSPedido_Item.FieldByName('VLRUNITBRUTO_PEDITEM').AsCurrency *
                                                                           CDSCadastro.FieldByName('DESCONTOPERC_PEDIDO').AsCurrency) / 100));
      CloneCDSPedido_Item.FieldByName('VLRTOTLIQUIDO_PEDITEM').AsCurrency := (CloneCDSPedido_Item.FieldByName('VLRTOTBRUTO_PEDITEM').AsCurrency -
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
  end;
end;

end.
