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
    pgEdit: TTabSheet;
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
  private
    { Private declarations }
    FDMCadastro: TDMPaiCadastro;
  protected
    //FDMCadastro: TDMPaiCadastro;
  public
    { Public declarations }
    property DMCadastro: TDMPaiCadastro read FDMCadastro write FDMCadastro;
  end;

    //FDMCadsatro = class of TDMPaiCadastro;


var
  FrmPaiCadastro: TFrmPaiCadastro;

implementation

{$R *.dfm}


procedure TFrmPaiCadastro.btnAnteriorClick(Sender: TObject);
begin
  inherited;
  edtCodigo.AsInteger := FDMCadastro.Anterior(edtCodigo.AsInteger);
end;

procedure TFrmPaiCadastro.btnCancelarClick(Sender: TObject);
begin
  inherited;

  if DSCadastro.DataSet.State in [dsEdit, dsInsert] then
  begin
    if MessageDlg('Deseja realmente cancelar?',mtWarning,mbYesNo,0) = mrYes then
      FDMCadastro.CDSCadastro.Cancel;
  end;
  DSCadastro.DataSet.Close;
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

  if FDMCadastro.CDSCadastro.State in [dsEdit, dsInsert] then
    FDMCadastro.CDSCadastro.Post;
  edtCodigo.SetFocus;
end;

procedure TFrmPaiCadastro.btnIncluirClick(Sender: TObject);
begin
  inherited;

  if FDMCadastro.CDSCadastro.State in [dsEdit, dsInsert] then
    Exit;

  try
    edtCodigo.AsInteger            := 0;
    pgctrlCadastro.ActivePageIndex := 0;

    FDMCadastro.CDSCadastro.Close;
    FDMCadastro.CDSCadastro.Open;
    FDMCadastro.CDSCadastro.Insert;
    //Vai para o proximo Edit;
    //Perform(WM_NEXTDLGCTL, 0, 0);
  except
    raise Exception.Create('Ocorreram erros ao tentar incluir o Registro!');
  end;
end;

procedure TFrmPaiCadastro.btnPrimeiroClick(Sender: TObject);
begin
  inherited;
  edtCodigo.AsInteger := FDMCadastro.Primeiro;
end;

procedure TFrmPaiCadastro.btnProximoClick(Sender: TObject);
begin
  inherited;
  edtCodigo.AsInteger := FDMCadastro.Proximo(edtCodigo.AsInteger);
end;

procedure TFrmPaiCadastro.btnUltimoClick(Sender: TObject);
begin
  inherited;
  edtCodigo.AsInteger := FDMCadastro.Ultimo;
end;

procedure TFrmPaiCadastro.DSCadastroStateChange(Sender: TObject);
begin
  inherited;
  if FDMCadastro = nil then
    Exit;

  pnlTop.Enabled       := not (DSCadastro.DataSet.State in [dsInsert, dsEdit]);
  btnIncluir.Enabled   := (DSCadastro.DataSet.State in [dsBrowse, dsInactive]);
  btnExcluir.Enabled   := (DSCadastro.DataSet.State in [dsBrowse]) and DSCadastro.DataSet.IsEmpty;
  btnGravar.Enabled    := (DSCadastro.DataSet.State in [dsInsert, dsEdit]);
  btnCancelar.Enabled  := (DSCadastro.DataSet.State in [dsInsert, dsEdit]);
  btnPesquisar.Enabled := (DSCadastro.DataSet.State in [dsBrowse, dsInactive]);
  btnRelatorio.Enabled := (DSCadastro.DataSet.State in [dsBrowse, dsInactive]);
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
  for I := 0 to ComponentCount - 1 do
  begin
    if (Components[I] is TDBEdit) then
      (Components[I] as TDBEdit).CharCase := ecUpperCase;
  end;

  if pgctrlCadastro.PageCount = 1 then
  begin
    pgEdit.TabVisible := False;
    pgEdit.TabStop := False;
  end;
  pgctrlCadastro.ActivePageIndex := 0;

  DSCadastro.DataSet := FDMCadastro.CDSCadastro;
end;

end.
