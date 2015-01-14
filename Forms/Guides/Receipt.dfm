object ReceiptForm: TReceiptForm
  Left = 0
  Top = 0
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' <'#1056#1077#1094#1077#1087#1090#1091#1088#1099'>'
  ClientHeight = 467
  ClientWidth = 1152
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  AddOnFormData.isAlwaysRefresh = False
  AddOnFormData.RefreshAction = actRefresh
  AddOnFormData.ChoiceAction = dsdChoiceGuides
  PixelsPerInch = 96
  TextHeight = 13
  object cxGrid: TcxGrid
    Left = 0
    Top = 26
    Width = 1152
    Height = 297
    Align = alClient
    TabOrder = 0
    LookAndFeel.NativeStyle = False
    ExplicitWidth = 1186
    object cxGridDBTableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DataSource
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Filter.Active = True
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      Images = dmMain.SortImageList
      OptionsBehavior.IncSearch = True
      OptionsCustomize.ColumnHiding = True
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.HeaderHeight = 40
      OptionsView.Indicator = True
      Styles.StyleSheet = dmMain.cxGridTableViewStyleSheet
      object clCode: TcxGridDBColumn
        Caption = #1050#1086#1076
        DataBinding.FieldName = 'Code'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 39
      end
      object clReceiptCode: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1088#1077#1094#1077#1087#1090#1091#1088#1099
        DataBinding.FieldName = 'ReceiptCode'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 111
      end
      object clName: TcxGridDBColumn
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        DataBinding.FieldName = 'Name'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 173
      end
      object colValue: TcxGridDBColumn
        Caption = #1047#1085#1072#1095#1077#1085#1080#1077' ('#1082#1086#1083'.)'
        DataBinding.FieldName = 'Value'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 62
      end
      object clValueCost: TcxGridDBColumn
        Caption = #1047#1085#1072#1095#1077#1085#1080#1077' '#1079#1072#1090#1088#1072#1090' ('#1082#1086#1083'.)'
        DataBinding.FieldName = 'ValueCost'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 83
      end
      object clTaxExit: TcxGridDBColumn
        Caption = '% '#1074#1099#1093#1086#1076#1072
        DataBinding.FieldName = 'TaxExit'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 70
      end
      object clPartionValue: TcxGridDBColumn
        Caption = #1050#1086#1083'. '#1074' '#1087#1072#1088#1090#1080#1080' ('#1082#1086#1083'. '#1074' '#1082#1091#1090#1077#1088#1077')'
        DataBinding.FieldName = 'PartionValue'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 45
      end
      object clPartionCount: TcxGridDBColumn
        Caption = #1052#1080#1085'.'#1082#1086#1083'. '#1087#1072#1088#1090#1080#1081' ('#1082#1086#1083'. '#1082#1091#1090#1077#1088#1086#1074', '#1079#1085#1072#1095#1077#1085#1080#1077' '#1080#1083#1080' 0.5 '#1080#1083#1080' 1)'
        DataBinding.FieldName = 'PartionCount'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 195
      end
      object clStartDate: TcxGridDBColumn
        Caption = #1053#1072#1095#1072#1083#1100#1085#1072#1103' '#1076#1072#1090#1072
        DataBinding.FieldName = 'StartDate'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 70
      end
      object clEndDate: TcxGridDBColumn
        Caption = #1050#1086#1085#1077#1095#1085#1072#1103' '#1076#1072#1090#1072
        DataBinding.FieldName = 'EndDate'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 69
      end
      object clMain: TcxGridDBColumn
        Caption = #1055#1088#1080#1079#1085#1072#1082' '#1075#1083#1072#1074#1085#1099#1081
        DataBinding.FieldName = 'Main'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 59
      end
      object clGoodsCode: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1090#1086#1074#1072#1088#1072
        DataBinding.FieldName = 'GoodsCode'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 55
      end
      object clGoodsName: TcxGridDBColumn
        Caption = #1058#1086#1074#1072#1088
        DataBinding.FieldName = 'GoodsName'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 113
      end
      object clGoodsKindName: TcxGridDBColumn
        Caption = #1042#1080#1076' '#1090#1086#1074#1072#1088#1072
        DataBinding.FieldName = 'GoodsKindName'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 55
      end
      object clGoodsKindCompleteName: TcxGridDBColumn
        Caption = #1042#1080#1076' '#1090#1086#1074#1072#1088#1072'('#1075#1086#1090#1086#1074#1072#1103' '#1087#1088#1086#1076#1091#1082#1094#1080#1103')'
        DataBinding.FieldName = 'GoodsKindCompleteName'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 80
      end
      object clReceiptCostName: TcxGridDBColumn
        Caption = #1047#1072#1090#1088#1072#1090#1099' '#1074' '#1088#1077#1094#1077#1087#1090#1091#1088#1072#1093
        DataBinding.FieldName = 'ReceiptCostName'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 87
      end
      object clReceiptKindName: TcxGridDBColumn
        Caption = #1058#1080#1087' '#1088#1077#1094#1077#1087#1090#1091#1088
        DataBinding.FieldName = 'ReceiptKindName'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 77
      end
      object clComment: TcxGridDBColumn
        Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
        DataBinding.FieldName = 'Comment'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 108
      end
      object clIsErased: TcxGridDBColumn
        Caption = #1059#1076#1072#1083#1077#1085
        DataBinding.FieldName = 'isErased'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 40
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridDBTableView
    end
  end
  object cxGridContractCondition: TcxGrid
    Left = 0
    Top = 323
    Width = 1152
    Height = 144
    Align = alBottom
    TabOrder = 1
    LookAndFeel.Kind = lfStandard
    LookAndFeel.NativeStyle = False
    LookAndFeel.SkinName = ''
    ExplicitWidth = 1186
    object cxGridDBTableViewContractCondition: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = ReceiptChildDS
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Filter.Active = True
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      Images = dmMain.SortImageList
      OptionsBehavior.IncSearch = True
      OptionsCustomize.ColumnHiding = True
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      OptionsView.HeaderHeight = 40
      OptionsView.Indicator = True
      Styles.StyleSheet = dmMain.cxGridTableViewStyleSheet
      object colGoodsName: TcxGridDBColumn
        Caption = #1058#1086#1074#1072#1088
        DataBinding.FieldName = 'GoodsName'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Action = Goods_ObjectChoiceForm
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ReadOnly = True
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 155
      end
      object colGoodsKindName: TcxGridDBColumn
        Caption = #1042#1080#1076' '#1090#1086#1074#1072#1088#1072
        DataBinding.FieldName = 'GoodsKindName'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Action = ReceiptChildChoiceForm
            Caption = 'GoodsKindChoiceForm'
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ReadOnly = True
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 150
      end
      object clValue: TcxGridDBColumn
        Caption = #1047#1085#1072#1095#1077#1085#1080#1077
        DataBinding.FieldName = 'Value'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 112
      end
      object colStartDate: TcxGridDBColumn
        Caption = #1053#1072#1095#1072#1083#1100#1085#1072#1103' '#1076#1072#1090#1072
        DataBinding.FieldName = 'StartDate'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 77
      end
      object colEndDate: TcxGridDBColumn
        Caption = #1050#1086#1085#1077#1095#1085#1072#1103' '#1076#1072#1090#1072
        DataBinding.FieldName = 'EndDate'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 77
      end
      object colWeight: TcxGridDBColumn
        Caption = #1042#1093#1086#1076#1080#1090' '#1074' '#1086#1073#1097#1080#1081' '#1074#1077#1089' '#1074#1099#1093#1086#1076#1072
        DataBinding.FieldName = 'Weight'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 137
      end
      object colTaxExit: TcxGridDBColumn
        Caption = #1047#1072#1074#1080#1089#1080#1090' '#1086#1090' % '#1074#1099#1093#1086#1076#1072
        DataBinding.FieldName = 'TaxExit'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 148
      end
      object colComment: TcxGridDBColumn
        Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
        DataBinding.FieldName = 'Comment'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 239
      end
      object clsfcisErased: TcxGridDBColumn
        Caption = #1059#1076#1072#1083#1077#1085
        DataBinding.FieldName = 'isErased'
        Visible = False
        Width = 60
      end
    end
    object cxGridLevel2: TcxGridLevel
      GridView = cxGridDBTableViewContractCondition
    end
  end
  object DataSource: TDataSource
    DataSet = ClientDataSet
    Left = 56
    Top = 96
  end
  object ClientDataSet: TClientDataSet
    Aggregates = <>
    MasterFields = 'Id'
    Params = <>
    Left = 64
    Top = 160
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
    Left = 296
    Top = 112
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = dmMain.ImageList
    NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
    PopupMenuLinks = <>
    ShowShortCutInHint = True
    UseSystemFont = True
    Left = 152
    Top = 88
    DockControlHeights = (
      0
      0
      26
      0)
    object dxBarManagerBar1: TdxBar
      Caption = 'Custom'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 671
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbInsert'
        end
        item
          Visible = True
          ItemName = 'bbEdit'
        end
        item
          Visible = True
          ItemName = 'bbSetErased'
        end
        item
          Visible = True
          ItemName = 'bbSetUnErased'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic1'
        end
        item
          Visible = True
          ItemName = 'bbInsertRecCCK'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarStatic1'
        end
        item
          Visible = True
          ItemName = 'bbRefresh'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic1'
        end
        item
          Visible = True
          ItemName = 'bbChoiceGuides'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic1'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic1'
        end
        item
          Visible = True
          ItemName = 'bbGridToExcel'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic1'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbRefresh: TdxBarButton
      Action = actRefresh
      Category = 0
    end
    object bbInsert: TdxBarButton
      Action = actInsert
      Category = 0
    end
    object bbEdit: TdxBarButton
      Action = actUpdate
      Category = 0
    end
    object bbSetErased: TdxBarButton
      Action = dsdSetErased
      Category = 0
    end
    object bbSetUnErased: TdxBarButton
      Action = dsdSetUnErased
      Category = 0
    end
    object bbGridToExcel: TdxBarButton
      Action = dsdGridToExcel
      Category = 0
    end
    object dxBarStatic1: TdxBarStatic
      Caption = '    '
      Category = 0
      Hint = '    '
      Visible = ivAlways
    end
    object bbChoiceGuides: TdxBarButton
      Action = dsdChoiceGuides
      Category = 0
    end
    object bbInsertRecCCK: TdxBarButton
      Action = InsertRecordCCK
      Category = 0
    end
    object bbIsPeriod: TdxBarControlContainerItem
      Caption = #1054#1075#1088#1072#1085#1080#1095#1077#1085#1080#1077' '#1079#1072' '#1087#1077#1088#1080#1086#1076
      Category = 0
      Hint = #1054#1075#1088#1072#1085#1080#1095#1077#1085#1080#1077' '#1079#1072' '#1087#1077#1088#1080#1086#1076
      Visible = ivAlways
    end
    object bbStartDate: TdxBarControlContainerItem
      Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072' '#1087#1077#1088#1080#1086#1076#1072
      Category = 0
      Hint = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072' '#1087#1077#1088#1080#1086#1076#1072
      Visible = ivAlways
    end
    object bbEnd: TdxBarControlContainerItem
      Caption = #1054#1082#1086#1085#1095#1072#1085#1080#1077' '#1087#1077#1088#1080#1086#1076#1072
      Category = 0
      Hint = #1054#1082#1086#1085#1095#1072#1085#1080#1077' '#1087#1077#1088#1080#1086#1076#1072
      Visible = ivAlways
    end
    object bbEndDate: TdxBarControlContainerItem
      Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' '#1087#1077#1088#1080#1086#1076#1072
      Category = 0
      Hint = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' '#1087#1077#1088#1080#1086#1076#1072
      Visible = ivAlways
    end
    object bbIsEndDate: TdxBarControlContainerItem
      Caption = #1054#1075#1088#1072#1085#1080#1095#1077#1085#1080#1077' '#1087#1086' '#1076#1072#1090#1091' '#1086#1082#1086#1085#1095#1072#1085#1080#1103
      Category = 0
      Hint = #1054#1075#1088#1072#1085#1080#1095#1077#1085#1080#1077' '#1087#1086' '#1076#1072#1090#1091' '#1086#1082#1086#1085#1095#1072#1085#1080#1103
      Visible = ivAlways
    end
  end
  object ActionList: TActionList
    Images = dmMain.ImageList
    Left = 248
    Top = 136
    object actRefresh: TdsdDataSetRefresh
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = dsdStoredProc
      StoredProcList = <
        item
          StoredProc = dsdStoredProc
        end
        item
          StoredProc = spSelectReceiptChild
        end>
      Caption = #1055#1077#1088#1077#1095#1080#1090#1072#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      ImageIndex = 4
      ShortCut = 116
      RefreshOnTabSetChanges = False
    end
    object actInsert: TdsdInsertUpdateAction
      Category = 'DSDLib'
      MoveParams = <>
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ShortCut = 45
      ImageIndex = 0
      FormName = 'TReceiptEditForm'
      FormNameParam.Value = 'TReceiptEditForm'
      FormNameParam.DataType = ftString
      GuiParams = <
        item
          Name = 'Id'
          Value = Null
        end
        item
          Name = 'JuridicalId'
          Value = 0
        end
        item
          Name = 'JuridicalName'
          Value = ''
          DataType = ftString
        end>
      isShowModal = True
      DataSource = DataSource
      DataSetRefresh = actRefresh
      IdFieldName = 'Id'
    end
    object actUpdate: TdsdInsertUpdateAction
      Category = 'DSDLib'
      MoveParams = <>
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      ShortCut = 115
      ImageIndex = 1
      FormName = 'TReceiptEditForm'
      FormNameParam.Value = 'TReceiptEditForm'
      FormNameParam.DataType = ftString
      GuiParams = <
        item
          Name = 'Id'
          Value = Null
          Component = ClientDataSet
          ComponentItem = 'Id'
          ParamType = ptInput
        end>
      isShowModal = True
      ActionType = acUpdate
      DataSource = DataSource
      DataSetRefresh = actRefresh
      IdFieldName = 'Id'
    end
    object dsdSetErased: TdsdUpdateErased
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spErasedUnErased
      StoredProcList = <
        item
          StoredProc = spErasedUnErased
        end>
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      ImageIndex = 2
      ShortCut = 46
      ErasedFieldName = 'isErased'
      DataSource = DataSource
    end
    object dsdSetUnErased: TdsdUpdateErased
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spErasedUnErased
      StoredProcList = <
        item
          StoredProc = spErasedUnErased
        end>
      Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100
      Hint = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      ImageIndex = 8
      ShortCut = 32776
      ErasedFieldName = 'isErased'
      isSetErased = False
      DataSource = DataSource
    end
    object dsdChoiceGuides: TdsdChoiceGuides
      Category = 'DSDLib'
      MoveParams = <>
      Params = <
        item
          Name = 'Key'
          Value = Null
          Component = ClientDataSet
          ComponentItem = 'Id'
        end
        item
          Name = 'TextValue'
          Value = Null
          Component = ClientDataSet
          ComponentItem = 'Name'
          DataType = ftString
        end>
      Caption = #1042#1099#1073#1086#1088' '#1080#1079' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1072
      Hint = #1042#1099#1073#1086#1088' '#1080#1079' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1072
      ImageIndex = 7
    end
    object dsdGridToExcel: TdsdGridToExcel
      Category = 'DSDLib'
      MoveParams = <>
      Grid = cxGrid
      Caption = #1042#1099#1075#1088#1091#1079#1082#1072' '#1074' Excel'
      Hint = #1042#1099#1075#1088#1091#1079#1082#1072' '#1074' Excel'
      ImageIndex = 6
      ShortCut = 16472
    end
    object ReceiptChildChoiceForm: TOpenChoiceForm
      Category = 'DSDLib'
      MoveParams = <>
      Caption = 'ReceiptChildForm'
      FormName = 'TGoodsKindForm'
      FormNameParam.Value = 'TGoodsKindForm'
      FormNameParam.DataType = ftString
      GuiParams = <
        item
          Name = 'Key'
          Value = Null
          Component = ReceiptChildCDS
          ComponentItem = 'GoodsKindId'
        end
        item
          Name = 'TextValue'
          Value = Null
          Component = ReceiptChildCDS
          ComponentItem = 'GoodsKindName'
          DataType = ftString
        end>
      isShowModal = False
    end
    object Goods_ObjectChoiceForm: TOpenChoiceForm
      Category = 'DSDLib'
      MoveParams = <>
      Caption = 'Goods_ObjectChoiceForm'
      FormName = 'TGoods_ObjectForm'
      FormNameParam.Value = 'TGoods_ObjectForm'
      FormNameParam.DataType = ftString
      GuiParams = <
        item
          Name = 'Key'
          Value = Null
          Component = ReceiptChildCDS
          ComponentItem = 'GoodsId'
        end
        item
          Name = 'TextValue'
          Value = Null
          Component = ReceiptChildCDS
          ComponentItem = 'GoodsName'
          DataType = ftString
        end>
      isShowModal = False
    end
    object InsertRecordCCK: TInsertRecord
      Category = 'DSDLib'
      MoveParams = <>
      View = cxGridDBTableViewContractCondition
      Action = Goods_ObjectChoiceForm
      Params = <>
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' <'#1057#1086#1089#1090#1072#1074#1083#1103#1102#1097#1080#1077' '#1088#1077#1094#1077#1087#1090#1091#1088#1099'>'
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' <'#1057#1086#1089#1090#1072#1074#1083#1103#1102#1097#1080#1077' '#1088#1077#1094#1077#1087#1090#1091#1088#1099'>'
      ImageIndex = 0
    end
    object actReceiptChild: TdsdUpdateDataSet
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spInsertUpdateReceiptChild
      StoredProcList = <
        item
          StoredProc = spInsertUpdateReceiptChild
        end>
      Caption = 'actUpdateDataSetCCK'
      DataSource = ReceiptChildDS
    end
    object actUpdateDataSet: TdsdUpdateDataSet
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spInsertUpdate
      StoredProcList = <
        item
          StoredProc = spInsertUpdate
        end>
      Caption = 'actUpdateDataSet'
      DataSource = DataSource
    end
  end
  object dsdStoredProc: TdsdStoredProc
    StoredProcName = 'gpSelect_Object_Receipt'
    DataSet = ClientDataSet
    DataSets = <
      item
        DataSet = ClientDataSet
      end>
    Params = <>
    PackSize = 1
    Left = 216
    Top = 224
  end
  object dsdUserSettingsStorageAddOn: TdsdUserSettingsStorageAddOn
    Left = 104
    Top = 208
  end
  object spErasedUnErased: TdsdStoredProc
    StoredProcName = 'gpUpdate_Object_isErased_Contract'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inObjectId'
        Value = Null
        Component = ClientDataSet
        ComponentItem = 'Id'
        ParamType = ptInput
      end>
    PackSize = 1
    Left = 160
    Top = 160
  end
  object dsdDBViewAddOn: TdsdDBViewAddOn
    ErasedFieldName = 'isErased'
    View = cxGridDBTableView
    OnDblClickActionList = <
      item
        Action = actUpdate
      end
      item
        Action = dsdChoiceGuides
      end>
    ActionItemList = <
      item
        Action = dsdChoiceGuides
        ShortCut = 13
      end
      item
        Action = actUpdate
        ShortCut = 13
      end>
    SortImages = dmMain.SortImageList
    OnlyEditingCellOnEnter = False
    ColorRuleList = <>
    ColumnAddOnList = <>
    ColumnEnterList = <>
    SummaryItemList = <>
    Left = 272
    Top = 184
  end
  object ReceiptChildDS: TDataSource
    DataSet = ReceiptChildCDS
    Left = 102
    Top = 413
  end
  object ReceiptChildCDS: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'ReceiptId'
    MasterFields = 'Id'
    MasterSource = DataSource
    PacketRecords = 0
    Params = <>
    Left = 225
    Top = 413
  end
  object spInsertUpdateReceiptChild: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_Object_ReceiptChild'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'ioId'
        Value = Null
        Component = ReceiptChildCDS
        ComponentItem = 'Id'
        ParamType = ptInputOutput
      end
      item
        Name = 'inValue'
        Value = Null
        Component = ReceiptChildCDS
        ComponentItem = 'Value'
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'inWeight'
        Value = Null
        Component = ReceiptChildCDS
        ComponentItem = 'Weight'
        DataType = ftBoolean
        ParamType = ptInput
      end
      item
        Name = 'inTaxExit'
        Value = Null
        Component = ReceiptChildCDS
        ComponentItem = 'TaxExit'
        DataType = ftBoolean
        ParamType = ptInput
      end
      item
        Name = 'inStartDate'
        Value = Null
        Component = ReceiptChildCDS
        ComponentItem = 'StartDate'
        DataType = ftDateTime
        ParamType = ptInput
      end
      item
        Name = 'inEndDate'
        Value = Null
        Component = ReceiptChildCDS
        ComponentItem = 'EndDate'
        DataType = ftDateTime
        ParamType = ptInput
      end
      item
        Name = 'inComment'
        Value = Null
        Component = ReceiptChildCDS
        ComponentItem = 'Comment'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'inReceiptId'
        Value = Null
        Component = ClientDataSet
        ComponentItem = 'Id'
        ParamType = ptInput
      end
      item
        Name = 'inGoodsId'
        Value = Null
        Component = ReceiptChildCDS
        ComponentItem = 'GoodsId'
        ParamType = ptInput
      end
      item
        Name = 'inGoodsKindId'
        Value = Null
        Component = ReceiptChildCDS
        ComponentItem = 'GoodsKindId'
        ParamType = ptInput
      end>
    PackSize = 1
    Left = 368
    Top = 416
  end
  object spSelectReceiptChild: TdsdStoredProc
    StoredProcName = 'gpSelect_Object_ReceiptChild'
    DataSet = ReceiptChildCDS
    DataSets = <
      item
        DataSet = ReceiptChildCDS
      end>
    Params = <>
    PackSize = 1
    Left = 650
    Top = 397
  end
  object spInsertUpdate: TdsdStoredProc
    StoredProcName = 'gpUpdate_Object_Receipt'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'ioId'
        Value = Null
        Component = ClientDataSet
        ComponentItem = 'Id'
        ParamType = ptInputOutput
      end
      item
        Name = 'inPersonalId'
        Value = Null
        Component = ClientDataSet
        ComponentItem = 'PersonalId'
        ParamType = ptInput
      end
      item
        Name = 'inPersonalTradeId'
        Value = Null
        Component = ClientDataSet
        ComponentItem = 'PersonalTradeId'
        ParamType = ptInput
      end
      item
        Name = 'inPersonalCollationId'
        Value = Null
        Component = ClientDataSet
        ComponentItem = 'PersonalCollationId'
        ParamType = ptInput
      end
      item
        Name = 'inBankAccountId'
        Value = Null
        Component = ClientDataSet
        ComponentItem = 'BankAccountId'
        ParamType = ptInput
      end
      item
        Name = 'inContractTagId'
        Value = Null
        Component = ClientDataSet
        ComponentItem = 'ContractTagId'
        ParamType = ptInput
      end>
    PackSize = 1
    Left = 432
    Top = 176
  end
  object ChildViewAddOn: TdsdDBViewAddOn
    ErasedFieldName = 'isErased'
    View = cxGridDBTableViewContractCondition
    OnDblClickActionList = <
      item
        Action = actUpdate
      end
      item
        Action = dsdChoiceGuides
      end>
    ActionItemList = <
      item
        Action = dsdChoiceGuides
        ShortCut = 13
      end
      item
        Action = actUpdate
        ShortCut = 13
      end>
    SortImages = dmMain.SortImageList
    OnlyEditingCellOnEnter = False
    ColorRuleList = <>
    ColumnAddOnList = <>
    ColumnEnterList = <>
    SummaryItemList = <>
    Left = 448
    Top = 360
  end
  object PeriodChoice: TPeriodChoice
    Left = 480
    Top = 120
  end
  object RefreshDispatcher: TRefreshDispatcher
    RefreshAction = actRefresh
    ComponentList = <
      item
        Component = PeriodChoice
      end>
    Left = 536
    Top = 160
  end
end