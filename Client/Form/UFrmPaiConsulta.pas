unit UFrmPaiConsulta;

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
  UFrmPai,
  Vcl.ExtCtrls,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.Imaging.pngimage,
  Datasnap.Provider,
  Datasnap.DBClient,
  Datasnap.DSConnect,
  //--------------------//
  UDMConexao,
  ClassPaiCadastro,
  Constantes, ClassHelper;

type
  TFrmPaiConsulta = class(TFrmPai)
    pnlTop: TPanel;
    gridConsulta: TDBGrid;
    cbxOperadores: TComboBox;
    cbxCampos: TComboBox;
    edtValorConsulta: TEdit;
    lblCampo: TLabel;
    lblOperador: TLabel;
    lblValorConsulta: TLabel;
    lblFechar: TLabel;
    imgConsultar: TImage;
    imgConfirmar: TImage;
    CDSConsulta: TClientDataSet;
    DSConsulta: TDataSource;
    DSPCConsulta: TDSProviderConnection;
    lblTituloConsulta: TLabel;
    procedure lblFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure imgConfirmarClick(Sender: TObject);
    procedure imgConsultarClick(Sender: TObject);
    procedure cbxOperadoresChange(Sender: TObject);
    procedure CDSConsultaAfterOpen(DataSet: TDataSet);
    procedure gridConsultaDblClick(Sender: TObject);
    procedure gridConsultaTitleClick(Column: TColumn);

    //---Confirma Consulta---//
    //procedure FormCreate(Sender: TObject; edtCodigo: Integer);

  private
    { Private declarations }
    CamposSQL: TStrings;
    FCodigo: Integer;
    FClasse: TFClassPaiCadastro;
    function SQLOperador: string;
    function SQLCampos: string;
  public
    { Public declarations }
    property Classe: TFClassPaiCadastro read FClasse write FClasse;
    property Codigo: Integer read FCodigo write FCodigo;
  end;

    FClasse = class of TClassPaiCadastro;

var
  FrmPaiConsulta: TFrmPaiConsulta;

implementation

{$R *.dfm}

procedure TFrmPaiConsulta.cbxOperadoresChange(Sender: TObject);
begin
  inherited;
  if cbxOperadores.ItemIndex in [0..8] then
  begin
    edtValorConsulta.Clear;
  end;
end;

procedure TFrmPaiConsulta.CDSConsultaAfterOpen(DataSet: TDataSet);
var
  I: Integer;
begin
  inherited;
  for I := 0 to DataSet.FieldCount - 1 do
  begin
    if DataSet.Fields[I] is TDateTimeField then
      TDateTimeField(DataSet.Fields[I]).DisplayFormat := sDisplayFormatData;
  end;
end;

procedure TFrmPaiConsulta.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  cdsConsulta.Close;
  CamposSQL.Free;
end;

procedure TFrmPaiConsulta.FormCreate(Sender: TObject);
begin
  inherited;
  CamposSQL := TStringList.Create;
  DSPCConsulta.SQLConnection := DMConexao.ConexaoDS;
  DSPCConsulta.ServerClassName := 'TSMPaiConsulta';
  CDSConsulta.ProviderName := 'DSPConsulta';
  //CDSConsulta.SetProvider(DSPCConsulta.Name);

  cbxOperadores.Items.Add('Igual a');
  cbxOperadores.Items.Add('Maior que');
  cbxOperadores.Items.Add('Menor que');
  cbxOperadores.Items.Add('Maior ou igual a');
  cbxOperadores.Items.Add('Menor ou igual a');
  cbxOperadores.Items.Add('Come�a com');
  cbxOperadores.Items.Add('Termina com');
  cbxOperadores.Items.Add('Cont�m');
  cbxOperadores.Items.Add('Todos');
end;

procedure TFrmPaiConsulta.FormShow(Sender: TObject);
var
  Lista: TStrings;
begin
  inherited;
  frmPaiConsulta.Caption    := 'Consulta de ' + FClasse.Descricao;
  lblTituloConsulta.Caption := 'Consulta de ' + FClasse.Descricao;

  Lista := TStringList.Create;
  try
    cbxCampos.Items.AddStrings(FClasse.CamposConsulta(Lista, CamposSQL));
  finally
    Lista.Free;
  end;

  cbxCampos.ItemIndex := 0;
  cbxOperadores.ItemIndex := 8;
end;

procedure TFrmPaiConsulta.gridConsultaDblClick(Sender: TObject);
begin
  inherited;
  imgConsultar.OnClick(imgConsultar);
end;

procedure TFrmPaiConsulta.gridConsultaTitleClick(Column: TColumn);
begin
  inherited;
  CDSConsulta.IndexFieldNames := Column.FieldName;
end;

procedure TFrmPaiConsulta.imgConfirmarClick(Sender: TObject);
var
  X: Integer;
begin
  inherited;
  X := DSConsulta.DataSet.Fields[0].AsInteger;

  if X > 0 then
    FCodigo := X;
  Self.Close;
end;

procedure TFrmPaiConsulta.imgConsultarClick(Sender: TObject);
var
  SQL: String;
begin
  inherited;
  SQL := FClasse.SQLBaseConsulta;
  SQL := SQL + SQLOperador;

  CDSConsulta.Close;
  CDSConsulta.CommandText := SQL;
  CDSConsulta.AdicionarCampos;
  FClasse.ConfigurarPropriedadesDoCampo(CDSConsulta);
  CDSConsulta.Open;
end;

procedure TFrmPaiConsulta.lblFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

function TFrmPaiConsulta.SQLCampos: string;
begin
  Result := ' WHERE ' + CamposSQL[cbxCampos.ItemIndex];
end;

function TFrmPaiConsulta.SQLOperador: string;
begin
  if cbxOperadores.ItemIndex in [0..7] then
  begin
    if Trim(edtValorConsulta.Text) = '' then
    begin
      ShowMessage('Informe algum Valor para a Consulta!');
      Abort;
    end;
  end;

  case cbxOperadores.ItemIndex of
    0: Result := SQLCampos + ' = ' + QuotedStr(Trim(edtValorConsulta.Text));                //0 - Igual
    1: Result := SQLCampos + ' > ' + QuotedStr(Trim(edtValorConsulta.Text));                //1 - Maior que
    2: Result := SQLCampos + ' < ' + QuotedStr(Trim(edtValorConsulta.Text));                //2 - Menor que
    3: Result := SQLCampos + ' >= ' + QuotedStr(Trim(edtValorConsulta.Text));               //3 - Maior ou igual a
    4: Result := SQLCampos + ' <= ' + QuotedStr(Trim(edtValorConsulta.Text));               //4 - Menor ou igual a
    5: Result := SQLCampos + ' like ' + QuotedStr(Trim(edtValorConsulta.Text) + '%');       //5 - Come�a com
    6: Result := SQLCampos + ' like ' + QuotedStr('%' + Trim(edtValorConsulta.Text));       //6 - Termina com
    7: Result := SQLCampos + ' like ' + QuotedStr('%' + Trim(edtValorConsulta.Text) + '%'); //7 - Cont�m
    8: Result := '';                                                                        //8 - Preenchido
  end;
end;

end.
