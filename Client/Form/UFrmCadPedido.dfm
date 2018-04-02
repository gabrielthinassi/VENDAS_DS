inherited FrmCadPedido: TFrmCadPedido
  Caption = 'Cadastro de Pedido (Venda/Assistencia)'
  ClientHeight = 600
  ClientWidth = 800
  ExplicitWidth = 806
  ExplicitHeight = 629
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBot: TPanel
    Top = 559
    Width = 800
    ExplicitTop = 459
    ExplicitWidth = 800
    inherited txtAjuda: TDBText
      Width = 798
      ExplicitWidth = 798
    end
  end
  inherited pnlTop: TPanel
    Width = 800
    ExplicitWidth = 800
    inherited pnlNavegar: TPanel
      Left = 615
      ExplicitLeft = 615
    end
  end
  inherited pnlButtons: TPanel
    Height = 518
    ExplicitHeight = 418
  end
  inherited pgctrlCadastro: TPageControl
    Width = 674
    Height = 518
    ExplicitWidth = 674
    ExplicitHeight = 418
    inherited tsPrincipal: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 666
      ExplicitHeight = 390
      object groupCliente: TGroupBox
        Left = 3
        Top = 3
        Width = 660
        Height = 62
        TabOrder = 0
        object lblClienteCodigo: TLabel
          Left = 20
          Top = 9
          Width = 33
          Height = 13
          Caption = 'Cliente'
        end
        object lblEmissao: TLabel
          Left = 520
          Top = 9
          Width = 38
          Height = 13
          Caption = 'Emiss'#227'o'
        end
        object edtClienteCodigo: TJvCalcEdit
          Left = 20
          Top = 28
          Width = 93
          Height = 21
          BevelInner = bvLowered
          BevelKind = bkFlat
          BevelOuter = bvNone
          Flat = False
          ParentFlat = False
          ImageKind = ikEllipsis
          ButtonWidth = 34
          TabOrder = 0
          DecimalPlacesAlwaysShown = False
        end
        object edtClienteRazao: TDBEdit
          Left = 119
          Top = 28
          Width = 378
          Height = 21
          TabOrder = 1
        end
        object edtEmissao: TJvDBDateEdit
          Left = 520
          Top = 28
          Width = 121
          Height = 21
          ButtonWidth = 34
          ShowNullDate = False
          TabOrder = 2
        end
      end
      object groupEndereco: TGroupBox
        Left = 3
        Top = 71
        Width = 660
        Height = 114
        Caption = 'Endere'#231'o'
        TabOrder = 1
        object lblRuaEndereco: TLabel
          Left = 20
          Top = 16
          Width = 19
          Height = 13
          Caption = 'Rua'
        end
        object lblBairroEndereco: TLabel
          Left = 20
          Top = 62
          Width = 28
          Height = 13
          Caption = 'Bairro'
        end
        object lblCepEndereco: TLabel
          Left = 232
          Top = 62
          Width = 19
          Height = 13
          Caption = 'Cep'
        end
        object lblNumeroEndereco: TLabel
          Left = 359
          Top = 16
          Width = 37
          Height = 13
          Caption = 'N'#250'mero'
        end
        object lblCidadeEndereco: TLabel
          Left = 464
          Top = 16
          Width = 33
          Height = 13
          Caption = 'Cidade'
        end
        object lblTipoEndereco: TLabel
          Left = 464
          Top = 62
          Width = 83
          Height = 13
          Caption = 'Tipo de Endere'#231'o'
        end
        object lblUfEndereco: TLabel
          Left = 359
          Top = 62
          Width = 13
          Height = 13
          Caption = 'UF'
        end
        object cbbEnderecoEntrega: TJvDBLookupCombo
          Left = 20
          Top = 35
          Width = 317
          Height = 21
          TabOrder = 0
        end
        object edtBairroEndereco: TDBEdit
          Left = 20
          Top = 81
          Width = 189
          Height = 21
          TabOrder = 1
        end
        object edtCepEndereco: TDBEdit
          Left = 232
          Top = 81
          Width = 105
          Height = 21
          TabOrder = 2
        end
        object edtNumeroEndereco: TDBEdit
          Left = 359
          Top = 35
          Width = 82
          Height = 21
          TabOrder = 3
        end
        object edtCidadeEndereco: TDBEdit
          Left = 464
          Top = 35
          Width = 177
          Height = 21
          TabOrder = 4
        end
        object edtTipoEndereco: TDBEdit
          Left = 464
          Top = 81
          Width = 89
          Height = 21
          TabOrder = 5
        end
        object edtUfEndereco: TDBEdit
          Left = 359
          Top = 81
          Width = 82
          Height = 21
          TabOrder = 6
        end
      end
      object DBGrid1: TDBGrid
        Left = 2
        Top = 327
        Width = 660
        Height = 177
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object groupNegociacao: TGroupBox
        Left = 3
        Top = 191
        Width = 660
        Height = 130
        Caption = 'Negocia'#231#227'o'
        TabOrder = 3
        object lblPedidoConsultor: TLabel
          Left = 166
          Top = 24
          Width = 81
          Height = 13
          Caption = 'Pedido Consultor'
        end
        object lblPrazoPedido: TLabel
          Left = 166
          Top = 74
          Width = 27
          Height = 13
          Caption = 'Prazo'
        end
        object lblDescontoPercentual: TLabel
          Left = 464
          Top = 24
          Width = 73
          Height = 13
          Caption = 'Desconto ( % )'
        end
        object lblDescontoValor: TLabel
          Left = 464
          Top = 74
          Width = 68
          Height = 13
          Caption = 'Desconto ( $ )'
        end
        object ctrlPedidoConsultor: TDBCtrlGrid
          Left = 166
          Top = 43
          Width = 134
          Height = 25
          ColCount = 2
          PanelHeight = 25
          PanelWidth = 58
          TabOrder = 0
          RowCount = 1
        end
        object DBCtrlGrid2: TDBCtrlGrid
          Left = 166
          Top = 93
          Width = 253
          Height = 25
          ColCount = 5
          PanelHeight = 25
          PanelWidth = 47
          TabOrder = 1
          RowCount = 1
        end
        object rdgrpCondicaoPagamento: TDBRadioGroup
          Left = 20
          Top = 24
          Width = 121
          Height = 97
          Caption = 'Condi'#231#227'o Pagamento'
          Items.Strings = (
            #192' Vista'
            #192' Prazo'
            'Outros')
          TabOrder = 2
          Values.Strings = (
            '0'
            '1'
            '2')
        end
        object DBCtrlGrid1: TDBCtrlGrid
          Left = 464
          Top = 43
          Width = 133
          Height = 25
          ColCount = 2
          PanelHeight = 25
          PanelWidth = 58
          TabOrder = 3
          RowCount = 1
        end
        object edtDescontoValor: TDBEdit
          Left = 464
          Top = 93
          Width = 116
          Height = 25
          TabOrder = 4
        end
      end
    end
  end
  inherited DSCadastro: TDataSource
    Left = 18
    Top = 363
  end
  inherited pmOutros: TPopupMenu
    Left = 78
    Top = 362
  end
end
