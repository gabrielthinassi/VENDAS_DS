unit ClassPedido;

interface

uses
  Classes,
  DB,
  SysUtils,
  ClassPaiCadastro,
  System.MaskUtils,
  Constantes;

type
  TClassPedido = class(TClassPaiCadastro)
    class function Descricao: string; override;
    class function TabelaPrincipal: string; override;
    class function CampoChave: string; override;

    class function CamposCadastro: string; override;
    class function SQLBaseCadastro: string; override;
    class function SQLBaseRelatorio: string; override;
    class function SQLBaseConsulta: string; override;

    class function CamposConsulta(Lista, Campos: TStrings): TStrings; override;

    class function ParametrosSql: TListaDeParametrosSql; override;
    class procedure ConfigurarPropriedadesDoCampo(DataSet: TDataSet); override;
  end;

implementation

{ TClassPedido }

class function TClassPedido.CampoChave: string;
begin
  Result := 'CODIGO_PEDIDO';
end;

class function TClassPedido.CamposCadastro: string;
begin
  Result := 'PEDIDO.CODIGO_PEDIDO,       ' + #13 +
            'PEDIDO.TIPO_PEDIDO,         ' + #13 +
            'PEDIDO.CODIGO_PESSOA,       ' + #13 +
            'PEDIDO.CODIGO_ENDERECO,     ' + #13 +
            'PEDIDO.DTEMISSAO_PEDIDO,    ' + #13 +
            'PEDIDO.CONDICAOPAG_PEDIDO,  ' + #13 +
            'PEDIDO.DESCONTOPERC_PEDIDO, ' + #13 +
            'PEDIDO.DESCONTOVLR_PEDIDO,  ' + #13 +
            'PEDIDO.VLRBRUTO_PEDIDO,     ' + #13 +
            'PEDIDO.VLRLIQUIDO_PEDIDO,   ' + #13 +
            'PEDIDO.PEDCONSULTOR_PEDIDO  ' ;

end;

class function TClassPedido.CamposConsulta(Lista, Campos: TStrings): TStrings;
begin
  {0}  Lista.Add('Pedido (Código)');
  {1}  Lista.Add('0-Venda / 1-Assist.');
  {2}  Lista.Add('Pessoa (Código)');
  {3}  Lista.Add('Nome/Razão Social');
  {4}  Lista.Add('Apelido/Nome Fantasia');
  {5}  Lista.Add('CNPJ');
  {6}  Lista.Add('CPF');
  {7}  Lista.Add('Cidade (Nome)');
  {8}  Lista.Add('UF (Sigla)');
  {9}  Lista.Add('País (Nome)');
  {10} Lista.Add('Telefone');
  {11} Lista.Add('Emissão');
  {12} Lista.Add('Valor Bruto');
  {13} Lista.Add('Valor Líquido');
  {14} Lista.Add('Pedido do Consultor');

  {0}  Campos.Add('CODIGO_PEDIDO');
  {1}  Campos.Add('TIPO_PEDIDO');
  {2}  Campos.Add('CODIGO_PESSOA');
  {3}  Campos.Add('RAZAOSOCIAL_PESSOA');
  {4}  Campos.Add('NOMEFANTASIA_PESSOA');
  {5}  Campos.Add('CNPJ_PESSOA');
  {6}  Campos.Add('CPF_PESSOA');
  {7}  Campos.Add('CIDADE_ENDERECOPESSOA');
  {8}  Campos.Add('UF_ENDERECOPESSOA');
  {9}  Campos.Add('PAIS_ENDERECOPESSOA');
  {10} Campos.Add('TELEFONE_ENDERECOPESSOA');
  {11} Campos.Add('DTEMISSAO_PEDIDO');
  {12} Campos.Add('VLRBRUTO_PEDIDO');
  {13} Campos.Add('VLRLIQUIDO_PEDIDO');
  {14} Campos.Add('PEDCONSULTOR_PEDIDO');

  Result := Lista;
end;

class procedure TClassPedido.ConfigurarPropriedadesDoCampo(DataSet: TDataSet);
var
  I     : Integer;
  Campo : String;
begin
  inherited;
  for I := 0 to DataSet.FieldCount - 1 do
  begin
    Campo := DataSet.Fields[I].FieldName;

    with DataSet.FieldByName(Campo) do
      if (Campo = 'CODIGO_PEDIDO') then
      begin
        DisplayLabel := 'Código';
        //CustomConstraint := sCC_ValueIsNotNullAndNotVazio;
      end
      else if (Campo = 'TIPO_PEDIDO') then
      begin
        DisplayLabel := 'Tipo';
        CustomConstraint := sCC_ValueIsNotNullAndNotVazio;
        ConstraintErrorMessage := DisplayLabel + sCC_ErrorMessage;
      end
      else if (Campo = 'CODIGO_PESSOA') then
      begin
        DisplayLabel := 'Pessoa';
        CustomConstraint := sCC_ValueIsNotNullAndNotVazio;
        ConstraintErrorMessage := DisplayLabel + sCC_ErrorMessage;
      end
      else if (Campo = 'CODIGO_ENDERECO') then
      begin
        DisplayLabel := 'Endereço';
        CustomConstraint := sCC_ValueIsNotNullAndNotVazio;
        ConstraintErrorMessage := DisplayLabel + sCC_ErrorMessage;
      end
      else if (Campo = 'DTEMISSAO_PEDIDO') then
      begin
        DisplayLabel := 'Emissão';
        CustomConstraint := sCC_ValueIsNotNullAndNotVazio;
        ConstraintErrorMessage := DisplayLabel + sCC_ErrorMessage;
        EditMask := sMascaraData;
        //DefaultExpression pra buscar a Data Atual
        //DefaultExpression := DateToStr(Date);
      end
      else if (Campo = 'CONDICAOPAG_PEDIDO') then
      begin
        DisplayLabel := 'Condição de Pagamento';
        CustomConstraint := sCC_ValueIsNotNullAndNotVazio;
        ConstraintErrorMessage := DisplayLabel + sCC_ErrorMessage;
      end
      else if (Campo = 'DESCONTOPERC_PEDIDO') then
      begin
        DisplayLabel := 'Desconto ( % )';
      end
      else if (Campo = 'DESCONTOVLR_PEDIDO') then
      begin
        DisplayLabel := 'Desconto ( $ )';
      end
      else if (Campo = 'VLRBRUTO_PEDIDO') then
      begin
        DisplayLabel := 'Valor Bruto';
      end
      else if (Campo = 'VLRLIQUIDO_PEDIDO') then
      begin
        DisplayLabel := 'Valor Líquido';
      end
      else if (Campo = 'PEDCONSULTOR_PEDIDO') then
      begin
        DisplayLabel := 'Pedido do Consultor';
      end;
  end;
end;

class function TClassPedido.Descricao: string;
begin
  Result := 'Pedido';
end;

class function TClassPedido.ParametrosSql: TListaDeParametrosSql;
var
  Parametros: TListaDeParametrosSql;
begin
    SetLength(Parametros, 1);
    Parametros[0].Nome := 'COD';
    Parametros[0].Tipo := ftInteger;

    Result := Parametros;
end;

class function TClassPedido.SQLBaseCadastro: string;
begin
  Result := 'SELECT                       ' + #13 +
            CamposCadastro           + ', ' + #13 +
            '  PESSOA.RAZAOSOCIAL_PESSOA  ' + #13 +
            'FROM PEDIDO                  ' + #13 +
            'LEFT JOIN PESSOA ON (PEDIDO.CODIGO_PESSOA = PESSOA.CODIGO_PESSOA) ' + #13 +
            'WHERE (PEDIDO.CODIGO_PEDIDO = :COD)';
end;

class function TClassPedido.SQLBaseConsulta: string;
begin
  Result := 'SELECT                                      ' + #13 +
            '  PEDIDO.CODIGO_PEDIDO,                     ' + #13 +
            '  PEDIDO.TIPO_PEDIDO,                       ' + #13 +
            '  PEDIDO.CODIGO_PESSOA,                     ' + #13 +
            '  PESSOA.RAZAOSOCIAL_PESSOA,                ' + #13 +
            '  PESSOA.NOMEFANTASIA_PESSOA,               ' + #13 +
            '  PESSOA.CNPJ_PESSOA,                       ' + #13 +
            '  PESSOA.CPF_PESSOA,                        ' + #13 +
            '  PESSOA.EMAIL_PESSOA,                      ' + #13 +
            '  PEDIDO.CODIGO_ENDERECO,                   ' + #13 +
            '  PESSOA_ENDERECO.TIPO_ENDERECOPESSOA,      ' + #13 +
            '  PESSOA_ENDERECO.RUA_ENDERECOPESSOA,       ' + #13 +
            '  PESSOA_ENDERECO.NUMERO_ENDERECOPESSOA,    ' + #13 +
            '  PESSOA_ENDERECO.BAIRRO_ENDERECOPESSOA,    ' + #13 +
            '  PESSOA_ENDERECO.CIDADE_ENDERECOPESSOA,    ' + #13 +
            '  PESSOA_ENDERECO.CEP_ENDERECOPESSOA,       ' + #13 +
            '  PESSOA_ENDERECO.UF_ENDERECOPESSOA,        ' + #13 +
            '  PESSOA_ENDERECO.PAIS_ENDERECOPESSOA,      ' + #13 +
            '  PESSOA_ENDERECO.TELEFONE_ENDERECOPESSOA,  ' + #13 +
            '  PEDIDO.DTEMISSAO_PEDIDO,                  ' + #13 +
            '  PEDIDO.CONDICAOPAG_PEDIDO,                ' + #13 +
            '  PEDIDO.DESCONTOPERC_PEDIDO,               ' + #13 +
            '  PEDIDO.DESCONTOVLR_PEDIDO,                ' + #13 +
            '  PEDIDO.VLRBRUTO_PEDIDO,                   ' + #13 +
            '  PEDIDO.VLRLIQUIDO_PEDIDO,                 ' + #13 +
            '  PEDIDO.PEDCONSULTOR_PEDIDO                ' + #13 +
            'FROM PEDIDO                                 ' + #13 +
            'LEFT JOIN PESSOA          ON (PEDIDO.CODIGO_PESSOA    = PESSOA.CODIGO_PESSOA)                  ' + #13 +
            'LEFT JOIN PESSOA_ENDERECO ON (PEDIDO.CODIGO_ENDERECO  = PESSOA_ENDERECO.CODIGO_ENDERECOPESSOA) ' ;
end;

class function TClassPedido.SQLBaseRelatorio: string;
begin
  Result := 'SELECT                                      ' + #13 +
            '  PEDIDO.CODIGO_PEDIDO,                     ' + #13 +
            '  PEDIDO.TIPO_PEDIDO,                       ' + #13 +
            '  PEDIDO.CODIGO_PESSOA,                     ' + #13 +
            '  PESSOA.RAZAOSOCIAL_PESSOA,                ' + #13 +
            '  PESSOA.NOMEFANTASIA_PESSOA,               ' + #13 +
            '  PESSOA.CNPJ_PESSOA,                       ' + #13 +
            '  PESSOA.CPF_PESSOA,                        ' + #13 +
            '  PESSOA.EMAIL_PESSOA,                      ' + #13 +
            '  PEDIDO.CODIGO_ENDERECO,                   ' + #13 +
            '  PESSOA_ENDERECO.TIPO_ENDERECOPESSOA,      ' + #13 +
            '  PESSOA_ENDERECO.RUA_ENDERECOPESSOA,       ' + #13 +
            '  PESSOA_ENDERECO.NUMERO_ENDERECOPESSOA,    ' + #13 +
            '  PESSOA_ENDERECO.BAIRRO_ENDERECOPESSOA,    ' + #13 +
            '  PESSOA_ENDERECO.CIDADE_ENDERECOPESSOA,    ' + #13 +
            '  PESSOA_ENDERECO.CEP_ENDERECOPESSOA,       ' + #13 +
            '  PESSOA_ENDERECO.UF_ENDERECOPESSOA,        ' + #13 +
            '  PESSOA_ENDERECO.PAIS_ENDERECOPESSOA,      ' + #13 +
            '  PESSOA_ENDERECO.TELEFONE_ENDERECOPESSOA,  ' + #13 +
            '  PEDIDO.DTEMISSAO_PEDIDO,                  ' + #13 +
            '  PEDIDO.CONDICAOPAG_PEDIDO,                ' + #13 +
            '  PEDIDO.DESCONTOPERC_PEDIDO,               ' + #13 +
            '  PEDIDO.DESCONTOVLR_PEDIDO,                ' + #13 +
            '  PEDIDO.VLRBRUTO_PEDIDO,                   ' + #13 +
            '  PEDIDO.VLRLIQUIDO_PEDIDO,                 ' + #13 +
            '  PEDIDO.PEDCONSULTOR_PEDIDO                ' + #13 +
            'FROM PEDIDO                                 ' + #13 +
            'LEFT JOIN PESSOA          ON (PEDIDO.CODIGO_PESSOA    = PESSOA.CODIGO_PESSOA)                  ' + #13 +
            'LEFT JOIN PESSOA_ENDERECO ON (PEDIDO.CODIGO_ENDERECO  = PESSOA_ENDERECO.CODIGO_ENDERECOPESSOA) ' ;
end;

class function TClassPedido.TabelaPrincipal: string;
begin
  Result := 'PEDIDO';
end;


initialization
  //Registra a Classe para ser utilizada posteriormente com a function FindClass('TClassStatus');
  //Pode ser utilizada para criação dinâmica de formulários;
  RegisterClass(TClassPedido);
end.
