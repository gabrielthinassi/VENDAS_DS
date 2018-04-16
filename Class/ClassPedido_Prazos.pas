unit ClassPedido_Prazos;

interface

uses
  Classes,
  DB,
  SysUtils,
  ClassPaiCadastro,
  System.MaskUtils,
  Constantes;

type
  TClassPedido_Prazos = class(TClassPaiCadastro)
    class function Descricao: string; override;
    class function TabelaPrincipal: string; override;
    class function CampoChave: string; override;
    class function ClassRelacional: string; override;

    class function CamposCadastro: string; override;
    class function SQLBaseCadastro: string; override;

    class function ParametrosSql: TListaDeParametrosSql; override;
    class procedure ConfigurarPropriedadesDoCampo(DataSet: TDataSet); override;
  end;

implementation

{ TClassPedido_Prazos }

class function TClassPedido_Prazos.CampoChave: string;
begin
  Result := 'AUTOINC_PEDPRAZO';
end;

class function TClassPedido_Prazos.CamposCadastro: string;
begin
  Result := 'PEDIDO_PRAZOS.AUTOINC_PEDPRAZO,    ' + #13 +
            'PEDIDO_PRAZOS.CODIGO_PEDIDO,       ' + #13 +
            'PEDIDO_PRAZOS.DIAS_PEDPRAZO,       ' + #13 +
            'PEDIDO_PRAZOS.VENCIMENTO_PEDPRAZO  ' ;
end;


class function TClassPedido_Prazos.ClassRelacional: string;
begin
  Result := 'ClassPedido';
end;

class procedure TClassPedido_Prazos.ConfigurarPropriedadesDoCampo(DataSet: TDataSet);
var
  I     : Integer;
  Campo : String;
begin
  inherited;
  for I := 0 to DataSet.FieldCount - 1 do
  begin
    Campo := DataSet.Fields[I].FieldName;

    with DataSet.FieldByName(Campo) do
      if (Campo = 'AUTOINC_PEDPRAZO') then
      begin
        DisplayLabel := 'AutoIncremento';
        //CustomConstraint := sCC_ValueIsNotNullAndNotVazio;
      end
      else if (Campo = 'CODIGO_PEDIDO') then
      begin
        DisplayLabel := 'Código do Pedido';
        Visible := False;
      end
      else if (Campo = 'DIAS_PEDPRAZO') then
      begin
        DisplayLabel := 'Prazo';
      end
      else if (Campo = 'VENCIMENTO_PEDPRAZO') then
      begin
        DisplayLabel := 'Vencimento do Prazo';
        //CustomConstraint := sCC_ValueIsNotNullAndNotVazio;
      end;
  end;
end;

class function TClassPedido_Prazos.Descricao: string;
begin
  Result := 'Prazos do Pedido';
end;

class function TClassPedido_Prazos.ParametrosSql: TListaDeParametrosSql;
var
  Parametros: TListaDeParametrosSql;
begin
    SetLength(Parametros, 1);
    Parametros[0].Nome := 'CODIGO_PEDIDO';
    Parametros[0].Tipo := ftInteger;

    Result := Parametros;
end;

class function TClassPedido_Prazos.SQLBaseCadastro: string;
begin
  Result := 'SELECT             ' + #13 +
            CamposCadastro        + #13 +
            'FROM PEDIDO_PRAZOS ' + #13 +
            'WHERE (PEDIDO_PRAZOS.CODIGO_PEDIDO = :CODIGO_PEDIDO)';
end;

class function TClassPedido_Prazos.TabelaPrincipal: string;
begin
  Result := 'PEDIDO_PRAZOS';
end;


initialization
  //Registra a Classe para ser utilizada posteriormente com a function FindClass('TClassStatus');
  //Pode ser utilizada para criação dinâmica de formulários;
  RegisterClass(TClassPedido_Prazos);
end.
