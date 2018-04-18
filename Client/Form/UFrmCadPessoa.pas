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
  Vcl.ExtCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  //---------------------//
  UDMCadPessoa,
  ClassPessoa,
  ClassPessoa_Endereco, Vcl.Menus;

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
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure rdgFisicaJuridicaChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadPessoa: TFrmCadPessoa;

implementation

uses
  UFrmPaiConsulta;

{$R *.dfm}

procedure TFrmCadPessoa.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  FrmPaiConsulta := TFrmPaiConsulta.Create(Self);
  FrmPaiConsulta.Classe := TClassPessoa;
  try
    FrmPaiConsulta.ShowModal;
    edtCodigo.AsInteger := FrmPaiConsulta.Codigo;
    DMCadastro.AbreCasdastro(edtCodigo.AsInteger);
  finally
    FreeAndNil(FrmPaiConsulta);
  end;
end;

procedure TFrmCadPessoa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(DMCadPessoa);
end;

procedure TFrmCadPessoa.FormCreate(Sender: TObject);
begin
  DMCadastro := TDMCadPessoa.Create(Self);
  DSPessoa_Endereco.DataSet := TDMCadPessoa(DMCadastro).CDSPessoa_Endereco;

  inherited;
end;

procedure TFrmCadPessoa.FormDestroy(Sender: TObject);
begin
  inherited;
  FrmCadPessoa := nil;
end;

procedure TFrmCadPessoa.rdgFisicaJuridicaChange(Sender: TObject);
begin
  inherited;
  if rdgFisicaJuridica.ItemIndex = 0 then
  begin
    edtCpf.Visible  := True;
    edtCnpj.Visible := False;
    lblCpfCnpj.Caption := 'CPF';
  end else
  begin
    edtCnpj.Visible := True;
    edtCpf.Visible  := False;
    lblCpfCnpj.Caption := 'CNPJ';
  end;
end;

end.
