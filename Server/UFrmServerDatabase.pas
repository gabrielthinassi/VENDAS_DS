unit UFrmServerDatabase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids, Vcl.ValEdit,
  Vcl.Buttons;

type
  TFrmServerDatabase = class(TForm)
    pnlFundo: TPanel;
    pnlInferior: TPanel;
    lstConfigBD: TValueListEditor;
    btnGravar: TSpeedButton;
    btnTestar: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnTestarClick(Sender: TObject);
  private
    { Private declarations }
    const ConfigNome = 'ServerConfig.ini';
    var ConfigDiretorio : String;
    procedure CriaArquivoPadrao;
  public
    { Public declarations }
  end;

var
  FrmServerDatabase: TFrmServerDatabase;

implementation

{$R *.dfm}

uses USMConexao, Constantes;

procedure TFrmServerDatabase.btnGravarClick(Sender: TObject);
var
  Diretorio: string;
begin
  Diretorio := ExtractFilePath(Application.ExeName);
  lstConfigBD.Strings.SaveToFile(Diretorio + ConfigNome);
  ShowMessage('Atualizado Configurações do Banco de Dados!');
  FrmServerDatabase.Close;
end;

procedure TFrmServerDatabase.btnTestarClick(Sender: TObject);
begin
  try
    SMConexao.ConexaoBD.Connected := True;
    ShowMessage(sSucessoNaConexao);
  finally
    SMConexao.ConexaoBD.Connected := False;
  end;
end;

procedure TFrmServerDatabase.CriaArquivoPadrao;
var
  Arquivo : TextFile;
begin
  AssignFile(Arquivo, ConfigDiretorio + ConfigNome);
  Rewrite(Arquivo);
  Writeln(Arquivo, 'DriverUnit=Data.DBXFirebird');
  Writeln(Arquivo, 'DriverPackageLoader=TDBXDynalinkDriverLoader,DbxCommonDriver240.bpl');
  Writeln(Arquivo, 'DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,Borland.Data.DbxCommonDriver,Version=24.0.0.0,Culture=neutral,PublicKeyToken=91d62ebb5b0d1b1b');
  Writeln(Arquivo, 'MetaDataPackageLoader=TDBXFirebirdMetaDataCommandFactory,DbxFirebirdDriver240.bpl');
  Writeln(Arquivo, 'MetaDataAssemblyLoader=Borland.Data.TDBXFirebirdMetaDataCommandFactory,Borland.Data.DbxFirebirdDriver,Version=24.0.0.0,Culture=neutral,PublicKeyToken=91d62ebb5b0d1b1b');
  Writeln(Arquivo, 'GetDriverFunc=getSQLDriverINTERBASE');
  Writeln(Arquivo, 'LibraryName=dbxfb.dll');
  Writeln(Arquivo, 'LibraryNameOsx=libsqlfb.dylib');
  Writeln(Arquivo, 'VendorLib=fbclient.dll');
  Writeln(Arquivo, 'VendorLibWin64=fbclient.dll');
  Writeln(Arquivo, 'VendorLibOsx=/Library/Frameworks/Firebird.framework/Firebird');
  Writeln(Arquivo, 'Database=localhost/3054:C:\TRABALHO\VENDAS_DS\Data\VENDAS.FDB');
  Writeln(Arquivo, 'User_Name=sysdba');
  Writeln(Arquivo, 'Password=masterkey');
  Writeln(Arquivo, 'Role=RoleName');
  Writeln(Arquivo, 'MaxBlobSize=-1');
  Writeln(Arquivo, 'LocaleCode=0000');
  Writeln(Arquivo, 'IsolationLevel=ReadCommitted');
  Writeln(Arquivo, 'SQLDialect=3');
  Writeln(Arquivo, 'CommitRetain=False');
  Writeln(Arquivo, 'WaitOnLocks=True');
  Writeln(Arquivo, 'TrimChar=False');
  Writeln(Arquivo, 'BlobSize=-1');
  Writeln(Arquivo, 'ErrorResourceFile=');
  Writeln(Arquivo, 'RoleName=RoleName');
  Writeln(Arquivo, 'ServerCharSet=');
  Writeln(Arquivo, 'Trim Char=False');
  CloseFile(Arquivo);
end;

procedure TFrmServerDatabase.FormCreate(Sender: TObject);
begin
  ConfigDiretorio := ExtractFilePath(Application.ExeName);

  if not FileExists(ConfigDiretorio + ConfigNome) then
    CriaArquivoPadrao;
  lstConfigBD.Strings.LoadFromFile(ConfigDiretorio + ConfigNome);
end;

end.
