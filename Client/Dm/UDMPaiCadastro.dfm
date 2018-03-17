inherited DMPaiCadastro: TDMPaiCadastro
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  Width = 136
  object CDSCadastro: TClientDataSet
    Aggregates = <>
    Params = <>
    RemoteServer = DSPCCadastro
    BeforeOpen = CDSCadastroBeforeOpen
    AfterOpen = CDSCadastroAfterOpen
    BeforeInsert = CDSCadastroBeforeInsert
    BeforePost = CDSCadastroBeforePost
    AfterPost = CDSCadastroAfterPost
    AfterDelete = CDSCadastroAfterDelete
    OnReconcileError = CDSCadastroReconcileError
    Left = 48
    Top = 73
  end
  object DSPCCadastro: TDSProviderConnection
    Left = 49
    Top = 25
  end
end
