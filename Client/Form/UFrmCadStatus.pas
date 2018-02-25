unit UFrmCadStatus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmPaiCadastro, Vcl.DBCtrls,
  Vcl.StdCtrls, Data.DB, Vcl.ComCtrls, Vcl.Buttons, Vcl.Mask, JvExMask,
  JvToolEdit, JvBaseEdits, Vcl.ExtCtrls;

type
  TFrmCadStatus = class(TFrmPaiCadastro)
    lblDescricaoStatus: TLabel;
    edtDescricao: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadStatus: TFrmCadStatus;

implementation

{$R *.dfm}

uses UDMCadStatus;

procedure TFrmCadStatus.FormCreate(Sender: TObject);
begin
  inherited;
  DMCadastro := TDMCadStatus.Create(Self);
  //ProcConsulta := cConsultaStatus;
end;

procedure TFrmCadStatus.FormDestroy(Sender: TObject);
begin
  inherited;
  FrmCadStatus := nil;
end;

initialization

  RegisterClass(TFrmCadStatus);

end.
