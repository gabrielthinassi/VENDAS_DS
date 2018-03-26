inherited SMPaiConsulta: TSMPaiConsulta
  OldCreateOrder = True
  OnCreate = DSServerModuleCreate
  Height = 110
  Width = 273
  object SQLDSConsulta: TSQLDataSet
    Params = <>
    Left = 56
    Top = 24
  end
  object DSPConsulta: TDataSetProvider
    DataSet = SQLDSConsulta
    Options = [poCascadeDeletes, poCascadeUpdates, poAllowCommandText, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 168
    Top = 24
  end
end
