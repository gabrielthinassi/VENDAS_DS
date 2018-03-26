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
  Funcoes in '..\Class\Funcoes.pas',
  ClassPessoa in '..\Class\ClassPessoa.pas',
  ClassPessoa_Endereco in '..\Class\ClassPessoa_Endereco.pas',
  UFrmCadPessoa in 'Form\UFrmCadPessoa.pas' {FrmCadPessoa},
  UDMCadPessoa in 'Dm\UDMCadPessoa.pas' {DMCadPessoa: TDataModule},
  UFrmLogin in 'Form\UFrmLogin.pas' {FrmLogin},
  UFrmPaiConsulta in 'Form\UFrmPaiConsulta.pas' {FrmPaiConsulta};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
