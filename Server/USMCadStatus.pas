unit USMCadStatus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, USMPaiCadastro, Data.FMTBcd,
  Datasnap.Provider, Data.DB, Data.SqlExpr;

type
  TSMCadStatus = class(TSMPaiCadastro)
  private
    { Private declarations }
  protected
    procedure DSServerModuleCreate_Filho(Sender: TObject); override;
  public
    { Public declarations }
  end;

var
  SMCadStatus: TSMCadStatus;

implementation

{$R *.dfm}

uses ClassStatus;

{ TSMCadStatus }

procedure TSMCadStatus.DSServerModuleCreate_Filho(Sender: TObject);
begin
  inherited;
  FClasseFilha := TClassStatus;
end;

end.
