inherited DMCadPessoa: TDMCadPessoa
  Height = 176
  Width = 134
  object CDSPessoa_Endereco: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DSPCadastro'
    BeforePost = CDSPessoa_EnderecoBeforePost
    Left = 48
    Top = 120
  end
end
