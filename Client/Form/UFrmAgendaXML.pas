unit UFrmAgendaXML;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmPai, Data.DB, Datasnap.DBClient,
  Vcl.Mask, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons,
  Vcl.ExtCtrls;

type
  TFrmAgendaXML = class(TFrmPai)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtLocalXML: TEdit;
    RadioGroup1: TRadioGroup;
    GroupBox1: TGroupBox;
    BitBtn1: TBitBtn;
    Edit2: TEdit;
    DBGrid1: TDBGrid;
    Button1: TButton;
    Button2: TButton;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Button3: TButton;
    Button4: TButton;
    CDS: TClientDataSet;
    CDSNOME: TStringField;
    CDSTELEFONE: TStringField;
    DS: TDataSource;
    procedure RadioGroup1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAgendaXML: TFrmAgendaXML;

implementation

{$R *.dfm}

procedure TFrmAgendaXML.BitBtn1Click(Sender: TObject);
begin
  inherited;
  CDS.FindNearest([Edit2.Text]);
  //CDS.Locate('NOME',Edit2.Text,[loCaseInsensitive, loPartialKey]);
end;

procedure TFrmAgendaXML.Button1Click(Sender: TObject);
begin
  inherited;
  CDS.Post;
end;

procedure TFrmAgendaXML.Button2Click(Sender: TObject);
begin
  inherited;
  if FileExists(edtLocalXML.Text) then
    CDS.LoadFromFile(edtLocalXML.Text)
  else
    ShowMessage('Você ainda não possui uma agenda, insira algum número antes!');
end;

procedure TFrmAgendaXML.Button3Click(Sender: TObject);
begin
  inherited;
  if not CDS.Active then
    CDS.Open;
  CDS.Insert;
end;

procedure TFrmAgendaXML.Button4Click(Sender: TObject);
begin
  inherited;
  CDS.SaveToFile(edtLocalXML.Text, dfXML);
  CDS.Close;
  Close;
end;

procedure TFrmAgendaXML.FormCreate(Sender: TObject);
begin
  inherited;
  edtLocalXML.Text := ExtractFilePath(Application.ExeName) + 'Agenda.XML';
end;

procedure TFrmAgendaXML.RadioGroup1Click(Sender: TObject);
begin
  inherited;
  if RadioGroup1.ItemIndex = 0 then
    CDS.IndexFieldNames := 'NOME'
  else
    CDS.IndexFieldNames := 'TELEFONE';
  CDS.Close;
  CDS.Open;
end;

end.
