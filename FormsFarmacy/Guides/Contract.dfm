inherited ContractForm: TContractForm
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' <'#1044#1086#1075#1086#1074#1086#1088#1072'>'
  ClientWidth = 828
  AddOnFormData.ChoiceAction = dsdChoiceGuides
  ExplicitWidth = 844
  ExplicitHeight = 346
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TcxPageControl
    Width = 828
    ExplicitWidth = 828
    ClientRectRight = 828
    inherited tsMain: TcxTabSheet
      ExplicitWidth = 828
      inherited cxGrid: TcxGrid
        Width = 828
        ExplicitWidth = 828
        inherited cxGridDBTableView: TcxGridDBTableView
          OptionsData.CancelOnExit = True
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          Styles.Content = nil
          Styles.Inactive = nil
          Styles.Selection = nil
          Styles.Footer = nil
          Styles.Header = nil
          object clName: TcxGridDBColumn
            Caption = #1053#1086#1084#1077#1088' '#1076#1086#1075#1086#1074#1086#1088#1072
            DataBinding.FieldName = 'Name'
            HeaderAlignmentVert = vaCenter
            Width = 123
          end
          object clJuridicalBasisName: TcxGridDBColumn
            Caption = #1043#1083#1072#1074#1085#1086#1077' '#1102#1088'. '#1083#1080#1094#1086
            DataBinding.FieldName = 'JuridicalBasisName'
            Visible = False
            HeaderAlignmentVert = vaCenter
            Width = 145
          end
          object clJuridicalName: TcxGridDBColumn
            Caption = #1070#1088#1080#1076#1080#1095#1077#1089#1082#1086#1077' '#1083#1080#1094#1086
            DataBinding.FieldName = 'JuridicalName'
            HeaderAlignmentVert = vaCenter
            Width = 212
          end
          object clBankAccountName: TcxGridDBColumn
            Caption = #1056#1072#1089#1095#1077#1090#1085#1099#1081' '#1089#1095#1077#1090
            DataBinding.FieldName = 'BankAccountName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 134
          end
          object clBankName: TcxGridDBColumn
            Caption = #1041#1072#1085#1082
            DataBinding.FieldName = 'BankName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 96
          end
          object colPercent: TcxGridDBColumn
            Caption = '% '#1082#1086#1088#1088#1077#1082#1090#1080#1088#1086#1074#1082#1080' '#1085#1072#1094#1077#1085#1082#1080
            DataBinding.FieldName = 'Percent'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            Properties.ReadOnly = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 120
          end
          object colPercent_Juridical: TcxGridDBColumn
            Caption = '% '#1082#1086#1088#1088'. '#1085#1072#1094#1077#1085#1082#1080' '#1102#1088'.'#1083#1080#1094#1086
            DataBinding.FieldName = 'Percent_Juridical'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            Properties.ReadOnly = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 120
          end
          object clStartDate: TcxGridDBColumn
            Caption = #1044#1077#1081#1089#1090#1074'. '#1089
            DataBinding.FieldName = 'StartDate'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 78
          end
          object clEndDate: TcxGridDBColumn
            Caption = #1044#1077#1081#1089#1090#1074'. '#1076#1086
            DataBinding.FieldName = 'EndDate'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 78
          end
          object colDeferment: TcxGridDBColumn
            Caption = #1054#1090#1089#1088#1086#1095#1082#1072
            DataBinding.FieldName = 'Deferment'
            HeaderAlignmentVert = vaCenter
            Width = 98
          end
          object colisReport: TcxGridDBColumn
            Caption = #1059#1095#1072#1089#1090#1074#1091#1077#1090' '#1074' '#1086#1090#1095#1077#1090#1077
            DataBinding.FieldName = 'isReport'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            HeaderHint = #1059#1095#1072#1089#1090#1074#1091#1077#1090' '#1074' '#1086#1090#1095#1077#1090#1077' "'#1075#1088#1072#1092#1080#1082' '#1076#1074#1080#1078#1077#1085#1080#1103' '#1094#1077#1085#1099' '#1087#1086' '#1087#1088#1077#1087#1072#1088#1072#1090#1091'"'
            Options.Editing = False
            Width = 90
          end
          object GroupMemberSPName: TcxGridDBColumn
            Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1103' '#1087#1072#1094#1080#1077#1085#1090#1072' ('#1057#1086#1094'.'#1087#1088#1086#1077#1082#1090')'
            DataBinding.FieldName = 'GroupMemberSPName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 105
          end
          object colPercentSP: TcxGridDBColumn
            Caption = '% '#1089#1082#1080#1076#1082#1080' ('#1057#1086#1094'. '#1087#1088#1086#1077#1082#1090')'
            DataBinding.FieldName = 'PercentSP'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            Properties.ReadOnly = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            HeaderHint = '% '#1089#1082#1080#1076#1082#1080' ('#1057#1086#1094'. '#1087#1088#1086#1077#1082#1090')'
            Options.Editing = False
            Width = 86
          end
          object clComment: TcxGridDBColumn
            Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
            DataBinding.FieldName = 'Comment'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 268
          end
          object clisErased: TcxGridDBColumn
            Caption = #1059#1076#1072#1083#1077#1085
            DataBinding.FieldName = 'isErased'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 88
          end
        end
      end
    end
  end
  inherited ActionList: TActionList
    inherited actInsert: TInsertUpdateChoiceAction
      FormName = 'TContractEditForm'
      FormNameParam.Value = 'TContractEditForm'
    end
    inherited actUpdate: TdsdInsertUpdateAction
      FormName = 'TContractEditForm'
      FormNameParam.Value = 'TContractEditForm'
    end
    object actUpdateisReport: TdsdExecStoredProc
      Category = 'DSDLib'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      StoredProc = spUpdate_Contract_isReport
      StoredProcList = <
        item
          StoredProc = spUpdate_Contract_isReport
        end>
      Caption = #1059#1095#1072#1089#1090#1074#1091#1077#1090' '#1074' '#1086#1090#1095#1077#1090#1077' '#1044#1072'/'#1053#1077#1090
      Hint = #1059#1095#1072#1089#1090#1074#1091#1077#1090' '#1074' '#1086#1090#1095#1077#1090#1077' '#1044#1072'/'#1053#1077#1090
      ImageIndex = 52
    end
  end
  inherited MasterDS: TDataSource
    Top = 96
  end
  inherited MasterCDS: TClientDataSet
    FilterOptions = []
    Top = 88
  end
  inherited spSelect: TdsdStoredProc
    StoredProcName = 'gpSelect_Object_Contract'
    Left = 88
    Top = 80
  end
  inherited BarManager: TdxBarManager
    Left = 144
    Top = 56
    DockControlHeights = (
      0
      0
      26
      0)
    inherited Bar: TdxBar
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
          ItemName = 'bbErased'
        end
        item
          Visible = True
          ItemName = 'bbUnErased'
        end
        item
          BeginGroup = True
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
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbUpdateisReport'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbProtocolOpenForm'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbChoiceGuides'
        end>
    end
    object bbUpdateisReport: TdxBarButton
      Action = actUpdateisReport
      Category = 0
    end
  end
  inherited DBViewAddOn: TdsdDBViewAddOn
    OnDblClickActionList = <
      item
        Action = dsdChoiceGuides
      end
      item
        Action = actUpdate
      end>
  end
  object spUpdate_Contract_isReport: TdsdStoredProc
    StoredProcName = 'gpUpdate_Contract_isReport'
    DataSet = MasterCDS
    DataSets = <
      item
        DataSet = MasterCDS
      end>
    OutputType = otResult
    Params = <
      item
        Name = 'inId'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inisReport'
        Value = 'FALSE'
        Component = MasterCDS
        ComponentItem = 'isReport'
        DataType = ftBoolean
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'outisReport'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'isReport'
        DataType = ftBoolean
        MultiSelectSeparator = ','
      end
      item
        Name = 'isNotParam'
        Value = 'TRUE'
        DataType = ftBoolean
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 504
    Top = 99
  end
end
