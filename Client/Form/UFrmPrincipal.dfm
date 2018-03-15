object FrmPrincipal: TFrmPrincipal
  Left = 560
  Top = 332
  Caption = 'FrmPrincipal'
  ClientHeight = 400
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 26
    Top = 6
    object mnCadastros: TMenuItem
      Caption = 'Cadastros'
      object mmStatus: TMenuItem
        Caption = 'Status'
        OnClick = mmStatusClick
      end
    end
    object mnUtilitarios: TMenuItem
      Caption = 'Utilit'#225'rios'
      object mnConfiguracoes: TMenuItem
        Caption = 'Configura'#231#245'es'
        OnClick = mnConfiguracoesClick
      end
    end
  end
end
