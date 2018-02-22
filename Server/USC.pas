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
Datasnap.DSAuth;

type
  TSC = class(TDataModule)
    DSServer: TDSServer;
    DSTCPServerTransport: TDSTCPServerTransport;
    DSServerClass: TDSServerClass;
    procedure DSServerClassGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
  private
    { Private declarations }
  public
  end;

var
  SC: TSC;

implementation


{$R *.dfm}

uses USMPai;

procedure TSC.DSServerClassGetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := USMPai.TSMPai;
end;

end.

