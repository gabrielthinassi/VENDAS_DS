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
    function GetIdDetalhe: Integer;
  protected
    FClasseFilha: TFClassPaiCadastro;
    FCodigoAtual: Integer;
  public
    property CodigoAtual: Integer read FCodigoAtual write FCodigoAtual;
    property IdDetalhe: Integer read GetIdDetalhe;

    function GetClassNameClasseFilha: string;

    function Primeiro: Integer; virtual;
    function Anterior(Atual: Integer): Integer; virtual;
    function Proximo(Atual: Integer): Integer; virtual;
    function Ultimo: Integer; virtual;
    function NovoCodigo: Integer; virtual;

    procedure IncluirRegistro;
    procedure GravarRegistro;

    function AbreCasdastro(ACodigo: Integer): Boolean;
    procedure AbreFilhos;

    //Validates
    class procedure ValidateDescricao(Codigo: Integer; Classe: TFClassPaiCadastro; DataSet: TDataSet);




    //procedure AtribuiAutoIncDetalhe(DataSet: TDataSet; Classe: TClassPaiCadastro; CampoChaveEstrangeira: String);

    //Exportar & Importar
    procedure ExportarArquivo(ACodigo: Integer);
    procedure ImportarArquivo(ACodigo: Integer; EventoIncluir, EventoGravar: TNotifyEvent);

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

{$REGION 'Importar/Exportar [criar function posteriormente]'}

procedure TDMPaiCadastro.ImportarArquivo(ACodigo: Integer;
                                         EventoIncluir, EventoGravar: TNotifyEvent);
var
  Field: TField;
  NomeDoArquivo : String;
  OpenDialog    : TOpenDialog;
  CDSTemp       : TClientDataSet;
begin
  NomeDoArquivo := FClasseFilha.Descricao + '_' + IntToStr(ACodigo) + '.XML';

  {$REGION 'OpenDialog [criar function posteriormente]'}
  OpenDialog := TSaveDialog.Create(nil);
  try
    OpenDialog.InitialDir := ExtractFilePath(Application.ExeName);
    OpenDialog.FileName   := NomeDoArquivo;
    OpenDialog.Title      := 'Exportando ' + FClasseFilha.Descricao;
    OpenDialog.Options    := OpenDialog.Options + [TOpenOption.ofFileMustExist, TOpenOption.ofPathMustExist];

    if OpenDialog.Execute then
      NomeDoArquivo := Trim(OpenDialog.Files.Text)
    else
      NomeDoArquivo := '';
  finally
    OpenDialog.Free;
  end;
  {$ENDREGION}

  if NomeDoArquivo = '' then
    Exit;

  if CDSCadastro.State in [dsEdit, dsInsert] then
  begin
    ShowMessage('Grave o Registro atual antes de tentar Importar!');
    Exit;
  end;

  CDSTemp := TClientDataSet.Create(nil);
  try
    CDSTemp.LoadFromFile(NomeDoArquivo);

    if CDSTemp.FindField(FClasseFilha.CampoChave) = nil then
    begin
      ShowMessage('Arquivo incompatível com o cadastro "' + FClasseFilha.Descricao + '"');
      Exit;
    end;

    CDSTemp.First;
    while not CDSTemp.Eof do
    begin

      if Assigned(EventoIncluir) then
        EventoIncluir(CDSCadastro);

      CDSCadastro.DisableControls;
      try
        //if not (CDSTemp.State in [dsInsert, dsEdit]) then
        //  Exit;

        for Field in CDSTemp.Fields do
        begin
          if FClasseFilha.CampoDescricao = Field.FieldName then
          begin
            CDSTemp.Edit;
            Field.Value := Field.Value + '_COPIA';
            CDSTemp.Post;
          end;

          //Este IF irá saltar o Campo chave, deixando-o Null para pegar o AutoInc
          if FClasseFilha.CampoChave <> Field.FieldName then
            CDSCadastro.FieldByName(Field.FieldName).Assign(Field);
        end;

        if Assigned(EventoGravar) then
          EventoGravar(CDSCadastro)
        else
          CDSCadastroBeforePost(CDSCadastro);

      finally
        CDSCadastro.EnableControls;
      end;

      CDSTemp.Next;
    end;

  finally
    FreeAndNil(CDSTemp);
  end;

end;

procedure TDMPaiCadastro.ExportarArquivo(ACodigo: Integer);
var
  NomeDoArquivo : String;
  SaveDialog    : TSaveDialog;
begin
  NomeDoArquivo := FClasseFilha.Descricao + '_' + IntToStr(ACodigo) + '.XML';

  {$REGION 'SaveDialog [criar function posteriormente]'}
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

{$ENDREGION}

function TDMPaiCadastro.AbreCasdastro(ACodigo: Integer): Boolean;
begin
  Result := False;

  CDSCadastro.Close;
  CDSCadastro.FetchParams;
  CDSCadastro.ParamByName('COD').AsInteger := ACodigo;
  CDSCadastro.Open;

  if not CDSCadastro.IsEmpty then
    Result := True;
end;


function TDMPaiCadastro.Primeiro: Integer;
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

function TDMPaiCadastro.Proximo(Atual: Integer): Integer;
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

procedure TDMPaiCadastro.AbreFilhos;
var
  X: Integer;
begin
  with Self do
  for X := 0 to ComponentCount - 1 do
  begin
    if (Components[X] is TClientDataSet) and not (Components[X].Name = 'CDSCadastro') and (TClientDataSet(Components[X]).DataSetField <> nil) then
    begin
      (Components[X] as TClientDataSet).Close;
      (Components[X] as TClientDataSet).AdicionarCampos();

      (Components[X] as TClientDataSet).Open;
    end;
  end;
end;

function TDMPaiCadastro.Anterior(Atual: Integer): Integer;
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

function TDMPaiCadastro.Ultimo: Integer;
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

class procedure TDMPaiCadastro.ValidateDescricao(Codigo: Integer;
  Classe: TFClassPaiCadastro; DataSet: TDataSet);
var
  SQL, Descricao: String;
begin
  if Codigo = 0 then
    exit;

  with Classe do
  begin
    SQL :=  'SELECT ' +
            CampoDescricao +
            ' FROM ' +
            TabelaPrincipal +
            ' WHERE ' +
            TabelaPrincipal + '.' +
            CampoChave + ' = ' +
            IntToStr(Codigo);
  end;


  Descricao := VarToStrDef(DMConexao.ExecuteScalar(SQL), '');

  if (Descricao <> '') and DataSet.Active then
  begin
    if not (DataSet.State in [dsEdit, dsInsert]) then
      DataSet.Edit;
    DataSet.FieldByName(Classe.CampoDescricao).AsString := Descricao
  end
  else
  begin
    ShowMessage(Classe.Descricao + ' não localizada!');
    Abort;
  end;
end;

function TDMPaiCadastro.NovoCodigo: Integer;
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

function TDMPaiCadastro.GetIdDetalhe: Integer;
begin
  //FIdDetalhe := FIdDetalhe - 1;
  //Result := FIdDetalhe;
end;

procedure TDMPaiCadastro.GravarRegistro;
begin
  if CDSCadastro.State in [dsEdit, dsInsert] then
  begin
    CDSCadastro.Post;
    //Atribuindo o CodigoAtual para o Registro Gravado
    CodigoAtual := CDSCadastro.Fields[0].AsInteger;
  end;
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
        ((FieldByName(CampoChave).IsNull)) then
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
