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
  UDMCadPessoa;

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
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtClienteCodigoButtonClick(Sender: TObject);
  private
    { Private declarations }
    FDMPessoa: TDMCadPessoa;
  public
    { Public declarations }
    property DMPessoa: TDMCadPessoa read FDMPessoa write FDMPessoa;
  end;

var
  FrmCadPedido: TFrmCadPedido;

implementation

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
  FrmPaiConsulta := TFrmPaiConsulta.Create(Self);
  FrmPaiConsulta.Classe := TClassPessoa;
  try
    FrmPaiConsulta.ShowModal;
    edtClienteCodigo.AsInteger := FrmPaiConsulta.Codigo;
    DMCadastro.AbreCasdastro(edtClienteCodigo.AsInteger);
  finally
    Abort;
    FreeAndNil(FrmPaiConsulta);
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
  DMPessoa   := TDMCadPessoa.Create(Self);
  DSPedido_Prazos.DataSet   := TDMCadPedido(DMCadastro).CDSPedido_Prazos;
  DSPedido_Item.DataSet     := TDMCadPedido(DMCadastro).CDSPedido_Item;
  DSPessoa_Endereco.DataSet := TDMCadPessoa(DMPessoa).CDSPessoa_Endereco;

  inherited;
end;

procedure TFrmCadPedido.FormDestroy(Sender: TObject);
begin
  inherited;
  FrmCadPedido := nil;
end;

end.
