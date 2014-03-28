inherited Report_JuridicalCollationForm: TReport_JuridicalCollationForm
  Caption = #1040#1082#1090' '#1089#1074#1077#1088#1082#1080' '
  ClientHeight = 389
  ClientWidth = 927
  ExplicitWidth = 935
  ExplicitHeight = 416
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TcxPageControl
    Top = 80
    Width = 927
    Height = 309
    TabOrder = 3
    ExplicitTop = 80
    ExplicitWidth = 927
    ExplicitHeight = 309
    ClientRectBottom = 309
    ClientRectRight = 927
    inherited tsMain: TcxTabSheet
      ExplicitWidth = 927
      ExplicitHeight = 309
      inherited cxGrid: TcxGrid
        Width = 927
        Height = 309
        ExplicitWidth = 927
        ExplicitHeight = 309
        inherited cxGridDBTableView: TcxGridDBTableView
          DataController.Summary.DefaultGroupSummaryItems = <
            item
              Format = ',0.00'
              Kind = skSum
              Column = colDebet
            end
            item
              Format = ',0.00'
              Kind = skSum
              Column = colKredit
            end
            item
              Format = ',0.00'
              Kind = skSum
            end
            item
              Format = ',0.00'
              Kind = skSum
            end
            item
              Format = ',0.00'
              Kind = skSum
            end
            item
              Format = ',0.00'
              Kind = skSum
            end>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00'
              Kind = skSum
              Column = colDebet
            end
            item
              Format = ',0.00'
              Kind = skSum
              Column = colKredit
            end
            item
              Format = ',0.00'
              Kind = skSum
            end
            item
              Format = ',0.00'
              Kind = skSum
            end
            item
              Format = ',0.00'
              Kind = skSum
            end
            item
              Format = ',0.00'
              Kind = skSum
            end>
          OptionsData.CancelOnExit = True
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsView.GroupByBox = True
          Styles.Inactive = nil
          Styles.Selection = nil
          Styles.Footer = nil
          Styles.Header = nil
          object colItemName: TcxGridDBColumn
            Caption = #1058#1080#1087' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
            DataBinding.FieldName = 'ItemName'
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 95
          end
          object coInvNumber: TcxGridDBColumn
            Caption = #8470' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
            DataBinding.FieldName = 'InvNumber'
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 70
          end
          object colOperDate: TcxGridDBColumn
            Caption = #1044#1072#1090#1072
            DataBinding.FieldName = 'OperDate'
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 93
          end
          object colDebet: TcxGridDBColumn
            Caption = #1044#1077#1073#1077#1090
            DataBinding.FieldName = 'Debet'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00; '
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 107
          end
          object colKredit: TcxGridDBColumn
            Caption = #1050#1088#1077#1076#1080#1090
            DataBinding.FieldName = 'Kredit'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00; '
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 99
          end
          object colAccountCode: TcxGridDBColumn
            DataBinding.FieldName = 'AccountCode'
            Visible = False
            HeaderAlignmentVert = vaCenter
            Width = 60
          end
          object colAccountName: TcxGridDBColumn
            Caption = #1057#1095#1077#1090
            DataBinding.FieldName = 'AccountName'
            HeaderAlignmentVert = vaCenter
            Width = 86
          end
          object colContractName: TcxGridDBColumn
            Caption = #8470' '#1076#1086#1075'.'
            DataBinding.FieldName = 'ContractName'
            HeaderAlignmentVert = vaCenter
            Width = 60
          end
          object colInfoMoneyGroupCode: TcxGridDBColumn
            Caption = #1050#1086#1076' '#1059#1055' '#1075#1088#1091#1087#1087#1099
            DataBinding.FieldName = 'InfoMoneyGroupCode'
            Visible = False
            HeaderAlignmentVert = vaCenter
            Width = 45
          end
          object colInfoMoneyGroupName: TcxGridDBColumn
            Caption = #1059#1055' '#1075#1088#1091#1087#1087#1072' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1103
            DataBinding.FieldName = 'InfoMoneyGroupName'
            HeaderAlignmentVert = vaCenter
            Width = 80
          end
          object colInfoMoneyDestinationCode: TcxGridDBColumn
            Caption = #1050#1086#1076' '#1059#1055' '#1085#1072#1079#1085#1072#1095'.'
            DataBinding.FieldName = 'InfoMoneyDestinationCode'
            Visible = False
            HeaderAlignmentVert = vaCenter
            Width = 45
          end
          object colInfoMoneyDestinationName: TcxGridDBColumn
            Caption = #1059#1055' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1077
            DataBinding.FieldName = 'InfoMoneyDestinationName'
            HeaderAlignmentVert = vaCenter
            Width = 80
          end
          object colInfoMoneyCode: TcxGridDBColumn
            Caption = #1050#1086#1076' '#1059#1055
            DataBinding.FieldName = 'InfoMoneyCode'
            Visible = False
            HeaderAlignmentVert = vaCenter
            Width = 45
          end
          object colInfoMoneyName: TcxGridDBColumn
            Caption = #1059#1055' '#1089#1090#1072#1090#1100#1103' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1103
            DataBinding.FieldName = 'InfoMoneyName'
            HeaderAlignmentVert = vaCenter
            Width = 80
          end
        end
      end
    end
  end
  inherited Panel: TPanel
    Width = 927
    Height = 54
    ExplicitWidth = 927
    ExplicitHeight = 54
    inherited deStart: TcxDateEdit
      Left = 118
      Top = 4
      ExplicitLeft = 118
      ExplicitTop = 4
    end
    inherited deEnd: TcxDateEdit
      Left = 118
      Top = 29
      ExplicitLeft = 118
      ExplicitTop = 29
    end
    inherited cxLabel1: TcxLabel
      Left = 27
      ExplicitLeft = 27
    end
    inherited cxLabel2: TcxLabel
      Left = 8
      Top = 31
      ExplicitLeft = 8
      ExplicitTop = 31
    end
    object cxLabel6: TcxLabel
      Left = 236
      Top = 6
      Caption = #1070#1088#1080#1076#1080#1095#1077#1089#1082#1086#1077' '#1083#1080#1094#1086':'
    end
    object edJuridical: TcxButtonEdit
      Left = 343
      Top = 4
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 5
      Width = 245
    end
    object cxLabel3: TcxLabel
      Left = 207
      Top = 29
      Caption = #1053#1072#1096#1077' '#1102#1088#1080#1076#1080#1095#1077#1089#1082#1086#1077' '#1083#1080#1094#1086':'
    end
    object edMainJuridical: TcxButtonEdit
      Left = 343
      Top = 29
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 7
      Width = 245
    end
    object cxLabel4: TcxLabel
      Left = 596
      Top = 31
      Caption = #1057#1095#1077#1090' '#1085#1072#1079#1074#1072#1085#1080#1077':'
    end
    object edAccount: TcxButtonEdit
      Left = 683
      Top = 29
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 9
      Width = 240
    end
    object cxLabel8: TcxLabel
      Left = 628
      Top = 6
      Caption = #1044#1086#1075#1086#1074#1086#1088':'
    end
    object ceContract: TcxButtonEdit
      Left = 683
      Top = 4
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 11
      Width = 240
    end
  end
  inherited ActionList: TActionList
    inherited actRefresh: TdsdDataSetRefresh
      StoredProc = gpGetDefault
      StoredProcList = <
        item
          StoredProc = gpGetDefault
        end
        item
          StoredProc = spSelect
        end>
    end
    object dsdPrintAction: TdsdPrintAction
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spJuridicalBalance
      StoredProcList = <
        item
          StoredProc = spJuridicalBalance
        end
        item
          StoredProc = gpGetJuridical
        end>
      Caption = #1055#1077#1095#1072#1090#1100' '#1086#1090#1095#1077#1090#1072
      Hint = #1040#1082#1090' '#1089#1074#1077#1088#1082#1080' ('#1073#1091#1093#1075#1072#1083#1090#1077#1088#1089#1082#1080#1081')'
      ImageIndex = 3
      ShortCut = 16464
      DataSets = <>
      Params = <
        item
          Name = 'EndDate'
          Value = 41395d
          Component = deEnd
          DataType = ftDateTime
          ParamType = ptInput
        end
        item
          Name = 'StartBalance'
          Component = FormParams
          ComponentItem = 'StartBalance'
          DataType = ftFloat
          ParamType = ptInput
        end
        item
          Name = 'PartnerName'
          Value = ''
          Component = JuridicalGuides
          ComponentItem = 'TextValue'
          DataType = ftString
          ParamType = ptInput
        end
        item
          Name = 'OurFirm'
          Value = ''
          Component = MainJuridicalGuides
          ComponentItem = 'TextValue'
          DataType = ftString
          ParamType = ptInput
        end
        item
          Name = 'AccounterName'
          Component = FormParams
          ComponentItem = 'AccounterName'
          DataType = ftString
          ParamType = ptInput
        end
        item
          Name = 'AccountName'
          Value = ''
          Component = AccountGuides
          ComponentItem = 'TextValue'
          DataType = ftString
        end
        item
          Name = 'ContractName'
          Value = ''
          Component = ContractGuides
          ComponentItem = 'TextValue'
          DataType = ftString
        end>
      ReportName = #1040#1082#1090' '#1089#1074#1077#1088#1082#1080' ('#1073#1091#1093#1075#1072#1083#1090#1077#1088#1089#1082#1080#1081') '#1040#1051#1040#1053
      ReportNameParam.Value = #1040#1082#1090' '#1089#1074#1077#1088#1082#1080' ('#1073#1091#1093#1075#1072#1083#1090#1077#1088#1089#1082#1080#1081') '#1040#1051#1040#1053
      ReportNameParam.DataType = ftString
    end
    object actOpenForm: TdsdOpenForm
      Category = 'DSDLib'
      MoveParams = <>
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090
      FormName = 'NULL'
      FormNameParam.Value = Null
      FormNameParam.Component = FormParams
      FormNameParam.ComponentItem = 'FormName'
      FormNameParam.DataType = ftString
      GuiParams = <
        item
          Name = 'Id'
          Component = MasterCDS
          ComponentItem = 'MovementId'
          ParamType = ptInput
        end
        item
          Name = 'inOperDate'
          Component = MasterCDS
          ComponentItem = 'OperDate'
          DataType = ftDateTime
          ParamType = ptInput
        end>
      isShowModal = False
    end
    object actGetForm: TdsdExecStoredProc
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = getMovementForm
      StoredProcList = <
        item
          StoredProc = getMovementForm
        end>
      Caption = 'actGetForm'
    end
    object actOpenDocument: TMultiAction
      Category = 'DSDLib'
      MoveParams = <>
      ActionList = <
        item
          Action = actGetForm
        end
        item
          Action = actOpenForm
        end>
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090
      ImageIndex = 28
      ShortCut = 13
    end
    object actPrint: TdsdPrintAction
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spJuridicalBalance
      StoredProcList = <
        item
          StoredProc = spJuridicalBalance
        end
        item
          StoredProc = gpGetJuridical
        end>
      Caption = 'actPrint'
      Hint = #1040#1082#1090' '#1089#1074#1077#1088#1082#1080
      ImageIndex = 17
      DataSets = <
        item
          DataSet = MasterCDS
          IndexFieldNames = 'ItemName;OperDate'
        end>
      Params = <
        item
          Name = 'EndDate'
          Value = 41395d
          Component = deEnd
          DataType = ftDateTime
          ParamType = ptInput
        end
        item
          Name = 'StartBalance'
          Component = FormParams
          ComponentItem = 'StartBalance'
          DataType = ftFloat
          ParamType = ptInput
        end
        item
          Name = 'PartnerName'
          Value = ''
          Component = JuridicalGuides
          ComponentItem = 'TextValue'
          DataType = ftString
          ParamType = ptInput
        end
        item
          Name = 'OurFirm'
          Value = ''
          Component = MainJuridicalGuides
          ComponentItem = 'TextValue'
          DataType = ftString
          ParamType = ptInput
        end
        item
          Name = 'AccounterName'
          Component = FormParams
          ComponentItem = 'AccounterName'
          DataType = ftString
          ParamType = ptInput
        end
        item
          Name = 'AccountName'
          Value = ''
          Component = AccountGuides
          ComponentItem = 'TextValue'
          DataType = ftString
        end>
      ReportName = #1054#1090#1095#1077#1090' '#1048#1090#1086#1075' '#1087#1086' '#1087#1086#1082#1091#1087#1072#1090#1077#1083#1102' ('#1040#1082#1090' '#1089#1074#1077#1088#1082#1080')'
      ReportNameParam.Value = #1054#1090#1095#1077#1090' '#1048#1090#1086#1075' '#1087#1086' '#1087#1086#1082#1091#1087#1072#1090#1077#1083#1102' ('#1040#1082#1090' '#1089#1074#1077#1088#1082#1080')'
      ReportNameParam.DataType = ftString
    end
  end
  inherited MasterCDS: TClientDataSet
    IndexFieldNames = 'ItemName;OperDate'
    Top = 24
  end
  inherited spSelect: TdsdStoredProc
    StoredProcName = 'gpReport_JuridicalCollation'
    Params = <
      item
        Name = 'inStartDate'
        Value = 41395d
        Component = deStart
        DataType = ftDateTime
        ParamType = ptInput
      end
      item
        Name = 'inEndDate'
        Value = 41395d
        Component = deEnd
        DataType = ftDateTime
        ParamType = ptInput
      end
      item
        Name = 'inJuridicalId'
        Value = ''
        Component = JuridicalGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'inContractId'
        Value = ''
        Component = ContractGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'inAccountId'
        Value = ''
        Component = AccountGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end>
    Top = 24
  end
  inherited BarManager: TdxBarManager
    Left = 112
    Top = 24
    DockControlHeights = (
      0
      0
      26
      0)
    inherited Bar: TdxBar
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbPrintReport'
        end
        item
          Visible = True
          ItemName = 'bbPrint'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbRefresh'
        end
        item
          Visible = True
          ItemName = 'bbGridToExcel'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbOpenDocument'
        end>
    end
    object bbPrint: TdxBarButton
      Action = dsdPrintAction
      Category = 0
    end
    object bbOpenDocument: TdxBarButton
      Action = actOpenDocument
      Category = 0
    end
    object bbPrintReport: TdxBarButton
      Action = actPrint
      Category = 0
    end
  end
  inherited RefreshDispatcher: TRefreshDispatcher
    ComponentList = <
      item
        Component = PeriodChoice
      end
      item
        Component = JuridicalGuides
      end
      item
        Component = ContractGuides
      end
      item
        Component = AccountGuides
      end>
    Left = 408
    Top = 72
  end
  object frxDBDataset: TfrxDBDataset
    UserName = 'frxDBDataset'
    CloseDataSource = False
    DataSource = MasterDS
    BCDToCurrency = False
    Left = 184
    Top = 264
  end
  object JuridicalGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = edJuridical
    FormNameParam.Value = 'TJuridical_ObjectForm'
    FormNameParam.DataType = ftString
    FormName = 'TJuridical_ObjectForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = JuridicalGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = JuridicalGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 312
    Top = 48
  end
  object getMovementForm: TdsdStoredProc
    StoredProcName = 'gpGet_Movement_Form'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inMovementId'
        Component = MasterCDS
        ComponentItem = 'MovementId'
        ParamType = ptInput
      end
      item
        Name = 'FormName'
        Value = Null
        Component = FormParams
        ComponentItem = 'FormName'
        DataType = ftString
      end>
    Left = 296
    Top = 120
  end
  object FormParams: TdsdFormParams
    Params = <
      item
        Name = 'FormName'
        Value = Null
        DataType = ftString
      end>
    Left = 208
    Top = 160
  end
  object spJuridicalBalance: TdsdStoredProc
    StoredProcName = 'gpReport_JuridicalBalance'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inOperDate'
        Value = 41395d
        Component = deStart
        DataType = ftDateTime
        ParamType = ptInput
      end
      item
        Name = 'inJuridicalId'
        Value = ''
        Component = JuridicalGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'inContractId'
        Value = ''
        Component = ContractGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'inAccountId'
        Value = ''
        Component = AccountGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'StartBalance'
        Component = FormParams
        ComponentItem = 'StartBalance'
        DataType = ftFloat
      end
      item
        Name = 'OurFirm'
        Component = FormParams
        ComponentItem = 'OurFirm'
        DataType = ftString
      end>
    Left = 88
    Top = 176
  end
  object MainJuridicalGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = edMainJuridical
    FormNameParam.Value = 'TJuridical_ObjectForm'
    FormNameParam.DataType = ftString
    FormName = 'TJuridical_ObjectForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = MainJuridicalGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = MainJuridicalGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 512
    Top = 56
  end
  object gpGetDefault: TdsdStoredProc
    StoredProcName = 'gpGetJuridicalCollation'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'OperDate'
        Value = 41395d
        Component = deEnd
        DataType = ftDateTime
        ParamType = ptInput
      end
      item
        Name = 'MainJuridicalId'
        Value = ''
        Component = MainJuridicalGuides
        ComponentItem = 'Key'
      end
      item
        Name = 'MainJuridicalName'
        Value = ''
        Component = MainJuridicalGuides
        ComponentItem = 'TextValue'
        DataType = ftString
      end>
    Left = 576
    Top = 64
  end
  object gpGetJuridical: TdsdStoredProc
    StoredProcName = 'gpGet_ObjectHistory_JuridicalDetails'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inJuridicalId'
        Value = ''
        Component = MainJuridicalGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'inOperDate'
        Value = 41395d
        Component = deEnd
        DataType = ftDateTime
        ParamType = ptInput
      end
      item
        Name = 'AccounterName'
        Component = FormParams
        ComponentItem = 'AccounterName'
        DataType = ftString
      end>
    Left = 296
    Top = 192
  end
  object AccountGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = edAccount
    FormNameParam.Value = 'TAccount_ObjectForm'
    FormNameParam.DataType = ftString
    FormName = 'TAccount_ObjectForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = AccountGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'TextValueAll'
        Value = ''
        Component = AccountGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 768
    Top = 48
  end
  object ContractGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = ceContract
    FormNameParam.Value = 'TContractChoiceForm'
    FormNameParam.DataType = ftString
    FormName = 'TContractChoiceForm'
    PositionDataSet = 'MasterCDS'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = ContractGuides
        ComponentItem = 'Key'
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = ContractGuides
        ComponentItem = 'TextValue'
        DataType = ftString
      end
      item
        Name = 'JuridicalId'
        Value = ''
        Component = JuridicalGuides
        ComponentItem = 'Key'
      end
      item
        Name = 'JuridicalName'
        Value = ''
        Component = JuridicalGuides
        ComponentItem = 'TextValue'
        DataType = ftString
      end
      item
        Name = 'InfoMoneyId'
        Value = ''
        ComponentItem = 'Key'
      end
      item
        Name = 'InfoMoneyName'
        Value = ''
        ComponentItem = 'TextValue'
        DataType = ftString
      end
      item
        Name = 'inPaidKindId'
        Value = '0'
        Component = FormParams
        ComponentItem = 'inPaidKindId'
      end>
    Left = 728
    Top = 65534
  end
end
