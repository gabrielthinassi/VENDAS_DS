unit ClassPessoa_Endereco;

interface

uses
  Classes,
  DB,
  SysUtils,
  ClassPaiCadastro,
  Constantes,
  ClassDataSet;

type
  TClassPessoa_Endereco = class(TClassPaiCadastro)
  public
    class function Descricao: string; override;
    class function TabelaPrincipal: string; override;
    class function ClassRelacional: string; override;
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

{ TClassPessoa_Endereco }

class function TClassPessoa_Endereco.CampoChave: string;
begin
  Result := 'CODIGO_ENDERECOPESSOA';
end;

class function TClassPessoa_Endereco.CampoDescricao: string;
begin
  Result := 'RUA_ENDERECOPESSOA';
end;

class function TClassPessoa_Endereco.CamposCadastro: string;
begin
  Result := 'PESSOA_ENDERECO.CODIGO_ENDERECOPESSOA,   ' + #13 +
            'PESSOA_ENDERECO.TIPO_ENDERECOPESSOA,     ' + #13 +
            'PESSOA_ENDERECO.RUA_ENDERECOPESSOA,      ' + #13 +
            'PESSOA_ENDERECO.NUMERO_ENDERECOPESSOA,   ' + #13 +
            'PESSOA_ENDERECO.BAIRRO_ENDERECOPESSOA,   ' + #13 +
            'PESSOA_ENDERECO.CIDADE_ENDERECOPESSOA,   ' + #13 +
            'PESSOA_ENDERECO.CEP_ENDERECOPESSOA,      ' + #13 +
            'PESSOA_ENDERECO.UF_ENDERECOPESSOA,       ' + #13 +
            'PESSOA_ENDERECO.PAIS_ENDERECOPESSOA,     ' + #13 +
            'PESSOA_ENDERECO.TELEFONE_ENDERECOPESSOA, ' + #13 +
            'PESSOA_ENDERECO.CODIGO_PESSOA            ';

end;

class function TClassPessoa_Endereco.ClassRelacional: string;
begin
  Result := 'ClassPessoa';
end;

class procedure TClassPessoa_Endereco.ConfigurarPropriedadesDoCampo(DataSet: TDataSet);
var
  I     : Integer;
  Campo : String;
begin
  inherited;
  for I := 0 to DataSet.FieldCount - 1 do
  begin
    Campo := DataSet.Fields[I].FieldName;

    with DataSet.FieldByName(Campo) do
      if (Campo = 'CODIGO_ENDERECOPESSOA') then
      begin
        DisplayLabel := 'Código Endereço';
        Visible := False;
        //CustomConstraint := sCC_ValueIsNotNullAndNotVazio;
      end
      else if (Campo = 'TIPO_ENDERECOPESSOA') then
      begin
        DisplayLabel := 'Tipo do Endereço';
        Visible := False;
        CustomConstraint := sCC_ValueIsNotNullAndNotVazio;
      end
      else if (Campo = 'RUA_ENDERECOPESSOA') then
      begin
        DisplayLabel := 'Rua';
        CustomConstraint := sCC_ValueIsNotNullAndNotVazio;
        ConstraintErrorMessage := DisplayLabel + sCC_ErrorMessage;
      end
      else if (Campo = 'NUMERO_ENDERECOPESSOA') then
      begin
        DisplayLabel := 'Número';
      end
      else if (Campo = 'BAIRRO_ENDERECOPESSOA') then
      begin
        DisplayLabel := 'Bairro';
      end
      else if (Campo = 'CIDADE_ENDERECOPESSOA') then
      begin
        DisplayLabel := 'Cidade';
      end
      else if (Campo = 'CEP_ENDERECOPESSOA') then
      begin
        DisplayLabel := 'Cep';
        EditMask := sMascaraCep;
      end
      else if (Campo = 'UF_ENDERECOPESSOA') then
      begin
        DisplayLabel := 'UF';
      end
      else if (Campo = 'PAIS_ENDERECOPESSOA') then
      begin
        DisplayLabel := 'País';
      end
      else if (Campo = 'TELEFONE_ENDERECOPESSOA') then
      begin
        DisplayLabel := 'Telefone/Celular';
        EditMask := sMascaraTelefone;
      end
      else if (Campo = 'CODIGO_PESSOA') then
      begin
        DisplayLabel := 'Código da Pessoa';
        Visible := False;
        //CustomConstraint := sCC_ValueIsNotNullAndNotVazio;
      end;
  end;
end;

class function TClassPessoa_Endereco.Descricao: string;
begin
  Result := 'Endereço';
end;

class function TClassPessoa_Endereco.ParametrosSql: TListaDeParametrosSql;
var
  Parametros: TListaDeParametrosSql;
begin
    SetLength(Parametros, 1);
    Parametros[0].Nome := 'CODIGO_PESSOA';
    Parametros[0].Tipo := ftInteger;

    Result := Parametros;
end;

class function TClassPessoa_Endereco.SQLBaseCadastro: string;
begin
  Result := 'SELECT'                 + #13 +
            CamposCadastro           + #13 +
            'FROM PESSOA_ENDERECO'   + #13 +
            'WHERE PESSOA_ENDERECO.CODIGO_PESSOA = :CODIGO_PESSOA';
end;

class function TClassPessoa_Endereco.SQLBaseConsulta: string;
begin
  Result := 'SELECT'               + #13 +
            CamposCadastro         + #13 +
            'FROM PESSOA_ENDERECO' ;
end;

class function TClassPessoa_Endereco.SQLBaseRelatorio: string;
begin
  Result := 'SELECT'               + #13 +
            CamposCadastro         + #13 +
            'FROM PESSOA_ENDERECO' ;
end;

class function TClassPessoa_Endereco.TabelaPrincipal: string;
begin
  Result := 'PESSOA_ENDERECO';
end;


initialization
  //Registra a Classe para ser utilizada posteriormente com a function FindClass('TClassStatus');
  //Pode ser utilizada para criação dinâmica de formulários;
  RegisterClass(TClassPessoa_Endereco);

end.
