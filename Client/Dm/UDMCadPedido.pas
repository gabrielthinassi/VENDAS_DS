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
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure CDSPedido_ItemBeforePost(DataSet: TDataSet);
    procedure CDSPedido_PrazosBeforePost(DataSet: TDataSet);
    procedure CDSCadastroAfterOpen(DataSet: TDataSet);
    procedure CDSCadastroBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    FlagCalculandoValores: Boolean;
    FClassPedido_Prazos:   TClassPedido_Prazos;
    FClassPedido_Item:     TClassPedido_Item;

    procedure CarregaEndereco(Codigo: Integer);
    procedure CalculaValores;

    //--Validates
    procedure Validate_PedidoPessoa(Sender: TField);
    procedure Validate_PedidoTipoEndereco(Sender: TField);
    procedure Validate_PedidoValores(Sender: TField);

  public
    { Public declarations }
  end;

var
  DMCadPedido: TDMCadPedido;

implementation

uses
  ClassDataSet;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMCadPedido.CDSCadastroAfterOpen(DataSet: TDataSet);
begin
  inherited;

  CarregaEndereco(CDSCadastro.FieldByName('CODIGO_PESSOA').AsInteger);

  //--Validates--
  CDSCadastro.FieldByName('CODIGO_PESSOA').OnValidate                    := Validate_PedidoPessoa;
  CDSCadastro.FieldByName('DESCONTOPERC_PEDIDO').OnValidate              := Validate_PedidoValores;
  CDSCadastro.FieldByName('DESCONTOVLR_PEDIDO').OnValidate               := Validate_PedidoValores;

  //Abre os DataSetsDetalhe ***Deprecated***
  //AbreFilhos;
end;

procedure TDMCadPedido.CDSCadastroBeforePost(DataSet: TDataSet);
begin
  inherited;

  if ((CDSCadastro.FieldByName('DESCONTOPERC_PEDIDO').Value < 0)
    or (CDSCadastro.FieldByName('DESCONTOPERC_PEDIDO').Value > 100)) then
  begin
    ShowMessage('O Percentual de Desconto deve estar entre 0 e 100!');
    Abort;
  end;

  if CDSCadastro.FieldByName('VLRDESCONTO_PEDIDO').Value
    > CDSCadastro.FieldByName('VLRBRUTO_PEDIDO').Value then
  begin
    ShowMessage('O Valor de Desconto n�o pode ser maior que o Valor Bruto do Pedido!');
    Abort;
  end;

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
  CDSPedido_Item.FieldByName('QTD_PEDITEM').OnValidate                   := Validate_PedidoValores;
  CDSPedido_Item.FieldByName('VLRUNITBRUTO_PEDITEM').OnValidate          := Validate_PedidoValores;
  
  // Flags
  FlagCalculandoValores := False;
end;

procedure TDMCadPedido.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FClassPedido_Prazos.Free;
  CDSPedido_Prazos.Close;

  FClassPedido_Item.Free;
  CDSPedido_Item.Close;
end;

procedure TDMCadPedido.Validate_PedidoValores(Sender: TField);
begin
  CalculaValores;
end;

procedure TDMCadPedido.Validate_PedidoPessoa(Sender: TField);
begin
  ValidateDescricao(Sender.AsInteger, TClassPessoa, CDSCadastro);
  CarregaEndereco(Sender.AsInteger);
end;

procedure TDMCadPedido.Validate_PedidoTipoEndereco(Sender: TField);
begin

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

    CDSPedido_Item.First;
    while not CDSPedido_Item.Eof do
    begin
      if not (CDSPedido_Item.State in [dsEdit, dsInsert]) then
        CDSPedido_Item.Edit;
      // Calculando Valores Pedido_Item
      CDSPedido_item.FieldByName('VLRTOTBRUTO_PEDITEM').AsCurrency   := CDSPedido_item.FieldByName('VLRUNITBRUTO_PEDITEM').AsCurrency *
                                                                        CDSPedido_item.FieldByName('QTD_PEDITEM').AsCurrency;
      CDSPedido_Item.FieldByName('VLRTOTLIQUIDO_PEDITEM').AsCurrency := (CDSPedido_item.FieldByName('VLRTOTBRUTO_PEDITEM').AsCurrency -
                                                                        ((CDSPedido_item.FieldByName('VLRTOTBRUTO_PEDITEM').AsCurrency *
                                                                          CDSCadastro.FieldByName('DESCONTOPERC_PEDIDO').AsCurrency) / 100));
      CDSPedido_Item.FieldByName('VLRUNITLIQUIDO_PEDITEM').AsCurrency := (CDSPedido_Item.FieldByName('VLRUNITBRUTO_PEDITEM').AsCurrency -
                                                                         ((CDSPedido_Item.FieldByName('VLRUNITBRUTO_PEDITEM').AsCurrency *
                                                                           CDSCadastro.FieldByName('DESCONTOPERC_PEDIDO').AsCurrency) / 100));
      // Calculando Valores Pedido
      TotalBruto    := TotalBruto + CDSPedido_item.FieldByName('VLRTOTBRUTO_PEDITEM').AsCurrency;
      TotalDesconto := TotalDesconto + ((CDSPedido_item.FieldByName('VLRTOTBRUTO_PEDITEM').AsCurrency *
                                         CDSCadastro.FieldByName('DESCONTOPERC_PEDIDO').AsCurrency) / 100);

      CDSPedido_Item.Next;
    end;

    // Atribuindo Totaliza��o do Pedido para os DBEdit
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
