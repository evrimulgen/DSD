﻿object ProfitLossEditForm: TProfitLossEditForm
  Left = 0
  Top = 0
  Caption = #1053#1086#1074#1072#1103' '#1089#1090#1072#1090#1100#1103
  ClientHeight = 371
  ClientWidth = 348
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  AddOnFormData.RefreshAction = dsdDataSetRefresh
  AddOnFormData.Params = dsdFormParams
  PixelsPerInch = 96
  TextHeight = 13
  object edName: TcxTextEdit
    Left = 40
    Top = 76
    TabOrder = 0
    Width = 273
  end
  object cxLabel1: TcxLabel
    Left = 40
    Top = 48
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
  end
  object cxButton1: TcxButton
    Left = 56
    Top = 321
    Width = 75
    Height = 25
    Action = dsdInsertUpdateGuides
    Default = True
    ModalResult = 8
    TabOrder = 2
  end
  object cxButton2: TcxButton
    Left = 222
    Top = 321
    Width = 75
    Height = 25
    Action = dsdFormClose1
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 8
    TabOrder = 3
  end
  object Код: TcxLabel
    Left = 40
    Top = 3
    Caption = #1050#1086#1076
  end
  object ceCode: TcxCurrencyEdit
    Left = 40
    Top = 26
    Properties.DecimalPlaces = 0
    Properties.DisplayFormat = '0'
    TabOrder = 5
    Width = 273
  end
  object cxLabel3: TcxLabel
    Left = 40
    Top = 103
    Caption = #1043#1088#1091#1087#1087#1099' '#1089#1090#1072#1090#1077#1081' '#1086#1090#1095#1077#1090#1072' '#1086' '#1087#1088#1080#1073#1099#1083#1103#1093' '#1080' '#1091#1073#1099#1090#1082#1072#1093
  end
  object cxLabel2: TcxLabel
    Left = 40
    Top = 155
    Caption = #1040#1085#1072#1083#1080#1090#1080#1082#1080' '#1089#1090#1072#1090#1077#1081' '#1086#1090#1095#1077#1090#1072' '#1086' '#1087#1088#1080#1073#1099#1083#1103#1093' '#1080' '#1091#1073#1099#1090#1082#1072#1093' - '#1085#1072#1087#1088#1072#1074#1083#1077#1085#1080#1103
  end
  object cxLabel4: TcxLabel
    Left = 40
    Top = 205
    Caption = #1059#1087#1088#1072#1074#1083#1077#1085#1095#1077#1089#1082#1080#1077' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1103
  end
  object cxLabel5: TcxLabel
    Left = 40
    Top = 255
    Caption = #1057#1090#1072#1090#1100#1080' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1103
  end
  object ceProfitLossGroup: TcxButtonEdit
    Left = 40
    Top = 128
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    TabOrder = 10
    Width = 273
  end
  object ceProfitLossDirection: TcxButtonEdit
    Left = 40
    Top = 178
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    TabOrder = 11
    Width = 273
  end
  object ceInfoMoneyDestination: TcxButtonEdit
    Left = 40
    Top = 228
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    TabOrder = 12
    Width = 273
  end
  object ceInfoMoney: TcxButtonEdit
    Left = 40
    Top = 278
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    TabOrder = 13
    Width = 273
  end
  object ActionList: TActionList
    Left = 240
    Top = 120
    object dsdDataSetRefresh: TdsdDataSetRefresh
      Category = 'DSDLib'
      StoredProc = spGet
      StoredProcList = <
        item
          StoredProc = spGet
        end
        item
        end>
      Caption = #1055#1077#1088#1077#1095#1080#1090#1072#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      ShortCut = 116
      RefreshOnTabSetChanges = False
    end
    object dsdFormClose1: TdsdFormClose
    end
    object dsdInsertUpdateGuides: TdsdInsertUpdateGuides
      Category = 'DSDLib'
      StoredProc = spInsertUpdate
      StoredProcList = <
        item
          StoredProc = spInsertUpdate
        end>
      Caption = #1054#1082
    end
  end
  object spInsertUpdate: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_Object_ProfitLoss'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'ioId'
        Value = Null
        Component = dsdFormParams
        ComponentItem = 'Id'
        ParamType = ptInputOutput
      end
      item
        Name = 'inCode'
        Value = 0.000000000000000000
        Component = ceCode
        ParamType = ptInput
      end
      item
        Name = 'inName'
        Value = ''
        Component = edName
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'inProfitLossGroupId '
        Value = ''
        Component = ProfitLossGroupGuides
        ParamType = ptInput
      end
      item
        Name = 'inProfitLossDirectionId'
        Value = ''
        Component = ProfitLossDirectionGuides
        ParamType = ptInput
      end
      item
        Name = 'inInfoMoneyDestinationId'
        Value = ''
        Component = InfoMoneyDestinationGuides
        ParamType = ptInput
      end
      item
        Name = 'inInfoMoneyId '
        Value = ''
        Component = InfoMoneyGuides
      end>
    Left = 264
    Top = 64
  end
  object dsdFormParams: TdsdFormParams
    Params = <
      item
        Name = 'Id'
        Value = Null
        ParamType = ptInputOutput
      end>
    Left = 216
    Top = 24
  end
  object spGet: TdsdStoredProc
    StoredProcName = 'gpGet_Object_ProfitLoss'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'Id'
        Value = Null
        Component = dsdFormParams
        ComponentItem = 'Id'
        ParamType = ptInput
      end
      item
        Name = 'Name'
        Value = ''
        Component = edName
        DataType = ftString
      end
      item
        Name = 'Code'
        Value = 0.000000000000000000
        Component = ceCode
      end
      item
        Name = 'ProfitLossGroupId'
        Value = ''
        Component = ProfitLossGroupGuides
        ComponentItem = 'Key'
      end
      item
        Name = 'ProfitLossDirectionId'
        Value = ''
        Component = ProfitLossDirectionGuides
        ComponentItem = 'Key'
      end
      item
        Name = 'ProfitLossGroupName'
        Value = ''
        Component = ProfitLossGroupGuides
        ComponentItem = 'TextValue'
      end
      item
        Name = 'ProfitLossDirectionName'
        Value = ''
        Component = ProfitLossDirectionGuides
        ComponentItem = 'TextValue'
      end
      item
        Name = 'InfoMoneyDestinationId'
        Value = ''
        Component = InfoMoneyDestinationGuides
        ComponentItem = 'Key'
      end
      item
        Name = 'InfoMoneyDestinationName'
        Value = ''
        Component = InfoMoneyDestinationGuides
        ComponentItem = 'TextValue'
      end
      item
        Name = 'InfoMoneyId'
        Value = ''
        Component = InfoMoneyGuides
        ComponentItem = 'Key'
      end
      item
        Name = 'InfoMoneyName'
        Value = ''
        Component = InfoMoneyGuides
        ComponentItem = 'TextValue'
      end>
    Left = 192
    Top = 72
  end
  object ProfitLossGroupGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = ceProfitLossGroup
    FormName = 'TProfitLossGroupForm'
    PositionDataSet = 'ClientDataSet'
    Params = <>
    Left = 184
    Top = 117
  end
  object ProfitLossDirectionGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = ceProfitLossDirection
    FormName = 'TProfitLossDirectionForm'
    PositionDataSet = 'ClientDataSet'
    Params = <>
    Left = 192
    Top = 173
  end
  object cxPropertiesStore: TcxPropertiesStore
    Components = <
      item
        Component = Owner
        Properties.Strings = (
          'Height'
          'Left'
          'Top'
          'Width')
      end>
    StorageName = 'cxPropertiesStore'
    StorageType = stStream
    Left = 240
    Top = 176
  end
  object dsdUserSettingsStorageAddOn: TdsdUserSettingsStorageAddOn
    Left = 256
    Top = 24
  end
  object InfoMoneyDestinationGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = ceInfoMoneyDestination
    FormName = 'TInfoMoneyDestinationForm'
    PositionDataSet = 'ClientDataSet'
    Params = <>
    Left = 208
    Top = 229
  end
  object InfoMoneyGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = ceInfoMoney
    FormName = 'TInfoMoney_ObjectForm'
    PositionDataSet = 'ClientDataSet'
    Params = <>
    Left = 184
    Top = 269
  end
end
