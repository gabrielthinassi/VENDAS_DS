object FrmPrincipal: TFrmPrincipal
  Left = 560
  Top = 332
  Caption = 'FrmPrincipal'
  ClientHeight = 692
  ClientWidth = 900
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlFundo: TPanel
    Left = 0
    Top = 0
    Width = 900
    Height = 640
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 0
  end
  object pnlBot: TPanel
    Left = 0
    Top = 640
    Width = 900
    Height = 52
    Align = alBottom
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
      object mmItem: TMenuItem
        Caption = 'Item'
        OnClick = mmItemClick
      end
    end
    object mmLancamentos: TMenuItem
      Caption = 'Lan'#231'amentos'
      object mmPedido: TMenuItem
        Caption = 'Pedido'
        OnClick = mmPedidoClick
      end
    end
    object mnUtilitarios: TMenuItem
      Caption = 'Utilit'#225'rios'
      object mnConfiguracoes: TMenuItem
        Caption = 'Configura'#231#245'es'
        OnClick = mnConfiguracoesClick
      end
      object mnAgendaXML: TMenuItem
        Caption = 'AgendaXML'
        OnClick = mnAgendaXMLClick
      end
    end
  end
end
