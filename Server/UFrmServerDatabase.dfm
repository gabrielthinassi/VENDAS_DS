object FrmServerDatabase: TFrmServerDatabase
  Left = 0
  Top = 0
  Caption = 'Configura'#231#227'o da Base de Dados'
  ClientHeight = 350
  ClientWidth = 500
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlFundo: TPanel
    Left = 0
    Top = 0
    Width = 500
    Height = 350
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 0
    object pnlInferior: TPanel
      Left = 0
      Top = 296
      Width = 496
      Height = 50
      Align = alBottom
      BevelKind = bkFlat
      BevelOuter = bvNone
      TabOrder = 0
      object btnGravar: TSpeedButton
        Left = 405
        Top = 4
        Width = 81
        Height = 37
        Caption = 'Gravar'
        OnClick = btnGravarClick
      end
      object btnTestar: TSpeedButton
        Left = 318
        Top = 4
        Width = 81
        Height = 37
        Caption = 'Testar'
        OnClick = btnTestarClick
      end
    end
    object lstConfigBD: TValueListEditor
      Left = 0
      Top = 0
      Width = 496
      Height = 296
      Align = alClient
      KeyOptions = [keyEdit, keyAdd, keyDelete]
      TabOrder = 1
      TitleCaptions.Strings = (
        'Chave'
        'Valor')
      ColWidths = (
        150
        340)
      RowHeights = (
        18
        18)
    end
  end
end
