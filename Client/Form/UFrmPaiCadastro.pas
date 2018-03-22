unit UFrmPaiCadastro;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.UITypes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  UFrmPai,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Vcl.StdCtrls,
  Vcl.Mask,
  JvExMask,
  JvToolEdit,
  JvBaseEdits,
  Vcl.Buttons,
  Data.DB,
  Vcl.DBCtrls,
  UDMPaiCadastro;

type
  TFrmPaiCadastro = class(TFrmPai)
    pnlBot: TPanel;
    pnlTop: TPanel;
    pnlButtons: TPanel;
    edtCodigo: TJvCalcEdit;
    btnRelatorio: TSpeedButton;
    btnIncluir: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnGravar: TSpeedButton;
    btnCancelar: TSpeedButton;
    btnPesquisar: TSpeedButton;
    DSCadastro: TDataSource;
    txtAjuda: TDBText;
    pnlNavegar: TPanel;
    btnUltimo: TSpeedButton;
    btnProximo: TSpeedButton;
    btnAnterior: TSpeedButton;
    btnPrimeiro: TSpeedButton;
    pgctrlCadastro: TPageControl;
    tsPrincipal: TTabSheet;
    btnOutros: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnPrimeiroClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure btnUltimoClick(Sender: TObject);
    procedure DSCadastroStateChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodigoButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pnlTopExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FDMCadastro: TDMPaiCadastro;
  public
    { Public declarations }
    property DMCadastro: TDMPaiCadastro read FDMCadastro write FDMCadastro;
  end;

var
  FrmPaiCadastro: TFrmPaiCadastro;

implementation

{$R *.dfm}


procedure TFrmPaiCadastro.btnCancelarClick(Sender: TObject);
begin
  inherited;

  if DSCadastro.DataSet.State in [dsEdit, dsInsert] then
  begin
    if MessageDlg('Deseja realmente cancelar?',mtWarning,mbYesNo,0) = mrYes then
      FDMCadastro.CDSCadastro.Cancel;
  end;
  DSCadastro.DataSet.Close;
  edtCodigo.SetFocus;
end;

procedure TFrmPaiCadastro.btnExcluirClick(Sender: TObject);
begin
  inherited;

  if ((not DSCadastro.DataSet.Active) or (DSCadastro.DataSet.IsEmpty)) then
  begin
    ShowMessage('Não há o que excluir!');
  end
  else
  begin
    if MessageDlg('Deseja realmente deletar o registro?', mtConfirmation, mbYesNo,0) = mrNo then
      Exit;

    if FDMCadastro.CDSCadastro.State in [dsEdit, dsInsert] then
      Exit;

      FDMCadastro.CDSCadastro.Delete;
      edtCodigo.AsInteger := 0;
      edtCodigo.SetFocus;
  end;
end;

procedure TFrmPaiCadastro.btnGravarClick(Sender: TObject);
begin
  inherited;
  try
    FDMCadastro.GravarRegistro;
  finally
    edtCodigo.AsInteger := FDMCadastro.CodigoAtual;
    pnlTop.Enabled := True;
    edtCodigo.Enabled := True;
    edtCodigo.SetFocus;
  end;
end;

procedure TFrmPaiCadastro.btnIncluirClick(Sender: TObject);
begin
  inherited;
  edtCodigo.AsInteger := 0;
  FDMCadastro.IncluirRegistro;
end;

procedure TFrmPaiCadastro.btnPrimeiroClick(Sender: TObject);
begin
  inherited;
  edtCodigo.AsInteger := FDMCadastro.Primeiro;
  pnlTop.OnExit(pnlTop);
end;

procedure TFrmPaiCadastro.btnAnteriorClick(Sender: TObject);
begin
  inherited;
  edtCodigo.AsInteger := FDMCadastro.Anterior(edtCodigo.AsInteger);
  pnlTop.OnExit(pnlTop);
end;

procedure TFrmPaiCadastro.btnProximoClick(Sender: TObject);
begin
  inherited;
  edtCodigo.AsInteger := FDMCadastro.Proximo(edtCodigo.AsInteger);
  pnlTop.OnExit(pnlTop);
end;

procedure TFrmPaiCadastro.btnUltimoClick(Sender: TObject);
begin
  inherited;
  edtCodigo.AsInteger := FDMCadastro.Ultimo;
  pnlTop.OnExit(pnlTop);
end;

procedure TFrmPaiCadastro.DSCadastroStateChange(Sender: TObject);
begin
  inherited;
  if FDMCadastro = nil then
    Exit;

  pnlTop.Enabled       := ((not (DSCadastro.DataSet.State in [dsInsert, dsEdit])) or (DSCadastro.DataSet.State in [dsBrowse, dsInactive]));
  btnIncluir.Enabled   := (DSCadastro.DataSet.State in [dsBrowse, dsInactive]);
  btnExcluir.Enabled   := (DSCadastro.DataSet.State in [dsBrowse]) and not DSCadastro.DataSet.IsEmpty;
  btnGravar.Enabled    := (DSCadastro.DataSet.State in [dsInsert, dsEdit]);
  btnCancelar.Enabled  := (DSCadastro.DataSet.State in [dsInsert, dsEdit]);
  btnPesquisar.Enabled := (DSCadastro.DataSet.State in [dsBrowse, dsInactive]);
  btnRelatorio.Enabled := (DSCadastro.DataSet.State in [dsBrowse, dsInactive]);

end;

procedure TFrmPaiCadastro.edtCodigoButtonClick(Sender: TObject);
begin
  inherited;
  Abort;
end;

procedure TFrmPaiCadastro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmPaiCadastro.FormCreate(Sender: TObject);
var
  I : Integer;
begin
  inherited;
  //Mudando todos os Componentes Edit para MAIUSCULO
  for I := 0 to ComponentCount - 1 do
  begin
    if (Components[I] is TDBEdit) then
      (Components[I] as TDBEdit).CharCase := ecUpperCase;
  end;

  if pgctrlCadastro.PageCount = 1 then
  begin
    tsPrincipal.TabVisible := False;
    tsPrincipal.TabStop := False;
  end;
  pgctrlCadastro.ActivePageIndex := 0;

  //Atribuindo o CDSCadastro para o DSCadastro
  DSCadastro.DataSet := FDMCadastro.CDSCadastro;
end;

procedure TFrmPaiCadastro.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TFrmPaiCadastro.FormShow(Sender: TObject);
begin
  inherited;
  edtCodigo.SetFocus;
end;

procedure TFrmPaiCadastro.pnlTopExit(Sender: TObject);
begin
  inherited;

  if not FDMCadastro.AbreCasdastro(edtCodigo.AsInteger) then
  begin
    ShowMessage('Código ' + edtCodigo.Text + ' não encontrado!');
    if edtCodigo.CanFocus then
      edtCodigo.SetFocus;

    Abort;
  end
  else
    Perform(WM_NEXTDLGCTL, 0, 0);

end;

end.
