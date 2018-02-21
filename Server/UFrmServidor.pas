unit UFrmServidor;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.Menus, Vcl.AppEvnts, Vcl.Imaging.pngimage;

type
  TFrmServidor = class(TForm)
    pnlFundo: TPanel;
    imgBD: TImage;
    imgMonitor: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    AppEvents: TApplicationEvents;
    TrayIcon: TTrayIcon;
    pmServidor: TPopupMenu;
    mpRestore: TMenuItem;
    pmClose: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TrayIconDblClick(Sender: TObject);
    procedure AppEventsMinimize(Sender: TObject);
    procedure imgBDClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmServidor: TFrmServidor;

implementation

{$R *.dfm}

uses UFrmServerDatabase;

procedure TFrmServidor.AppEventsMinimize(Sender: TObject);
begin
  Self.Hide;
  Self.WindowState := wsMinimized;
end;

procedure TFrmServidor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmServidor.FormCreate(Sender: TObject);
begin
  Self.Hide;
  Self.WindowState := wsMinimized;
end;

procedure TFrmServidor.imgBDClick(Sender: TObject);
begin
  FrmServerDatabase := TFrmServerDatabase.Create(Self);
  FrmServerDatabase.ShowModal;
  FrmServerDatabase.FreeOnRelease;
end;

procedure TFrmServidor.TrayIconDblClick(Sender: TObject);
begin
  Show;
  Self.WindowState := wsNormal;
  Self.FormStyle := fsNormal;
end;

end.

