unit UFrmCadPessoa;

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
  Data.DB,
  Vcl.ComCtrls,
  Vcl.Buttons,
  Vcl.StdCtrls,
  Vcl.Mask,
  JvExMask,
  JvToolEdit,
  JvBaseEdits,
  Vcl.DBCtrls,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TFrmCadPessoa = class(TFrmPaiCadastro)
    tsPessoa_Endereco: TTabSheet;
    lblRazaoSocial: TLabel;
    edtRazaoSocial: TDBEdit;
    lblNomeFantasia: TLabel;
    edtNomeFantasia: TDBEdit;
    lblEmail: TLabel;
    edtEmail: TDBEdit;
    gbxTipoPessoa: TGroupBox;
    cbxTipoCliente: TDBCheckBox;
    cbxTipoOutros: TDBCheckBox;
    edtCpf: TDBEdit;
    lblCpfCnpj: TLabel;
    edtCnpj: TDBEdit;
    lblRua: TLabel;
    edtRua: TDBEdit;
    lblBairro: TLabel;
    edtBairro: TDBEdit;
    lblCidade: TLabel;
    edtCidade: TDBEdit;
    lblPais: TLabel;
    edtPais: TDBEdit;
    DSPessoa_Endereco: TDataSource;
    edtNumero: TDBEdit;
    lblNumero: TLabel;
    lblCep: TLabel;
    edtCep: TDBEdit;
    edtUf: TDBEdit;
    lblUf: TLabel;
    lblTelefone: TLabel;
    edtTelefone: TDBEdit;
    DBGrid1: TDBGrid;
    rdgFisicaJuridica: TDBRadioGroup;
    rdgTipoEndereco: TDBRadioGroup;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadPessoa: TFrmCadPessoa;

implementation

{$R *.dfm}

end.
