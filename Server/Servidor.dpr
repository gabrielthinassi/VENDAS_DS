program Servidor;

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  UFrmServidor in 'UFrmServidor.pas' {FrmServidor},
  USMPai in 'USMPai.pas' {SMPai: TDSServerModule},
  USC in 'USC.pas' {SC: TDataModule},
  UFrmServerDatabase in 'UFrmServerDatabase.pas' {FrmServerDatabase};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmServidor, FrmServidor);
  Application.CreateForm(TSC, SC);
  Application.Run;
end.

