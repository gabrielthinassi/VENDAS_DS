unit USMCadItem;

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
  USMPaiCadastro,
  Data.FMTBcd,
  Datasnap.Provider,
  Data.DB,
  Data.SqlExpr,
  ClassItem;

type
  TSMCadItem = class(TSMPaiCadastro)
  private
    { Private declarations }
  protected
    procedure DSServerModuleCreate_Filho(Sender: TObject); override;
  public
    { Public declarations }
  end;

var
  SMCadItem: TSMCadItem;

implementation

{$R *.dfm}

{ TSMCadItem }

procedure TSMCadItem.DSServerModuleCreate_Filho(Sender: TObject);
begin
  inherited;
  FClasseFilha := TClassItem;
end;

end.
