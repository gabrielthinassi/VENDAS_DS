unit UDMCadStatus;

interface

uses
  System.SysUtils, System.Classes, UDMPaiCadastro, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect;

type
  TDMCadStatus = class(TDMPaiCadastro)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMCadStatus: TDMCadStatus;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses ClassStatus, UDMConexao;

{$R *.dfm}

procedure TDMCadStatus.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FClasseFilha := TClassStatus;
  DSPCCadastro.ServerClassName := 'TSMCadStatus';
end;

end.
