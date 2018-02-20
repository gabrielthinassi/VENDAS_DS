program Servidor;

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  UFrmServer in 'UFrmServer.pas' {FrmServer},
  USMBase in 'USMBase.pas' {SMBase: TDSServerModule},
  USC in 'USC.pas' {SC: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmServer, FrmServer);
  Application.CreateForm(TSC, SC);
  Application.Run;
end.

