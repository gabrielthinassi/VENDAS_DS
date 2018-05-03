inherited DMCadPedido: TDMCadPedido
  Height = 309
  Width = 285
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
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterOpen = ClientDataSet1AfterOpen
    BeforePost = CDSPedido_ItemBeforePost
    Left = 184
    Top = 105
  end
  object CDSPedido_PessoaEndereco__: TClientDataSet
    Aggregates = <>
    Params = <>
    BeforePost = CDSPedido_ItemBeforePost
    Left = 96
    Top = 233
  end
end
