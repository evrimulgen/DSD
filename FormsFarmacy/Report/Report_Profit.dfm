inherited Report_ProfitForm: TReport_ProfitForm
  Caption = #1054#1090#1095#1077#1090' '#1044#1086#1093#1086#1076#1085#1086#1089#1090#1080
  ClientHeight = 668
  ClientWidth = 1592
  AddOnFormData.RefreshAction = actRefreshStart
  AddOnFormData.ExecuteDialogAction = ExecuteDialog
  ExplicitWidth = 1608
  ExplicitHeight = 706
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TcxPageControl
    Top = 91
    Width = 1592
    Height = 577
    TabOrder = 3
    ExplicitTop = 91
    ExplicitWidth = 1045
    ExplicitHeight = 577
    ClientRectBottom = 577
    ClientRectRight = 1592
    ClientRectTop = 24
    inherited tsMain: TcxTabSheet
      Caption = #1055#1088#1086#1089#1090#1086#1077' '#1087#1088#1077#1076#1089#1090#1072#1074#1083#1077#1085#1080#1077
      TabVisible = True
      ExplicitTop = 24
      ExplicitWidth = 1045
      ExplicitHeight = 553
      inherited cxGrid: TcxGrid
        Width = 1592
        Height = 369
        ExplicitLeft = 3
        ExplicitTop = 2
        ExplicitWidth = 1592
        ExplicitHeight = 369
        inherited cxGridDBTableView: TcxGridDBTableView
          DataController.Summary.DefaultGroupSummaryItems = <
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              Position = spFooter
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              Position = spFooter
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              Position = spFooter
              Column = SummaProfit
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
              Column = clSumma
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
              Column = SummaProfit
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
              Column = clSummaSale
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
              Column = clSummaSaleFree
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
              Column = clSummaFree
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
              Column = SummaProfitFree
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
              Column = clSummaSale1
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
              Column = clSumma1
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
              Column = SummaProfit1
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
              Column = SummaProfitTax1
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
              Column = clSummaSale2
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
              Column = clSumma2
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
              Column = SummaProfit2
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
              Column = SummaProfitTax2
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
              Column = SummaProfitAll
            end>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
              Column = SummaProfit
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
              Column = clSumma
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
              Column = clSummaSale
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
              Column = clSummaSaleFree
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
              Column = clSummaFree
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
              Column = SummaProfitFree
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
              Column = clSummaSale1
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
              Column = clSumma1
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
              Column = SummaProfit1
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
              Column = SummaProfitTax1
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
              Column = clSummaSale2
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
              Column = clSumma2
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
              Column = SummaProfit2
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
              Column = SummaProfitTax2
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
              Column = SummaProfitAll
            end>
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = True
          Styles.Content = nil
          Styles.Inactive = nil
          Styles.Selection = nil
          Styles.Footer = nil
          Styles.Header = nil
          object JuridicalMainName: TcxGridDBColumn
            Caption = #1070#1088'.'#1083#1080#1094#1086
            DataBinding.FieldName = 'JuridicalMainName'
            PropertiesClassName = 'TcxDateEditProperties'
            Properties.DisplayFormat = 'DD.MM.YYYY (DDD)'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 41
          end
          object colUnitName: TcxGridDBColumn
            Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
            DataBinding.FieldName = 'UnitName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 103
          end
          object clSummaSale: TcxGridDBColumn
            Caption = #1054#1041#1066#1045#1052' '#1055#1056#1054#1044#1040#1046'  '#1074' '#1094#1077#1085#1072#1093' '#1088#1077#1072#1083#1080#1079','#1075#1088#1085
            DataBinding.FieldName = 'SummaSale'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 50
          end
          object clSumma: TcxGridDBColumn
            Caption = #1057#1077#1073#1077#1089#1090#1086#1080#1084#1086#1089#1090#1100' '#1055#1056#1054#1044#1040#1046'  '#1074' '#1079#1072#1082#1091#1087#1086#1095#1085' '#1094#1077#1085#1072#1093','#1075#1088#1085
            DataBinding.FieldName = 'Summa'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 50
          end
          object SummaProfit: TcxGridDBColumn
            Caption = #1044#1054#1061#1054#1044', '#1075#1088#1085
            DataBinding.FieldName = 'SummaProfit'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 50
          end
          object PersentProfit: TcxGridDBColumn
            Caption = '% '#1044#1054#1061#1054#1044#1040' '#1054#1058' '#1042#1040#1051#1040
            DataBinding.FieldName = 'PersentProfit'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 50
          end
          object CorrectPersentProfit: TcxGridDBColumn
            Caption = #1050#1086#1088#1088#1077#1082#1090' % '#1044#1054#1061#1054#1044#1040' '#1054#1058' '#1042#1040#1051#1040
            DataBinding.FieldName = 'CorrectPersentProfit'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 50
          end
          object clSummaSaleFree: TcxGridDBColumn
            Caption = #1054#1041#1066#1045#1052' '#1055#1056#1054#1044#1040#1046' '#1087#1088'.'#1087#1086#1089#1090#1072#1074#1097#1080#1082#1080' '#1074' '#1094#1077#1085#1072#1093' '#1088#1077#1072#1083#1080#1079','#1075#1088#1085
            DataBinding.FieldName = 'SummaSaleFree'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            VisibleForCustomization = False
            Width = 50
          end
          object clSummaFree: TcxGridDBColumn
            Caption = #1057#1077#1073#1077#1089#1090#1086#1080#1084#1086#1089#1090#1100' '#1055#1056#1054#1044#1040#1046' '#1087#1088'.'#1087#1086#1089#1090#1072#1074#1097#1080#1082#1080' '#1074' '#1079#1072#1082#1091#1087#1086#1095#1085' '#1094#1077#1085#1072#1093','#1075#1088#1085
            DataBinding.FieldName = 'SummaFree'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            VisibleForCustomization = False
            Width = 50
          end
          object SummaProfitFree: TcxGridDBColumn
            Caption = #1044#1054#1061#1054#1044' '#1087#1088'.'#1087#1086#1089#1090#1072#1074#1097#1080#1082#1080', '#1075#1088#1085
            DataBinding.FieldName = 'SummaProfitFree'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            VisibleForCustomization = False
            Width = 50
          end
          object clSummaSale1: TcxGridDBColumn
            Caption = #1054#1041#1066#1045#1052' '#1055#1056#1054#1044#1040#1046' '#1087#1086#1089#1090#1072#1074#1097#1080#1082'1 '#1074' '#1094#1077#1085#1072#1093' '#1088#1077#1072#1083#1080#1079', '#1075#1088#1085
            DataBinding.FieldName = 'SummaSale1'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            VisibleForCustomization = False
            Width = 50
          end
          object clSumma1: TcxGridDBColumn
            Caption = #1057#1077#1073#1077#1089#1090#1086#1080#1084#1086#1089#1090#1100' '#1055#1056#1054#1044#1040#1046' '#1087#1086#1089#1090#1072#1074#1097#1080#1082'1  '#1074' '#1079#1072#1082#1091#1087#1086#1095#1085' '#1094#1077#1085#1072#1093','#1075#1088#1085
            DataBinding.FieldName = 'Summa1'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            VisibleForCustomization = False
            Width = 50
          end
          object SummaProfit1: TcxGridDBColumn
            Caption = #1044#1054#1061#1054#1044' '#1087#1086#1089#1090#1072#1074#1097#1080#1082'1, '#1075#1088#1085
            DataBinding.FieldName = 'SummaProfit1'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            VisibleForCustomization = False
            Width = 50
          end
          object SummaProfitTax1: TcxGridDBColumn
            Caption = #1050#1086#1088#1088#1077#1082#1090' '#1044#1054#1061#1054#1044' '#1087#1086#1089#1090#1072#1074#1097#1080#1082'1, '#1075#1088#1085
            DataBinding.FieldName = 'SummaProfitTax1'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            VisibleForCustomization = False
            Width = 50
          end
          object clSummaSale2: TcxGridDBColumn
            Caption = #1054#1041#1066#1045#1052' '#1055#1056#1054#1044#1040#1046'  '#1087#1086#1089#1090#1072#1074#1097#1080#1082'2 '#1074' '#1094#1077#1085#1072#1093' '#1088#1077#1072#1083#1080#1079','#1075#1088#1085
            DataBinding.FieldName = 'SummaSale2'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            VisibleForCustomization = False
            Width = 50
          end
          object clSumma2: TcxGridDBColumn
            Caption = #1057#1077#1073#1077#1089#1090#1086#1080#1084#1086#1089#1090#1100' '#1055#1056#1054#1044#1040#1046' '#1087#1086#1089#1090#1072#1074#1097#1080#1082'2  '#1074' '#1079#1072#1082#1091#1087#1086#1095#1085' '#1094#1077#1085#1072#1093','#1075#1088#1085
            DataBinding.FieldName = 'Summa2'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            VisibleForCustomization = False
            Width = 50
          end
          object SummaProfit2: TcxGridDBColumn
            Caption = #1044#1054#1061#1054#1044' '#1087#1086#1089#1090#1072#1074#1097#1080#1082'3, '#1075#1088#1085
            DataBinding.FieldName = 'SummaProfit2'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            VisibleForCustomization = False
            Width = 50
          end
          object SummaProfitTax2: TcxGridDBColumn
            Caption = #1050#1086#1088#1088#1077#1082#1090' '#1044#1054#1061#1054#1044' '#1087#1086#1089#1090#1072#1074#1097#1080#1082'2, '#1075#1088#1085
            DataBinding.FieldName = 'SummaProfitTax2'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            VisibleForCustomization = False
            Width = 50
          end
          object SummaProfitAll: TcxGridDBColumn
            Caption = #1050#1086#1088#1088#1077#1082#1090' '#1044#1054#1061#1054#1044', '#1075#1088#1085
            DataBinding.FieldName = 'SummaProfitAll'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 50
          end
        end
      end
      object cxSplitter1: TcxSplitter
        Left = 0
        Top = 369
        Width = 1592
        Height = 8
        HotZoneClassName = 'TcxMediaPlayer8Style'
        AlignSplitter = salBottom
        Control = grChart
        ExplicitWidth = 1045
      end
      object grChart: TcxGrid
        Left = 0
        Top = 377
        Width = 1592
        Height = 176
        Align = alBottom
        TabOrder = 2
        ExplicitWidth = 1045
        object grChartDBChartView1: TcxGridDBChartView
          DataController.DataSource = MasterDS
          DiagramColumn.Active = True
          ToolBox.CustomizeButton = True
          ToolBox.DiagramSelector = True
          object dgJuridicalMainName: TcxGridDBChartDataGroup
            DataBinding.FieldName = 'JuridicalMainName'
            DisplayText = #1070#1088'.'#1083#1080#1094#1086
          end
          object dgUnit: TcxGridDBChartDataGroup
            DataBinding.FieldName = 'unitname'
            DisplayText = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
          end
          object serSummaSale: TcxGridDBChartSeries
            DataBinding.FieldName = 'SummaSale'
            DisplayText = #1054#1073#1098#1077#1084' '#1087#1088#1086#1076#1072#1078
          end
          object serSumma: TcxGridDBChartSeries
            DataBinding.FieldName = 'Summa'
            DisplayText = #1057#1077#1073#1077#1089#1090#1086#1080#1084#1086#1089#1090#1100' '#1087#1088#1086#1076#1072#1078
          end
          object serSummaProfit: TcxGridDBChartSeries
            DataBinding.FieldName = 'SummaProfit'
            DisplayText = #1044#1086#1093#1086#1076
          end
          object serPersentProfit: TcxGridDBChartSeries
            DataBinding.FieldName = 'PersentProfit'
            DisplayText = '% '#1076#1086#1093#1086#1076#1072
          end
          object serCorrectPersentProfit: TcxGridDBChartSeries
            DataBinding.FieldName = 'CorrectPersentProfit'
            DisplayText = #1050#1086#1088#1088#1077#1082#1090'. % '#1076#1086#1093#1086#1076#1072
          end
        end
        object grChartLevel1: TcxGridLevel
          GridView = grChartDBChartView1
        end
      end
    end
    object tsPivot: TcxTabSheet
      Caption = #1057#1074#1086#1076#1085#1072#1103' '#1090#1072#1073#1083#1080#1094#1072
      ImageIndex = 1
      ExplicitWidth = 1045
      object cxDBPivotGrid1: TcxDBPivotGrid
        Left = 0
        Top = 0
        Width = 1592
        Height = 553
        Align = alClient
        DataSource = MasterDS
        Groups = <>
        OptionsView.RowGrandTotalWidth = 118
        TabOrder = 0
        ExplicitWidth = 1045
        object pcolPlanDate: TcxDBPivotGridField
          AreaIndex = 2
          AllowedAreas = [faColumn, faRow, faFilter]
          IsCaptionAssigned = True
          Caption = #1044#1072#1090#1072
          DataBinding.FieldName = 'PlanDate'
          Visible = True
          UniqueName = #1044#1072#1090#1072
        end
        object pcolWeek: TcxDBPivotGridField
          AreaIndex = 0
          AllowedAreas = [faColumn, faRow, faFilter]
          IsCaptionAssigned = True
          Caption = #1053#1077#1076#1077#1083#1103
          DataBinding.FieldName = 'PlanDate'
          GroupInterval = giDateWeekOfYear
          Visible = True
          UniqueName = #1053#1077#1076#1077#1083#1103
        end
        object pcolUnitName: TcxDBPivotGridField
          Area = faRow
          AreaIndex = 0
          AllowedAreas = [faColumn, faRow, faFilter]
          IsCaptionAssigned = True
          Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
          DataBinding.FieldName = 'UnitName'
          Visible = True
          UniqueName = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
        end
        object pcolPlanAmount: TcxDBPivotGridField
          Area = faData
          AreaIndex = 0
          AllowedAreas = [faFilter, faData]
          IsCaptionAssigned = True
          Caption = #1055#1083#1072#1085
          DataBinding.FieldName = 'PlanAmount'
          Visible = True
          UniqueName = #1055#1083#1072#1085
        end
        object pcolFactAmount: TcxDBPivotGridField
          Area = faData
          AreaIndex = 1
          AllowedAreas = [faFilter, faData]
          IsCaptionAssigned = True
          Caption = #1060#1072#1082#1090
          DataBinding.FieldName = 'FactAmount'
          Visible = True
          UniqueName = #1060#1072#1082#1090
        end
        object pcolDiffAmount: TcxDBPivotGridField
          Area = faData
          AreaIndex = 2
          AllowedAreas = [faFilter, faData]
          IsCaptionAssigned = True
          Caption = #1054#1090#1082#1083#1086#1085#1077#1085#1080#1077
          DataBinding.FieldName = 'DiffAmount'
          Visible = True
          UniqueName = #1054#1090#1082#1083#1086#1085#1077#1085#1080#1077
        end
        object pcolDayOfWeek: TcxDBPivotGridField
          AreaIndex = 1
          IsCaptionAssigned = True
          Caption = #1044#1077#1085#1100' '#1085#1077#1076#1077#1083#1080
          DataBinding.FieldName = 'PlanDate'
          GroupInterval = giDateDayOfWeek
          Visible = True
          UniqueName = #1044#1077#1085#1100' '#1085#1077#1076#1077#1083#1080
        end
      end
    end
  end
  inherited Panel: TPanel
    Width = 1592
    Height = 65
    ExplicitWidth = 1045
    ExplicitHeight = 65
    inherited deStart: TcxDateEdit
      Left = 127
      Top = 6
      EditValue = 42370d
      ExplicitLeft = 127
      ExplicitTop = 6
    end
    inherited deEnd: TcxDateEdit
      Left = 127
      Top = 36
      EditValue = 42371d
      ExplicitLeft = 127
      ExplicitTop = 36
    end
    inherited cxLabel1: TcxLabel
      Left = 64
      Top = 7
      Caption = #1053#1072#1095'.'#1076#1072#1090#1072':'
      ExplicitLeft = 64
      ExplicitTop = 7
      ExplicitWidth = 56
    end
    inherited cxLabel2: TcxLabel
      Left = 13
      Top = 18
      Caption = '-'
      Visible = False
      ExplicitLeft = 13
      ExplicitTop = 18
      ExplicitWidth = 8
    end
    object cxLabel3: TcxLabel
      Left = 231
      Top = 7
      Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082' 1:'
    end
    object ceJuridical1: TcxButtonEdit
      Left = 306
      Top = 6
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.Nullstring = '<'#1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077'>'
      Properties.ReadOnly = True
      Properties.UseNullString = True
      TabOrder = 5
      Text = '<'#1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1072'>'
      TextHint = '<'#1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1072'>'
      Width = 214
    end
    object cxLabel4: TcxLabel
      Left = 64
      Top = 40
      Caption = #1050#1086#1085'.'#1076#1072#1090#1072':'
    end
    object cxLabel5: TcxLabel
      Left = 231
      Top = 40
      Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082' 2:'
    end
    object ceJuridical2: TcxButtonEdit
      Left = 306
      Top = 39
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.Nullstring = '<'#1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077'>'
      Properties.ReadOnly = True
      Properties.UseNullString = True
      TabOrder = 8
      Text = '<'#1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1072'>'
      TextHint = '<'#1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1072'>'
      Width = 214
    end
    object cxLabel6: TcxLabel
      Left = 532
      Top = 40
      Caption = '% :'
    end
    object cxLabel7: TcxLabel
      Left = 532
      Top = 7
      Caption = '% :'
    end
    object ceTax1: TcxCurrencyEdit
      Left = 554
      Top = 6
      Properties.DecimalPlaces = 4
      Properties.DisplayFormat = ',0.####'
      TabOrder = 11
      Width = 68
    end
    object ceTax2: TcxCurrencyEdit
      Left = 554
      Top = 39
      Properties.DecimalPlaces = 4
      Properties.DisplayFormat = ',0.####'
      TabOrder = 12
      Width = 68
    end
  end
  inherited UserSettingsStorageAddOn: TdsdUserSettingsStorageAddOn
    Left = 83
    Top = 272
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
        Component = Juridical1Guides
        Properties.Strings = (
          'Key'
          'TextValue')
      end
      item
        Component = Juridical2Guides
        Properties.Strings = (
          'Key'
          'TextValue')
      end
      item
        Component = ceTax1
      end
      item
        Component = ceTax2
      end>
  end
  inherited ActionList: TActionList
    Left = 159
    Top = 255
    object actGet_UserUnit: TdsdExecStoredProc
      Category = 'DSDLib'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      StoredProcList = <
        item
        end>
      Caption = 'actGet_UserUnit'
    end
    object actRefreshStart: TdsdDataSetRefresh
      Category = 'DSDLib'
      MoveParams = <>
      StoredProcList = <
        item
        end
        item
          StoredProc = spSelect
        end>
      Caption = #1055#1077#1088#1077#1095#1080#1090#1072#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      ShortCut = 116
      RefreshOnTabSetChanges = False
    end
    object actQuasiSchedule: TBooleanStoredProcAction
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spSelect
      StoredProcList = <
        item
          StoredProc = spSelect
        end>
      Caption = #1069#1084#1087#1080#1088#1080#1095#1077#1089#1082#1080#1081
      Hint = 
        #1055#1083#1072#1085' '#1088#1072#1087#1088#1077#1076#1077#1083#1103#1077#1090#1089#1103' '#1087#1086' '#1076#1085#1103#1084' '#1085#1077#1076#1077#1083#1080' '#1089#1086#1075#1083#1072#1089#1085#1086' '#1076#1086#1083#1080' '#1087#1088#1086#1076#1072#1078' '#1076#1085#1103' '#1079#1072' '#1087#1086 +
        #1089#1083#1077#1076#1085#1080#1077' 8 '#1085#1077#1076#1077#1083#1100
      ImageIndex = 40
      Value = False
      HintTrue = #1055#1083#1072#1085' '#1076#1077#1083#1080#1090#1089#1103' '#1088#1072#1074#1085#1086#1084#1077#1088#1085#1086' '#1085#1072' '#1082#1086#1083'-'#1074#1086' '#1076#1085#1077#1081' '#1074' '#1084#1077#1089#1103#1094#1077
      HintFalse = 
        #1055#1083#1072#1085' '#1088#1072#1087#1088#1077#1076#1077#1083#1103#1077#1090#1089#1103' '#1087#1086' '#1076#1085#1103#1084' '#1085#1077#1076#1077#1083#1080' '#1089#1086#1075#1083#1072#1089#1085#1086' '#1076#1086#1083#1080' '#1087#1088#1086#1076#1072#1078' '#1076#1085#1103' '#1079#1072' '#1087#1086 +
        #1089#1083#1077#1076#1085#1080#1077' 8 '#1085#1077#1076#1077#1083#1100
      CaptionTrue = #1056#1072#1074#1085#1086#1084#1077#1088#1085#1099#1081
      CaptionFalse = #1069#1084#1087#1080#1088#1080#1095#1077#1089#1082#1080#1081
      ImageIndexTrue = 35
      ImageIndexFalse = 40
    end
    object ExecuteDialog: TExecuteDialog
      Category = 'DSDLib'
      MoveParams = <>
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1086#1090#1095#1077#1090#1072
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1086#1090#1095#1077#1090#1072
      ImageIndex = 35
      FormName = 'TReport_ProfitDialogForm'
      FormNameParam.Value = 'TReport_ProfitDialogForm'
      FormNameParam.DataType = ftString
      GuiParams = <
        item
          Name = 'StartDate'
          Value = 42370d
          Component = deStart
          DataType = ftDateTime
          ParamType = ptInput
        end
        item
          Name = 'EndDate'
          Value = 42371d
          Component = deEnd
          DataType = ftDateTime
          ParamType = ptInput
        end
        item
          Name = 'Juridical1Id'
          Value = ''
          Component = Juridical1Guides
          ComponentItem = 'Key'
          ParamType = ptInput
        end
        item
          Name = 'Juridical1Name'
          Value = ''
          Component = Juridical1Guides
          ComponentItem = 'TextValue'
          DataType = ftString
          ParamType = ptInput
        end
        item
          Name = 'Juridical2Id'
          Value = Null
          Component = Juridical2Guides
          ComponentItem = 'TextValue'
          ParamType = ptInput
        end
        item
          Name = 'Juridical2Name'
          Value = Null
          Component = Juridical2Guides
          ComponentItem = 'TextValue'
          DataType = ftString
          ParamType = ptInput
        end
        item
          Name = 'Tax1'
          Value = Null
          Component = ceTax1
          DataType = ftFloat
          ParamType = ptInput
        end
        item
          Name = 'Tax2'
          Value = Null
          Component = ceTax2
          DataType = ftFloat
          ParamType = ptInput
        end>
      isShowModal = True
      RefreshDispatcher = RefreshDispatcher
      OpenBeforeShow = True
    end
  end
  inherited MasterDS: TDataSource
    Top = 128
  end
  inherited MasterCDS: TClientDataSet
    Top = 128
  end
  inherited spSelect: TdsdStoredProc
    StoredProcName = 'gpReport_Profit'
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
        Value = 42248d
        Component = deEnd
        DataType = ftDateTime
        ParamType = ptInput
      end
      item
        Name = 'inJuridical1Id'
        Value = 41395d
        Component = Juridical1Guides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'inJuridical2Id'
        Value = Null
        Component = Juridical2Guides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'inTax1'
        Value = Null
        Component = ceTax1
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'inTax2'
        Value = Null
        Component = ceTax2
        DataType = ftFloat
        ParamType = ptInput
      end>
    Top = 128
  end
  inherited BarManager: TdxBarManager
    Top = 128
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
          ItemName = 'bbGridToExcel'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end>
    end
    object dxBarControlContainerItem1: TdxBarControlContainerItem
      Caption = #1053#1072#1095'.'#1076#1072#1090#1072
      Category = 0
      Hint = #1053#1072#1095'.'#1076#1072#1090#1072
      Visible = ivAlways
      Control = cxLabel1
    end
    object bbStart: TdxBarControlContainerItem
      Caption = #1053#1072#1095'.'#1076#1072#1090#1072
      Category = 0
      Hint = #1053#1072#1095'.'#1076#1072#1090#1072
      Visible = ivAlways
      Control = deStart
    end
    object dxBarControlContainerItem3: TdxBarControlContainerItem
      Caption = #1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
      Category = 0
      Hint = #1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
      Visible = ivAlways
      Control = cxLabel3
    end
    object dxBarControlContainerItem4: TdxBarControlContainerItem
      Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
      Category = 0
      Hint = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
      Visible = ivAlways
      Control = ceJuridical1
    end
    object bbQuasiSchedule: TdxBarButton
      Action = actQuasiSchedule
      Category = 0
    end
    object bb122: TdxBarControlContainerItem
      Caption = #1050#1086#1085' '#1076#1072#1090#1072
      Category = 0
      Hint = #1050#1086#1085' '#1076#1072#1090#1072
      Visible = ivAlways
      Control = cxLabel4
    end
    object bbEnd: TdxBarControlContainerItem
      Caption = #1050#1086#1085'.'#1076#1072#1090#1072
      Category = 0
      Hint = #1050#1086#1085'.'#1076#1072#1090#1072
      Visible = ivAlways
      Control = deEnd
    end
    object bbExecuteDialog: TdxBarButton
      Action = ExecuteDialog
      Category = 0
    end
  end
  inherited DBViewAddOn: TdsdDBViewAddOn
    Left = 352
    Top = 288
  end
  inherited PopupMenu: TPopupMenu
    Left = 248
    Top = 256
  end
  inherited PeriodChoice: TPeriodChoice
    DateStart = nil
    DateEnd = nil
    Left = 24
    Top = 176
  end
  inherited RefreshDispatcher: TRefreshDispatcher
    ComponentList = <
      item
      end>
    Left = 88
    Top = 176
  end
  object Juridical1Guides: TdsdGuides
    KeyField = 'Id'
    LookupControl = ceJuridical1
    FormNameParam.Value = 'TJuridicalForm'
    FormNameParam.DataType = ftString
    FormName = 'TJuridicalForm'
    PositionDataSet = 'MasterCDS'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = Juridical1Guides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = Juridical1Guides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 432
  end
  object Juridical2Guides: TdsdGuides
    KeyField = 'Id'
    LookupControl = ceJuridical2
    FormNameParam.Value = 'TJuridicalForm'
    FormNameParam.DataType = ftString
    FormName = 'TJuridicalForm'
    PositionDataSet = 'MasterCDS'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = Juridical2Guides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = Juridical2Guides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 416
    Top = 32
  end
end