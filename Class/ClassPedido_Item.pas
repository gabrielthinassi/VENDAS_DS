unit ClassPedido_Item;

interface

uses
  Classes,
  DB,
  SysUtils,
  ClassPaiCadastro,
  System.MaskUtils,
  Constantes;

type
  TClassPedido_Item = class(TClassPaiCadastro)
    class function Descricao: string; override;
    class function TabelaPrincipal: string; override;
    class function CampoChave: string; override;
    class function ClassRelacional: string; override;

    class function CamposCadastro: string; override;
    class function SQLBaseCadastro: string; override;
    class function SQLBaseRelatorio: string; override;

    class function ParametrosSql: TListaDeParametrosSql; override;
    class procedure ConfigurarPropriedadesDoCampo(DataSet: TDataSet); override;
  end;

implementation

{ TClassPedido_Item }

class function TClassPedido_Item.CampoChave: string;
begin
  Result := 'AUTOINC_PEDITEM';
end;

class function TClassPedido_Item.CamposCadastro: string;
begin
  Result := 'PEDIDO_ITEM.AUTOINC_PEDITEM,        ' + #13 +
            'PEDIDO_ITEM.CODIGO_PEDIDO,          ' + #13 +
            'PEDIDO_ITEM.CODIGO_ITEM,            ' + #13 +
            'PEDIDO_ITEM.QTD_PEDITEM,            ' + #13 +
            'PEDIDO_ITEM.VLRUNITBRUTO_PEDITEM,   ' + #13 +
            'PEDIDO_ITEM.VLRUNITLIQUIDO_PEDITEM, ' + #13 +
            'PEDIDO_ITEM.VLRTOTBRUTO_PEDITEM,    ' + #13 +
            'PEDIDO_ITEM.VLRTOTLIQUIDO_PEDITEM   ' ;
end;


class function TClassPedido_Item.ClassRelacional: string;
begin
  Result := 'ClassPedido';
end;

class procedure TClassPedido_Item.ConfigurarPropriedadesDoCampo(DataSet: TDataSet);
var
  I     : Integer;
  Campo : String;
begin
  inherited;
  for I := 0 to DataSet.FieldCount - 1 do
  begin
    Campo := DataSet.Fields[I].FieldName;

    with DataSet.FieldByName(Campo) do
      if (Campo = 'AUTOINC_PEDITEM') then
      begin
        DisplayLabel := 'AutoIncremento';
        Visible := False;
      end
      else if (Campo = 'CODIGO_PEDIDO') then
      begin
        DisplayLabel := 'Código do Pedido';
        Visible := False;
      end
      else if (Campo = 'CODIGO_ITEM') then
      begin
        DisplayLabel := 'Item';
        Index := 0;
        DisplayWidth := 5;
      end
      else if (Campo = 'REFERENCIA_ITEM') then
      begin
        DisplayLabel := 'Referência';
        Tag := CampoNaoEditavel;
        Index := 1;
        DisplayWidth := 10;
        Visible := False;
      end
      else if (Campo = 'DESCRICAO_ITEM') then
      begin
        DisplayLabel := 'Descrição';
        Tag := CampoNaoEditavel;
        Index := 2;
        DisplayWidth := 20;
      end
      else if (Campo = 'UNIDADE_ITEM') then
      begin
        DisplayLabel := 'UN';
        Tag := CampoNaoEditavel;
        Index := 3;
        DisplayWidth := 3;
      end
      else if (Campo = 'QTD_PEDITEM') then
      begin
        DisplayLabel := 'Quantidade';
        Index := 4;
        DisplayWidth := 5;
      end
      else if (Campo = 'VLRUNITBRUTO_PEDITEM') then
      begin
        DisplayLabel := 'Vlr.Unit.Bruto';
        Index := 4;
        DisplayWidth := 5;
      end
      else if (Campo = 'VLRUNITLIQUIDO_PEDITEM') then
      begin
        DisplayLabel := 'Vlr.Unit.Liquido';
        Tag := CampoNaoEditavel;
        Index := 6;
        DisplayWidth := 5;
      end
      else if (Campo = 'VLRTOTBRUTO_PEDITEM') then
      begin
        DisplayLabel := 'Vlr.Tot.Bruto';
        Tag := CampoNaoEditavel;
        Index := 7;
        DisplayWidth := 5;
      end
      else if (Campo = 'VLRTOTLIQUIDO_PEDITEM') then
      begin
        DisplayLabel := 'Vlr.Tot.Liquido';
        Tag := CampoNaoEditavel;
        Index := 8;
        DisplayWidth := 5;
      end;
  end;
end;

class function TClassPedido_Item.Descricao: string;
begin
  Result := 'Itens do Pedido';
end;

class function TClassPedido_Item.ParametrosSql: TListaDeParametrosSql;
var
  Parametros: TListaDeParametrosSql;
begin
    SetLength(Parametros, 1);
    Parametros[0].Nome := 'CODIGO_PEDIDO';
    Parametros[0].Tipo := ftInteger;

    Result := Parametros;
end;

class function TClassPedido_Item.SQLBaseCadastro: string;
begin
  Result := 'SELECT                  ' + #13 +
            CamposCadastro      + ', ' + #13 +
            '  ITEM.REFERENCIA_ITEM, ' + #13 +
            '  ITEM.DESCRICAO_ITEM,  ' + #13 +
            '  ITEM.UNIDADE_ITEM     ' + #13 +
            'FROM PEDIDO_ITEM        ' + #13 +
            'LEFT JOIN ITEM ON (ITEM.CODIGO_ITEM = PEDIDO_ITEM.CODIGO_ITEM) ' + #13 +
            'WHERE (PEDIDO_ITEM.CODIGO_PEDIDO = :CODIGO_PEDIDO)';
end;

class function TClassPedido_Item.SQLBaseRelatorio: string;
begin
  Result := 'SELECT                  ' + #13 +
            CamposCadastro      + ', ' + #13 +
            '  ITEM.REFERENCIA_ITEM, ' + #13 +
            '  ITEM.DESCRICAO_ITEM,  ' + #13 +
            '  ITEM.UNIDADE_ITEM     ' + #13 +
            'FROM PEDIDO_ITEM        ' + #13 +
            'LEFT JOIN ITEM ON (ITEM.CODIGO_ITEM = PEDIDO_ITEM.CODIGO_ITEM) ' + #13 +
            'WHERE (PEDIDO_ITEM.CODIGO_PEDIDO = :CODIGO_PEDIDO)';
end;

class function TClassPedido_Item.TabelaPrincipal: string;
begin
  Result := 'PEDIDO_ITEM';
end;


initialization
  //Registra a Classe para ser utilizada posteriormente com a function FindClass('TClassStatus');
  //Pode ser utilizada para criação dinâmica de formulários;
  RegisterClass(TClassPedido_Item);
end.
