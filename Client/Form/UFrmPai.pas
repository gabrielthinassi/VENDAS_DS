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
  DBClient,
  Data.DB,
  System.Classes,
  System.Math,
  Vcl.Grids,
  Vcl.DBGrids,
  JvExDBGrids,
  JvDBGrid, 
  Vcl.Mask, 
  JvExMask, 
  JvToolEdit, 
  JvBaseEdits, 
  JvDBControls,
  Vcl.DBCtrls, 
  JvExControls, 
  JvDBLookup, 
  Vcl.ComCtrls;

type
  TFrmPai = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    procedure ConfiguraComponentes; virtual;
  public
  end;

var
  FrmPai: TFrmPai;

implementation

uses Constantes, ClassHelper;

{$R *.dfm}

procedure TFrmPai.FormCreate(Sender: TObject);
begin
  //Centro do Form que o chamou
  Position := poOwnerFormCenter;
  ConfiguraComponentes;
end;

procedure TFrmPai.FormKeyPress(Sender: TObject; var Key: Char);
var
  T: TComponent;
  DataDBGridIsNull: Boolean;
  Dia, Mes, Ano: Word;
  PrimeiroDiaProximoMes: TDate;
begin
  T := Screen.ActiveControl;

  if (T is TDBGrid) then
    TDBGrid(T).ProximaColunaNaGrade(Key);

  if Key = #13 then
  begin
    if (T is TDBLookupComboBox) then
      with (T as TDBLookupComboBox) do
        if not ListVisible then
          Screen.ActiveForm.Perform(WM_NEXTDLGCTL, 0, 0);

    if (T is TDBComboBox) then
      with (T as TDBComboBox) do
        if not DroppedDown then
          Screen.ActiveForm.Perform(WM_NEXTDLGCTL, 0, 0);

    if (T is TJvDBLookupCombo) then
      with (T as TJvDBLookupCombo) do
        if not ListVisible then
          Screen.ActiveForm.Perform(WM_NEXTDLGCTL, 0, 0);

    if (T is TPageControl) then
      Screen.ActiveForm.Perform(WM_NEXTDLGCTL, 0, 0);

    if (T is TDBRadioGroup) then
      Screen.ActiveForm.Perform(WM_NEXTDLGCTL, 0, 0);
  end;

  if(T is TJvDateEdit) or (T is TJvDBDateEdit)then
  begin
  if (CharInSet(UpCase(Key), [Char(Ord('I'))]))then
    begin
      if TJvDateEdit(T).Date > 0 then
        DecodeDate(TJvDateEdit(T).Date, Ano, Mes, Dia)
      else
        DecodeDate(Date, Ano, Mes, Dia);

      TJvDateEdit(T).Clear;
      TJvDateEdit(T).Date := EncodeDate(ano, mes, 1);
    end
  else if (CharInSet(UpCase(Key), [Char(Ord('U'))]))then
    begin
      if TJvDateEdit(T).Date > 0 then
        DecodeDate(TJvDateEdit(T).Date, Ano, Mes, Dia)
      else
        DecodeDate(Date, Ano, Mes, Dia);

      if Mes = 12 then
      begin
        Mes := 1;
        Inc(Ano);
      end
      else
        inc(Mes);

      PrimeiroDiaProximoMes := EncodeDate(ano, mes, 1);
      TJvDateEdit(T).Clear;
      TJvDateEdit(T).Date   := PrimeiroDiaProximoMes-1;
    end;
  end;

  // Na grade ao pressionar T ou + ou - ou I ou U irá preencher a Data.
  if ((T is TJvDBGrid) or (T is TDBGrid)) and
     (dgEditing in (T as TDBGrid).Options) and
     ((T as TDBGrid).SelectedField <> nil) and ((T as TDBGrid).SelectedField.DataType in [ftDate, ftDateTime, ftTimeStamp]) and
     (not(T as TDBGrid).Columns[(T as TDBGrid).SelectedIndex].ReadOnly) then
  begin
    if (CharInSet(UpCase(Key), [Char(Ord('-')), Char(Ord('+')), Char(Ord('T')), Char(Ord('I')), Char(Ord('U'))]))then
    begin
      // Verificar como está a Data, assim que pressionou uma das teclas ('T', '+', '-')
      DataDBGridIsNull := ((T as TDBGrid).SelectedField.IsNull) or ((T as TDBGrid).SelectedField.AsDateTime = 0);

      // Colocar o DataSet em Edição se o mesmo não estiver.
      with (T as TDBGrid).DataSource.DataSet  do
        if not(State in [dsEdit, dsInsert]) then
          Edit;

      // Se Antes de pressionar ('T', '+', '-') a Data estava vazia ou foi pressionado a Tecla 'T'
      // Preencher com da Data de Hoje
      if ((DataDBGridIsNull) and
          (UpCase(Key) <> Char(Ord('I'))) and
          (UpCase(Key) <> Char(Ord('U')))) or (UpCase(Key) = Char(Ord('T')))then
        (T as TDBGrid).SelectedField.AsDateTime := Date
      else
      // Se a Data estava vazia ou foi pressionado a Tecla 'I'
      if ((DataDBGridIsNull) and (UpCase(Key) <> char(Ord('U')))) or
          (UpCase(Key) = Char(Ord('I'))) then
      begin
        // Se havia Data informada preencher com o primeiro dia do mês informado na data.
        if (T as TDBGrid).SelectedField.AsDateTime > 0 then
          DecodeDate((T as TDBGrid).SelectedField.AsDateTime, Ano, Mes, Dia)
        else
          // Se a data estava vazia informar o primeiro dia do mês corrente
          DecodeDate(Date, Ano, Mes, Dia);

        (T as TDBGrid).SelectedField.AsDateTime := EncodeDate(ano, mes, 1);
      end
      else
      // Se a Data estava vazia ou foi pressionado a Tecla 'U'
      if (DataDBGridIsNull) or (UpCase(Key) = Char(Ord('U'))) then
      begin
        // Se havia data informada preencher com o último dia do mês informado na data.
        if (T as TDBGrid).SelectedField.AsDateTime > 0 then
          DecodeDate((T as TDBGrid).SelectedField.AsDateTime, Ano, Mes, Dia)
        else
          // Se a data estava vazia informar o último dia do mês corrente
          DecodeDate(Date, Ano, Mes, Dia);

        if Mes = 12 then
        begin
          Mes := 1;
          Inc(Ano);
        end
        else
          inc(Mes);

        PrimeiroDiaProximoMes := EncodeDate(ano, mes, 1);
        (T as TDBGrid).SelectedField.AsDateTime := PrimeiroDiaProximoMes-1;
      end
      else
        // Se a Data já estava preenchida e foi pressionado '+' ou '-'
        // Incrementar ou Decrementar conforme a tecla pressionada
        (T as TDBGrid).SelectedField.AsDateTime := (T as TDBGrid).SelectedField.AsDateTime + IfThen(Key = Char(Ord('+')), 1, -1);
    end;
  end;
end;

procedure TFrmPai.ConfiguraComponentes;
var
  T: TComponent;
begin
  T := Screen.ActiveControl;

  if (T is TDBEdit) or (T is TJvDBCalcEdit) then
  begin
    if T.Tag = CampoNaoEditavelENaoAtualizavel then
    begin
      ActiveControl.Enabled := False;
    end;
  end;
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

