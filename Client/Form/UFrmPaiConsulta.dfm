inherited FrmPaiConsulta: TFrmPaiConsulta
  BorderStyle = bsNone
  Caption = 'Consulta'
  ClientHeight = 329
  ClientWidth = 605
  Color = 7232050
  OnShow = FormShow
  ExplicitWidth = 605
  ExplicitHeight = 329
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 605
    Height = 121
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lblCampo: TLabel
      Left = 16
      Top = 55
      Width = 64
      Height = 19
      Caption = 'Campos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblOperador: TLabel
      Left = 159
      Top = 55
      Width = 94
      Height = 19
      Caption = 'Operadores'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblValorConsulta: TLabel
      Left = 302
      Top = 55
      Width = 43
      Height = 19
      Caption = 'Valor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblFechar: TLabel
      Left = 562
      Top = 12
      Width = 30
      Height = 29
      Caption = ' X '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 14741189
      Font.Height = -24
      Font.Name = 'Myriad Pro'
      Font.Style = [fsBold]
      Font.Quality = fqProof
      ParentFont = False
      OnClick = lblFecharClick
    end
    object imgConsultar: TImage
      Left = 503
      Top = 71
      Width = 35
      Height = 30
      Hint = 'Consultar'
      ParentShowHint = False
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000001000000
        010008060000005C72A866000000097048597300000B1300000B1301009A9C18
        000009084944415478DAEDDD5972DC4614454169FF8B96A32852E6CCEE06506F
        CA5C008D425D9C0FDB41FEFEF3E7CF2F60A6DF02007309000C2600309800C060
        02008309000C2600309800C06002008309402E472FE377F401A84500F6C9F0A2
        05823704E01A955EAA280C2600E7E8F4120561100178CCA49726088D09C0EDBC
        28316847007EE6057D4E0C1A1080CF7929B71382C204E02D2FE37142509000FC
        E5259C4B0C8A981E80D187DF4008929B1A8091870E2404494D0BC0A8C3262302
        094D09C08843162104894C0840FB0316250409740E40DB83352202C13A06A0DD
        8106108220DD02D0EA30C38840804E01687390E18460A30E01287F003E10814D
        AA07A0F4C3F32D11D8A07200CA3E387711820B550C40B907E63011B848B50094
        7A584E250217A81480320FCA6544E064550250E221D942044E542100E91F90ED
        44E024D90390FAE108250227C81C80B40F461A227050D600A47C285212810332
        0620DD03919E083C285B00523D0CA588C003320520CD83509608DC294B00523C
        042D88C01D320420FC016847046E240074250237880E808F9FAB08C00D2203E0
        E3E76A22F083A800F8F8D94504BE21004C20025F8808808F9FDD04E00BBB03E0
        E3278A087C6267007CFC4413817704806944E0955D01F0F1DFE6E838BDE79F09
        C02B021067D710BDFB8F44E0D98E0018E05F1946E72EFECA7017295C1D80E983
        CB3C347783005CA4D2B8A6DED152E99EAE7901170660E2B02A0FCA7D0D2400E7
        E834A449F7B674BABBFB0F7F5100A68CA8F378DCE10002F0B829C371978D5D11
        80EE8399381677DA9400DC67EC509EB9DB66CE0E40D7818C1CC717DC712302F0
        B391C3F841C77B5EC6DDF59901E8388A7183B883FB6E4000BE366E0C0FE876E7
        CBA87B3F2B00DD86306A0407B9FBC204E0A351033889FB2F4A00DE1A75F927EB
        B28165CC0ECE0840978B1F73E917B2856204E0F93D443F4023F650C8D10074B8
        ECA7F710FD00CD74D8C5884D08C0908BDECC2E8A981E8011971CC4360A381280
        EA17FC74FEE80768AEFA46DAEF637200DA5F6E023692DCD400B4BFD844EC2431
        0160075B49EAD100B850EE612F490900BB54DD4CEBBD4C0B40EBCB4CCE661212
        0076B29B641E09804BE451B6938C00B05BC5FDB4DDCE9400B4BDC082EC271101
        6037FB49440088604349DC1B0017C719EC28090120821D25210044A9B6A5963B
        1200A254DB52CB1D750F40CB4B6BC296121000A254DBD2D26E4F0240946A5B5A
        DAED490088644FD107120002D953F481EE0880CBE26C36157D200120904D451F
        4800086453D107120002D954F48104804036157D200120904D451F4800086453
        D107120002D954F48104804036157D200120904D451F4800086453D107120002
        D954F48104804036157D200120904D451F4800086453D107120002D954F481FC
        421002D953F481048040F6147D20012048B52D2DEDF6240044B1A504048028B6
        9440F7003C9D31FA01F854B52DB5DC910010C18E92100022D85112F706607179
        1C6543490800BB55DCCFD2724302C06EF693C894003C9D35FA017852713F6DB7
        2300EC643BC93C1280C545F208BB494600D8A5EA6696B6BB991680A733473FC0
        505537D37A2F02C00EF692D4A301585C2AB7B295A40480ABD949625303F074F6
        E80718A2F24EDA6F4400B8928D247724008B0BE62BD5B7B1B4DFC7F4003CBD83
        E80768AAFA3646EC4200865CF4667651C4D1002C2E9BD73AEC6119B10901F8DF
        880BBF982D1423006F8DB9F80BD8414167046071F974D9C0A8FB1780CF8D1AC1
        093ADDFFA8BB3F2B004BA7112CA38670807B2F4C00BE376A0C7772DF0D9C1980
        C52866E878CFCBB8BB1680DB8C1BC637DC71230270BB910379C7FD3673760096
        CE2359460EE557EF7B9D7AA702F0A04983719F8D5D118065C26896EEC399708F
        DDEFF0FBC30BC0611D07E4FE86B82A00CBA4112D1D86E4CE86B93200CBB4412D
        1547E59E861280EB541898FB19EEEA002C9347F622D3D8DC47AEFB082500FB45
        8CCF1DBC2500CF76046031C0EF9D3D48EFFB7B02F06C570016A3241311F82500
        CC363E023B03B08800D98C8EC0EE002C22403663232000F0D7C8084404601101
        321A1781A8002C224046A3221019804504C8684C0404003E372202D10158C21F
        00BED03E021902B0A47808F844EB086409C092E641E09DB611C8148025D5C3C0
        2B2D23902D004BBA078267ED229031004BCA87825FCD229035004BDA0763BC36
        11C81C8025F5C3315A8B08640FC092FE0119AB7C042A046029F1908C543A0255
        02B0947950C6291B814A01584A3D2CA3948C40B5002CE51E9831CA45A0620096
        920FCD08A5225035002F4A3F3C6D958940F5002CE50F404B2522D021004B8B43
        D04EFA087409C08B5687A185D411E81680A5DD81282F6D043A06606979284A4B
        1981AE0178D1FA7094932E02DD03F062C4218B78FD114CBC97541198128065CC
        4193FA6AF813EF254D042605E0C5B80327F0D3E027DE498A084C0CC08BB107DF
        E89E914FBC8FF0084C0EC08BF12FE0028F0E7BE25D84464000FEE7451C77C698
        27DE43580404E0232FE47E670F78E21D84444000BEE7E57CEDEAC14E7CF7DB23
        2000B7F3A2FEDA39D289EF7C6B0404E031D35E5AE4BFA89AF6AE976DEF5B008E
        EBF802C3FFF3D43B1DDFF14FB6DC81009CAFEA0BCDF6D1BF57F5BD1E71F99D08
        C01ED95E72F68FFD2BD9DEE30E97DE9500C4BAF2E557FDC87F3271B097DDA500
        50D1C4D15E120101A0AA89C33D3D0202406513C77B6A040480EA260EF8B40808
        001D4C1CF129111000BA9838E4C31110003A9938E643111000BA9938E8872320
        00743471D40F454000E86AE2B0EF8E8000D0D9C471DF150101A0BB6903170078
        67D2C805003E3169E8374740009864CAD80500BE3061F00200DFE83E7A01801F
        741FFE4D11100026EB3C7E01801B74FD0004006ED4F1231000B843B70F4100E0
        4E9D3E0601800774F92004001ED4E1A3100038A0F287E17F04821354FD380400
        4E52F10311003851B58F4400E064553E14BF10042E52E1631100B850E60FC66F
        05860DB27E3402009B64FB70FC6110D82CCBC7E34F834190E80FC81F07856091
        1F91004002BB3FA4431FFEBF1F2200709A5D1FD3291FFFD30F120038D5D51FD4
        691FFFD30F1300B8C4D91FD6A91FFEBF1F2A0070A9A31FD8251FFEBF1F2E00B0
        D54F1FDCA51FFC877F9800C05C02008309000C2600309800C06002008309000C
        2600309800C060020083FD078EAF613DB553F9D50000000049454E44AE426082}
      Proportional = True
      ShowHint = True
      OnClick = imgConsultarClick
    end
    object imgConfirmar: TImage
      Left = 544
      Top = 68
      Width = 43
      Height = 36
      Hint = 'Confirmar'
      ParentShowHint = False
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000001000000
        010008060000005C72A866000000097048597300000B1300000B1301009A9C18
        000007EA4944415478DAEDDD0172DC460C45C1F8FE87768A769444B256227749
        0E80DF7D02CE0CF0AA9CD8D28F9F3F7FFE0564FA2100904B0020980040300180
        600200C10400820900041300082600104C0020980040300180600200C1040082
        0900041300082600104C0020980040300180600200C104008209000413000826
        00104C0020980040300180600200C10400820900041300082600104C00209800
        40300180600200C10400820900041300082600104C0020980040300180600200
        C1040082090004130078DEDBF2FC58FD21CF120078CEC7C56919010180E31E2D
        4DBB0808001CF3DDC2B48A8000C07E7B97A54D040400F639BA282D222000F0BD
        6797A47C040400BEF6EA82948E8000C063672D47D90808007CEEECC528190101
        803F5DB514E5222000F0DED50B512A020200FFB96B19CA444000E0B7BB17A144
        040400EE5FFE37CB232000A45BBD004B23200024AB32FCCB222000A4AA36F84B
        22200024AA3AF4B747400048537DE06F8D800090A4CBB0DF1601012045B741BF
        2502024082AE437E79040480E9BA0FF8A5111000269B32DC97454000986ADA60
        5F12010160A2A9437D7A04048069A60FF4A9111000264919E6D32220004C9136
        C8A7444000982075885F8E8000D05DFA00BF140101A033C32B008432B8FE0840
        2843EB3F0212CAC0FADF808432ACFE2210A10CAABF0A4C2843EA1F0311CA80FA
        E7C084329C7E2008A10CA61F09462843E9878212CA40FAB1E084328C7E3108A1
        0CA25F0D462843E8978312CA00FAF5E0CBBC1D7ED903848B1EBE7F2C9DBDE400
        7C3CB808DC2B76F0FE67F9CCA506E0D1A1973F4888C8A1FBA0C4AC2506E0BB03
        977898C1E206EE1365662C2D007B0F5BE68186891AB6074ACD5652008E1EB4D4
        430D1033685F283753290178F690E51EACA98821FB46C9594A08C0AB072CF970
        8D8C1FB01DCACED0F4009C75B8B20F58DCE8E1DAA9F4EC4C0EC0D9072BFD9005
        8D1DAC03CACFCCD4005C75A8F20F5AC4C8A13AA8C5AC4C0CC0D5076AF1B00B8D
        1BA827B499916901B8EB306D1EF866A386E949AD66635200EE3E48AB87BEC198
        417A41BB99981280558768F7E0171931442F6A390B1302B0FA002D1FFE44ABEF
        BF82B633D03D00553EBEED00BCA8CAFDAFD4FAED3B07A0DA87B71E842754BBFF
        15DABF79D70054FDE8F603B153D5FBBFD388B7EE1880EA1F3C6230BE50FDFEEF
        30E68DBB05A0CBC78E19900FBADCFF9546BD6DA700B4F9D07F8C1A94BFFADDFF
        15A6BD699B00B4F8C84F4C1998AEF77FA6296FF9FE500D0250FE03BFD17D70BA
        DFFF19BABFE1E383150F40E98F3BA0EB004DB9FF57747DBB7D872B1C80B21FF6
        A46E8334EDFE9FD1EDCD8E1FB068004A7ED409BA0CD4D4FB3FA2CB5BBD76C882
        0128F74127AB3E58D3EF7F8FEA6F74DE418B05A0D4C75CA8EA80A5DCFF57AABE
        CD35872D1480321F72936A839676FF9FA9F626D71FB848004A7CC40255062EF5
        FEFFAFCA5BDC7BE8020158FE018BAD1EBCF4FBDFAC7E837507178012560DA0BB
        0F5EFE5F872F10804D898F58ECEE4174E7E1CBFFEB028A046053E64316BA6B20
        DDB5E5FFA5520036A53E6691AB07D31D5BFE7F550BC0A6DC072D70D580BA5BCB
        FF4EC5006C4A7ED4CDCE1E54776AF9FF5035009BB21F76A3B306D65D5AFE4F55
        0EC0A6F4C7DDE4D5C1758796FFA1EA01D894FFC01B3C3BC0EECEF27FA9430036
        2D3EF2624707D99D59FE6F7509C0A6CD875E68EF40BB2BCBBF4BA7006C5A7DEC
        45BE1B6C7764F977EB16804DBB0FBEC0A301773796FF908E01D8B4FCE8937D1C
        747762F90FEB1A804DDB0F3FD1DBC0BB0BCBFF94CE01D8B4FE784E63F99FD43D
        009BF607E02596FF051302B01971080EB3FC2F9A1280CD9883B08BE53FC1A400
        6C461D86872CFF49A6056033EE40BC63F94F3431009B9187C2F29F6D6A003663
        0F16CAF25F60720036A30F17C4F25F647A0036E30F389CE5BF5042003611871C
        C8F25F2C25009B98830E61F96F9014804DD4611BB3FC37490BC026EEC0CD58FE
        1B2506601379E8062CFFCD5203B0893D7851967F81E4006CA20F5F88E55F243D
        009BF80B58CCF22F2400BFB984352CFF6202F01F17712FCB5F8000BCE732EE61
        F98B10803FB9906B59FE4204E0732EE51A96BF180178CCC59CCBF21724005F73
        39E7B0FC4509C0F75CD06B2C7F6102B08F4B7A8EE52F4E00F67351C758FE0604
        E01897B58FE56F42008E73615FB3FC8D08C0735CDAE72C7F3302F03C17F79EE5
        6F48005EE3F27EB3FC4D09C0EBD22FD0F2372600E748BD44CBDF9C009C27ED22
        2DFF000270AE94CBB4FC4308C0F9A65FA8E51F4400AE31F5522DFF3002709D69
        176BF90712806B4DB95CCB3F94005CAFFB055BFEC104E01E5D2FD9F20F2700F7
        E976D1963F8000DCABCB655BFE100270BFEA176EF98308C01A552FDDF2871180
        75AA5DBCE50F24006B55B97CCB1F4A00D65BFD00963F9800D4B0EA112C7F3801
        A8E3EE87B0FC084031773D86E5E71701A8E7EA07B1FCFC4B006ABAEA512C3FEF
        08405D673F8CE5E70F0250DB598F63F9F99400D4F7EA03597E1E12801E9E7D24
        CBCF9704A08FA30F65F9F99600F4B2F7B12C3FBB08403FDF3D98E5673701E8E9
        D1A3597E0E1180BE3E3E9CE5E73001E8EDEDF12C3F4F1100082600104C002098
        0040300180600200C10400820900041300082600104C00209800403001806002
        00C10400820900041300082600104C0020980040300180600200C10400820900
        041300082600104C0020980040300180600200C1040082090004130008260010
        4C0020980040300180600200C10400820900041300082600104C002098004030
        0180600200C1040082090004FB1B51F0CD2E4A002ED60000000049454E44AE42
        6082}
      Proportional = True
      ShowHint = True
      OnClick = imgConfirmarClick
    end
    object cbxOperadores: TComboBox
      Left = 159
      Top = 80
      Width = 137
      Height = 21
      BevelInner = bvNone
      BevelOuter = bvNone
      Color = 11840140
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 0
      OnChange = cbxOperadoresChange
    end
    object cbxCampos: TComboBox
      Left = 16
      Top = 80
      Width = 137
      Height = 21
      BevelInner = bvNone
      BevelOuter = bvNone
      Color = 11840140
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 1
    end
    object edtValorConsulta: TEdit
      Left = 302
      Top = 80
      Width = 187
      Height = 21
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = 11840140
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
  end
  object gridConsulta: TDBGrid
    Left = 0
    Top = 121
    Width = 605
    Height = 208
    Align = alClient
    BorderStyle = bsNone
    Color = 11840396
    DataSource = DSConsulta
    DrawingStyle = gdsGradient
    FixedColor = 11840140
    GradientEndColor = 11840140
    GradientStartColor = 7232050
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = gridConsultaDblClick
    OnTitleClick = gridConsultaTitleClick
  end
  object CDSConsulta: TClientDataSet
    Aggregates = <>
    Params = <>
    RemoteServer = DSPCConsulta
    AfterOpen = CDSConsultaAfterOpen
    Left = 544
    Top = 184
  end
  object DSConsulta: TDataSource
    DataSet = CDSConsulta
    Left = 544
    Top = 232
  end
  object DSPCConsulta: TDSProviderConnection
    Left = 544
    Top = 136
  end
end
