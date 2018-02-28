program Cliente;

uses
  Vcl.Forms,
  UFrmPrincipal in 'Form\UFrmPrincipal.pas' {FrmPrincipal},
  UFrmPai in 'Form\UFrmPai.pas' {FrmPai},
  UFrmPaiCadastro in 'Form\UFrmPaiCadastro.pas' {FrmPaiCadastro},
  UDMConexao in 'Dm\UDMConexao.pas' {DMConexao: TDataModule},
  UDMPai in 'Dm\UDMPai.pas' {DMPai: TDataModule},
  UDMPaiCadastro in 'Dm\UDMPaiCadastro.pas' {DMPaiCadastro: TDataModule},
  UFrmConfigServidorAplicacao in 'Form\UFrmConfigServidorAplicacao.pas' {FrmConfigServidorAplicacao},
  ClassDataSet in '..\Class\ClassDataSet.pas',
  ClassExpositorDeClasses in '..\Class\ClassExpositorDeClasses.pas',
  ClassPai in '..\Class\ClassPai.pas',
  ClassStatus in '..\Class\ClassStatus.pas',
  Constantes in '..\Class\Constantes.pas',
  ClassPaiCadastro in '..\Class\ClassPaiCadastro.pas',
  UFrmCadStatus in 'Form\UFrmCadStatus.pas' {FrmCadStatus},
  UDMCadStatus in 'Dm\UDMCadStatus.pas' {DMCadStatus: TDataModule},
  Funcoes in '..\Class\Funcoes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TFrmPai, FrmPai);
  Application.CreateForm(TFrmPaiCadastro, FrmPaiCadastro);
  Application.CreateForm(TDMConexao, DMConexao);
  Application.CreateForm(TDMPai, DMPai);
  Application.CreateForm(TDMPaiCadastro, DMPaiCadastro);
  Application.CreateForm(TFrmConfigServidorAplicacao, FrmConfigServidorAplicacao);
  Application.CreateForm(TFrmCadStatus, FrmCadStatus);
  Application.CreateForm(TDMCadStatus, DMCadStatus);
  Application.Run;
end.
