inherited FrmCadSituacao: TFrmCadSituacao
  Caption = 'Cadastro de Situa'#231#227'o'
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
      object lblDescricao: TLabel
        Left = 15
        Top = 16
        Width = 46
        Height = 13
        Caption = 'Descri'#231#227'o'
      end
      object dbedtDESCRICAO_SITUACAO: TDBEdit
        Left = 15
        Top = 35
        Width = 326
        Height = 21
        DataField = 'DESCRICAO_SITUACAO'
        DataSource = DSCadastro
        TabOrder = 0
      end
    end
  end
  inherited DSCadastro: TDataSource
    Left = 256
    Top = 296
  end
  inherited pmOutros: TPopupMenu
    Left = 184
    Top = 296
  end
end
