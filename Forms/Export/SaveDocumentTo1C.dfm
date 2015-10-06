inherited SaveDocumentTo1CForm: TSaveDocumentTo1CForm
  ActiveControl = deStart
  Caption = #1042#1099#1075#1088#1091#1079#1082#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074' '#1074' 1'#1057
  ClientHeight = 159
  ClientWidth = 536
  AddOnFormData.RefreshAction = nil
  AddOnFormData.isSingle = False
  ExplicitWidth = 542
  ExplicitHeight = 184
  PixelsPerInch = 96
  TextHeight = 13
  inherited bbOk: TcxButton
    Left = 148
    Top = 93
    Action = MultiAction
    ExplicitLeft = 148
    ExplicitTop = 93
  end
  inherited bbCancel: TcxButton
    Left = 292
    Top = 93
    Action = actClose
    ExplicitLeft = 292
    ExplicitTop = 93
  end
  object deStart: TcxDateEdit [2]
    Left = 131
    Top = 16
    Properties.ShowTime = False
    TabOrder = 2
    Width = 121
  end
  object deEnd: TcxDateEdit [3]
    Left = 371
    Top = 16
    Properties.ShowTime = False
    TabOrder = 3
    Width = 121
  end
  object cxLabel1: TcxLabel [4]
    Left = 38
    Top = 18
    Caption = #1053#1072#1095#1072#1083#1100#1085#1072#1103' '#1076#1072#1090#1072':'
  end
  object cxLabel2: TcxLabel [5]
    Left = 278
    Top = 18
    Caption = #1050#1086#1085#1077#1095#1085#1072#1103' '#1076#1072#1090#1072':'
  end
  object cxLabel7: TcxLabel [6]
    Left = 7
    Top = 55
    Caption = #1059#1055' '#1089#1090#1072#1090#1100#1103' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1103':'
  end
  object ceInfoMoney: TcxButtonEdit [7]
    Left = 131
    Top = 54
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    TabOrder = 7
    Width = 170
  end
  object cxLabel5: TcxLabel [8]
    Left = 307
    Top = 55
    Caption = #1060#1086#1088#1084#1072' '#1086#1087#1083#1072#1090#1099':'
  end
  object edPaidKind: TcxButtonEdit [9]
    Left = 402
    Top = 54
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    TabOrder = 9
    Width = 90
  end
  inherited UserSettingsStorageAddOn: TdsdUserSettingsStorageAddOn
    Left = 59
    Top = 104
  end
  inherited cxPropertiesStore: TcxPropertiesStore
    Components = <
      item
        Component = deEnd
        Properties.Strings = (
          'Date')
      end
      item
        Component = deStart
        Properties.Strings = (
          'Date')
      end
      item
        Component = InfoMoneyGuides
        Properties.Strings = (
          'Key'
          'TextValue')
      end
      item
        Component = PaidKindGuides
        Properties.Strings = (
          'Key'
          'TextValue')
      end
      item
        Component = Owner
        Properties.Strings = (
          'Height'
          'Left'
          'Top'
          'Width')
      end>
    Left = 32
    Top = 104
  end
  inherited ActionList: TActionList
    Images = dmMain.ImageList
    Left = 87
    Top = 103
    object mactPeriodSave: TMultiAction [0]
      Category = 'macPeriodSave'
      MoveParams = <>
      ActionList = <
        item
          Action = actRefresh
        end
        item
          Action = ExternalSaveAction
        end>
      DataSource = DataSource
      Caption = 'mactPeriodSave'
    end
    inherited actRefresh: TdsdDataSetRefresh
      Category = 'macPeriodSave'
      StoredProc = spBillList
      StoredProcList = <
        item
          StoredProc = spBillList
        end>
    end
    object MultiAction: TMultiAction
      Category = 'DSDLib'
      MoveParams = <
        item
          FromParam.Value = Null
          FromParam.DataType = ftString
          ToParam.Value = Null
          ToParam.Component = FormParams
          ToParam.ComponentItem = 'FileName'
          ToParam.DataType = ftString
        end
        item
          FromParam.Value = Null
          ToParam.Value = Null
        end>
      ActionList = <
        item
          Action = actPeriodOpen
        end
        item
          Action = mactPeriodSave
        end>
      InfoAfterExecute = #1044#1072#1085#1085#1099#1077' '#1076#1083#1103' 1C '#1091#1089#1087#1077#1096#1085#1086' '#1074#1099#1075#1088#1091#1078#1077#1085#1099
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100
    end
    object ExternalSaveAction: TExternalSaveAction
      Category = 'macPeriodSave'
      MoveParams = <>
      FieldDefs = <
        item
          Name = 'UNITID'
          DataType = ftString
          Size = 9
        end
        item
          Name = 'VIDDOC'
          DataType = ftString
          Size = 9
        end
        item
          Name = 'INVNUMBER'
          DataType = ftString
          Size = 20
        end
        item
          Name = 'OPERDATE'
          DataType = ftString
          Size = 10
        end
        item
          Name = 'CLIENTCODE'
          DataType = ftString
          Size = 9
        end
        item
          Name = 'CLIENTNAME'
          DataType = ftString
          Size = 50
        end
        item
          Name = 'GOODSCODE'
          DataType = ftString
          Size = 9
        end
        item
          Name = 'GOODSNAME'
          DataType = ftString
          Size = 50
        end
        item
          Name = 'OPERCOUNT'
          DataType = ftString
          Size = 10
        end
        item
          Name = 'OPERPRICE'
          DataType = ftString
          Size = 10
        end
        item
          Name = 'TAX'
          DataType = ftString
          Size = 10
        end
        item
          Name = 'DOC1DATE'
          DataType = ftString
          Size = 10
        end
        item
          Name = 'DOC1NUMBER'
          DataType = ftString
          Size = 10
        end
        item
          Name = 'DOC2DATE'
          DataType = ftString
          Size = 10
        end
        item
          Name = 'DOC2NUMBER'
          DataType = ftString
          Size = 10
        end
        item
          Name = 'SUMA'
          DataType = ftString
          Size = 10
        end
        item
          Name = 'PDV'
          DataType = ftString
          Size = 10
        end
        item
          Name = 'SUMAPDV'
          DataType = ftString
          Size = 10
        end
        item
          Name = 'CLIENTINN'
          DataType = ftString
          Size = 10
        end
        item
          Name = 'CLIENTOKPO'
          DataType = ftString
          Size = 10
        end
        item
          Name = 'CLIENTKIND'
          DataType = ftString
          Size = 2
        end
        item
          Name = 'INVNALOG'
          DataType = ftString
          Size = 12
        end
        item
          Name = 'BILLID'
          DataType = ftString
          Size = 10
        end
        item
          Name = 'EKSPCODE'
          DataType = ftString
          Size = 10
        end
        item
          Name = 'EXPNAME'
          DataType = ftString
          Size = 50
        end
        item
          Name = 'GOODSID'
          DataType = ftString
          Size = 10
        end
        item
          Name = 'PACKID'
          DataType = ftString
          Size = 10
        end
        item
          Name = 'PACKNAME'
          DataType = ftString
          Size = 50
        end>
      DataSet = BillList
      OpenFileDialog = False
      FileName.Value = Null
      FileName.Component = FormParams
      FileName.ComponentItem = 'FileName'
      FileName.DataType = ftString
    end
    object actClose: TdsdFormClose
      Category = 'DSDLib'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      Caption = #1054#1090#1084#1077#1085#1072
      Hint = #1054#1090#1084#1077#1085#1072
    end
    object actPeriodOpen: TdsdExecStoredProc
      Category = 'DSDLib'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      StoredProc = spBillPeriod
      StoredProcList = <
        item
          StoredProc = spBillPeriod
        end>
      Caption = 'actPeriodOpen'
    end
  end
  inherited FormParams: TdsdFormParams
    Params = <
      item
        Name = 'FileName'
        Value = Null
        DataType = ftString
      end>
    Top = 88
  end
  object spBillList: TdsdStoredProc
    StoredProcName = 'gpSelect_Movement_1C_Load'
    DataSet = BillList
    DataSets = <
      item
        DataSet = BillList
      end>
    Params = <
      item
        Name = 'inStartDate'
        Value = Null
        Component = cdsBillPeriod
        ComponentItem = 'StartDate'
        DataType = ftDateTime
        ParamType = ptInput
      end
      item
        Name = 'inEndDate'
        Value = Null
        Component = cdsBillPeriod
        ComponentItem = 'EndDate'
        DataType = ftDateTime
        ParamType = ptInput
      end
      item
        Name = 'inInfoMoneyId'
        Value = ''
        Component = InfoMoneyGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'inPaidKindId'
        Value = ''
        Component = PaidKindGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end>
    PackSize = 1
    Left = 280
    Top = 24
  end
  object BillList: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 256
    Top = 8
  end
  object PeriodChoice: TPeriodChoice
    DateStart = deStart
    DateEnd = deEnd
    Left = 472
  end
  object InfoMoneyGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = ceInfoMoney
    FormNameParam.Value = 'TInfoMoney_ObjectForm'
    FormNameParam.DataType = ftString
    FormName = 'TInfoMoney_ObjectForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = InfoMoneyGuides
        ComponentItem = 'Key'
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = InfoMoneyGuides
        ComponentItem = 'TextValue'
        DataType = ftString
      end>
    Left = 216
    Top = 53
  end
  object PaidKindGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = edPaidKind
    FormNameParam.Value = 'TPaidKindForm'
    FormNameParam.DataType = ftString
    FormName = 'TPaidKindForm'
    PositionDataSet = 'MasterCDS'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = PaidKindGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = PaidKindGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 456
    Top = 56
  end
  object spBillPeriod: TdsdStoredProc
    StoredProcName = 'gpSelectPeriodList'
    DataSet = cdsBillPeriod
    DataSets = <
      item
        DataSet = cdsBillPeriod
      end>
    Params = <
      item
        Name = 'inStartDate'
        Value = 0d
        Component = deStart
        DataType = ftDateTime
        ParamType = ptInput
      end
      item
        Name = 'inEndDate'
        Value = 0d
        Component = deEnd
        DataType = ftDateTime
        ParamType = ptInput
      end
      item
        Name = 'inPeriodLenght'
        Value = 'Day'
        DataType = ftString
        ParamType = ptInput
      end>
    PackSize = 1
    Left = 24
    Top = 40
  end
  object DataSource: TDataSource
    DataSet = cdsBillPeriod
    Left = 64
    Top = 16
  end
  object cdsBillPeriod: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 72
    Top = 8
  end
  object DataSource1: TDataSource
    Left = 408
    Top = 128
  end
end
