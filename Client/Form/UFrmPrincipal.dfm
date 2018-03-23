object FrmPrincipal: TFrmPrincipal
  Left = 560
  Top = 332
  Caption = 'FrmPrincipal'
  ClientHeight = 600
  ClientWidth = 900
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
  object stbar: TStatusBar
    Left = 0
    Top = 544
    Width = 900
    Height = 56
    Panels = <
      item
        Text = 'Menu'
        Width = 50
      end
      item
        Text = 'Usuario'
        Width = 50
      end
      item
        Text = 'Data/Hora'
        Width = 50
      end>
  end
  object pnlFundo: TPanel
    Left = 0
    Top = 0
    Width = 900
    Height = 544
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 1
  end
  object MainMenu1: TMainMenu
    Left = 26
    Top = 6
    object mnCadastros: TMenuItem
      Caption = 'Cadastros'
      object mmStatus: TMenuItem
        Caption = 'Status'
        OnClick = mmStatusClick
      end
      object mmPessoa: TMenuItem
        Caption = 'Pessoa'
        OnClick = mmPessoaClick
      end
    end
    object mmLancamentos: TMenuItem
      Caption = 'Lan'#231'amentos'
      object mmPedidoVenda: TMenuItem
        Caption = 'Pedido de Venda'
      end
      object mmPedidoAssistencia: TMenuItem
        Caption = 'Pedido de Assist'#234'ncia'
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
