unit ClassItem;

interface

uses
  Classes,
  DB,
  SysUtils,
  ClassPaiCadastro,
  Constantes;

type
  TClassItem = class(TClassPaiCadastro)
  public
    class function Descricao: string; override;
    class function TabelaPrincipal: string; override;
    class function CampoChave: string; override;
    class function CampoDescricao: string; override;

    class function CamposCadastro: string; override;
    class function SQLBaseCadastro: string; override;
    class function SQLBaseRelatorio: string; override;
    class function SQLBaseConsulta: string; override;

    class function CamposConsulta(Lista, Campos: TStrings): TStrings; override;

    class function ParametrosSql: TListaDeParametrosSql; override;
    class procedure ConfigurarPropriedadesDoCampo(DataSet: TDataSet); override;
  end;

implementation
  { TClassItem }

class function TClassItem.Descricao: string;
begin
  Result := 'Item';
end;

class function TClassItem.TabelaPrincipal: string;
begin
  Result := 'ITEM';
end;

class function TClassItem.CampoChave: string;
begin
  Result := 'CODIGO_ITEM';
end;

class function TClassItem.CampoDescricao: string;
begin
  Result := 'DESCRICAO_ITEM';
end;

class function TClassItem.CamposCadastro: string;
begin
  Result := ' ITEM.CODIGO_ITEM,     ' +
            ' ITEM.REFERENCIA_ITEM, ' +
            ' ITEM.UNIDADE_ITEM,    ' +
            ' ITEM.DESCRICAO_ITEM   ' ;
end;

class function TClassItem.CamposConsulta(Lista, Campos: TStrings): TStrings;
begin
  {0} Lista.Add('Código');
  {1} Lista.Add('Descrição');

  {0} Campos.Add('CODIGO_STATUS');
  {1} Campos.Add('DESCRICAO_STATUS');

  Result := Lista;
end;

class function TClassItem.SQLBaseCadastro: string;
begin
  Result := ' SELECT       ' + #13 +
            CamposCadastro   + #13 +
            ' FROM ITEM    ' + #13 +
            ' WHERE (ITEM.CODIGO_ITEM = :COD)';
end;

class function TClassItem.SQLBaseConsulta: string;
begin
  Result := ' SELECT       ' + #13 +
            CamposCadastro   + #13 +
            ' FROM ITEM    ' ;
end;

class function TClassItem.SQLBaseRelatorio: string;
begin
  Result := ' SELECT       ' + #13 +
            CamposCadastro   + #13 +
            ' FROM ITEM    ' ;
end;

class procedure TClassItem.ConfigurarPropriedadesDoCampo(DataSet: TDataSet);
var
  Campo : String;
  I     : Integer;
begin
  inherited;
  for I := 0 to DataSet.FieldCount - 1 do
  begin
    Campo := DataSet.Fields[I].FieldName;

    with DataSet.FieldByName(Campo) do
      if (Campo = 'CODIGO_ITEM') then
      begin
        DisplayLabel := 'Código'
      end
      else if (Campo = 'REFERENCIA_ITEM') then
      begin
        DisplayLabel := 'Referência do Item';
      end
      else if (Campo = 'DESCRICAO_ITEM') then
      begin
        DisplayLabel := 'Descrição do Item';
        CustomConstraint := sCC_ValueIsNotNullAndNotVazio;
        ConstraintErrorMessage := DisplayLabel + sCC_ErrorMessage;
      end
      else if (Campo = 'UNIDADE_ITEM') then
      begin
        DisplayLabel := 'Unidade do Item';
        CustomConstraint := sCC_ValueIsNotNullAndNotVazio;
        ConstraintErrorMessage := DisplayLabel + sCC_ErrorMessage;
      end
  end;
end;

class function TClassItem.ParametrosSql: TListaDeParametrosSql;
var
  Parametros: TListaDeParametrosSql;
begin
    SetLength(Parametros, 1);
    Parametros[0].Nome := 'COD';
    Parametros[0].Tipo := ftInteger;

    Result := Parametros;
end;

initialization
  //Registra a Classe para ser utilizada posteriormente com a function FindClass('TClassItem');
  //Pode ser utilizada para criação dinâmica de formulários;
  RegisterClass(TClassItem);

end.

