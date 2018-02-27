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

  private
    FClasseFilha: TClassPaiCadastro;
    function GetIdDetalhe: integer;
    function ProximoCodigo(Tabela: string): int64;
  protected
  public
    property ClasseFilha: TClassPaiCadastro read FClasseFilha write FClasseFilha;

    //property CodigoAtual: integer read FCodigoAtual write FCodigoAtual;
    //property RefreshRecordAfterPost: boolean read FRefreshRecordAfterPost write FRefreshRecordAfterPost;

    property IdDetalhe: integer read GetIdDetalhe;

    function GetClassNameClasseFilha: string;

    function Primeiro: integer; virtual;
    function Anterior(Atual: integer): integer; virtual;
    function Proximo(Atual: integer): integer; virtual;
    function Ultimo: integer; virtual;
    function Novo: integer; virtual;

    //procedure AtribuiAutoIncDetalhe(DataSet: TDataSet; Classe: TClassPaiCadastro; CampoChaveEstrangeira: String);
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
    if Trim(CDSCadastro.CommandText) = '' then
      CDSCadastro.CommandText := SQLBaseCadastro;

    CDSCadastro.AdicionarCampos;
  end;
    //cdsCadastro.FetchParams;
    //cdsCadastro.ParamByName('Cod').AsInteger := -1;
    //cdsCadastro.Open;
end;

procedure TDMPaiCadastro.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  DSPCCadastro.Close;
  DSPCCadastro.SQLConnection := nil;
end;

function TDMPaiCadastro.Primeiro: integer;
var
  SQL: string;
  Classe: TClassPaiCadastro;
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
  Classe: TClassPaiCadastro;
begin
  Classe := FClasseFilha;

  with Classe do
  begin
    SQL := ' SELECT MIN(' + TabelaPrincipal + '.' + CampoChave + ')' +#13+
           ' FROM '  + TabelaPrincipal +#13+
           ' WHERE ' + TabelaPrincipal + '.' + CampoChave + ' > ' + IntToStr(Atual) +#13+
           ' AND '   + TabelaPrincipal + '.' + CampoChave + ' <> 0)';
  end;
  Result := DMConexao.ExecuteScalar(SQL);
end;


function TDMPaiCadastro.ProximoCodigo(Tabela: string): int64;
begin
  //Busca o Próximo Código no Servidor de Aplicação
  Tabela := AnsiUpperCase(Tabela);
  Result := DMConexao.ExecutaMetodo('TSMConexao.ProximoCodigo', [Tabela]);
end;

function TDMPaiCadastro.Anterior(Atual: integer): integer;
var
  SQL: string;
  Classe: TClassPaiCadastro;
begin
  Classe := FClasseFilha;

  with Classe do
  begin
    SQL := ' SELECT MAX(' + TabelaPrincipal + '.' + CampoChave + ')' +#13+
           ' FROM '  + TabelaPrincipal +#13+
           ' WHERE ' + TabelaPrincipal + '.' + CampoChave + ' < ' + IntToStr(Atual) +#13+
           ' AND '   + TabelaPrincipal + '.' + CampoChave + ' <> 0)';
  end;
  Result := DMConexao.ExecuteScalar(SQL);
end;

function TDMPaiCadastro.Ultimo: integer;
var
  SQL: string;
  Classe: TClassPaiCadastro;
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

function TDMPaiCadastro.Novo: integer;
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

procedure TDMPaiCadastro.CDSCadastroReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
  inherited;
  Action := raAbort;
end;

end.
