inherited DMCadPedido: TDMCadPedido
  Height = 254
  Width = 135
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
end
