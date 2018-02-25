program Cliente;

uses
  Vcl.Forms,
  UFrmPrincipal in 'Form\UFrmPrincipal.pas' {FrmPrincipal},
  UFrmPai in 'Form\UFrmPai.pas' {FrmPai},
  UFrmPaiCadastro in 'Form\UFrmPaiCadastro.pas' {FrmPaiCadastro},
  ClassDataSet in '..\Class\ClassDataSet.pas',
  Constantes in '..\Class\Constantes.pas',
  UDMConexao in 'Dm\UDMConexao.pas' {DMConexao: TDataModule},
  UDMPai in 'Dm\UDMPai.pas' {DMPai: TDataModule},
  UDMPaiCadastro in 'Dm\UDMPaiCadastro.pas' {DMPaiCadastro: TDataModule},
  UFrmConfigServidorAplicacao in 'Form\UFrmConfigServidorAplicacao.pas' {FrmConfigServidorAplicacao};

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
  Application.Run;
end.
