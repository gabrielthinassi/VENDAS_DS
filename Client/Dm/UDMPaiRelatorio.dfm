inherited DMPaiRelatorio: TDMPaiRelatorio
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  Height = 263
  Width = 389
  object frxReport: TfrxReport
    Version = '5.6.8'
    ParentReport = 'FRPAIRELATORIO.fr3'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43212.754441805560000000
    ReportOptions.LastChange = 43212.754441805560000000
    ScriptLanguage = 'PascalScript'
    StoreInDFM = False
    Left = 48
    Top = 40
  end
  object FRPrincipal: TfrxDBDataset
    Enabled = False
    UserName = 'frPrincipal'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 160
    Top = 40
  end
end
