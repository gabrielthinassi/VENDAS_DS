unit UFrmServer;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.Menus, Vcl.AppEvnts;

type
  TFrmServer = class(TForm)
    pnlBackground: TPanel;
    imgDB: TImage;
    imgMonitor: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    AppEvents: TApplicationEvents;
    TrayIcon: TTrayIcon;
    pmServer: TPopupMenu;
    mpRestore: TMenuItem;
    pmClose: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TrayIconDblClick(Sender: TObject);
    procedure AppEventsMinimize(Sender: TObject);
    procedure imgDBClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmServer: TFrmServer;

implementation

{$R *.dfm}

procedure TFrmServer.AppEventsMinimize(Sender: TObject);
begin
  Self.Hide;
  Self.WindowState := wsMinimized;
end;

procedure TFrmServer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmServer.FormCreate(Sender: TObject);
begin
  Self.Hide;
  Self.WindowState := wsNormal;
end;

procedure TFrmServer.imgDBClick(Sender: TObject);
begin
  frmConfigDatabase := TfrmConfigDatabase.Create(Self);
  frmConfigDatabase.ShowModal;
  frmConfigDatabase.FreeOnRelease;
end;

procedure TFrmServer.TrayIconDblClick(Sender: TObject);
begin
  Show;
  Self.WindowState := wsNormal;
  Self.FormStyle := fsNormal;
end;

end.

