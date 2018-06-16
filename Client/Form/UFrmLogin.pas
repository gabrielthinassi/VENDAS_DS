unit UFrmLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmPai, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage;

type
  TFrmLogin = class(TFrmPai)
    edtLogin: TEdit;
    edtSenha: TEdit;
    imgLogin: TImage;
    lblFechar: TLabel;
    lblLogar: TLabel;
    procedure lblFecharClick(Sender: TObject);
    procedure edtSenhaKeyPress(Sender: TObject; var Key: Char);
    procedure lblLogarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

uses
  Funcoes, UFrmPrincipal;

{$R *.dfm}

procedure TFrmLogin.edtSenhaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if key = #13 then
  begin
    if ActiveControl = edtSenha then
    begin
      lblLogar.OnClick(lblLogar);
      FrmLogin.Close;
    end
    else
    begin
      Perform(WM_NEXTDLGCTL, 0, 0);
    end;
  end;

end;

procedure TFrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmLogin.Free;
end;

procedure TFrmLogin.lblFecharClick(Sender: TObject);
begin
  inherited;
  Application.Terminate;
end;

procedure TFrmLogin.lblLogarClick(Sender: TObject);
begin
  inherited;
  if edtLogin.Text = '' then
  begin
    ShowMessage('Usuário deve ser preenchido!');
    edtLogin.SetFocus;
    Exit;
  end;

  if edtSenha.Text = '' then
  begin
    ShowMessage('Senha deve ser preenchida!');
    edtSenha.SetFocus;
    Exit;
  end;

  FrmPrincipal := TFrmPrincipal(CriaForm(nil , FrmPrincipal, TFrmPrincipal, False, Sender));
end;

end.
