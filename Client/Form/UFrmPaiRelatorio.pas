unit UFrmPaiRelatorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmPai, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Imaging.pngimage;

type
  TFrmPaiRelatorio = class(TFrmPai)
    pnlTop: TPanel;
    pnlBot: TPanel;
    pgctrlPrincipal: TPageControl;
    pgPrincipal: TTabSheet;
    lblTituloRelatorio: TLabel;
    imgImprimir: TImage;
    lblFechar: TLabel;
    imgCancelar: TImage;
    procedure lblFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPaiRelatorio: TFrmPaiRelatorio;

implementation

{$R *.dfm}

procedure TFrmPaiRelatorio.lblFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
