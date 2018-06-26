unit ClassHelper;

interface

uses
  System.SysUtils,
  System.Classes,
  Datasnap.DBClient,
  Data.DB,
  Data.SqlExpr,
  System.DateUtils,
  System.Variants,
  Data.FMTBcd,
  Vcl.ExtCtrls,
  Vcl.Graphics,
  System.JSON.Writers,
  System.StrUtils,
  Vcl.Grids,
  Vcl.DBGrids;

type

  TDataSetHelper = class Helper for TDataSet
  public
    procedure AdicionarCampos(const bVerificarSeJaExiste: Boolean = True);
    procedure RemoverCampos;
    procedure ConfigurarProviderFlags(const aChavePrimaria: array of const);
  end;

  TGridHelper = class Helper for TCustomDBGrid
  public
    function CriarColuna(const Campos: array of string; EstiloBotao: TColumnButtonStyle = cbsAuto): TColumn;
  end;

implementation

uses Constantes;

{$REGION 'TDataSetHelper'}

procedure TDataSetHelper.AdicionarCampos;
var
  X: Integer;
begin
  Active := False;

  FieldDefs.Update;
  for X := 0 to Pred(FieldDefs.Count) do
  begin
    if FindField(FieldDefs[x].Name) = nil then
      FieldDefs.Items[X].CreateField(Self);
  end;
  FieldDefs.EndUpdate;
end;

procedure TDataSetHelper.RemoverCampos;
begin
  Close;
  if (FieldCount > 0) then
    Fields.Clear;
  if (FieldDefs.Count > 0) then
    FieldDefs.Clear;
end;

procedure TDataSetHelper.ConfigurarProviderFlags(const aChavePrimaria: array of const);
var
  x, Y: integer;
begin
  for x := 0 to FieldDefList.Count - 1 do
  begin
    // Para todos os campos
    if Fields[x].Tag = CampoNaoAtualizavel then
    begin
      Fields[x].ProviderFlags := [];
      Fields[x].CustomConstraint := '';
      Fields[x].ConstraintErrorMessage := '';
    end
    else
    begin
      Fields[x].ProviderFlags := [pfInUpdate];
      Fields[x].Required := False;
    end;

    // Para as Chaves Primárias
    for Y := Low(aChavePrimaria) to High(aChavePrimaria) do
    begin
      if (AnsiUpperCase(FieldDefList[x].Name) = AnsiUpperCase(aChavePrimaria[Y].{$IFDEF VER185} VPChar {$ELSE} VPWideChar {$endif})) then
      begin
        Fields[x].ProviderFlags := [pfInUpdate, pfInWhere, pfInKey];
        Break;
      end;
    end;
  end;
end;

{$ENDREGION}


{$REGION 'TGridHelper'}

function TGridHelper.CriarColuna(const Campos: array of string;
  EstiloBotao: TColumnButtonStyle): TColumn;
var
  I: Integer;
  CampoTemp: TField;

  procedure AdicionaColuna(Campo: TField);
  var
    vFielKind: TFieldKind;
    vProviderFlag: TProviderFlags;
  begin
    Result := Self.Columns.Add;

    Result.Title.Alignment := taCenter;
    Result.FieldName := Campo.FieldName;

    if Campo.DataType in [ftDate, ftDateTime, ftTimeStamp] then
      Result.Alignment := taCenter;

    vFielKind := Campo.FieldKind;
    vProviderFlag := Campo.ProviderFlags;

    //Result.ReadOnly := (Campo.Tag = CampoNaoEditavel) or (vFielKind = fkInternalCalc) or (vProviderFlag = []);

    if Campo.Tag <> CampoNaoEditavel then
      Result.ButtonStyle := EstiloBotao;
  end;

begin
  if not Assigned(DataSource) then
    raise Exception.Create('Favor informar o DataSource da Grade ' + Name);

  if not Assigned(DataSource.DataSet) then
    raise Exception.Create('Favor informar o DataSet do DataSource da Grade ' + Name);

  Columns.BeginUpdate;
  try
    if (High(Campos) = -1) then
      for I := 0 to Pred(DataSource.DataSet.FieldCount) do
        AdicionaColuna(DataSource.DataSet.Fields[I])
    else
      for I := Low(Campos) to High(Campos) do
      begin
        CampoTemp := DataSource.DataSet.FindField(Campos[I]);

        if CampoTemp <> nil then
          AdicionaColuna(CampoTemp);
      end;
  finally
    Columns.EndUpdate;
  end;
end;

{$ENDREGION}
end.
