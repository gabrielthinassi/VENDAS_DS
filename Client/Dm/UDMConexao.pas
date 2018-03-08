unit UDMConexao;

interface

uses
  SysUtils,
  Classes,
  FMTBcd,
  Vcl.Graphics,
  Controls,
  Forms,
  Menus,
  Dialogs,
  AppEvnts,
  Registry,
  Variants,
  ExtCtrls,
  ShellApi,
  ComCtrls,
  ActiveX,
  Windows,
  Messages,
  IniFiles,
  StdCtrls,
  IdStack,
  DB,
  DBClient,
  SqlExpr,
  Provider,
  System.Math,
  System.StrUtils,
  DateUtils,
  IndyPeerImpl,
  Datasnap.DSHTTPCommon,
  Data.DBXCommon,
  Data.DBXDataSnap,
  Datasnap.DSConnect,
  DBXJSONReflect,
  DSProxy,
  System.Json,
  IPPeerClient,
  System.ImageList,
  DSHTTPLayer,
  ImgList,
  DBGrids,
  JvDBGrid;

type
  TDMConexao = class(TDataModule)
    ConexaoDS: TSQLConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    procedure CarregarListaDeTabelasEProceduresDoBDD;
  public
    function ExecutaMetodo(Metodo: string; Parametros_Valor: array of OleVariant): OleVariant;
    function ExecuteReader(sql: string): OleVariant;
    function ExecuteScalar(sql: string): OleVariant;
    function ExecuteCommand(sql: WideString): int64;
    function ExecuteCommand_Update(sql: WideString; Campo: string; Valor: OleVariant): int64;
    function ProximoCodigo(Tabela: string): int64;

    //Conexão
    function TestaConexao(Servidor, Porta: String): Boolean;
    //procedure FazConexao;

    //procedure CarregaDefaults;
    //function GetCDSConfigCamposClasses: OleVariant;
    //function GetCDSConfigClasses: OleVariant;
  end;

var
  DMConexao: TDMConexao;

implementation

uses Constantes, ClassDataSet;
{$R *.dfm}

procedure TDMConexao.DataModuleCreate(Sender: TObject);
begin
  //CarregaDefaults;
  //CarregaConfigClasses;
  CarregarListaDeTabelasEProceduresDoBDD;
end;

procedure TDMConexao.DataModuleDestroy(Sender: TObject);
begin
  if ConexaoDS.Connected then
    ConexaoDS.Close;
end;


function TDMConexao.TestaConexao(Servidor, Porta: string): Boolean;
var
  ClienteConfig: TIniFile;
begin
  ClienteConfig := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'ClientConfig.ini');

  if Servidor = '' then
    Servidor := ClienteConfig.ReadString('Configuracao', 'Servidor', 'localhost');
  if Porta = '' then
    Porta := ClienteConfig.ReadString('Configuracao', 'Porta', '211');

  try
    with ConexaoDS do
    begin
      if Connected = True then
          Result := True
      else
      begin
        try
          Close;
          Params.Clear;
          Params.Add('DriverUnit=Data.DBXDataSnap');
          Params.Add('HostName=' + Servidor);
          Params.Add('Port=' + Porta);
          Params.Add('CommunicationProtocol=tcp/ip');
          Params.Add('DatasnapContext=datasnap/');
          Params.Add('Borland.Data.TDBXClientDriverLoader,Borland.Data.DbxClientDriver,Version=22.0.0.0,Culture=neutral,PublicKeyToken=91d62ebb5b0d1b1b');

          ShowMessage(Params.Text);

          Connected := True;
          Result := True;
        finally
          Connected := False;
        end;
      end;
    end;
  except
    On E: Exception do
    begin
      Result := False;
      ShowMessage(ErroServidorApl + ErroServidorAplNaoEstaRodando + E.Message);
    end;
  end;
end;

function TDMConexao.ExecutaMetodo(Metodo: string; Parametros_Valor: array of OleVariant): OleVariant;
var
  Comando : TDBXCommand;
  I : Integer;
begin
    Comando := ConexaoDS.DBXConnection.CreateCommand;
    try
      Comando.CommandType := TDBXCommandTypes.DSServerMethod;
      Comando.Text := Metodo;
      Comando.Prepare;


      for I := low(Parametros_Valor) to high(Parametros_Valor) do
      begin
        case Comando.Parameters[I].DataType of
          TDBXDataTypes.BooleanType:
            Comando.Parameters[I].Value.SetBoolean(Parametros_Valor[I]);
          TDBXDataTypes.CurrencyType:
            Comando.Parameters[I].Value.AsCurrency := StrToCurr(Parametros_Valor[I]);
          TDBXDataTypes.DateType,
            TDBXDataTypes.DateTimeType,
            TDBXDataTypes.TimeStampType:
            Comando.Parameters[I].Value.AsDateTime := StrToDateTime(Parametros_Valor[I]);
          TDBXDataTypes.DoubleType,
            TDBXDataTypes.BcdType:
            Comando.Parameters[I].Value.SetDouble(StrToCurr(Parametros_Valor[I]));
          TDBXDataTypes.UInt8Type,
            TDBXDataTypes.Int8Type:
            Comando.Parameters[I].Value.SetInt8(StrToInt(Parametros_Valor[I]));
          TDBXDataTypes.Int16Type:
            Comando.Parameters[I].Value.SetInt16(StrToInt(Parametros_Valor[I]));
          TDBXDataTypes.Int32Type:
            Comando.Parameters[I].Value.SetInt32(StrToInt(Parametros_Valor[I]));
          TDBXDataTypes.Int64Type,
            TDBXDataTypes.Uint64Type:
            Comando.Parameters[I].Value.SetInt64(StrToInt64(Parametros_Valor[I]));
          TDBXDataTypes.VariantType:
            Comando.Parameters[I].Value.AsVariant := Parametros_Valor[I];
          TDBXDataTypes.AnsiStringType:
            Comando.Parameters[I].Value.AsString := Parametros_Valor[I];
          TDBXDataTypes.WideStringType:
            Comando.Parameters[I].Value.SetWideString(Parametros_Valor[I]);
          TDBXDataTypes.BlobType:
            Comando.Parameters[I].Value.SetWideString(Parametros_Valor[I]);
        end;
        //Executa e retorna
        Comando.ExecuteUpdate;
        Result := Comando.Parameters[I+1].Value.AsVariant;
      end;
    finally
      //Comando.Free;
    end;
end;

function TDMConexao.ProximoCodigo(Tabela: string): int64;
begin
  Tabela := AnsiUpperCase(Tabela);
  Result := ExecutaMetodo('TSMConexao.ProximoCodigo', [Trim(Tabela)]);
end;

function TDMConexao.ExecuteScalar(sql: string): OleVariant;
begin
  Result := ExecutaMetodo('TSMConexao.ExecuteScalar', [Trim(sql)]);
end;

function TDMConexao.ExecuteReader(sql: string): OleVariant;
begin
  Result := ExecutaMetodo('TSMConexao.ExecuteReader', [Trim(sql)]);
end;


function TDMConexao.ExecuteCommand(sql: WideString): int64;
begin
  //Result := TFuncoesConversao.VariantParaInt64(ExecutaMetodo('TSMConexao.ExecuteCommand', [Trim(sql), True]));
end;

function TDMConexao.ExecuteCommand_Update(sql: WideString; Campo: string; Valor: OleVariant): int64;
begin
  //teste
end;

procedure TDMConexao.CarregarListaDeTabelasEProceduresDoBDD;
begin
  //SynSQLSynPadrao.FunctionNames.Text := ExecutaMetodo('TSMConexao.GetProcedureNames', []);
  //SynSQLSynPadrao.TableNames.Text    := ExecutaMetodo('TSMConexao.GetTableNames',     [False]);
  //SynSQLSynPadrao.TableNames.Add(ExecutaMetodo('TSMConexao.GetTableNames', [True]));
end;

end.
