inherited FrmCadStatus: TFrmCadStatus
  Caption = 'Cadastro de Status'
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
      object lblDescricaoStatus: TLabel
        Left = 15
        Top = 16
        Width = 46
        Height = 13
        Caption = 'Descri'#231#227'o'
      end
      object edtDescricao: TDBEdit
        Left = 15
        Top = 35
        Width = 326
        Height = 21
        DataField = 'DESCRICAO_STATUS'
        DataSource = DSCadastro
        TabOrder = 0
      end
    end
  end
  inherited DSCadastro: TDataSource
    Left = 231
    Top = 289
  end
  inherited pmOutros: TPopupMenu
    Top = 288
  end
end
