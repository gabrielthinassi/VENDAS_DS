inherited DMCadPedido: TDMCadPedido
  Height = 309
  Width = 285
  inherited CDSCadastro: TClientDataSet
    BeforePost = nil
  end
  object CDSPedido_Prazos: TClientDataSet
    Aggregates = <>
    Params = <>
    BeforePost = CDSPedido_PrazosBeforePost
    Left = 48
    Top = 121
  end
  object CDSPedido_Item: TClientDataSet
    Aggregates = <>
    Params = <>
    BeforePost = CDSPedido_ItemBeforePost
    Left = 48
    Top = 169
  end
  object CDSPedido_PessoaEndereco: TClientDataSet
    Aggregates = <>
    Params = <>
    BeforePost = CDSPedido_ItemBeforePost
    Left = 96
    Top = 233
  end
end
