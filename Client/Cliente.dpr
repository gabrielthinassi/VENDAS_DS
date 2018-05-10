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
  UFrmPaiConsulta in 'Form\UFrmPaiConsulta.pas' {FrmPaiConsulta},
  UFrmCadPedido in 'Form\UFrmCadPedido.pas' {FrmCadPedido},
  UFrmPaiRelatorio in 'Form\UFrmPaiRelatorio.pas' {FrmPaiRelatorio},
  ClassPaiRelatorio in '..\Class\ClassPaiRelatorio.pas',
  ClassItem in '..\Class\ClassItem.pas',
  UFrmCadItem in 'Form\UFrmCadItem.pas' {FrmCadItem},
  UDMCadItem in 'Dm\UDMCadItem.pas' {DMCadItem: TDataModule},
  ClassPedido in '..\Class\ClassPedido.pas',
  ClassPedido_Item in '..\Class\ClassPedido_Item.pas',
  ClassPedido_Prazos in '..\Class\ClassPedido_Prazos.pas',
  UDMCadPedido in 'Dm\UDMCadPedido.pas' {DMCadPedido: TDataModule},
  UDMPaiRelatorio in 'Dm\UDMPaiRelatorio.pas' {DMPaiRelatorio: TDataModule},
  UFrmAgendaXML in 'Form\UFrmAgendaXML.pas' {FrmAgendaXML};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TDMPaiRelatorio, DMPaiRelatorio);
  Application.CreateForm(TFrmAgendaXML, FrmAgendaXML);
  Application.Run;
end.
