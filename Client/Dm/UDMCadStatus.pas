unit UDMCadStatus;

interface

uses
  System.SysUtils,
  System.Classes,
  UDMPaiCadastro,
  Data.DB,
  Datasnap.DBClient,
  Datasnap.DSConnect,
  //---//
  ClassStatus;

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

{$R *.dfm}

procedure TDMCadStatus.DataModuleCreate(Sender: TObject);
begin
  FClasseFilha := TClassStatus;
  DSPCCadastro.ServerClassName := 'TSMCadStatus';
  CDSCadastro.ProviderName := 'DSPCCadastro';
  inherited;
end;

end.
