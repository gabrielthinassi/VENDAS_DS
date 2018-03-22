inherited SMCadPessoa: TSMCadPessoa
  object dsLink: TDataSource
    DataSet = SQLDSCadastro
    Left = 80
    Top = 88
  end
  object SQLDSPessoa_Endereco: TSQLDataSet
    DataSource = dsLink
    Params = <>
    Left = 80
    Top = 144
  end
end
