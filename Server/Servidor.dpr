program Servidor;

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  UFrmServidor in 'UFrmServidor.pas' {FrmServidor},
  USMPai in 'USMPai.pas' {SMPai: TDSServerModule},
  USC in 'USC.pas' {SC: TDataModule},
  UFrmServerDatabase in 'UFrmServerDatabase.pas' {FrmServerDatabase},
  ClassPai in '..\Class\ClassPai.pas',
  ClassPaiCadastro in '..\Class\ClassPaiCadastro.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmServidor, FrmServidor);
  Application.CreateForm(TSC, SC);
  Application.Run;
end.

