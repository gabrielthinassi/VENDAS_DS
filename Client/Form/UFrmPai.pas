unit UFrmPai;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  DBClient;

type
  TFrmPai = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure ConfiguraComponentes; virtual;
  public
  end;

var
  FrmPai: TFrmPai;

implementation

uses Constantes;

{$R *.dfm}

procedure TFrmPai.FormCreate(Sender: TObject);
begin
  //Centro do Form que o chamou
  Position := poOwnerFormCenter;
  ConfiguraComponentes;
end;

procedure TFrmPai.ConfiguraComponentes;
begin
// Sobrescrever nos filhos
end;

procedure TFrmPai.FormClose(Sender: TObject; var Action: TCloseAction);
var
  X: integer;
begin
  with Self do
    for X := 0 to ComponentCount - 1 do
    begin
      if (Components[X] is TClientDataSet) then
        (Components[X] as TClientDataSet).Close;
    end;
  Action := caFree;
end;

end.

