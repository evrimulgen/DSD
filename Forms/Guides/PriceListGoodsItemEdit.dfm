﻿object PriceListGoodsItemEditForm: TPriceListGoodsItemEditForm
  Left = 0
  Top = 0
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100'/'#1048#1079#1084#1077#1085#1080#1090#1100' <'#1062#1077#1085#1091'>'
  ClientHeight = 217
  ClientWidth = 335
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
  object cxButton1: TcxButton
    Left = 72
    Top = 178
    Width = 75
    Height = 25
    Action = dsdInsertUpdateGuides
    Default = True
    ModalResult = 8
    TabOrder = 2
  end
  object cxButton2: TcxButton
    Left = 176
    Top = 178
    Width = 75
    Height = 25
    Action = dsdFormClose1
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 8
    TabOrder = 3
  end
  object cxLabel3: TcxLabel
    Left = 24
    Top = 59
    Caption = #1044#1072#1090#1072' '#1089' :'
  end
  object cxLabel2: TcxLabel
    Left = 138
    Top = 59
    Caption = #1044#1072#1090#1072' '#1087#1086' :'
  end
  object edStartDate: TcxDateEdit
    Left = 24
    Top = 79
    EditValue = 42236d
    Properties.SaveTime = False
    Properties.ShowTime = False
    TabOrder = 0
    Width = 92
  end
  object edEndDate: TcxDateEdit
    Left = 138
    Top = 79
    EditValue = 42236d
    Properties.ReadOnly = True
    Properties.SaveTime = False
    Properties.ShowTime = False
    TabOrder = 1
    Width = 92
  end
  object Код: TcxLabel
    Left = 24
    Top = 3
    Caption = #1058#1086#1074#1072#1088
  end
  object edGoods: TcxButtonEdit
    Left = 24
    Top = 22
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.ReadOnly = False
    TabOrder = 7
    Width = 273
  end
  object cxLabel1: TcxLabel
    Left = 24
    Top = 109
    Caption = #1062#1077#1085#1072' :'
  end
  object cePrice: TcxCurrencyEdit
    Left = 24
    Top = 133
    Properties.DecimalPlaces = 4
    Properties.DisplayFormat = ',0.####'
    Properties.UseDisplayFormatWhenEditing = True
    TabOrder = 9
    Width = 120
  end
  object ActionList: TActionList
    Left = 304
    Top = 8
    object dsdDataSetRefresh: TdsdDataSetRefresh
      Category = 'DSDLib'
      MoveParams = <>
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
      Category = 'DSDLib'
      MoveParams = <>
      PostDataSetBeforeExecute = False
    end
    object dsdInsertUpdateGuides: TdsdInsertUpdateGuides
      Category = 'DSDLib'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      StoredProc = spInsertUpdate
      StoredProcList = <
        item
          StoredProc = spInsertUpdate
        end>
      Caption = #1054#1082
    end
  end
  object spInsertUpdate: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_ObjectHistory_PriceListItemLast'
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
        Name = 'inPriceListId'
        Value = ''
        Component = dsdFormParams
        ComponentItem = 'PriceListId'
        ParamType = ptInput
      end
      item
        Name = 'inGoodsId'
        Value = ''
        Component = dsdFormParams
        ComponentItem = 'GoodsId'
        ParamType = ptInput
      end
      item
        Name = 'inOperDate'
        Value = ''
        Component = edStartDate
        DataType = ftDateTime
        ParamType = ptInput
      end
      item
        Name = 'outStartDate'
        Value = ''
        Component = edStartDate
        DataType = ftDateTime
      end
      item
        Name = 'outEndDate'
        Value = ''
        Component = edEndDate
        DataType = ftDateTime
      end
      item
        Name = 'inValue'
        Value = Null
        Component = cePrice
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'inIsLast'
        Value = False
        DataType = ftBoolean
        ParamType = ptInput
      end>
    PackSize = 1
    Left = 259
    Top = 54
  end
  object dsdFormParams: TdsdFormParams
    Params = <
      item
        Name = 'GoodsId'
        Value = Null
        ParamType = ptInputOutput
      end
      item
        Name = 'PriceListId'
        ParamType = ptInputOutput
      end
      item
        Name = 'GoodsName'
        Value = Null
        DataType = ftString
        ParamType = ptInputOutput
      end
      item
        Name = 'StartDate'
        Value = Null
        DataType = ftDateTime
        ParamType = ptInput
      end>
    Left = 80
    Top = 8
  end
  object spGet: TdsdStoredProc
    StoredProcName = 'gpGet_ObjectHistory_PriceListItem'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inOperDate'
        Value = Null
        Component = dsdFormParams
        ComponentItem = 'StartDate'
        DataType = ftDateTime
        ParamType = ptInput
      end
      item
        Name = 'inPriceListId'
        Component = dsdFormParams
        ComponentItem = 'PriceListId'
        ParamType = ptInput
      end
      item
        Name = 'inGoodsId'
        Value = 0.000000000000000000
        Component = dsdFormParams
        ComponentItem = 'GoodsId'
        ParamType = ptInput
      end
      item
        Name = 'GoodsId'
        Value = ''
        Component = GoodsGuides
        ComponentItem = 'Key'
      end
      item
        Name = 'GoodsName'
        Value = ''
        Component = GoodsGuides
        ComponentItem = 'TextValue'
        DataType = ftString
      end
      item
        Name = 'StartDate'
        Value = ''
        Component = edStartDate
        DataType = ftDateTime
      end
      item
        Name = 'EndDate'
        Value = ''
        Component = edEndDate
        DataType = ftDateTime
      end
      item
        Name = 'ValuePrice'
        Value = ''
        Component = cePrice
        DataType = ftFloat
      end>
    PackSize = 1
    Left = 120
    Top = 70
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
    Left = 144
    Top = 120
  end
  object dsdUserSettingsStorageAddOn: TdsdUserSettingsStorageAddOn
    Left = 272
    Top = 104
  end
  object GoodsGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = edGoods
    FormNameParam.Value = 'TGoods_ObjectForm'
    FormNameParam.DataType = ftString
    FormName = 'TGoods_ObjectForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        ComponentItem = 'GoodsId'
        ParamType = ptInput
      end
      item
        Name = 'TextValue'
        Value = ''
        ComponentItem = 'GoodsName'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 160
    Top = 8
  end
end
