unit UFrmCadPedido;

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
  UFrmPaiCadastro,
  Vcl.Menus,
  Data.DB,
  Vcl.ComCtrls,
  Vcl.Buttons,
  Vcl.StdCtrls,
  Vcl.Mask,
  JvExMask,
  JvToolEdit,
  JvBaseEdits,
  Vcl.DBCtrls,
  Vcl.ExtCtrls,
  JvDBControls,
  JvExControls,
  JvDBLookup,
  Vcl.DBCGrids,
  Vcl.Grids,
  Vcl.DBGrids,
  //---//
  UFrmPaiConsulta,
  ClassPedido,
  ClassPedido_Item,
  ClassPedido_Prazos,
  UDMCadPedido,
  ClassPessoa,
  UDMCadPessoa,
  Constantes;

type
  TFrmCadPedido = class(TFrmPaiCadastro)
    groupCliente: TGroupBox;
    lblClienteCodigo: TLabel;
    edtClienteRazao: TDBEdit;
    edtEmissao: TJvDBDateEdit;
    lblEmissao: TLabel;
    groupEndereco: TGroupBox;
    lblRuaEndereco: TLabel;
    cbbEnderecoEntrega: TJvDBLookupCombo;
    lblBairroEndereco: TLabel;
    edtBairroEndereco: TDBEdit;
    edtCepEndereco: TDBEdit;
    lblCepEndereco: TLabel;
    edtNumeroEndereco: TDBEdit;
    lblNumeroEndereco: TLabel;
    lblCidadeEndereco: TLabel;
    edtCidadeEndereco: TDBEdit;
    lblTipoEndereco: TLabel;
    edtTipoEndereco: TDBEdit;
    edtUfEndereco: TDBEdit;
    lblUfEndereco: TLabel;
    gridPedido_Item: TDBGrid;
    groupNegociacao: TGroupBox;
    ctrlgrdPrazos: TDBCtrlGrid;
    rdgrpCondicaoPagamento: TDBRadioGroup;
    lblPedidoConsultor: TLabel;
    lblPrazoPedido: TLabel;
    lblDescontoPercentual: TLabel;
    lblDescontoValor: TLabel;
    edtDescontoValor: TDBEdit;
    edtPedidoConsultor: TDBEdit;
    edtDescontoPercentual: TDBEdit;
    edtPrazo: TDBEdit;
    rdgrpTipoPedido: TDBRadioGroup;
    DSPedido_Prazos: TDataSource;
    DSPedido_Item: TDataSource;
    DSPessoa_Endereco: TDataSource;
    edtClienteCodigo: TJvDBCalcEdit;
    lblFormaPagamento: TLabel;
    lblTotalBruto: TStaticText;
    lblDesconto: TStaticText;
    lblTotalLiquido: TStaticText;
    edtTotalBruto: TDBEdit;
    edtDesconto: TDBEdit;
    edtTotalLiquido: TDBEdit;
    JvDBNavigator1: TJvDBNavigator;
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtClienteCodigoButtonClick(Sender: TObject);
    procedure gridPedido_ItemDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure gridPedido_ItemColExit(Sender: TObject);
  private
    { Private declarations }
    //FDMPessoa: TDMCadPessoa;
  public
    { Public declarations }
    //property DMPessoa: TDMCadPessoa read FDMPessoa write FDMPessoa;
  end;

var
  FrmCadPedido: TFrmCadPedido;

implementation

uses
  ClassHelper;

{$R *.dfm}

procedure TFrmCadPedido.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  FrmPaiConsulta := TFrmPaiConsulta.Create(Self);
  FrmPaiConsulta.Classe := TClassPedido;
  try
    FrmPaiConsulta.ShowModal;
    edtCodigo.AsInteger := FrmPaiConsulta.Codigo;
    DMCadastro.AbreCasdastro(edtCodigo.AsInteger);
  finally
    FreeAndNil(FrmPaiConsulta);
  end;
end;

procedure TFrmCadPedido.edtClienteCodigoButtonClick(Sender: TObject);
begin
  inherited;
  if not (DMCadastro.CDSCadastro.State in [dsEdit, dsInsert]) then
    DMCadastro.CDSCadastro.Edit;

  FrmPaiConsulta := TFrmPaiConsulta.Create(Self);
  FrmPaiConsulta.Classe := TClassPessoa;
  try
    FrmPaiConsulta.ShowModal;
    DMCadastro.CDSCadastro.FieldByName('CODIGO_PESSOA').AsInteger := FrmPaiConsulta.Codigo;
    //TJvDBCalcEdit(Sender).DataSource.DataSet.FieldByName(TJvDBCalcEdit(Sender).DataField).AsInteger := FrmPaiConsulta.Codigo;
  finally
    FreeAndNil(FrmPaiConsulta);
    Abort;
  end;
end;

procedure TFrmCadPedido.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(DMCadPedido);
end;

procedure TFrmCadPedido.FormCreate(Sender: TObject);
begin
  DMCadastro := TDMCadPedido.Create(Self);
  //DMPessoa   := TDMCadPessoa.Create(Self);

  DSPedido_Prazos.DataSet   := TDMCadPedido(DMCadastro).CDSPedido_Prazos;
  DSPedido_Item.DataSet     := TDMCadPedido(DMCadastro).CDSPedido_Item;

  DSPessoa_Endereco.DataSet := TDMCadPedido(DMCadastro).CDSPedido_PessoaEndereco;
  inherited;
end;

procedure TFrmCadPedido.FormDestroy(Sender: TObject);
begin
  inherited;
  FrmCadPedido := nil;
end;

procedure TFrmCadPedido.FormShow(Sender: TObject);
begin
  inherited;
  with gridPedido_Item do
  begin
    CriarColuna(['CODIGO_ITEM'], cbsEllipsis);
    CriarColuna(['REFERENCIA_ITEM',
                 'DESCRICAO_ITEM',
                 'UNIDADE_ITEM',
                 'QTD_PEDITEM',
                 'VLRUNITBRUTO_PEDITEM',
                 'VLRUNITLIQUIDO_PEDITEM',
                 'VLRTOTBRUTO_PEDITEM',
                 'VLRTOTLIQUIDO_PEDITEM']);
  end;
end;

procedure TFrmCadPedido.gridPedido_ItemColExit(Sender: TObject);
begin
  inherited;
  if TDBGrid(sender).DataSource.DataSet.State in [dsEdit, dsInsert] then
    TDBGrid(sender).DataSource.DataSet.Post;
end;

procedure TFrmCadPedido.gridPedido_ItemDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  if Column.Field.Tag = CampoNaoEditavel then
  begin
    gridPedido_Item.Canvas.Brush.Color := clGradeSomenteLeitura;
    gridPedido_Item.Canvas.FillRect(rect);
    Column.ReadOnly := True;

    gridPedido_Item.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

end.
