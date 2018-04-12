inherited FrmCadItem: TFrmCadItem
  Caption = 'Cadastro de Item'
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlButtons: TPanel
    inherited btnPesquisar: TSpeedButton
      OnClick = btnPesquisarClick
    end
  end
  inherited pgctrlCadastro: TPageControl
    inherited tsPrincipal: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 366
      ExplicitHeight = 282
      object lblReferenciaItem: TLabel
        Left = 15
        Top = 16
        Width = 52
        Height = 13
        Caption = 'Refer'#234'ncia'
      end
      object lblUnidade: TLabel
        Left = 288
        Top = 16
        Width = 39
        Height = 13
        Caption = 'Unidade'
      end
      object lblDescricaoItem: TLabel
        Left = 15
        Top = 64
        Width = 46
        Height = 13
        Caption = 'Descri'#231#227'o'
      end
      object edtReferenciaItem: TDBEdit
        Left = 15
        Top = 35
        Width = 150
        Height = 21
        DataField = 'REFERENCIA_ITEM'
        DataSource = DSCadastro
        TabOrder = 0
      end
      object edtUnidadeItem: TDBEdit
        Left = 288
        Top = 35
        Width = 53
        Height = 21
        DataField = 'UNIDADE_ITEM'
        DataSource = DSCadastro
        TabOrder = 1
      end
      object edtDescricaoItem: TDBEdit
        Left = 15
        Top = 83
        Width = 326
        Height = 21
        DataField = 'DESCRICAO_ITEM'
        DataSource = DSCadastro
        TabOrder = 2
      end
    end
  end
  inherited DSCadastro: TDataSource
    Left = 152
    Top = 304
  end
  inherited pmOutros: TPopupMenu
    Left = 208
    Top = 304
  end
end
