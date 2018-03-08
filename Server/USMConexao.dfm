object SMConexao: TSMConexao
  OldCreateOrder = False
  OnCreate = DSServerModuleCreate
  OnDestroy = DSServerModuleDestroy
  Height = 213
  Width = 291
  object CDSProximoCodigo: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'TABELA'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'QUEBRA'
        ParamType = ptInput
      end>
    ProviderName = 'DSPProximoCodigo'
    Left = 62
    Top = 112
  end
  object DSPProximoCodigo: TDataSetProvider
    DataSet = SQLDSProximoCodigo
    Constraints = False
    Exported = False
    Options = []
    Left = 63
    Top = 63
  end
  object SQLDSProximoCodigo: TSQLDataSet
    CommandText = 
      'select '#13#10'AUTOINCREMENTOS.TABELA_AUTOINC,'#13#10'AUTOINCREMENTOS.CODIGO' +
      '_AUTOINC'#13#10'from AUTOINCREMENTOS'#13#10'where AUTOINCREMENTOS.TABELA_AUT' +
      'OINC = :TABELA'
    MaxBlobSize = -1
    Params = <>
    Left = 62
    Top = 13
  end
  object ConexaoBD: TSQLConnection
    DriverName = 'DevartInterBase'
    LoginPrompt = False
    Params.Strings = (
      'GetDriverFunc=getSQLDriverInterBase'
      'LibraryName=dbexpida40.dll'
      'VendorLib=fbclient.dll'
      'DataBase=localhost/3054:c:\trabalho\vendas_ds\data\vendas.fdb'
      'User_Name=sysdba'
      'Password=masterkey'
      'SQLDialect=3'
      'BlobSize=-1'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'DevartInterBase TransIsolation=ReadCommitted'
      'ProductName=DevartInterBase'
      
        'DriverPackageLoader=TDBXDynalinkDriverLoader,DBXCommonDriver240.' +
        'bpl'
      
        'MetaDataPackageLoader=TDBXDevartInterBaseMetaDataCommandFactory,' +
        'DbxDevartInterBaseDriver240.bpl'
      'DriverUnit=DbxDevartInterBase')
    Connected = True
    Left = 210
    Top = 10
  end
end
