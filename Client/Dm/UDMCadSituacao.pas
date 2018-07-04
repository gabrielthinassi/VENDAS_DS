unit UDMCadSituacao;

interface

uses
  System.SysUtils,
  System.Classes,
  UDMPaiCadastro,
  Data.DB,
  Datasnap.DBClient,
  Datasnap.DSConnect,
  ClassSituacao;

type
  TDMCadSituacao = class(TDMPaiCadastro)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMCadSituacao: TDMCadSituacao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMCadSituacao.DataModuleCreate(Sender: TObject);
begin
  FClasseFilha := TClassSituacao;
  DSPCCadastro.ServerClassName := 'TSMCadSituacao';
  CDSCadastro.ProviderName := 'DSPCCadastro';
  inherited;
end;

end.
