inherited Report_SupplyBalanceForm: TReport_SupplyBalanceForm
  Caption = #1054#1090#1095#1077#1090' <'#1087#1086' '#1086#1089#1090#1072#1090#1082#1072#1084' '#1076#1083#1103' '#1089#1085#1072#1073#1078#1077#1085#1080#1103'>'
  ClientHeight = 534
  ClientWidth = 1366
  AddOnFormData.isSingle = False
  AddOnFormData.ExecuteDialogAction = ExecuteDialog
  AddOnFormData.Params = FormParams
  ExplicitLeft = -211
  ExplicitWidth = 1382
  ExplicitHeight = 572
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TcxPageControl
    Top = 59
    Width = 1366
    Height = 475
    TabOrder = 3
    ExplicitTop = 59
    ExplicitWidth = 1366
    ExplicitHeight = 475
    ClientRectBottom = 475
    ClientRectRight = 1366
    inherited tsMain: TcxTabSheet
      ExplicitWidth = 1366
      ExplicitHeight = 475
      inherited cxGrid: TcxGrid
        Width = 1366
        Height = 475
        ExplicitWidth = 1366
        ExplicitHeight = 475
        inherited cxGridDBTableView: TcxGridDBTableView
          DataController.Summary.DefaultGroupSummaryItems = <
            item
              Format = ',0.####'
              Kind = skSum
              Column = Color_RemainsDays
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = RemainsStart
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountOut_oth
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountIncome
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = RemainsEnd
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountProductionOut
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountIn_oth
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = PlanOrder
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountOrder
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = RemainsStart_Oth
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = RemainsEnd_Oth
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountIncome1
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountIncome2
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountIncome3
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountIncome4
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountIncome5
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountIncome6
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountIncome7
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountProductionOut1
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountProductionOut2
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountProductionOut3
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountProductionOut4
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountProductionOut5
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountProductionOut6
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountProductionOut7
            end>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.####'
              Kind = skSum
              Column = Color_RemainsDays
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = RemainsStart
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountOut_oth
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountIncome
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = RemainsEnd
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountProductionOut
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountIn_oth
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = PlanOrder
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountOrder
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
            end
            item
              Format = #1057#1090#1088#1086#1082': ,0'
              Kind = skCount
              Column = clGoodsName
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = RemainsStart_Oth
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = RemainsEnd_Oth
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountIncome1
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountIncome2
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountIncome3
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountIncome4
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountIncome5
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountIncome6
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountIncome7
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountProductionOut1
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountProductionOut2
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountProductionOut3
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountProductionOut4
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountProductionOut5
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountProductionOut6
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = CountProductionOut7
            end>
          OptionsData.CancelOnExit = True
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsView.GroupByBox = True
          Styles.Content = nil
          Styles.Inactive = nil
          Styles.Selection = nil
          Styles.Footer = nil
          Styles.Header = nil
          object clGoodsGroupNameFull: TcxGridDBColumn
            Caption = #1043#1088#1091#1087#1087#1072' '#1090#1086#1074#1072#1088#1072' ('#1074#1089#1077')'
            DataBinding.FieldName = 'GoodsGroupNameFull'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 150
          end
          object GoodsGroupName: TcxGridDBColumn
            Caption = #1043#1088#1091#1087#1087#1072' '#1090#1086#1074#1072#1088#1072
            DataBinding.FieldName = 'GoodsGroupName'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 80
          end
          object clGoodsCode: TcxGridDBColumn
            Caption = #1050#1086#1076
            DataBinding.FieldName = 'GoodsCode'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 0
            Properties.DisplayFormat = ',0.;-,0.; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 35
          end
          object clGoodsName: TcxGridDBColumn
            Caption = #1058#1086#1074#1072#1088
            DataBinding.FieldName = 'GoodsName'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 151
          end
          object clGoodsKindName: TcxGridDBColumn
            Caption = #1042#1080#1076' '#1090#1086#1074#1072#1088#1072
            DataBinding.FieldName = 'GoodsKindName'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            VisibleForCustomization = False
            Width = 60
          end
          object clMeasureName: TcxGridDBColumn
            Caption = #1045#1076'. '#1080#1079#1084'.'
            DataBinding.FieldName = 'MeasureName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 35
          end
          object PartnerCode: TcxGridDBColumn
            Caption = #1050#1086#1076' '#1087#1086#1089#1090'.'
            DataBinding.FieldName = 'PartnerCode'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 55
          end
          object PartnerName: TcxGridDBColumn
            Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082
            DataBinding.FieldName = 'PartnerName'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 152
          end
          object CountDays: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086' '#1076#1085#1077#1081
            DataBinding.FieldName = 'CountDays'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 70
          end
          object RemainsStart: TcxGridDBColumn
            Caption = #1054#1089#1090#1072#1090#1086#1082' '#1085#1072#1095'.'
            DataBinding.FieldName = 'RemainsStart'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 70
          end
          object RemainsEnd: TcxGridDBColumn
            Caption = #1054#1089#1090#1072#1090#1086#1082' '#1082#1086#1085#1077#1095#1085'.'
            DataBinding.FieldName = 'RemainsEnd'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 70
          end
          object RemainsStart_Oth: TcxGridDBColumn
            Caption = #1054#1089#1090#1072#1090#1086#1082' '#1085#1072#1095'. '#1074' '#1087#1088#1086#1080#1079#1074
            DataBinding.FieldName = 'RemainsStart_Oth'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 70
          end
          object RemainsEnd_Oth: TcxGridDBColumn
            Caption = #1054#1089#1090#1072#1090#1086#1082' '#1082#1086#1085#1077#1095#1085'. '#1074' '#1087#1088#1086#1080#1079#1074
            DataBinding.FieldName = 'RemainsEnd_Oth'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 70
          end
          object CountIncome: TcxGridDBColumn
            Caption = #1055#1088#1080#1093#1086#1076'-'#1042#1086#1079#1074#1088#1072#1090' '#1087#1086#1089#1090'.'
            DataBinding.FieldName = 'CountIncome'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.##;-,0.##; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 70
          end
          object CountProductionOut: TcxGridDBColumn
            Caption = #1056#1072#1089#1093#1086#1076' '#1085#1072' '#1087#1088'-'#1074#1086
            DataBinding.FieldName = 'CountProductionOut'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.##;-,0.##; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 70
          end
          object CountIn_oth: TcxGridDBColumn
            Caption = #1055#1088#1080#1093'. '#1076#1088#1091#1075#1086#1081
            DataBinding.FieldName = 'CountIn_oth'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 70
          end
          object CountOut_oth: TcxGridDBColumn
            Caption = #1056#1072#1089#1093'. '#1076#1088#1091#1075#1086#1081
            DataBinding.FieldName = 'CountOut_oth'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 70
          end
          object CountOnDay: TcxGridDBColumn
            Caption = #1057#1088#1077#1076#1085#1080#1081' '#1088#1072#1089#1093#1086#1076' '#1074' '#1076#1077#1085#1100
            DataBinding.FieldName = 'CountOnDay'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.##;-,0.##; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 70
          end
          object RemainsDays: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086' '#1076#1085#1077#1081' '#1086#1089#1090#1072#1090#1082#1072
            DataBinding.FieldName = 'RemainsDays'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.#;-,0.#; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 70
          end
          object ReserveDays: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086' '#1076#1085#1077#1081' '#1079#1072#1087#1072#1089#1072
            DataBinding.FieldName = 'ReserveDays'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.##;-,0.##; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 70
          end
          object PlanOrder: TcxGridDBColumn
            Caption = #1055#1083#1072#1085'. '#1047#1072#1082#1072#1079' '#1085#1072' '#1084#1077#1089#1103#1094
            DataBinding.FieldName = 'PlanOrder'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.##;-,0.##; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 70
          end
          object CountOrder: TcxGridDBColumn
            Caption = #1047#1072#1082#1072#1079' '#1074' '#1087#1091#1090#1080
            DataBinding.FieldName = 'CountOrder'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.##;-,0.##; ;'
            Properties.ReadOnly = True
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 70
          end
          object RemainsDaysWithOrder: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086' '#1076#1085#1077#1081' '#1086#1089#1090#1072#1090#1082#1072' '#1089' '#1091#1095#1077#1090#1086#1084' '#1079#1072#1082#1072#1079#1072
            DataBinding.FieldName = 'RemainsDaysWithOrder'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.#;-,0.#; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 70
          end
          object Color_RemainsDays: TcxGridDBColumn
            DataBinding.FieldName = 'Color_RemainsDays'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            VisibleForCustomization = False
            Width = 70
          end
          object colComment: TcxGridDBColumn
            Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077' ('#1079#1072#1082#1072#1079')'
            DataBinding.FieldName = 'Comment'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 140
          end
          object colMovementId_List: TcxGridDBColumn
            DataBinding.FieldName = 'MovementId_List'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 60
          end
          object CountIncome1: TcxGridDBColumn
            Caption = #1055#1085'. '#1087#1088#1080#1093#1086#1076
            DataBinding.FieldName = 'CountIncome1'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.##;-,0.##; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 60
          end
          object CountIncome2: TcxGridDBColumn
            Caption = #1042#1090'. '#1087#1088#1080#1093#1086#1076
            DataBinding.FieldName = 'CountIncome2'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.##;-,0.##; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 60
          end
          object CountIncome3: TcxGridDBColumn
            Caption = #1057#1088'. '#1087#1088#1080#1093#1086#1076
            DataBinding.FieldName = 'CountIncome3'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.##;-,0.##; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 60
          end
          object CountIncome4: TcxGridDBColumn
            Caption = #1063#1090'. '#1087#1088#1080#1093#1086#1076
            DataBinding.FieldName = 'CountIncome4'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.##;-,0.##; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 60
          end
          object CountIncome5: TcxGridDBColumn
            Caption = #1055#1090'. '#1087#1088#1080#1093#1086#1076
            DataBinding.FieldName = 'CountIncome5'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.##;-,0.##; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 60
          end
          object CountIncome6: TcxGridDBColumn
            Caption = #1057#1073'. '#1087#1088#1080#1093#1086#1076
            DataBinding.FieldName = 'CountIncome6'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.##;-,0.##; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 60
          end
          object CountIncome7: TcxGridDBColumn
            Caption = #1042#1089'. '#1087#1088#1080#1093#1086#1076
            DataBinding.FieldName = 'CountIncome7'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.##;-,0.##; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 60
          end
          object CountProductionOut1: TcxGridDBColumn
            Caption = #1055#1085'. '#1088#1072#1089#1093#1086#1076
            DataBinding.FieldName = 'CountProductionOut1'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.##;-,0.##; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 60
          end
          object CountProductionOut2: TcxGridDBColumn
            Caption = #1042#1090'. '#1088#1072#1089#1093#1086#1076
            DataBinding.FieldName = 'CountProductionOut2'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.##;-,0.##; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 60
          end
          object CountProductionOut3: TcxGridDBColumn
            Caption = #1057#1088'. '#1088#1072#1089#1093#1086#1076
            DataBinding.FieldName = 'CountProductionOut3'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.##;-,0.##; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 60
          end
          object CountProductionOut4: TcxGridDBColumn
            Caption = #1063#1090'. '#1088#1072#1089#1093#1086#1076
            DataBinding.FieldName = 'CountProductionOut4'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.##;-,0.##; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 60
          end
          object CountProductionOut5: TcxGridDBColumn
            Caption = #1055#1090'. '#1088#1072#1089#1093#1086#1076
            DataBinding.FieldName = 'CountProductionOut5'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.##;-,0.##; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 60
          end
          object CountProductionOut6: TcxGridDBColumn
            Caption = #1057#1073'. '#1088#1072#1089#1093#1086#1076
            DataBinding.FieldName = 'CountProductionOut6'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.##;-,0.##; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 60
          end
          object CountProductionOut7: TcxGridDBColumn
            Caption = #1042#1089'. '#1088#1072#1089#1093#1086#1076
            DataBinding.FieldName = 'CountProductionOut7'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.##;-,0.##; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 60
          end
        end
      end
    end
  end
  inherited Panel: TPanel
    Width = 1366
    Height = 33
    ExplicitWidth = 1366
    ExplicitHeight = 33
    inherited deStart: TcxDateEdit
      Left = 98
      EditValue = 42736d
      Properties.SaveTime = False
      ExplicitLeft = 98
      ExplicitWidth = 79
      Width = 79
    end
    inherited deEnd: TcxDateEdit
      Left = 294
      EditValue = 42736d
      Properties.SaveTime = False
      ExplicitLeft = 294
      ExplicitWidth = 81
      Width = 81
    end
    inherited cxLabel1: TcxLabel
      Left = 5
      ExplicitLeft = 5
    end
    inherited cxLabel2: TcxLabel
      Left = 182
      ExplicitLeft = 182
    end
    object cxLabel4: TcxLabel
      Left = 691
      Top = 6
      Caption = #1043#1088#1091#1087#1087#1072' '#1090#1086#1074#1072#1088#1086#1074':'
    end
    object edGoodsGroup: TcxButtonEdit
      Left = 782
      Top = 5
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      TabOrder = 5
      Width = 180
    end
    object cxLabel3: TcxLabel
      Left = 387
      Top = 6
      Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077':'
    end
    object edUnit: TcxButtonEdit
      Left = 474
      Top = 4
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      TabOrder = 7
      Width = 209
    end
    object cxLabel5: TcxLabel
      Left = 969
      Top = 6
      Caption = #1070#1088'. '#1083#1080#1094#1086' ('#1087#1086#1089#1090#1072#1074#1097#1080#1082'):'
    end
    object edJuridical: TcxButtonEdit
      Left = 1091
      Top = 4
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      TabOrder = 9
      Width = 192
    end
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
        Component = GoodsGroupGuides
        Properties.Strings = (
          'Key'
          'TextValue')
      end
      item
        Component = UnitGuides
        Properties.Strings = (
          'Key'
          'TextValue')
      end>
  end
  inherited ActionList: TActionList
    object actPrint: TdsdPrintAction
      Category = 'DSDLib'
      MoveParams = <
        item
          FromParam.Name = 'id'
          FromParam.Value = Null
          FromParam.ComponentItem = 'id'
          FromParam.MultiSelectSeparator = ','
          ToParam.Value = '0'
          ToParam.Component = FormParams
          ToParam.ComponentItem = 'Id'
          ToParam.ParamType = ptInputOutput
          ToParam.MultiSelectSeparator = ','
        end
        item
          FromParam.Value = 42005d
          FromParam.Component = deStart
          FromParam.DataType = ftDateTime
          FromParam.MultiSelectSeparator = ','
          ToParam.Name = 'StartDate'
          ToParam.Value = 'NULL'
          ToParam.DataType = ftDateTime
          ToParam.ParamType = ptInputOutput
          ToParam.MultiSelectSeparator = ','
        end
        item
          FromParam.Value = 42005d
          FromParam.Component = deEnd
          FromParam.DataType = ftDateTime
          FromParam.MultiSelectSeparator = ','
          ToParam.Name = 'EndDate'
          ToParam.Value = 'NULL'
          ToParam.DataType = ftDateTime
          ToParam.ParamType = ptInputOutput
          ToParam.MultiSelectSeparator = ','
        end>
      StoredProcList = <>
      Caption = #1055#1077#1095#1072#1090#1100
      Hint = #1055#1077#1095#1072#1090#1100
      ImageIndex = 3
      DataSets = <
        item
          UserName = 'frxDBDItems'
          IndexFieldNames = 'GoodsGroupNameFull;GoodsName'
          GridView = cxGridDBTableView
        end>
      Params = <
        item
          Name = 'StartDate'
          Value = 42005d
          Component = deStart
          DataType = ftDateTime
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'EndDate'
          Value = 42005d
          Component = deEnd
          DataType = ftDateTime
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'GoodsGroupName'
          Value = ''
          Component = GoodsGroupGuides
          ComponentItem = 'TextValue'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'UnitName'
          Value = Null
          Component = UnitGuides
          ComponentItem = 'TextValue'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end>
      ReportName = #1054#1090#1095#1077#1090' '#1087#1086' '#1086#1089#1090#1072#1090#1082#1072#1084' '#1076#1083#1103' '#1089#1085#1072#1073#1078#1077#1085#1080#1103
      ReportNameParam.Value = #1054#1090#1095#1077#1090' '#1087#1086' '#1086#1089#1090#1072#1090#1082#1072#1084' '#1076#1083#1103' '#1089#1085#1072#1073#1078#1077#1085#1080#1103
      ReportNameParam.DataType = ftString
      ReportNameParam.ParamType = ptInput
      ReportNameParam.MultiSelectSeparator = ','
    end
    object actPrint_Real: TdsdPrintAction
      Category = 'DSDLib'
      MoveParams = <
        item
          FromParam.Name = 'id'
          FromParam.Value = Null
          FromParam.ComponentItem = 'id'
          FromParam.MultiSelectSeparator = ','
          ToParam.Value = '0'
          ToParam.Component = FormParams
          ToParam.ComponentItem = 'Id'
          ToParam.ParamType = ptInputOutput
          ToParam.MultiSelectSeparator = ','
        end
        item
          FromParam.Value = 41640d
          FromParam.Component = deStart
          FromParam.DataType = ftDateTime
          FromParam.MultiSelectSeparator = ','
          ToParam.Name = 'StartDate'
          ToParam.Value = 'NULL'
          ToParam.DataType = ftDateTime
          ToParam.ParamType = ptInputOutput
          ToParam.MultiSelectSeparator = ','
        end
        item
          FromParam.Value = 41640d
          FromParam.Component = deEnd
          FromParam.DataType = ftDateTime
          FromParam.MultiSelectSeparator = ','
          ToParam.Name = 'EndDate'
          ToParam.Value = 'NULL'
          ToParam.DataType = ftDateTime
          ToParam.ParamType = ptInputOutput
          ToParam.MultiSelectSeparator = ','
        end>
      StoredProcList = <>
      Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1090#1086#1074#1072#1088#1091' ('#1076#1072#1085#1085#1099#1077' '#1087#1086#1082#1091#1087#1072#1090#1077#1083#1103')'
      Hint = #1054#1090#1095#1077#1090' '#1087#1086' '#1090#1086#1074#1072#1088#1091' ('#1076#1072#1085#1085#1099#1077' '#1087#1086#1082#1091#1087#1072#1090#1077#1083#1103')'
      ImageIndex = 17
      ShortCut = 16464
      DataSets = <
        item
          UserName = 'frxDBDItems'
          IndexFieldNames = 
            'JuridicalName;PartnerName;GoodsGroupNameFull;GoodsName;GoodsKind' +
            'Name;PartionGoods'
          GridView = cxGridDBTableView
        end>
      Params = <
        item
          Name = 'StartDate'
          Value = 41640d
          Component = deStart
          DataType = ftDateTime
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'EndDate'
          Value = 41640d
          Component = deEnd
          DataType = ftDateTime
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'GoodsGroupName'
          Value = ''
          Component = GoodsGroupGuides
          ComponentItem = 'TextValue'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'JuridicalName'
          Value = ''
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'isGoods'
          Value = Null
          DataType = ftBoolean
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'isPartner'
          Value = Null
          DataType = ftBoolean
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'isTradeMark'
          Value = Null
          DataType = ftBoolean
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'isGoodsKind'
          Value = Null
          DataType = ftBoolean
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'isPartionGoods'
          Value = Null
          DataType = ftBoolean
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'DescName'
          Value = Null
          Component = FormParams
          ComponentItem = 'InDescName'
          DataType = ftString
          MultiSelectSeparator = ','
        end
        item
          Name = 'ReportType'
          Value = '2'
          MultiSelectSeparator = ','
        end>
      ReportName = #1054#1090#1095#1077#1090' '#1087#1086' '#1090#1086#1074#1072#1088#1091' ('#1087#1088#1086#1076#1072#1078#1072' '#1087#1086' '#1087#1086#1082#1091#1087#1072#1090#1077#1083#1103#1084')'
      ReportNameParam.Value = #1054#1090#1095#1077#1090' '#1087#1086' '#1090#1086#1074#1072#1088#1091' ('#1087#1088#1086#1076#1072#1078#1072' '#1087#1086' '#1087#1086#1082#1091#1087#1072#1090#1077#1083#1103#1084')'
      ReportNameParam.DataType = ftString
      ReportNameParam.ParamType = ptInput
      ReportNameParam.MultiSelectSeparator = ','
    end
    object ExecuteDialog: TExecuteDialog
      Category = 'DSDLib'
      MoveParams = <>
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1086#1090#1095#1077#1090#1072
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1086#1090#1095#1077#1090#1072
      ImageIndex = 35
      FormName = 'TReport_SupplyBalanceDialogForm'
      FormNameParam.Value = 'TReport_SupplyBalanceDialogForm'
      FormNameParam.DataType = ftString
      FormNameParam.MultiSelectSeparator = ','
      GuiParams = <
        item
          Name = 'StartDate'
          Value = 41640d
          Component = deStart
          DataType = ftDateTime
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'EndDate'
          Value = 41640d
          Component = deEnd
          DataType = ftDateTime
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'GoodsGroupId'
          Value = ''
          Component = GoodsGroupGuides
          ComponentItem = 'Key'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'GoodsGroupName'
          Value = ''
          Component = GoodsGroupGuides
          ComponentItem = 'TextValue'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'UnitId'
          Value = ''
          Component = UnitGuides
          ComponentItem = 'Key'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'UnitName'
          Value = ''
          Component = UnitGuides
          ComponentItem = 'TextValue'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'JuridicalId'
          Value = Null
          Component = JuridicalGuides
          ComponentItem = 'Key'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'JuridicalName'
          Value = Null
          Component = JuridicalGuides
          ComponentItem = 'TextValue'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end>
      isShowModal = True
      RefreshDispatcher = RefreshDispatcher
      OpenBeforeShow = True
    end
    object actPrint1: TdsdPrintAction
      Category = 'DSDLib'
      MoveParams = <
        item
          FromParam.Name = 'id'
          FromParam.Value = Null
          FromParam.ComponentItem = 'id'
          FromParam.MultiSelectSeparator = ','
          ToParam.Value = '0'
          ToParam.Component = FormParams
          ToParam.ComponentItem = 'Id'
          ToParam.ParamType = ptInputOutput
          ToParam.MultiSelectSeparator = ','
        end
        item
          FromParam.Value = 42005d
          FromParam.Component = deStart
          FromParam.DataType = ftDateTime
          FromParam.MultiSelectSeparator = ','
          ToParam.Name = 'StartDate'
          ToParam.Value = 'NULL'
          ToParam.DataType = ftDateTime
          ToParam.ParamType = ptInputOutput
          ToParam.MultiSelectSeparator = ','
        end
        item
          FromParam.Value = 42005d
          FromParam.Component = deEnd
          FromParam.DataType = ftDateTime
          FromParam.MultiSelectSeparator = ','
          ToParam.Name = 'EndDate'
          ToParam.Value = 'NULL'
          ToParam.DataType = ftDateTime
          ToParam.ParamType = ptInputOutput
          ToParam.MultiSelectSeparator = ','
        end>
      StoredProcList = <>
      Caption = #1055#1077#1095#1072#1090#1100' ('#1087#1086#1089#1090#1072#1074#1097#1080#1082')'
      Hint = #1055#1077#1095#1072#1090#1100' ('#1087#1086#1089#1090#1072#1074#1097#1080#1082')'
      ImageIndex = 3
      DataSets = <
        item
          UserName = 'frxDBDItems'
          IndexFieldNames = 'GoodsGroupNameFull;PartnerName;GoodsName'
          GridView = cxGridDBTableView
        end>
      Params = <
        item
          Name = 'StartDate'
          Value = 42005d
          Component = deStart
          DataType = ftDateTime
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'EndDate'
          Value = 42005d
          Component = deEnd
          DataType = ftDateTime
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'GoodsGroupName'
          Value = ''
          Component = GoodsGroupGuides
          ComponentItem = 'TextValue'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'UnitName'
          Value = ''
          Component = UnitGuides
          ComponentItem = 'TextValue'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end>
      ReportName = #1054#1090#1095#1077#1090' '#1087#1086' '#1086#1089#1090#1072#1090#1082#1072#1084' '#1076#1083#1103' '#1089#1085#1072#1073#1078#1077#1085#1080#1103'('#1087#1086#1089#1090#1072#1074#1097#1080#1082')'
      ReportNameParam.Value = #1054#1090#1095#1077#1090' '#1087#1086' '#1086#1089#1090#1072#1090#1082#1072#1084' '#1076#1083#1103' '#1089#1085#1072#1073#1078#1077#1085#1080#1103'('#1087#1086#1089#1090#1072#1074#1097#1080#1082')'
      ReportNameParam.DataType = ftString
      ReportNameParam.ParamType = ptInput
      ReportNameParam.MultiSelectSeparator = ','
    end
    object OrderJournal: TdsdOpenForm
      Category = 'DSDLib'
      MoveParams = <>
      Caption = 'OrderJournal'
      FormName = 'TOrderIncomeSnabJournal_byReportForm'
      FormNameParam.Value = 'TOrderIncomeSnabJournal_byReportForm'
      FormNameParam.DataType = ftString
      FormNameParam.MultiSelectSeparator = ','
      GuiParams = <
        item
          Name = 'StartDate'
          Value = 42736d
          Component = deStart
          DataType = ftDateTime
          MultiSelectSeparator = ','
        end
        item
          Name = 'EndDate'
          Value = 42736d
          Component = deEnd
          DataType = ftDateTime
          MultiSelectSeparator = ','
        end
        item
          Name = 'GoodsId'
          Value = Null
          Component = MasterCDS
          ComponentItem = 'GoodsId'
          MultiSelectSeparator = ','
        end
        item
          Name = 'GoodsName'
          Value = Null
          Component = MasterCDS
          ComponentItem = 'GoodsName'
          DataType = ftString
          MultiSelectSeparator = ','
        end
        item
          Name = 'MovementId_List'
          Value = Null
          Component = MasterCDS
          ComponentItem = 'MovementId_List'
          DataType = ftString
          MultiSelectSeparator = ','
        end>
      isShowModal = False
    end
  end
  inherited MasterDS: TDataSource
    Left = 72
    Top = 208
  end
  inherited MasterCDS: TClientDataSet
    Left = 40
    Top = 208
  end
  inherited spSelect: TdsdStoredProc
    StoredProcName = 'gpReport_SupplyBalance'
    Params = <
      item
        Name = 'inStartDate'
        Value = 41640d
        Component = deStart
        DataType = ftDateTime
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inEndDate'
        Value = 41640d
        Component = deEnd
        DataType = ftDateTime
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inUnitId'
        Value = ''
        Component = UnitGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inGoodsGroupId'
        Value = ''
        Component = GoodsGroupGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inJuridicalId'
        Value = Null
        Component = JuridicalGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 112
    Top = 192
  end
  inherited BarManager: TdxBarManager
    Left = 160
    Top = 208
    DockControlHeights = (
      0
      0
      26
      0)
    inherited Bar: TdxBar
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbExecuteDialog'
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
          ItemName = 'dxBarStatic'
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
          ItemName = 'bbPrint_Real'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbGridToExcel'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end>
    end
    object bbPrint_Real: TdxBarButton
      Action = actPrint1
      Category = 0
      ImageIndex = 19
    end
    object bbPrint: TdxBarButton
      Action = actPrint
      Category = 0
    end
    object bbExecuteDialog: TdxBarButton
      Action = ExecuteDialog
      Category = 0
    end
    object bbGoods: TdxBarControlContainerItem
      Caption = #1087#1086' '#1058#1086#1074#1072#1088#1072#1084
      Category = 0
      Hint = #1087#1086' '#1058#1086#1074#1072#1088#1072#1084
      Visible = ivAlways
    end
    object bbPartner: TdxBarControlContainerItem
      Caption = #1087#1086' '#1050#1086#1085#1090#1088#1072#1075#1077#1085#1090#1072#1084
      Category = 0
      Hint = #1087#1086' '#1050#1086#1085#1090#1088#1072#1075#1077#1085#1090#1072#1084
      Visible = ivAlways
    end
    object bb: TdxBarControlContainerItem
      Caption = #1087#1086' '#1058#1086#1088#1075#1086#1074#1099#1084' '#1084#1072#1088#1082#1072#1084
      Category = 0
      Hint = #1087#1086' '#1058#1086#1088#1075#1086#1074#1099#1084' '#1084#1072#1088#1082#1072#1084
      Visible = ivAlways
    end
    object dxBarControlContainerItem1: TdxBarControlContainerItem
      Caption = #1087#1086' '#1042#1080#1076#1072#1084' '#1090#1086#1074#1072#1088#1072
      Category = 0
      Hint = #1087#1086' '#1042#1080#1076#1072#1084' '#1090#1086#1074#1072#1088#1072
      Visible = ivAlways
    end
    object bbPartionGoods: TdxBarControlContainerItem
      Caption = #1087#1086' '#1055#1088#1072#1090#1080#1103#1084
      Category = 0
      Hint = #1087#1086' '#1055#1088#1072#1090#1080#1103#1084
      Visible = ivAlways
    end
  end
  inherited DBViewAddOn: TdsdDBViewAddOn
    ColorRuleList = <
      item
        ColorColumn = RemainsDays
        ValueColumn = Color_RemainsDays
        ColorValueList = <>
      end
      item
        ColorColumn = clGoodsName
        ValueColumn = Color_RemainsDays
        ColorValueList = <>
      end
      item
        ColorColumn = RemainsStart
        ValueColumn = Color_RemainsDays
        ColorValueList = <>
      end
      item
        ColorColumn = RemainsEnd
        ValueColumn = Color_RemainsDays
        ColorValueList = <>
      end
      item
        ValueColumn = Color_RemainsDays
        ColorValueList = <>
      end>
    ColumnAddOnList = <
      item
        Column = clGoodsName
        Action = OrderJournal
        onExitColumn.Active = False
        onExitColumn.AfterEmptyValue = False
      end
      item
        Column = CountOrder
        Action = OrderJournal
        onExitColumn.Active = False
        onExitColumn.AfterEmptyValue = False
      end>
    Left = 320
    Top = 232
  end
  inherited PeriodChoice: TPeriodChoice
    Left = 112
    Top = 128
  end
  inherited RefreshDispatcher: TRefreshDispatcher
    ShowDialogAction = ExecuteDialog
    ComponentList = <
      item
        Component = PeriodChoice
      end
      item
        Component = JuridicalGuides
      end
      item
        Component = UnitGuides
      end
      item
        Component = GoodsGroupGuides
      end
      item
      end
      item
      end
      item
      end>
    Left = 208
    Top = 168
  end
  object GoodsGroupGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = edGoodsGroup
    Key = '0'
    FormNameParam.Value = 'TGoodsGroup_ObjectForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TGoodsGroup_ObjectForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = GoodsGroupGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = GoodsGroupGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 848
  end
  object FormParams: TdsdFormParams
    Params = <
      item
        Name = 'inUnitId'
        Value = Null
        Component = UnitGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inUnitName'
        Value = Null
        Component = UnitGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inGoodsGroupId'
        Value = Null
        Component = GoodsGroupGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inGoodsGroupName'
        Value = #1057#1044'-'#1057#1067#1056#1068#1045
        Component = GoodsGroupGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 328
    Top = 170
  end
  object UnitGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = edUnit
    Key = '0'
    FormNameParam.Value = 'TUnit_ObjectForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TUnit_ObjectForm'
    PositionDataSet = 'MasterCDS'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = UnitGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = UnitGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 568
    Top = 1
  end
  object JuridicalGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = edJuridical
    FormNameParam.Value = 'TJuridical_ObjectForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TJuridical_ObjectForm'
    PositionDataSet = 'MasterCDS'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = JuridicalGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = JuridicalGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 1152
  end
end
