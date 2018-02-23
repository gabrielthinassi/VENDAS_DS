program Cliente;

uses
  Vcl.Forms,
  UFrmPrincipal in 'Form\UFrmPrincipal.pas' {FrmPrincipal},
  UFrmPai in 'Form\UFrmPai.pas' {FrmPai},
  UFrmPaiCadastro in 'Form\UFrmPaiCadastro.pas' {FrmPaiCadastro};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TFrmPai, FrmPai);
  Application.CreateForm(TFrmPaiCadastro, FrmPaiCadastro);
  Application.Run;
end.
