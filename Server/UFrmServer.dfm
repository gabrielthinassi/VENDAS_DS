object FrmServer: TFrmServer
  Left = 0
  Top = 0
  Caption = 'Server Application'
  ClientHeight = 200
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBackground: TPanel
    Left = 0
    Top = 0
    Width = 400
    Height = 200
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 0
    object imgDB: TImage
      Left = 12
      Top = 15
      Width = 65
      Height = 65
      OnClick = imgDBClick
    end
    object imgMonitor: TImage
      Left = 88
      Top = 15
      Width = 65
      Height = 65
    end
    object Image2: TImage
      Left = 164
      Top = 15
      Width = 65
      Height = 65
    end
    object Image3: TImage
      Left = 240
      Top = 15
      Width = 65
      Height = 65
    end
    object Image4: TImage
      Left = 316
      Top = 15
      Width = 65
      Height = 65
    end
  end
  object AppEvents: TApplicationEvents
    OnMinimize = AppEventsMinimize
    Left = 340
    Top = 140
  end
  object TrayIcon: TTrayIcon
    PopupMenu = pmServer
    OnDblClick = TrayIconDblClick
    Left = 270
    Top = 140
  end
  object pmServer: TPopupMenu
    Left = 195
    Top = 140
    object mpRestore: TMenuItem
      Caption = 'Restaurar'
    end
    object pmClose: TMenuItem
      Caption = 'Fechar'
    end
  end
end
