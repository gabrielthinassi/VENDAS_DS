unit UFrmConfigServidorAplicacao;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  UFrmPai,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Buttons,
  IniFiles;

type
  TFrmConfigServidorAplicacao = class(TFrmPai)
    edtServidor: TEdit;
    edtPorta: TEdit;
    pnlFundo: TPanel;
    lblServidor: TLabel;
    lblPorta: TLabel;
    btnTestar: TSpeedButton;
    btnGravar: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnTestarClick(Sender: TObject);
  private
    { Private declarations }
    const NomeArquivoConfig = 'ClientConfig.ini';
  public
    { Public declarations }
  end;

var
  FrmConfigServidorAplicacao: TFrmConfigServidorAplicacao;

implementation

{$R *.dfm}

procedure TFrmConfigServidorAplicacao.btnTestarClick(Sender: TObject);
begin
  inherited;
  if DMConexao.TestaConexao(edtServidor.Text) then
    MensagemInformacao('Conexão efetuada com sucesso!');
end;

procedure TFrmConfigServidorAplicacao.FormCreate(Sender: TObject);
var
    ClienteConfig: TIniFile;
begin
  inherited;
    ClienteConfig := TIniFile.Create(ExtractFilePath(Application.ExeName) + NomeArquivoConfig);
    edtServidor.Text := ClienteConfig.ReadString('Configuracao', 'Servidor', 'localhost');
    edtPorta.Text := ClienteConfig.ReadString('Configuracao', 'Porta', '211');
    ClienteConfig.Free;
end;

end.
