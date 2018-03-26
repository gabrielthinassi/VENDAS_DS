inherited FrmCadPessoa: TFrmCadPessoa
  Caption = 'Cadastro de Pessoa'
  ClientWidth = 650
  OnDestroy = FormDestroy
  ExplicitWidth = 656
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBot: TPanel
    Width = 650
    ExplicitWidth = 650
    inherited txtAjuda: TDBText
      Width = 648
      ExplicitWidth = 798
    end
  end
  inherited pnlTop: TPanel
    Width = 650
    ExplicitWidth = 650
    inherited pnlNavegar: TPanel
      Left = 465
      ExplicitLeft = 465
    end
  end
  inherited pnlButtons: TPanel
    inherited btnPesquisar: TSpeedButton
      OnClick = btnPesquisarClick
    end
  end
  inherited pgctrlCadastro: TPageControl
    Width = 524
    ActivePage = tsPessoa_Endereco
    ExplicitWidth = 524
    inherited tsPrincipal: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 516
      ExplicitHeight = 282
      object lblRazaoSocial: TLabel
        Left = 15
        Top = 16
        Width = 97
        Height = 13
        Caption = 'Nome / Raz'#227'o Social'
      end
      object lblNomeFantasia: TLabel
        Left = 15
        Top = 62
        Width = 116
        Height = 13
        Caption = 'Apelido / Nome Fantasia'
      end
      object lblEmail: TLabel
        Left = 15
        Top = 108
        Width = 28
        Height = 13
        Caption = 'E-Mail'
      end
      object lblCpfCnpj: TLabel
        Left = 320
        Top = 108
        Width = 54
        Height = 13
        Caption = 'CPF / CNPJ'
      end
      object edtRazaoSocial: TDBEdit
        Left = 15
        Top = 35
        Width = 282
        Height = 21
        DataField = 'RAZAOSOCIAL_PESSOA'
        DataSource = DSCadastro
        TabOrder = 0
      end
      object edtNomeFantasia: TDBEdit
        Left = 15
        Top = 81
        Width = 282
        Height = 21
        DataField = 'NOMEFANTASIA_PESSOA'
        DataSource = DSCadastro
        TabOrder = 1
      end
      object edtEmail: TDBEdit
        Left = 15
        Top = 127
        Width = 282
        Height = 21
        DataField = 'EMAIL_PESSOA'
        DataSource = DSCadastro
        TabOrder = 2
      end
      object gbxTipoPessoa: TGroupBox
        Left = 407
        Top = 16
        Width = 90
        Height = 86
        Caption = 'Tipo Cadastro'
        TabOrder = 3
        object cbxTipoCliente: TDBCheckBox
          Left = 16
          Top = 21
          Width = 57
          Height = 17
          Caption = 'Cliente'
          DataField = 'CLIENTE_PESSOA'
          DataSource = DSCadastro
          TabOrder = 0
        end
        object cbxTipoOutros: TDBCheckBox
          Left = 16
          Top = 55
          Width = 57
          Height = 17
          Caption = 'Outros'
          DataField = 'OUTROS_PESSOA'
          DataSource = DSCadastro
          TabOrder = 1
        end
      end
      object edtCpf: TDBEdit
        Left = 320
        Top = 127
        Width = 177
        Height = 21
        DataField = 'CPF_PESSOA'
        DataSource = DSCadastro
        TabOrder = 4
      end
      object edtCnpj: TDBEdit
        Left = 320
        Top = 127
        Width = 177
        Height = 21
        DataField = 'CNPJ_PESSOA'
        DataSource = DSCadastro
        TabOrder = 5
      end
      object rdgFisicaJuridica: TDBRadioGroup
        Left = 303
        Top = 16
        Width = 98
        Height = 86
        Caption = 'Tipo'
        DataField = 'TIPO_PESSOA'
        DataSource = DSCadastro
        Items.Strings = (
          'F'#237'sica'
          'Jur'#237'dica')
        TabOrder = 6
      end
    end
    object tsPessoa_Endereco: TTabSheet
      Caption = 'Pessoa_Endereco'
      ImageIndex = 1
      object lblRua: TLabel
        Left = 13
        Top = 99
        Width = 19
        Height = 13
        Caption = 'Rua'
      end
      object lblBairro: TLabel
        Left = 96
        Top = 145
        Width = 28
        Height = 13
        Caption = 'Bairro'
      end
      object lblCidade: TLabel
        Left = 13
        Top = 191
        Width = 33
        Height = 13
        Caption = 'Cidade'
      end
      object lblPais: TLabel
        Left = 68
        Top = 237
        Width = 19
        Height = 13
        Caption = 'Pa'#237's'
      end
      object lblNumero: TLabel
        Left = 13
        Top = 145
        Width = 37
        Height = 13
        Caption = 'N'#250'mero'
      end
      object lblCep: TLabel
        Left = 202
        Top = 191
        Width = 19
        Height = 13
        Caption = 'Cep'
      end
      object lblUf: TLabel
        Left = 13
        Top = 237
        Width = 13
        Height = 13
        Caption = 'UF'
      end
      object lblTelefone: TLabel
        Left = 202
        Top = 237
        Width = 85
        Height = 13
        Caption = 'Telefone / Celular'
      end
      object edtRua: TDBEdit
        Left = 13
        Top = 118
        Width = 282
        Height = 21
        DataField = 'RUA_ENDERECOPESSOA'
        DataSource = DSPessoa_Endereco
        TabOrder = 0
      end
      object edtBairro: TDBEdit
        Left = 96
        Top = 164
        Width = 199
        Height = 21
        DataField = 'BAIRRO_ENDERECOPESSOA'
        DataSource = DSPessoa_Endereco
        TabOrder = 2
      end
      object edtCidade: TDBEdit
        Left = 13
        Top = 210
        Width = 172
        Height = 21
        DataField = 'CIDADE_ENDERECOPESSOA'
        DataSource = DSPessoa_Endereco
        TabOrder = 3
      end
      object edtPais: TDBEdit
        Left = 68
        Top = 256
        Width = 117
        Height = 21
        DataField = 'PAIS_ENDERECOPESSOA'
        DataSource = DSPessoa_Endereco
        TabOrder = 6
      end
      object edtNumero: TDBEdit
        Left = 13
        Top = 164
        Width = 65
        Height = 21
        DataField = 'NUMERO_ENDERECOPESSOA'
        DataSource = DSPessoa_Endereco
        TabOrder = 1
      end
      object edtCep: TDBEdit
        Left = 202
        Top = 210
        Width = 93
        Height = 21
        DataField = 'CEP_ENDERECOPESSOA'
        DataSource = DSPessoa_Endereco
        TabOrder = 4
      end
      object edtUf: TDBEdit
        Left = 13
        Top = 256
        Width = 37
        Height = 21
        DataField = 'UF_ENDERECOPESSOA'
        DataSource = DSPessoa_Endereco
        TabOrder = 5
      end
      object edtTelefone: TDBEdit
        Left = 202
        Top = 256
        Width = 93
        Height = 21
        DataField = 'TELEFONE_ENDERECOPESSOA'
        DataSource = DSPessoa_Endereco
        TabOrder = 7
      end
      object DBGrid1: TDBGrid
        Left = 13
        Top = 16
        Width = 484
        Height = 77
        DataSource = DSPessoa_Endereco
        TabOrder = 8
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object rdgTipoEndereco: TDBRadioGroup
        Left = 325
        Top = 99
        Width = 100
        Height = 86
        Caption = 'Tipo de Endere'#231'o'
        DataField = 'TIPO_ENDERECOPESSOA'
        DataSource = DSPessoa_Endereco
        Items.Strings = (
          'Residencial'
          'Comercial')
        TabOrder = 9
      end
    end
  end
  inherited DSCadastro: TDataSource
    Left = 312
    Top = 3
  end
  object DSPessoa_Endereco: TDataSource
    Left = 400
    Top = 3
  end
end
