unit UDMPaiRelatorio;

interface

uses
  System.SysUtils, System.Classes, UDMPai, frxClass, frxDBSet;

type
  TDMPaiRelatorio = class(TDMPai)
    frxReport: TfrxReport;
    FRPrincipal: TfrxDBDataset;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMPaiRelatorio: TDMPaiRelatorio;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMPaiRelatorio.DataModuleCreate(Sender: TObject);
begin
  inherited;
  with frxReport do
  begin
    PreviewOptions.ZoomMode := zmPageWidth;
    //Retirado alguns botões para evitar a edição do usuário
    PreviewOptions.Buttons := PreviewOptions.Buttons - [pbOutline, pbTools, pbEdit];

    EngineOptions.UseGlobalDataSetList := False;
    EngineOptions.DestroyForms         := True;
    EngineOptions.EnableThreadSafe     := True;
  end;
end;

end.
