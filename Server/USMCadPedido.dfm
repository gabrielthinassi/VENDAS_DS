inherited SMCadPedido: TSMCadPedido
  Height = 203
  Width = 478
  inherited SQLDSCadastro: TSQLDataSet
    Left = 41
  end
  object SQLDSPedido_Prazos: TSQLDataSet
    AfterOpen = SQLDSPedido_PrazosAfterOpen
    DataSource = dsLink
    MaxBlobSize = -1
    Params = <>
    Left = 41
    Top = 72
  end
  object SQLDSPedido_Item: TSQLDataSet
    AfterOpen = SQLDSPedido_ItemAfterOpen
    DataSource = dsLink
    Params = <>
    Left = 41
    Top = 128
  end
  object dsLink: TDataSource
    DataSet = SQLDSCadastro
    Left = 208
    Top = 20
  end
  object SQLDSPessoa_Endereco: TSQLDataSet
    AfterOpen = SQLDSPessoa_EnderecoAfterOpen
    MaxBlobSize = -1
    Params = <>
    Left = 304
    Top = 20
  end
end
