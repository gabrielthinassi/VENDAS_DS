unit UDMPai;

interface

uses
  SysUtils, Classes, DB, DBClient, Data.DBXDataSnap, Data.DBXCommon,
  IPPeerClient, Data.SqlExpr;

type
  TDMPai = class(TDataModule)
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
  end;

var
  DMPai: TDMPai;

implementation

{$R *.dfm}


procedure TDMPai.DataModuleDestroy(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to Self.ComponentCount - 1 do
  begin
    if ((Self.Components[I] is TClientDataSet) and
        (Self.Components[I] as TClientDataSet).Active) then
      (Self.Components[I] as TClientDataSet).Close;
  end;
end;

end.
