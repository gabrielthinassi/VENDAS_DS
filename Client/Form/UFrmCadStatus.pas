unit UFrmCadStatus;

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
  Vcl.DBCtrls,
  Vcl.StdCtrls,
  Data.DB,
  Vcl.ComCtrls,
  Vcl.Buttons,
  Vcl.Mask,
  JvExMask,
  JvToolEdit,
  JvBaseEdits,
  Vcl.ExtCtrls,
  //-------------------//
  UDMCadStatus,
  ClassStatus,
  UFrmPaiConsulta;

type
  TFrmCadStatus = class(TFrmPaiCadastro)
    lblDescricaoStatus: TLabel;
    edtDescricao: TDBEdit;
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
  FrmCadStatus: TFrmCadStatus;

implementation

{$R *.dfm}

procedure TFrmCadStatus.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  FrmPaiConsulta := TFrmPaiConsulta.Create(Self);
  FrmPaiConsulta.FClasse := TClassStatus;
  FrmPaiConsulta.ShowModal;
  DMCadStatus.AbreCasdastro(FrmPaiConsulta.Codigo);
  edtCodigo.AsInteger := FrmPaiConsulta.Codigo;
  FreeAndNil(FrmPaiConsulta);
end;

procedure TFrmCadStatus.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(DMCadStatus);
end;

procedure TFrmCadStatus.FormCreate(Sender: TObject);
begin
  DMCadastro := TDMCadStatus.Create(Self);
  inherited;
end;

procedure TFrmCadStatus.FormDestroy(Sender: TObject);
begin
  inherited;
  FrmCadStatus := nil;
end;

initialization

  RegisterClass(TFrmCadStatus);

end.
