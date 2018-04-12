unit UDMCadItem;

interface

uses
  System.SysUtils,
  System.Classes,
  UDMPaiCadastro,
  Data.DB,
  Datasnap.DBClient,
  Datasnap.DSConnect,
  //---//
  ClassItem;

type
  TDMCadItem = class(TDMPaiCadastro)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMCadItem: TDMCadItem;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMCadItem.DataModuleCreate(Sender: TObject);
begin
  FClasseFilha := TClassItem;
  DSPCCadastro.ServerClassName := 'TSMCadItem';
  CDSCadastro.ProviderName := 'DSPCCadastro';
  inherited;
end;

end.
