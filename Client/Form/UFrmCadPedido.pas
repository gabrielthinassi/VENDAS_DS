unit UFrmCadPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmPaiCadastro, Vcl.Menus, Data.DB,
  Vcl.ComCtrls, Vcl.Buttons, Vcl.StdCtrls, Vcl.Mask, JvExMask, JvToolEdit,
  JvBaseEdits, Vcl.DBCtrls, Vcl.ExtCtrls, JvDBControls, JvExControls, JvDBLookup,
  Vcl.DBCGrids, Vcl.Grids, Vcl.DBGrids;

type
  TFrmCadPedido = class(TFrmPaiCadastro)
    groupCliente: TGroupBox;
    lblClienteCodigo: TLabel;
    edtClienteCodigo: TJvCalcEdit;
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
    DBGrid1: TDBGrid;
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadPedido: TFrmCadPedido;

implementation

{$R *.dfm}

end.
