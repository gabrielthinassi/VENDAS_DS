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
  ClassPaiCadastro in '..\Class\ClassPaiCadastro.pas',
  URegistraClassesServidoras in 'URegistraClassesServidoras.pas',
  ClassExpositorDeClasses in '..\Class\ClassExpositorDeClasses.pas',
  ClassStatus in '..\Class\ClassStatus.pas',
  USMConexao in 'USMConexao.pas' {SMConexao: TDSServerModule},
  Constantes in '..\Class\Constantes.pas',
  ClassDataSet in '..\Class\ClassDataSet.pas',
  USMPaiCadastro in 'USMPaiCadastro.pas' {SMPaiCadastro: TDSServerModule},
  USMCadStatus in 'USMCadStatus.pas' {SMCadStatus: TDSServerModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmServidor, FrmServidor);
  Application.CreateForm(TSC, SC);
  Application.Run;
end.

