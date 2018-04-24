inherited FrmCadPedido: TFrmCadPedido
  Caption = 'Cadastro de Pedido (Venda/Assistencia)'
  ClientHeight = 600
  ClientWidth = 800
  OnDestroy = FormDestroy
  ExplicitWidth = 806
  ExplicitHeight = 629
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBot: TPanel
    Top = 559
    Width = 800
    ExplicitTop = 559
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
    ExplicitHeight = 518
    inherited btnPesquisar: TSpeedButton
      OnClick = btnPesquisarClick
    end
    object rdgrpTipoPedido: TDBRadioGroup
      Left = 7
      Top = 392
      Width = 113
      Height = 80
      Caption = 'Tipo Pedido'
      DataField = 'TIPO_PEDIDO'
      DataSource = DSCadastro
      Items.Strings = (
        'Venda'
        'Assist'#234'ncia')
      TabOrder = 0
      Values.Strings = (
        '0'
        '1')
    end
  end
  inherited pgctrlCadastro: TPageControl
    Width = 674
    Height = 518
    ExplicitWidth = 674
    ExplicitHeight = 518
    inherited tsPrincipal: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 666
      ExplicitHeight = 490
      object groupCliente: TGroupBox
        Left = 3
        Top = 3
        Width = 660
        Height = 62
        Caption = #39
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
        object edtClienteRazao: TDBEdit
          Left = 119
          Top = 28
          Width = 378
          Height = 21
          DataField = 'RAZAOSOCIAL_PESSOA'
          DataSource = DSCadastro
          TabOrder = 0
        end
        object edtEmissao: TJvDBDateEdit
          Left = 520
          Top = 28
          Width = 121
          Height = 21
          DataField = 'DTEMISSAO_PEDIDO'
          DataSource = DSCadastro
          ButtonWidth = 34
          ShowNullDate = False
          TabOrder = 1
        end
        object edtClienteCodigo: TJvDBCalcEdit
          Left = 20
          Top = 28
          Width = 93
          Height = 21
          ImageKind = ikEllipsis
          ButtonWidth = 34
          TabOrder = 2
          DecimalPlacesAlwaysShown = False
          OnButtonClick = edtClienteCodigoButtonClick
          DataField = 'CODIGO_PESSOA'
          DataSource = DSCadastro
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
          DataField = 'CODIGO_ENDERECOPESSOA'
          DataSource = DSCadastro
          LookupField = 'CODIGO_ENDERECOPESSOA'
          LookupDisplay = 'RUA_ENDERECOPESSOA'
          LookupSource = DSPessoa_Endereco
          TabOrder = 0
        end
        object edtBairroEndereco: TDBEdit
          Left = 20
          Top = 81
          Width = 189
          Height = 21
          DataField = 'BAIRRO_ENDERECOPESSOA'
          DataSource = DSPessoa_Endereco
          Enabled = False
          TabOrder = 1
        end
        object edtCepEndereco: TDBEdit
          Left = 232
          Top = 81
          Width = 105
          Height = 21
          DataField = 'CEP_ENDERECOPESSOA'
          DataSource = DSPessoa_Endereco
          Enabled = False
          TabOrder = 2
        end
        object edtNumeroEndereco: TDBEdit
          Left = 359
          Top = 35
          Width = 82
          Height = 21
          DataField = 'NUMERO_ENDERECOPESSOA'
          DataSource = DSPessoa_Endereco
          Enabled = False
          TabOrder = 3
        end
        object edtCidadeEndereco: TDBEdit
          Left = 464
          Top = 35
          Width = 177
          Height = 21
          DataField = 'CIDADE_ENDERECOPESSOA'
          DataSource = DSPessoa_Endereco
          Enabled = False
          TabOrder = 4
        end
        object edtTipoEndereco: TDBEdit
          Left = 464
          Top = 81
          Width = 89
          Height = 21
          DataField = 'TIPO_ENDERECOPESSOA'
          DataSource = DSPessoa_Endereco
          Enabled = False
          TabOrder = 5
        end
        object edtUfEndereco: TDBEdit
          Left = 359
          Top = 81
          Width = 82
          Height = 21
          DataField = 'UF_ENDERECOPESSOA'
          DataSource = DSPessoa_Endereco
          Enabled = False
          TabOrder = 6
        end
        object edtEnderecoCodigo: TDBEdit
          Left = 559
          Top = 81
          Width = 33
          Height = 21
          DataField = 'CODIGO_ENDERECO'
          DataSource = DSCadastro
          TabOrder = 7
        end
        object edtEnderecoCodigoPessoa: TDBEdit
          Left = 607
          Top = 81
          Width = 33
          Height = 21
          DataField = 'CODIGO_ENDERECOPESSOA'
          DataSource = DSPessoa_Endereco
          TabOrder = 8
        end
      end
      object gridPedido_Item: TDBGrid
        Left = 2
        Top = 327
        Width = 660
        Height = 177
        DataSource = DSPedido_Item
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDrawColumnCell = gridPedido_ItemDrawColumnCell
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
        object ctrlgrdPrazos: TDBCtrlGrid
          Left = 166
          Top = 93
          Width = 252
          Height = 25
          ColCount = 5
          PanelHeight = 25
          PanelWidth = 47
          TabOrder = 0
          RowCount = 1
          object edtPrazo: TDBEdit
            Left = 0
            Top = 0
            Width = 47
            Height = 25
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            ExplicitHeight = 24
          end
        end
        object rdgrpCondicaoPagamento: TDBRadioGroup
          Left = 20
          Top = 24
          Width = 121
          Height = 97
          Caption = 'Condi'#231#227'o Pagamento'
          DataField = 'CONDICAOPAG_PEDIDO'
          DataSource = DSCadastro
          Items.Strings = (
            #192' Vista'
            #192' Prazo'
            'Outros')
          TabOrder = 1
          Values.Strings = (
            '0'
            '1'
            '2')
        end
        object edtDescontoValor: TDBEdit
          Left = 464
          Top = 93
          Width = 116
          Height = 21
          DataField = 'DESCONTOVLR_PEDIDO'
          DataSource = DSCadastro
          TabOrder = 4
        end
        object edtPedidoConsultor: TDBEdit
          Left = 166
          Top = 43
          Width = 116
          Height = 21
          DataField = 'PEDCONSULTOR_PEDIDO'
          DataSource = DSCadastro
          TabOrder = 2
        end
        object edtDescontoPercentual: TDBEdit
          Left = 464
          Top = 43
          Width = 116
          Height = 21
          DataField = 'DESCONTOPERC_PEDIDO'
          DataSource = DSCadastro
          TabOrder = 3
        end
        object DBGrid1: TDBGrid
          Left = 253
          Top = 3
          Width = 232
          Height = 93
          DataSource = DSPessoa_Endereco
          TabOrder = 5
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
        end
      end
    end
  end
  inherited DSCadastro: TDataSource
    Left = 338
    Top = 419
  end
  inherited pmOutros: TPopupMenu
    Left = 78
    Top = 362
  end
  object DSPedido_Prazos: TDataSource
    Left = 504
    Top = 419
  end
  object DSPedido_Item: TDataSource
    Left = 416
    Top = 419
  end
  object DSPessoa_Endereco: TDataSource
    DataSet = DMCadPedido.CDSPedido_PessoaEndereco
    Left = 670
    Top = 419
  end
end
