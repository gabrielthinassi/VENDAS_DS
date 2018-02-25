inherited FrmConfigServidorAplicacao: TFrmConfigServidorAplicacao
  Caption = 'Configura'#231#227'o Servidor de Aplica'#231#227'o'
  ClientHeight = 100
  ClientWidth = 200
  ExplicitWidth = 206
  ExplicitHeight = 129
  PixelsPerInch = 96
  TextHeight = 13
  object pnlFundo: TPanel
    Left = 0
    Top = 0
    Width = 200
    Height = 100
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = 140
    ExplicitTop = 25
    ExplicitWidth = 185
    ExplicitHeight = 41
    object lblServidor: TLabel
      Left = 15
      Top = 8
      Width = 88
      Height = 13
      Caption = 'Servidor (TCP/IP):'
    end
    object lblPorta: TLabel
      Left = 140
      Top = 8
      Width = 30
      Height = 13
      Caption = 'Porta:'
    end
    object btnTestar: TSpeedButton
      Left = 15
      Top = 63
      Width = 81
      Height = 22
      Caption = 'Testar'
      OnClick = btnTestarClick
    end
    object btnGravar: TSpeedButton
      Left = 100
      Top = 63
      Width = 81
      Height = 22
      Caption = 'Gravar'
    end
    object edtServidor: TEdit
      Left = 15
      Top = 27
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object edtPorta: TEdit
      Left = 140
      Top = 27
      Width = 41
      Height = 21
      TabOrder = 1
    end
  end
end
