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
  JvDBGrid,
  Data.DBXCDSReaders;

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

uses Constantes, ClassHelper;
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
  LDBXCommand: TDBXCommand;
  I, NumParamEntrada, PosRetorno: Integer;

  Reader: TDBXReader;
  CDS: TClientDataSet;
begin
  LDBXCommand := ConexaoDS.DBXConnection.CreateCommand;
  try
    try
      LDBXCommand.CommandType := TDBXCommandTypes.DSServerMethod;
      LDBXCommand.Text := Metodo;
      LDBXCommand.Prepare;

      NumParamEntrada := LDBXCommand.Parameters.Count;
      if (NumParamEntrada > 0) and (LDBXCommand.Parameters[NumParamEntrada - 1].Name = 'ReturnParameter') then
      begin
        Dec(NumParamEntrada);
        PosRetorno := NumParamEntrada;
      end
      else
        PosRetorno := -1;

      if (NumParamEntrada <> High(Parametros_Valor) + 1) then
        raise Exception.Create(
          'Numero de parâmetros inválidos para a chamada do metodos "' + Metodo + '", esperado ' +
          IntToStr(NumParamEntrada) + ' encontrado ' + IntToStr(High(Parametros_Valor) + 1));

      for I := low(Parametros_Valor) to high(Parametros_Valor) do
        case LDBXCommand.Parameters[I].DataType of
          TDBXDataTypes.BooleanType:
            LDBXCommand.Parameters[I].Value.SetBoolean(Parametros_Valor[I]);
          TDBXDataTypes.CurrencyType:
            LDBXCommand.Parameters[I].Value.AsCurrency := StrToCurr(Parametros_Valor[I]);
          TDBXDataTypes.DateType,
            TDBXDataTypes.DateTimeType,
            TDBXDataTypes.TimeStampType:
            LDBXCommand.Parameters[I].Value.AsDateTime := StrToDateTime(Parametros_Valor[I]);
          // TDBXDataTypes.TimeType:
          // LDBXCommand.Parameters[I].Value.SetTime(StrToTime(Parametros_Valor[I]));
          TDBXDataTypes.DoubleType,
            TDBXDataTypes.BcdType:
            LDBXCommand.Parameters[I].Value.SetDouble(StrToCurr(Parametros_Valor[I]));
          TDBXDataTypes.UInt8Type,
            TDBXDataTypes.Int8Type:
            LDBXCommand.Parameters[I].Value.SetInt8(StrToInt(Parametros_Valor[I]));
          TDBXDataTypes.Int16Type:
            LDBXCommand.Parameters[I].Value.SetInt16(StrToInt(Parametros_Valor[I]));
          TDBXDataTypes.Int32Type:
            LDBXCommand.Parameters[I].Value.SetInt32(StrToInt(Parametros_Valor[I]));
          TDBXDataTypes.Int64Type,
            TDBXDataTypes.Uint64Type:
            LDBXCommand.Parameters[I].Value.SetInt64(StrToInt64(Parametros_Valor[I]));
          TDBXDataTypes.VariantType:
            LDBXCommand.Parameters[I].Value.AsVariant := Parametros_Valor[I];
          TDBXDataTypes.AnsiStringType:
            LDBXCommand.Parameters[I].Value.AsString := Parametros_Valor[I];
          TDBXDataTypes.WideStringType:
            LDBXCommand.Parameters[I].Value.SetWideString(Parametros_Valor[I]);
          TDBXDataTypes.BlobType:
            LDBXCommand.Parameters[I].Value.SetWideString(Parametros_Valor[I]);
        else
          raise Exception.Create('Tipo ' + TDBXValueType.DataTypeName(LDBXCommand.Parameters[I].DataType) +
            ' não preparado para o parâmetro ' + LDBXCommand.Parameters[I].Name);
        end;

      LDBXCommand.ExecuteUpdate;

      if (PosRetorno > -1) then
      begin
        case LDBXCommand.Parameters[PosRetorno].DataType of
          TDBXDataTypes.BooleanType:
            Result := LDBXCommand.Parameters[PosRetorno].Value.AsBoolean;
          TDBXDataTypes.CurrencyType:
            Result := LDBXCommand.Parameters[PosRetorno].Value.AsCurrency;
          TDBXDataTypes.DateType,
            TDBXDataTypes.DateTimeType,
            TDBXDataTypes.TimeStampType:
            Result := LDBXCommand.Parameters[PosRetorno].Value.AsDateTime;
          // TDBXDataTypes.TimeType:
          // Result := LDBXCommand.Parameters[PosRetorno].Value.AsTime;
          TDBXDataTypes.DoubleType,
            TDBXDataTypes.BcdType:
            Result := LDBXCommand.Parameters[PosRetorno].Value.AsCurrency;
          TDBXDataTypes.UInt8Type,
            TDBXDataTypes.Int8Type:
            Result := LDBXCommand.Parameters[PosRetorno].Value.AsInt8;
          TDBXDataTypes.Int16Type:
            Result := LDBXCommand.Parameters[PosRetorno].Value.AsInt16;
          TDBXDataTypes.Int32Type:
            Result := LDBXCommand.Parameters[PosRetorno].Value.AsInt32;
          TDBXDataTypes.Int64Type,
            TDBXDataTypes.Uint64Type:
            Result := LDBXCommand.Parameters[PosRetorno].Value.AsInt64;
          TDBXDataTypes.VariantType:
            Result := LDBXCommand.Parameters[PosRetorno].Value.AsVariant;
          TDBXDataTypes.AnsiStringType,
            TDBXDataTypes.WideStringType:
            Result := LDBXCommand.Parameters[PosRetorno].Value.AsString;
          TDBXDataTypes.BlobType:
            Result := LDBXCommand.Parameters[PosRetorno].Value.AsVariant;
          TDBXDataTypes.JsonValueType:
            Result := LDBXCommand.Parameters[PosRetorno].Value.GetJSONValue.ToJSON;
          TDBXDataTypes.TableType:
            begin
              CDS := TClientDataSet.Create(nil);
              try
                Reader := LDBXCommand.Parameters[PosRetorno].Value.GetDBXReader(True);
                //{$IFDEF VER230}
                //TDBXDataSetReader.CopyReaderToClientDataSet(Reader, CDS);
                //{$ELSE}
                TDBXClientDataSetReader.CopyReaderToClientDataSet(Reader, CDS);
                //{$ENDIF}
                Result := CDS.Data;
              finally
                CDS.Free;
              end;
            end
        else
          raise Exception.Create('Tipo ' + TDBXValueType.DataTypeName(LDBXCommand.Parameters[PosRetorno].DataType) +
            ' não preparado para o retorno ' + LDBXCommand.Parameters[PosRetorno].Name);
        end;
      end;
    except
      on E: Exception do
      begin
        if (Pos('Socket Error #', E.Message) > 0) or
           ((Pos('Connection reset by peer', E.Message) > 0) or (Pos('Connection Closed Gracefully', E.Message) > 0) or (Pos('Software caused connection abort', E.Message) > 0)) then
        begin
          try
            ConexaoDS.Close;
          except
            //
          end;
        end;
        raise Exception.Create(E.Message + #13#13 + 'Execução do método ' + Metodo);
      end;
    end;
  finally
    LDBXCommand.Free;
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
