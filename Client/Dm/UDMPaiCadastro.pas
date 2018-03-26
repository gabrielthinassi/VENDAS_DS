unit UDMPaiCadastro;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  DB,
  DBClient,
  MConnect,
  Typinfo,
  DateUtils,
  DBCtrls,
  Grids,
  DBGrids,
  JvDBGrid,
  Datasnap.DSConnect,
  System.StrUtils,
  System.Math,
  UDMPai,
  ClassPaiCadastro,
  Data.DBXDataSnap,
  Data.DBXCommon,
  IPPeerClient,
  Data.SqlExpr;

type
  TDMPaiCadastro = class(TDMPai)
    CDSCadastro: TClientDataSet;
    DSPCCadastro: TDSProviderConnection;

    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure CDSCadastroAfterDelete(DataSet: TDataSet);
    procedure CDSCadastroAfterPost(DataSet: TDataSet);
    procedure CDSCadastroBeforeInsert(DataSet: TDataSet);
    procedure CDSCadastroReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure CDSCadastroAfterOpen(DataSet: TDataSet);
    procedure CDSCadastroBeforeOpen(DataSet: TDataSet);
    procedure CDSCadastroBeforePost(DataSet: TDataSet);

  private
    function GetIdDetalhe: integer;
  protected
    FClasseFilha: TFClassPaiCadastro;
    FCodigoAtual: Integer;
  public
    property CodigoAtual: integer read FCodigoAtual write FCodigoAtual;
    property IdDetalhe: integer read GetIdDetalhe;

    function GetClassNameClasseFilha: string;

    function Primeiro: integer; virtual;
    function Anterior(Atual: integer): integer; virtual;
    function Proximo(Atual: integer): integer; virtual;
    function Ultimo: integer; virtual;
    function NovoCodigo: integer; virtual;

    procedure IncluirRegistro;
    procedure GravarRegistro;

    function AbreCasdastro(Codigo: Integer): Boolean;
    //procedure AtribuiAutoIncDetalhe(DataSet: TDataSet; Classe: TClassPaiCadastro; CampoChaveEstrangeira: String);

    //Exportar & Importar
    procedure ExportarArquivo;

  end;

var
  DMPaiCadastro: TDMPaiCadastro;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

uses Constantes, ClassDataSet, UDMConexao;

{$R *.dfm}


procedure TDMPaiCadastro.DataModuleCreate(Sender: TObject);
begin
  inherited;
  DSPCCadastro.SQLConnection := DMConexao.ConexaoDS;

  if DSPCCadastro.ServerClassName <> '' then
    CDSCadastro.RemoteServer := DSPCCadastro;
  CDSCadastro.ProviderName := 'DSPCadastro';

  with FClasseFilha do
  begin
    CDSCadastro.AdicionarCampos;
  end;

  cdsCadastro.FetchParams;
  cdsCadastro.ParamByName('COD').AsInteger := -1;
  cdsCadastro.Open;
end;

procedure TDMPaiCadastro.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  DSPCCadastro.Close;
  DSPCCadastro.SQLConnection := nil;
  //FClasseFilha.Free;    Da Erro
  CDSCadastro.Close;
end;

procedure TDMPaiCadastro.ExportarArquivo;
var
  NomeDoArquivo: String;
  SaveDialog: TSaveDialog;
begin
  NomeDoArquivo := FClasseFilha.Descricao + '_' + IntToStr(FCodigoAtual) + '.XML';

  {$REGION 'SaveDialog'}
  SaveDialog := TSaveDialog.Create(nil);
  try
    SaveDialog.InitialDir := ExtractFilePath(Application.ExeName);
    SaveDialog.FileName   := NomeDoArquivo;
    SaveDialog.Title      := 'Exportando ' + FClasseFilha.Descricao;
    SaveDialog.Options    := SaveDialog.Options + [TOpenOption.ofFileMustExist];

    if SaveDialog.Execute then
      NomeDoArquivo := SaveDialog.FileName
    else
      NomeDoArquivo := '';
  finally
    SaveDialog.Free;
  end;
  {$ENDREGION}

  if NomeDoArquivo = '' then
    Exit;

  if (not CDSCadastro.Active) or (CDSCadastro.IsEmpty) then
  begin
    ShowMessage('Não há o que Exportar!');
    Exit;
  end;

  if CDSCadastro.State in [dsEdit, dsInsert] then
  begin
    ShowMessage('Grave o Registro antes de tentar Exportá-lo!');
    Exit;
  end;

  //Salvando o Arquivo XML
  CDSCadastro.SaveToFile(NomeDoArquivo, dfXMLUTF8);
end;

function TDMPaiCadastro.AbreCasdastro(Codigo: Integer): Boolean;
begin
  Result := False;

  CDSCadastro.Close;
  CDSCadastro.FetchParams;
  CDSCadastro.ParamByName('COD').AsInteger := Codigo;
  CDSCadastro.Open;

  if not CDSCadastro.IsEmpty then
    Result := True;
end;


function TDMPaiCadastro.Primeiro: integer;
var
  SQL: string;
  Classe: TFClassPaiCadastro;
begin
  Classe := FClasseFilha;

  with Classe do
  begin
    SQL := ' SELECT MIN(' + TabelaPrincipal + '.' + CampoChave + ')' +#13+
           ' FROM '  + TabelaPrincipal +#13+
           ' WHERE ' + TabelaPrincipal + '.' + CampoChave + ' <> 0';
  end;
  Result := DMConexao.ExecuteScalar(SQL);
end;

function TDMPaiCadastro.Proximo(Atual: integer): integer;
var
  SQL: string;
  Classe: TFClassPaiCadastro;
begin
  Classe := FClasseFilha;

  with Classe do
  begin
    SQL := ' SELECT MIN(' + TabelaPrincipal + '.' + CampoChave + ')' +#13+
           ' FROM '  + TabelaPrincipal +#13+
           ' WHERE ' + TabelaPrincipal + '.' + CampoChave + ' > ' + IntToStr(Atual) +#13+
           ' AND '   + TabelaPrincipal + '.' + CampoChave + ' <> 0';
  end;

  Result := DMConexao.ExecuteScalar(SQL);
  if Result = 0 then
    Result := Atual;
end;

function TDMPaiCadastro.Anterior(Atual: integer): integer;
var
  SQL: string;
  Classe: TFClassPaiCadastro;
begin
  Classe := FClasseFilha;

  with Classe do
  begin
    SQL := ' SELECT MAX(' + TabelaPrincipal + '.' + CampoChave + ')' +#13+
           ' FROM '  + TabelaPrincipal +#13+
           ' WHERE ' + TabelaPrincipal + '.' + CampoChave + ' < ' + IntToStr(Atual) +#13+
           ' AND '   + TabelaPrincipal + '.' + CampoChave + ' <> 0';
  end;
  Result := DMConexao.ExecuteScalar(SQL);
  if Result = 0 then
    Result := Atual;
end;

function TDMPaiCadastro.Ultimo: integer;
var
  SQL: string;
  Classe: TFClassPaiCadastro;
begin
  Classe := FClasseFilha;

  with Classe do
  begin
    SQL := ' SELECT MAX(' + TabelaPrincipal + '.' + CampoChave + ')' +#13+
           ' FROM '  + TabelaPrincipal +#13+
           ' WHERE ' + TabelaPrincipal + '.' + CampoChave + ' <> 0';
  end;
  Result := DMConexao.ExecuteScalar(SQL);
end;

function TDMPaiCadastro.NovoCodigo: integer;
begin
  // Retorna o novo código a ser usado na inserção
  with FClasseFilha do
  begin
    Result := DMConexao.ProximoCodigo(TabelaPrincipal);
  end;
end;

function TDMPaiCadastro.GetClassNameClasseFilha: string;
begin
  if Assigned(FClasseFilha) then
    Result := FClasseFilha.ClassName
  else
    Result := '';
end;

function TDMPaiCadastro.GetIdDetalhe: integer;
begin
  //FIdDetalhe := FIdDetalhe - 1;
  //Result := FIdDetalhe;
end;

procedure TDMPaiCadastro.GravarRegistro;
begin
  if CDSCadastro.State in [dsEdit, dsInsert] then
  begin
    CDSCadastro.BeforePost(CDSCadastro);
    CDSCadastro.Post;
  end;

  if not CDSCadastro.ChangeCount <> 0 then
    CDSCadastro.Edit;
end;

procedure TDMPaiCadastro.IncluirRegistro;
begin
  if CDSCadastro.State in [dsInsert, dsEdit] then
    Exit;

  with CDSCadastro do
  begin
    Close;
    FCodigoAtual := -1;
    Open;
    Append;
  end;
end;

{procedure TDMPaiCadastro.AtribuiAutoIncDetalhe(DataSet: TDataSet; Classe: TFClassPaiCadastro; CampoChaveEstrangeira: String);
var
  QtdeAutoIncNegativos: Integer;
  AutoIncDetalhe: Integer;
begin
  with DataSet, Classe do
  begin
    QtdeAutoIncNegativos := 0;
    DisableControls;

    try
      First;
      while not EOF do
      begin
        if FieldByName(CampoChave).AsInteger <= 0 then
          inc(QtdeAutoIncNegativos);
        Next;
      end;

      if QtdeAutoIncNegativos > 0 then
      begin
        AutoIncDetalhe := DMConexao.ProximoCodigo(TabelaPrincipal, 0, QtdeAutoIncNegativos);
        AutoIncDetalhe := AutoIncDetalhe - QtdeAutoIncNegativos;

        First;
        while not Eof do
        begin
          if FieldByName(CampoChave).AsInteger <= 0 then
          begin
            Edit;
            FieldByName(CampoChave).AsInteger := AutoIncDetalhe;
            FieldByName(CampoChaveEstrangeira).AsInteger := CDSCadastro.FieldByName(FClasseFilha.CampoChave).AsInteger;
            Post;
            inc(AutoIncDetalhe);
          end;
          Next;
        end;
      end;
    finally
      EnableControls;
    end;
  end;
end;}

procedure TDMPaiCadastro.CDSCadastroAfterDelete(DataSet: TDataSet);
begin
  inherited;
  cdsCadastro.ApplyUpdates(0);
end;

procedure TDMPaiCadastro.CDSCadastroAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FClasseFilha.ConfigurarPropriedadesDoCampo(DataSet);
end;

procedure TDMPaiCadastro.CDSCadastroAfterPost(DataSet: TDataSet);
begin
  inherited;
  cdsCadastro.ApplyUpdates(0);
end;

procedure TDMPaiCadastro.CDSCadastroBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  cdsCadastro.EmptyDataSet;
end;

procedure TDMPaiCadastro.CDSCadastroBeforeOpen(DataSet: TDataSet);
var
  X : Integer;
begin
  inherited;
  with CDSCadastro do
    for X := 0 to ParamCount -1 do
    begin
      if AnsiUpperCase(Params.Items[X].Name) = 'COD' then
        Params.ParamByName('COD').AsInteger := FCodigoAtual;
    end;


end;

procedure TDMPaiCadastro.CDSCadastroBeforePost(DataSet: TDataSet);
begin
  inherited;
  with CDSCadastro, FClasseFilha do
  begin
    if (UpdateStatus = usInserted) and
        ((FieldByName(CampoChave).IsNull) or
         (FieldByName(CampoChave).AsInteger <= 0)) then
    begin
      FCodigoAtual := NovoCodigo;
      FieldByName(CampoChave).AsInteger := FCodigoAtual;
    end;
  end;
end;

procedure TDMPaiCadastro.CDSCadastroReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
  inherited;
  ShowMessage(E.Message);
  Action := raAbort;
end;

end.
