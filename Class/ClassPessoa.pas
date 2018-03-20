unit ClassPessoa;

interface

uses
  Classes,
  DB,
  SysUtils,
  ClassPaiCadastro,
  System.MaskUtils,
  DBClient,
  Windows,
  Data.SqlExpr,
  Data.DBConsts,
  Constantes;

type
  TClassPessoa = class(TClassPaiCadastro)
    class function Descricao: string; override;
    class function TabelaPrincipal: string; override;
    class function CampoChave: string; override;
    class function CampoDescricao: string; override;

    class function CamposCadastro: string; override;
    class function SQLBaseCadastro: string; override;
    class function SQLBaseRelatorio: string; override;
    class function SQLBaseConsulta: string; override;

    class function ParametrosSql: TListaDeParametrosSql; override;
    class procedure ConfigurarPropriedadesDoCampo(DataSet: TDataSet); override;
  end;

implementation

{ TClassPessoa }

class function TClassPessoa.CampoChave: string;
begin
  Result := 'CODIGO_PESSOA';
end;

class function TClassPessoa.CampoDescricao: string;
begin
  Result := 'RAZAOSOCIAL_PESSOA';
end;

class function TClassPessoa.CamposCadastro: string;
begin
  Result := 'PESSOA.CODIGO_PESSOA,       ' + #13 +
            'PESSOA.RAZAOSOCIAL_PESSOA,  ' + #13 +
            'PESSOA.NOMEFANTASIA_PESSOA, ' + #13 +
            'PESSOA.TIPO_PESSOA,         ' + #13 +
            'PESSOA.CNPJ_PESSOA,         ' + #13 +
            'PESSOA.CPF_PESSOA,          ' + #13 +
            'PESSOA.EMAIL_PESSOA,        ' + #13 +
            'PESSOA.CLIENTE_PESSOA,      ' + #13 +
            'PESSOA.OUTROS_PESSOA        ';

end;

class procedure TClassPessoa.ConfigurarPropriedadesDoCampo(DataSet: TDataSet);
var
  I     : Integer;
  Campo : String;
begin
  inherited;
  for I := 0 to DataSet.FieldCount - 1 do
  begin
    Campo := DataSet.Fields[I].FieldName;

    with DataSet.FieldByName(Campo) do
      if (Campo = 'CODIGO_PESSOA') then
      begin
        DisplayLabel := 'Código';
        CustomConstraint := sCC_ValueIsNotNullAndNotVazio;
      end
      else if (Campo = 'RAZAOSOCIAL_PESSOA') then
      begin
        DisplayLabel := 'Nome/Razão Social';
        CustomConstraint := sCC_ValueIsNotNullAndNotVazio;
        ConstraintErrorMessage := DisplayLabel + sCC_ErrorMessage;
      end
      else if (Campo = 'NOMEFANTASIA_PESSOA') then
      begin
        DisplayLabel := 'Fantasia/Apelido';
      end
      else if (Campo = 'TIPO_PESSOA') then
      begin
        DisplayLabel := 'Tipo de pessoa';
        CustomConstraint := sCC_ValueIsNotNullAndNotVazio;
      end
      else if (Campo = 'CNPJ_PESSOA') then
      begin
        DisplayLabel := 'CNPJ';
        EditMask := sMascaraCnpj;
      end
      else if (Campo = 'CPF_PESSOA') then
      begin
        DisplayLabel := 'CPF';
        EditMask := sMascaraCpf;
      end
      else if (Campo = 'EMAIL_PESSOA') then
      begin
        DisplayLabel := 'E-Mail';
      end
      else if (Campo = 'CLIENTE_PESSOA') then
      begin
        DisplayLabel := 'Cliente?';
        CustomConstraint := sCC_ValueIsNotNullAndNotVazio;
      end
      else if (Campo = 'OUTROS_PESSOA') then
      begin
        DisplayLabel := 'Outros?';
        CustomConstraint := sCC_ValueIsNotNullAndNotVazio;
      end;
  end;
end;

class function TClassPessoa.Descricao: string;
begin
  Result := 'Pessoa';
end;

class function TClassPessoa.ParametrosSql: TListaDeParametrosSql;
var
  Parametros: TListaDeParametrosSql;
begin
    SetLength(Parametros, 1);
    Parametros[0].Nome := 'COD';
    Parametros[0].Tipo := ftInteger;

    Result := Parametros;
end;

class function TClassPessoa.SQLBaseCadastro: string;
begin
  Result := 'SELECT'        + #13 +
            CamposCadastro  + #13 +
            'FROM PESSOA'   + #13 +
            'WHERE (PESSOA.CODIGO_PESSOA = :COD)';
end;

class function TClassPessoa.SQLBaseConsulta: string;
begin
  Result := 'SELECT'        + #13 +
            CamposCadastro  + #13 +
            'FROM PESSOA'   ;
end;

class function TClassPessoa.SQLBaseRelatorio: string;
begin
  Result := 'SELECT'        + #13 +
            CamposCadastro  + #13 +
            'FROM PESSOA'   ;
end;

class function TClassPessoa.TabelaPrincipal: string;
begin
  Result := 'PESSOA';
end;


initialization
  //Registra a Classe para ser utilizada posteriormente com a function FindClass('TClassStatus');
  //Pode ser utilizada para criação dinâmica de formulários;
  RegisterClass(TClassPessoa);

end.
