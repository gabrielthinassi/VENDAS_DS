unit ClassSituacao;

interface

uses
  Classes,
  DB,
  SysUtils,
  ClassPaiCadastro,
  Constantes;

type
  TClassSituacao = class(TClassPaiCadastro)
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
  { TClassSituacao }

class function TClassSituacao.Descricao: string;
begin
  Result := 'Situação';
end;

class function TClassSituacao.TabelaPrincipal: string;
begin
  Result := 'SITUACAO';
end;

class function TClassSituacao.CampoChave: string;
begin
  Result := 'CODIGO_SITUACAO';
end;

class function TClassSituacao.CampoDescricao: string;
begin
  Result := 'DESCRICAO_SITUACAO';
end;

class function TClassSituacao.CamposCadastro: string;
begin
  Result := '  SITUACAO.CODIGO_SITUACAO,   ' +
            '  SITUACAO.DESCRICAO_SITUACAO ' ;
end;

class function TClassSituacao.CamposConsulta(Lista, Campos: TStrings): TStrings;
begin
  {0} Lista.Add('Código');
  {1} Lista.Add('Descrição');

  {0} Campos.Add('CODIGO_SITUACAO');
  {1} Campos.Add('DESCRICAO_SITUACAO');

  Result := Lista;
end;

class function TClassSituacao.SQLBaseCadastro: string;
begin
  Result := ' SELECT        ' + #13 +
            CamposCadastro    + #13 +
            ' FROM SITUACAO ' + #13 +
            ' WHERE (SITUACAO.CODIGO_SITUACAO = :COD)';
end;

class function TClassSituacao.SQLBaseConsulta: string;
begin
  Result := ' SELECT        ' + #13 +
            CamposCadastro    + #13 +
            ' FROM SITUACAO ' ;
end;

class function TClassSituacao.SQLBaseRelatorio: string;
begin
  Result := ' SELECT        ' + #13 +
            CamposCadastro    + #13 +
            ' FROM SITUACAO ' ;
end;

class procedure TClassSituacao.ConfigurarPropriedadesDoCampo(DataSet: TDataSet);
var
  Campo : String;
  I     : Integer;
begin
  inherited;
  for I := 0 to DataSet.FieldCount - 1 do
  begin
    Campo := DataSet.Fields[I].FieldName;

    with DataSet.FieldByName(Campo) do
      if (Campo = 'CODIGO_SITUACAO') then
      begin
        DisplayLabel := 'Código'
      end
      else if (Campo = 'DESCRICAO_SITUACAO') then
      begin
        DisplayLabel := 'Descrição da Situação';
        CustomConstraint := sCC_ValueIsNotNullAndNotVazio;
        ConstraintErrorMessage := DisplayLabel + sCC_ErrorMessage;
      end
  end;
end;

class function TClassSituacao.ParametrosSql: TListaDeParametrosSql;
var
  Parametros: TListaDeParametrosSql;
begin
    SetLength(Parametros, 1);
    Parametros[0].Nome := 'COD';
    Parametros[0].Tipo := ftInteger;

    Result := Parametros;
end;

initialization
  //Registra a Classe para ser utilizada posteriormente com a function FindClass('TClassSituacao');
  //Pode ser utilizada para criação dinâmica de formulários;
  RegisterClass(TClassSituacao);

end.

