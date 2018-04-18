unit UFrmCadItem;

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
  //----//
  UFrmPaiConsulta,
  ClassItem,
  UDMCadItem;

type
  TFrmCadItem = class(TFrmPaiCadastro)
    lblReferenciaItem: TLabel;
    edtReferenciaItem: TDBEdit;
    lblUnidade: TLabel;
    edtUnidadeItem: TDBEdit;
    lblDescricaoItem: TLabel;
    edtDescricaoItem: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadItem: TFrmCadItem;

implementation

{$R *.dfm}

procedure TFrmCadItem.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  FrmPaiConsulta := TFrmPaiConsulta.Create(Self);
  FrmPaiConsulta.Classe := TClassItem;
  try
    FrmPaiConsulta.ShowModal;
    edtCodigo.AsInteger := FrmPaiConsulta.Codigo;
    DMCadastro.AbreCasdastro(edtCodigo.AsInteger);
  finally
    FreeAndNil(FrmPaiConsulta);
  end;
end;

procedure TFrmCadItem.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(DMCadItem);
end;

procedure TFrmCadItem.FormCreate(Sender: TObject);
begin
  DMCadastro := TDMCadItem.Create(Self);
  inherited;
end;

procedure TFrmCadItem.FormDestroy(Sender: TObject);
begin
  inherited;
  FrmCadItem := nil;
end;

initialization

  RegisterClass(TFrmCadItem);

end.
