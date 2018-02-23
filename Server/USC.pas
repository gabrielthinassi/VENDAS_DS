unit USC;

interface

uses
System.SysUtils,
System.Classes,
Datasnap.DSTCPServerTransport,
Datasnap.DSServer,
Datasnap.DSCommonServer,
IPPeerServer,
IPPeerAPI,
Datasnap.DSAuth,
Data.SqlExpr,
Datasnap.DSSession,
System.Generics.Collections,
Datasnap.dbclient;


type
  TSC = class(TDataModule)
    DSServer: TDSServer;
    DSTCPServerTransport: TDSTCPServerTransport;
    DSServerClass: TDSServerClass;
    procedure DSServerClassGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    //ListOfConnection: TDictionary<NativeInt, TSQLConnection>;
    //function GetConnection: TSQLConnection;
    //procedure ListConnection(CDS: TclientDataSet);
  end;

var
  SC: TSC;

implementation


{$R *.dfm}

uses USMPai, URegistraClassesServidoras;

procedure TSC.DataModuleCreate(Sender: TObject);
begin
  //Registrando as Classes Exportadas (Deve ser feito antes da Inicialização do Servidor)
  URegistraClassesServidoras.RegistrarClassesServidoras(Self, DSServer);
  DSServer.Start;

  //ListOfConnection := TDictionary<NativeInt, TSQLConnection>.Create;
end;

procedure TSC.DataModuleDestroy(Sender: TObject);
begin
  //ListOfConnection.Free;
  DSServer.Stop;
end;

procedure TSC.DSServerClassGetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := USMPai.TSMPai;
end;

end.

