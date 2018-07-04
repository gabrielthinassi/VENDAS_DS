unit USMCadSituacao;

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
  ClassSituacao;

type
  TSMCadSituacao = class(TSMPaiCadastro)
  private
    { Private declarations }
  protected
    procedure DSServerModuleCreate_Filho(Sender: TObject); override;
  public
    { Public declarations }
  end;

var
  SMCadSituacao: TSMCadSituacao;

implementation

{$R *.dfm}

{ TSMCadSituacao }

procedure TSMCadSituacao.DSServerModuleCreate_Filho(Sender: TObject);
begin
  inherited;
  FClasseFilha := TClassSituacao;
end;

end.
