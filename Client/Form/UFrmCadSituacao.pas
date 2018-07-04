unit UFrmCadSituacao;

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
  UDMCadSituacao,
  ClassSituacao,
  UFrmPaiConsulta;

type
  TFrmCadSituacao = class(TFrmPaiCadastro)
    lblDescricao: TLabel;
    dbedtDESCRICAO_SITUACAO: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnPesquisarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadSituacao: TFrmCadSituacao;

implementation

{$R *.dfm}

procedure TFrmCadSituacao.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  FrmPaiConsulta := TFrmPaiConsulta.Create(Self);
  FrmPaiConsulta.Classe := TClassSituacao;
  try
    FrmPaiConsulta.ShowModal;
    edtCodigo.AsInteger := FrmPaiConsulta.Codigo;
    DMCadastro.AbreCasdastro(edtCodigo.AsInteger);
  finally
    FreeAndNil(FrmPaiConsulta);
  end;
end;

procedure TFrmCadSituacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(DMCadSituacao);
end;

procedure TFrmCadSituacao.FormCreate(Sender: TObject);
begin
  DMCadastro := TDMCadSituacao.Create(Self);
  inherited;
end;

procedure TFrmCadSituacao.FormDestroy(Sender: TObject);
begin
  inherited;
  FrmCadSituacao := nil;
end;

initialization

  RegisterClass(TFrmCadSituacao);

end.
