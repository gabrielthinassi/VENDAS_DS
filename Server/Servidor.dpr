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
  ClassHelper in '..\Class\ClassHelper.pas',
  USMPaiCadastro in 'USMPaiCadastro.pas' {SMPaiCadastro: TDSServerModule},
  USMCadStatus in 'USMCadStatus.pas' {SMCadStatus: TDSServerModule},
  ClassPessoa in '..\Class\ClassPessoa.pas',
  ClassPessoa_Endereco in '..\Class\ClassPessoa_Endereco.pas',
  USMCadPessoa in 'USMCadPessoa.pas' {SMCadPessoa: TDSServerModule},
  USMPaiConsulta in 'USMPaiConsulta.pas' {SMPaiConsulta: TDSServerModule},
  ClassPaiRelatorio in '..\Class\ClassPaiRelatorio.pas',
  ClassItem in '..\Class\ClassItem.pas',
  USMCadItem in 'USMCadItem.pas' {SMCadItem: TDSServerModule},
  ClassPedido in '..\Class\ClassPedido.pas',
  ClassPedido_Prazos in '..\Class\ClassPedido_Prazos.pas',
  ClassPedido_Item in '..\Class\ClassPedido_Item.pas',
  USMCadPedido in 'USMCadPedido.pas' {SMCadPedido: TDSServerModule},
  USMRelatorio in 'USMRelatorio.pas' {SMRelatorio: TDSServerModule},
  ClassSituacao in '..\Class\ClassSituacao.pas',
  USMCadSituacao in 'USMCadSituacao.pas' {SMCadSituacao: TDSServerModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TSMConexao, SMConexao);
  Application.CreateForm(TSC, SC);
  Application.CreateForm(TFrmServidor, FrmServidor);
  Application.CreateForm(TSMCadSituacao, SMCadSituacao);
  Application.Run;
end.

