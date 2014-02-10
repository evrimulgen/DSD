inherited Report_JuridicalDefermentPayment: TReport_JuridicalDefermentPayment
  Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1086#1090#1089#1088#1086#1095#1082#1077
  ClientHeight = 394
  ClientWidth = 869
  ExplicitWidth = 877
  ExplicitHeight = 421
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TcxPageControl
    Width = 869
    Height = 337
    TabOrder = 3
    ExplicitWidth = 869
    ExplicitHeight = 337
    ClientRectBottom = 337
    ClientRectRight = 869
    inherited tsMain: TcxTabSheet
      ExplicitWidth = 869
      ExplicitHeight = 337
      inherited cxGrid: TcxGrid
        Width = 869
        Height = 337
        ExplicitWidth = 869
        ExplicitHeight = 337
        inherited cxGridDBTableView: TcxGridDBTableView
          DataController.Summary.DefaultGroupSummaryItems = <
            item
              Format = ',0.00'
              Kind = skSum
              Column = colSaleSumm
            end
            item
              Format = ',0.00'
              Kind = skSum
              Column = colKreditRemains
            end
            item
              Format = ',0.00'
              Kind = skSum
              Column = colDebetRemains
            end
            item
              Format = ',0.00'
              Kind = skSum
              Column = colDefermentPaymentRemains
            end
            item
              Format = ',0.00'
              Kind = skSum
              Column = colSaleSumm1
            end
            item
              Format = ',0.00'
              Kind = skSum
              Column = colSaleSumm2
            end
            item
              Format = ',0.00'
              Kind = skSum
              Column = colSaleSumm3
            end
            item
              Format = ',0.00'
              Kind = skSum
              Column = colSaleSumm4
            end
            item
              Format = ',0.00'
              Kind = skSum
              Column = colSaleSumm5
            end>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00'
              Kind = skSum
              Column = colSaleSumm
            end
            item
              Format = ',0.00'
              Kind = skSum
              Column = colKreditRemains
            end
            item
              Format = ',0.00'
              Kind = skSum
              Column = colDebetRemains
            end
            item
              Format = ',0.00'
              Kind = skSum
              Column = colDefermentPaymentRemains
            end
            item
              Format = ',0.00'
              Kind = skSum
              Column = colSaleSumm1
            end
            item
              Format = ',0.00'
              Kind = skSum
              Column = colSaleSumm2
            end
            item
              Format = ',0.00'
              Kind = skSum
              Column = colSaleSumm3
            end
            item
              Format = ',0.00'
              Kind = skSum
              Column = colSaleSumm4
            end
            item
              Format = ',0.00'
              Kind = skSum
              Column = colSaleSumm5
            end>
          OptionsView.GroupByBox = True
          Styles.Inactive = nil
          Styles.Selection = nil
          Styles.Footer = nil
          Styles.Header = nil
          object colAccountName: TcxGridDBColumn
            Caption = #1057#1095#1077#1090
            DataBinding.FieldName = 'AccountName'
            HeaderAlignmentVert = vaCenter
            Width = 53
          end
          object colJuridicalName: TcxGridDBColumn
            Caption = #1070#1088'. '#1083#1080#1094#1086
            DataBinding.FieldName = 'JuridicalName'
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 95
          end
          object colContractNumber: TcxGridDBColumn
            Caption = #1044#1086#1075#1086#1074#1086#1088
            DataBinding.FieldName = 'ContractNumber'
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 110
          end
          object colSaleSumm: TcxGridDBColumn
            Caption = #1055#1088#1086#1076#1072#1085#1086
            DataBinding.FieldName = 'SaleSumm'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 2
            Properties.DisplayFormat = ',0.00'
            HeaderAlignmentHorz = taRightJustify
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 64
          end
          object colKreditRemains: TcxGridDBColumn
            Caption = #1054#1089#1090#1072#1090#1086#1082' '#1082#1088#1077#1076#1080#1090
            DataBinding.FieldName = 'KreditRemains'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 2
            Properties.DisplayFormat = ',0.00'
            HeaderAlignmentHorz = taRightJustify
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 65
          end
          object colDebetRemains: TcxGridDBColumn
            Caption = #1054#1089#1090#1072#1090#1086#1082' '#1076#1077#1073#1077#1090
            DataBinding.FieldName = 'DebetRemains'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 2
            Properties.DisplayFormat = ',0.00'
            HeaderAlignmentHorz = taRightJustify
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 65
          end
          object colDefermentPaymentRemains: TcxGridDBColumn
            Caption = #1054#1089#1090#1072#1090#1086#1082' '#1089' '#1091#1095#1077#1090#1086#1084' '#1086#1090#1089#1088#1086#1095#1082#1080
            DataBinding.FieldName = 'DefermentPaymentRemains'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00'
            HeaderAlignmentHorz = taRightJustify
            HeaderAlignmentVert = vaCenter
            Width = 108
          end
          object colSaleSumm1: TcxGridDBColumn
            Caption = '7 '#1076#1085'.'
            DataBinding.FieldName = 'SaleSumm1'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00'
            HeaderAlignmentHorz = taRightJustify
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 40
          end
          object colSaleSumm2: TcxGridDBColumn
            Caption = '14 '#1076#1085'.'
            DataBinding.FieldName = 'SaleSumm2'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00'
            HeaderAlignmentHorz = taRightJustify
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 50
          end
          object colSaleSumm3: TcxGridDBColumn
            Caption = '21 '#1076#1085'.'
            DataBinding.FieldName = 'SaleSumm3'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00'
            HeaderAlignmentHorz = taRightJustify
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 47
          end
          object colSaleSumm4: TcxGridDBColumn
            Caption = '28 '#1076#1085'.'
            DataBinding.FieldName = 'SaleSumm4'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00'
            HeaderAlignmentHorz = taRightJustify
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 45
          end
          object colSaleSumm5: TcxGridDBColumn
            Caption = '>28 '#1076#1085'.'
            DataBinding.FieldName = 'SaleSumm5'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00'
            HeaderAlignmentHorz = taRightJustify
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 53
          end
          object colCondition: TcxGridDBColumn
            Caption = #1059#1089#1083#1086#1074#1080#1077
            DataBinding.FieldName = 'Condition'
            HeaderAlignmentVert = vaCenter
            Width = 60
          end
        end
      end
    end
  end
  inherited Panel: TPanel
    Width = 869
    ExplicitWidth = 869
    inherited deStart: TcxDateEdit
      EditValue = 41640d
    end
    inherited deEnd: TcxDateEdit
      Visible = False
    end
    inherited cxLabel2: TcxLabel
      Visible = False
    end
    object edAccount: TcxButtonEdit
      Left = 234
      Top = 5
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 4
      Width = 400
    end
    object cxLabel3: TcxLabel
      Left = 201
      Top = 6
      Caption = #1057#1095#1077#1090':'
    end
  end
  inherited cxPropertiesStore: TcxPropertiesStore
    Components = <
      item
        Component = AccountGuides
        Properties.Strings = (
          'Key'
          'TextValue')
      end
      item
        Component = deEnd
        Properties.Strings = (
          'Date')
      end
      item
        Component = deStart
        Properties.Strings = (
          'Date')
      end>
  end
  inherited MasterDS: TDataSource
    Top = 112
  end
  inherited MasterCDS: TClientDataSet
    Top = 112
  end
  inherited spSelect: TdsdStoredProc
    StoredProcName = 'gpReport_JuridicalDefermentPayment'
    Params = <
      item
        Name = 'inOperDate'
        Value = 41640d
        Component = deStart
        DataType = ftDateTime
        ParamType = ptInput
      end
      item
        Name = 'inEmptyParam'
        Value = 41395d
        Component = deEnd
        DataType = ftDateTime
        ParamType = ptInput
      end
      item
        Name = 'inAccountId'
        Value = ''
        Component = AccountGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end>
    Top = 112
  end
  inherited BarManager: TdxBarManager
    Top = 112
    DockControlHeights = (
      0
      0
      26
      0)
  end
  inherited PeriodChoice: TPeriodChoice
    DateStart = nil
    DateEnd = nil
    Top = 128
  end
  inherited RefreshDispatcher: TRefreshDispatcher
    ComponentList = <
      item
        Component = deStart
      end>
    Top = 136
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
    Left = 456
    Top = 8
  end
end
