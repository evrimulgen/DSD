﻿inherited MainForm: TMainForm
  ClientHeight = 174
  ClientWidth = 1118
  KeyPreview = True
  Position = poDesigned
  ExplicitLeft = -320
  ExplicitWidth = 1126
  ExplicitHeight = 201
  PixelsPerInch = 96
  TextHeight = 13
  inherited dxBarManager: TdxBarManager
    DockControlHeights = (
      0
      0
      28
      0)
    inherited dxBar: TdxBar
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbGoodsDocuments'
        end
        item
          Visible = True
          ItemName = 'bbFinanceDocuments'
        end
        item
          Visible = True
          ItemName = 'bbTaxDocuments'
        end
        item
          Visible = True
          ItemName = 'bbAssetDocuments'
        end
        item
          Visible = True
          ItemName = 'bbHistory'
        end
        item
          Visible = True
          ItemName = 'bbTransportDocuments'
        end
        item
          Visible = True
          ItemName = 'bbPersonalDocuments'
        end
        item
          Visible = True
          ItemName = 'bbReportsProduction'
        end
        item
          Visible = True
          ItemName = 'bbReportsGoods'
        end
        item
          Visible = True
          ItemName = 'bbReportsFinance'
        end
        item
          Visible = True
          ItemName = 'bbReportMain'
        end
        item
          Visible = True
          ItemName = 'bbGuides'
        end
        item
          Visible = True
          ItemName = 'bbService'
        end
        item
          Visible = True
          ItemName = 'bbExit'
        end>
    end
    inherited bbService: TdxBarSubItem
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbAction'
        end
        item
          Visible = True
          ItemName = 'bbProcess'
        end
        item
          Visible = True
          ItemName = 'bbUser'
        end
        item
          Visible = True
          ItemName = 'bbRole'
        end
        item
          Visible = True
          ItemName = 'bbSetUserDefaults'
        end
        item
          Visible = True
          ItemName = 'bbProtocol'
        end
        item
          Visible = True
          ItemName = 'bbMovementProtocol'
        end
        item
          Visible = True
          ItemName = 'bbUserProtocol'
        end
        item
          Visible = True
          ItemName = 'bbMovementDesc'
        end
        item
          Visible = True
          ItemName = 'bbPeriodClose'
        end
        item
          Visible = True
          ItemName = 'bbPartner1CLink'
        end
        item
          Visible = True
          ItemName = 'bbGoods1CLink'
        end
        item
          Visible = True
          ItemName = 'bbSaveDocumentTo1C'
        end
        item
          Visible = True
          ItemName = 'bbEDI'
        end
        item
          Visible = True
          ItemName = 'bbLoad1CSale'
        end
        item
          Visible = True
          ItemName = 'bbToolsWeighingTree'
        end
        item
          Visible = True
          ItemName = 'bbService_Separator'
        end
        item
          Visible = True
          ItemName = 'bbAbout'
        end
        item
          Visible = True
          ItemName = 'bbUpdateProgramm'
        end>
    end
    inherited bbGuides: TdxBarSubItem
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbJuridicalGroup'
        end
        item
          Visible = True
          ItemName = 'bbJuridical_List'
        end
        item
          Visible = True
          ItemName = 'bbJuridical'
        end
        item
          Visible = True
          ItemName = 'bbPartner'
        end
        item
          Visible = True
          ItemName = 'bbPartnerAddress'
        end
        item
          Visible = True
          ItemName = 'bbRouteSorting'
        end
        item
          Visible = True
          ItemName = 'bbArea'
        end
        item
          Visible = True
          ItemName = 'bbRetail'
        end
        item
          Visible = True
          ItemName = 'bbContactPerson'
        end
        item
          Visible = True
          ItemName = 'bbContactPersonKind'
        end
        item
          Visible = True
          ItemName = 'bbGuides_Separator'
        end
        item
          Visible = True
          ItemName = 'bbPaidKind'
        end
        item
          Visible = True
          ItemName = 'bbGuides_Separator'
        end
        item
          Visible = True
          ItemName = 'bbContractConditionValue'
        end
        item
          Visible = True
          ItemName = 'bbContract'
        end
        item
          Visible = True
          ItemName = 'bbContractKind'
        end
        item
          Visible = True
          ItemName = 'bbContractArticle'
        end
        item
          Visible = True
          ItemName = 'bbGuides_Separator'
        end
        item
          Visible = True
          ItemName = 'bbAssetDocuments'
        end
        item
          Visible = True
          ItemName = 'bbBusiness'
        end
        item
          Visible = True
          ItemName = 'bbBranch'
        end
        item
          Visible = True
          ItemName = 'bbUnit_List'
        end
        item
          Visible = True
          ItemName = 'bbUnit'
        end
        item
          Visible = True
          ItemName = 'bbCash'
        end
        item
          Visible = True
          ItemName = 'bbBank'
        end
        item
          Visible = True
          ItemName = 'bbBankAccount'
        end
        item
          Visible = True
          ItemName = 'bbBankAccountContract'
        end
        item
          Visible = True
          ItemName = 'bbCurrency'
        end
        item
          Visible = True
          ItemName = 'bbAdres'
        end
        item
          Visible = True
          ItemName = 'bbGuides_Separator'
        end
        item
          Visible = True
          ItemName = 'bbGoodsGroup'
        end
        item
          Visible = True
          ItemName = 'bbGoods_List'
        end
        item
          Visible = True
          ItemName = 'bbGoods'
        end
        item
          Visible = True
          ItemName = 'bbGoodsKind'
        end
        item
          Visible = True
          ItemName = 'bbGoodsKindWeighing'
        end
        item
          Visible = True
          ItemName = 'bbMeasure'
        end
        item
          Visible = True
          ItemName = 'bbGoodsProperty'
        end
        item
          Visible = True
          ItemName = 'bbGoodsPropertyValue'
        end
        item
          Visible = True
          ItemName = 'bbTradeMark'
        end
        item
          Visible = True
          ItemName = 'bbPriceList'
        end
        item
          Visible = True
          ItemName = 'bbGuides_Separator'
        end
        item
          Visible = True
          ItemName = 'dxBarSubItem'
        end>
    end
    object bbGoodsDocuments: TdxBarSubItem
      Caption = #1058#1086#1074#1072#1088#1085#1099#1081' '#1091#1095#1077#1090
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbIncome'
        end
        item
          Visible = True
          ItemName = 'bbReturnOut'
        end
        item
          Visible = True
          ItemName = 'bbGoodsDocuments_Separator'
        end
        item
          Visible = True
          ItemName = 'bbSale'
        end
        item
          Visible = True
          ItemName = 'bbSale_Partner'
        end
        item
          Visible = True
          ItemName = 'bbReturnIn'
        end
        item
          Visible = True
          ItemName = 'bbSendOnPrice'
        end
        item
          Visible = True
          ItemName = 'bbGoodsDocuments_Separator'
        end
        item
          Visible = True
          ItemName = 'bbProductionSeparate'
        end
        item
          Visible = True
          ItemName = 'bbProductionUnion'
        end
        item
          Visible = True
          ItemName = 'bbGoodsDocuments_Separator'
        end
        item
          Visible = True
          ItemName = 'bbWeighingPartner'
        end
        item
          Visible = True
          ItemName = 'bbWeighingProduction'
        end
        item
          Visible = True
          ItemName = 'bbGoodsDocuments_Separator'
        end
        item
          Visible = True
          ItemName = 'bbSend'
        end
        item
          Visible = True
          ItemName = 'bbLoss'
        end
        item
          Visible = True
          ItemName = 'bbInventory'
        end
        item
          Visible = True
          ItemName = 'bbGoodsDocuments_Separator'
        end
        item
          Visible = True
          ItemName = 'bbZakazExternal'
        end
        item
          Visible = True
          ItemName = 'bbZakazInternal'
        end>
    end
    object bbGoodsDocuments_Separator: TdxBarSeparator
      Caption = 'bbGoodsDocuments_Separator'
      Category = 0
      Hint = 'bbGoodsDocuments_Separator'
      Visible = ivAlways
      ShowCaption = False
    end
    object bbIncome: TdxBarButton
      Action = actIncome
      Category = 0
    end
    object bbReturnOut: TdxBarButton
      Action = actReturnOut
      Category = 0
    end
    object bbSale: TdxBarButton
      Action = actSale
      Category = 0
    end
    object bbSale_Partner: TdxBarButton
      Action = actSale_Partner
      Category = 0
    end
    object bbReturnIn: TdxBarButton
      Action = actReturnIn
      Category = 0
    end
    object bbSendOnPrice: TdxBarButton
      Action = actSendOnPrice
      Category = 0
    end
    object bbProductionSeparate: TdxBarButton
      Action = actProductionSeparate
      Category = 0
    end
    object bbProductionUnion: TdxBarButton
      Action = actProductionUnion
      Category = 0
    end
    object bbSend: TdxBarButton
      Action = actSend
      Category = 0
    end
    object bbLoss: TdxBarButton
      Action = actLoss
      Category = 0
    end
    object bbInventory: TdxBarButton
      Action = actInventory
      Category = 0
    end
    object bbZakazExternal: TdxBarButton
      Action = actOrderExternal
      Category = 0
    end
    object bbZakazInternal: TdxBarButton
      Action = actOrderInternal
      Category = 0
    end
    object bbFinanceDocuments: TdxBarSubItem
      Caption = #1060#1080#1085#1072#1085#1089#1086#1074#1099#1081' '#1091#1095#1077#1090
      Category = 0
      Hint = #1044#1086#1082#1091#1084#1077#1085#1090#1099' '#1092#1080#1085#1072#1085#1089#1086#1074#1099#1077
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbIncomeCash'
        end
        item
          Visible = True
          ItemName = 'bbFinanceDocuments_Separator'
        end
        item
          Visible = True
          ItemName = 'bbJuridicalService'
        end
        item
          Visible = True
          ItemName = 'bbProfitLossService'
        end
        item
          Visible = True
          ItemName = 'bbBankLoad'
        end
        item
          Visible = True
          ItemName = 'bbBankAccountDocument'
        end
        item
          Visible = True
          ItemName = 'bbFinanceDocuments_Separator'
        end
        item
          Visible = True
          ItemName = 'bbLossDebt'
        end
        item
          Visible = True
          ItemName = 'bbSendDebt'
        end>
    end
    object bbFinanceDocuments_Separator: TdxBarSeparator
      Caption = 'bbFinanceDocuments_Separator'
      Category = 0
      Hint = 'bbFinanceDocuments_Separator'
      Visible = ivAlways
      ShowCaption = False
    end
    object bbIncomeCash: TdxBarButton
      Action = actCashOperation
      Category = 0
    end
    object bbJuridicalService: TdxBarButton
      Action = actService
      Category = 0
    end
    object bbBankLoad: TdxBarButton
      Action = actBankLoad
      Category = 0
    end
    object bbBankAccountDocument: TdxBarButton
      Action = actBankAccountDocument
      Category = 0
    end
    object bbLossDebt: TdxBarButton
      Action = actLossDebt
      Category = 0
    end
    object bbSendDebt: TdxBarButton
      Action = actSendDebt
      Caption = #1042#1079#1072#1080#1084#1086#1079#1072#1095#1077#1090' ('#1102#1088'. '#1083#1080#1094#1072')'
      Category = 0
    end
    object bbTaxDocuments: TdxBarSubItem
      Caption = #1053#1072#1083#1086#1075#1086#1074#1099#1081' '#1091#1095#1077#1090
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbTax'
        end
        item
          Visible = True
          ItemName = 'bbTaxCorrective'
        end
        item
          Visible = True
          ItemName = 'bbTaxDocuments_Separator'
        end
        item
          Visible = True
          ItemName = 'bbReport_CheckTax'
        end
        item
          Visible = True
          ItemName = 'bbReport_CheckTaxCorrective'
        end
        item
          Visible = True
          ItemName = 'bbTaxDocuments_Separator'
        end
        item
          Visible = True
          ItemName = 'bbSaveTaxDocument'
        end
        item
          Visible = True
          ItemName = 'bbTaxDocuments_Separator'
        end
        item
          Visible = True
          ItemName = 'bbTransferDebtIn'
        end
        item
          Visible = True
          ItemName = 'bbTransferDebtOut'
        end
        item
          Visible = True
          ItemName = 'bbTaxDocuments_Separator'
        end
        item
          Visible = True
          ItemName = 'bbPriceCorrective'
        end
        item
          Visible = True
          ItemName = 'bbTaxDocuments_Separator'
        end
        item
          Visible = True
          ItemName = 'bbReport_GoodsMI_TransferDebtIn'
        end
        item
          Visible = True
          ItemName = 'bbReport_GoodsMI_TransferDebtOut'
        end>
    end
    object bbTaxDocuments_Separator: TdxBarSeparator
      Caption = 'bbTaxDocuments_Separator'
      Category = 0
      Hint = 'bbTaxDocuments_Separator'
      Visible = ivAlways
      ShowCaption = False
    end
    object bbTax: TdxBarButton
      Action = actTax
      Category = 0
    end
    object bbTaxCorrective: TdxBarButton
      Action = actTaxCorrection
      Category = 0
    end
    object bbReport_CheckTax: TdxBarButton
      Action = actReport_CheckTax
      Category = 0
    end
    object bbReport_CheckTaxCorrective: TdxBarButton
      Action = actReport_CheckTaxCorrective
      Category = 0
    end
    object bbSaveTaxDocument: TdxBarButton
      Action = actSaveTaxDocument
      Category = 0
    end
    object bbTransferDebtIn: TdxBarButton
      Action = actTransferDebtIn
      Category = 0
    end
    object bbTransferDebtOut: TdxBarButton
      Action = actTransferDebtOut
      Category = 0
    end
    object bbReport_GoodsMI_TransferDebtIn: TdxBarButton
      Action = actReport_GoodsMI_TransferDebtIn
      Category = 0
    end
    object bbReport_GoodsMI_TransferDebtOut: TdxBarButton
      Action = actReport_GoodsMI_TransferDebtOut
      Category = 0
    end
    object bbAssetDocuments: TdxBarSubItem
      Caption = #1054#1057
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbAssetGroup'
        end
        item
          Visible = True
          ItemName = 'bbAsset'
        end
        item
          Visible = True
          ItemName = 'bbAsset_Separator'
        end
        item
          Visible = True
          ItemName = 'bbCountry'
        end
        item
          Visible = True
          ItemName = 'bbMaker'
        end>
    end
    object bbAsset_Separator: TdxBarSeparator
      Caption = 'bbAsset_Separator'
      Category = 0
      Hint = 'bbAsset_Separator'
      Visible = ivAlways
      ShowCaption = False
    end
    object bbAssetGroup: TdxBarButton
      Action = actAssetGroup
      Category = 0
    end
    object bbAsset: TdxBarButton
      Action = actAsset
      Category = 0
    end
    object bbCountry: TdxBarButton
      Action = actCountry
      Category = 0
    end
    object bbMaker: TdxBarButton
      Action = actMaker
      Category = 0
    end
    object bbHistory: TdxBarSubItem
      Caption = #1048#1089#1090#1086#1088#1080#1080
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbPriceListItem'
        end>
    end
    object bbHistory_Separator: TdxBarSeparator
      Caption = 'bbHistory_Separator'
      Category = 0
      Hint = 'bbHistory_Separator'
      Visible = ivAlways
      ShowCaption = False
    end
    object bbPriceListItem: TdxBarButton
      Action = actPriceListItem
      Category = 0
    end
    object bbTransportDocuments: TdxBarSubItem
      Caption = #1058#1088#1072#1085#1089#1087#1086#1088#1090
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbTransport'
        end
        item
          Visible = True
          ItemName = 'bbIncomeFuel'
        end
        item
          Visible = True
          ItemName = 'bbPersonalSendCash'
        end
        item
          Visible = True
          ItemName = 'bbPersonalAccount'
        end
        item
          Visible = True
          ItemName = 'bbTransportService'
        end
        item
          Visible = True
          ItemName = 'bbSendTicketFuel'
        end
        item
          Visible = True
          ItemName = 'bbTransportDocuments_Separator'
        end
        item
          Visible = True
          ItemName = 'bbCar'
        end
        item
          Visible = True
          ItemName = 'bbRoute'
        end
        item
          Visible = True
          ItemName = 'bbCarModel'
        end
        item
          Visible = True
          ItemName = 'bbFreight'
        end
        item
          Visible = True
          ItemName = 'bbFuel'
        end
        item
          Visible = True
          ItemName = 'bbRateFuelKind'
        end
        item
          Visible = True
          ItemName = 'bbRateFuel'
        end
        item
          Visible = True
          ItemName = 'bbCardFuel'
        end
        item
          Visible = True
          ItemName = 'bbTicketFuel'
        end
        item
          Visible = True
          ItemName = 'bbTransportDocuments_Separator'
        end
        item
          Visible = True
          ItemName = 'bbtReport_Transport'
        end
        item
          Visible = True
          ItemName = 'bbReport_Fuel'
        end
        item
          Visible = True
          ItemName = 'bbReport_TransportHoursWork'
        end>
    end
    object bbTransportDocuments_Separator: TdxBarSeparator
      Caption = 'bbTransportDocuments_Separator'
      Category = 0
      Hint = 'bbTransportDocuments_Separator'
      Visible = ivAlways
      ShowCaption = False
    end
    object bbTransport: TdxBarButton
      Action = actTransport
      Category = 0
    end
    object bbIncomeFuel: TdxBarButton
      Action = actIncomeFuel
      Category = 0
    end
    object bbPersonalSendCash: TdxBarButton
      Action = actPersonalSendCash
      Category = 0
    end
    object bbPersonalAccount: TdxBarButton
      Action = actPersonalAccount
      Category = 0
    end
    object bbTransportService: TdxBarButton
      Action = actTransportService
      Category = 0
    end
    object bbSendTicketFuel: TdxBarButton
      Action = actSendTicketFuel
      Category = 0
    end
    object bbCar: TdxBarButton
      Action = actCar
      Category = 0
    end
    object bbRoute: TdxBarButton
      Action = actRoute
      Category = 0
    end
    object bbCarModel: TdxBarButton
      Action = actCarModel
      Category = 0
    end
    object bbFreight: TdxBarButton
      Action = actFreight
      Category = 0
    end
    object bbFuel: TdxBarButton
      Action = actFuel
      Category = 0
    end
    object bbRateFuelKind: TdxBarButton
      Action = actRateFuelKind
      Category = 0
    end
    object bbRateFuel: TdxBarButton
      Action = actRateFuel
      Category = 0
    end
    object bbCardFuel: TdxBarButton
      Action = actCardFuel
      Category = 0
    end
    object bbTicketFuel: TdxBarButton
      Action = actTicketFuel
      Category = 0
    end
    object bbtReport_Transport: TdxBarButton
      Action = actReport_Transport
      Category = 0
    end
    object bbReport_Fuel: TdxBarButton
      Action = actReport_Fuel
      Category = 0
    end
    object bbReport_TransportHoursWork: TdxBarButton
      Action = actReport_TransportHoursWork
      Category = 0
    end
    object bbPersonalDocuments: TdxBarSubItem
      Caption = #1055#1077#1088#1089#1086#1085#1072#1083
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbPersonalGroup'
        end
        item
          Visible = True
          ItemName = 'bbPersonal'
        end
        item
          Visible = True
          ItemName = 'bbPosition'
        end
        item
          Visible = True
          ItemName = 'bbPositionLevel'
        end
        item
          Visible = True
          ItemName = 'bbMember'
        end
        item
          Visible = True
          ItemName = 'bbWorkTimeKind'
        end
        item
          Visible = True
          ItemName = 'bbStaffListData'
        end
        item
          Visible = True
          ItemName = 'bbModelService'
        end
        item
          Visible = True
          ItemName = 'bbPersonalDocuments_Separator'
        end
        item
          Visible = True
          ItemName = 'bbCalendar'
        end
        item
          Visible = True
          ItemName = 'bbSheetWorkTime'
        end
        item
          Visible = True
          ItemName = 'bbPersonalService'
        end>
    end
    object bbPersonalDocuments_Separator: TdxBarSeparator
      Caption = 'bbPersonalDocuments_Separator'
      Category = 0
      Hint = 'bbPersonalDocuments_Separator'
      Visible = ivAlways
      ShowCaption = False
    end
    object bbPersonalGroup: TdxBarButton
      Action = actPersonalGroup
      Category = 0
    end
    object bbPersonal: TdxBarButton
      Action = actPersonal
      Category = 0
    end
    object bbPosition: TdxBarButton
      Action = actPosition
      Category = 0
    end
    object bbPositionLevel: TdxBarButton
      Action = actPositionLevel
      Category = 0
    end
    object bbMember: TdxBarButton
      Action = actMember
      Category = 0
    end
    object bbWorkTimeKind: TdxBarButton
      Action = actWorkTimeKind
      Category = 0
    end
    object bbStaffListData: TdxBarButton
      Action = actStaffListData
      Category = 0
    end
    object bbModelService: TdxBarButton
      Action = actModelService
      Category = 0
    end
    object bbCalendar: TdxBarButton
      Action = actCalendar
      Category = 0
    end
    object bbSheetWorkTime: TdxBarButton
      Action = actSheetWorkTime
      Category = 0
    end
    object bbPersonalService: TdxBarButton
      Action = actPersonalService
      Category = 0
    end
    object bbReportsProduction: TdxBarSubItem
      Caption = #1054#1090#1095#1077#1090#1099' ('#1087#1088'-'#1074#1086')'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbReportProductionUnion'
        end>
    end
    object bbReportsProduction_Separator: TdxBarSeparator
      Caption = 'bbReportsProduction_Separator'
      Category = 0
      Hint = 'bbReportsProduction_Separator'
      Visible = ivAlways
      ShowCaption = False
    end
    object bbReportProductionUnion: TdxBarButton
      Action = actReport_Production_Union
      Category = 0
    end
    object bbReportsGoods: TdxBarSubItem
      Caption = #1054#1090#1095#1077#1090#1099' ('#1090#1086#1074'.)'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbReport_MotionGoods'
        end
        item
          Visible = True
          ItemName = 'bbReport_GoodsTax'
        end
        item
          Visible = True
          ItemName = 'bbReport_Goods'
        end
        item
          Visible = True
          ItemName = 'bbReportsGoods_Separator'
        end
        item
          Visible = True
          ItemName = 'bbReport_GoodsMI_Income'
        end
        item
          Visible = True
          ItemName = 'bbReport_GoodsMI_IncomeByPartner'
        end
        item
          Visible = True
          ItemName = 'bbReportsGoods_Separator'
        end
        item
          Visible = True
          ItemName = 'bbReport_GoodsMI_SaleReturnIn'
        end
        item
          Visible = True
          ItemName = 'bbReport_GoodsMISale'
        end
        item
          Visible = True
          ItemName = 'bbReport_GoodsMI_byMovementSale'
        end
        item
          Visible = True
          ItemName = 'bbReport_GoodsMI_byMovementDifSale'
        end
        item
          Visible = True
          ItemName = 'bbReport_GoodsMI_byPriceDifSale'
        end
        item
          Visible = True
          ItemName = 'bbReportsGoods_Separator'
        end
        item
          Visible = True
          ItemName = 'bbReport_GoodsMIReturn'
        end
        item
          Visible = True
          ItemName = 'bbReport_GoodsMI_byMovementReturn'
        end
        item
          Visible = True
          ItemName = 'bbReport_GoodsMI_byMovementDifReturn'
        end
        item
          Visible = True
          ItemName = 'bbReportsGoods_Separator'
        end
        item
          Visible = True
          ItemName = 'bbReportHistoryCost'
        end
        item
          Visible = True
          ItemName = 'bbReportsGoods_Separator'
        end
        item
          Visible = True
          ItemName = 'bbReport_CheckContractInMovement'
        end>
    end
    object bbReportsGoods_Separator: TdxBarSeparator
      Caption = 'bbReportsGoods_Separator'
      Category = 0
      Hint = 'bbReportsGoods_Separator'
      Visible = ivAlways
      ShowCaption = False
    end
    object bbReport_MotionGoods: TdxBarButton
      Action = actReport_MotionGoods
      Category = 0
    end
    object bbReport_GoodsTax: TdxBarButton
      Action = actReport_GoodsTax
      Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1090#1086#1074#1072#1088#1091' ('#1053#1072#1083#1086#1075#1086#1074#1099#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099')'
      Category = 0
    end
    object bbReport_GoodsMI_SaleReturnIn: TdxBarButton
      Action = actReport_GoodsMI_SaleReturnIn
      Category = 0
    end
    object bbReport_GoodsMISale: TdxBarButton
      Action = actReport_GoodsMISale
      Category = 0
    end
    object bbReport_GoodsMI_byMovementSale: TdxBarButton
      Action = actReport_GoodsMI_byMovementSale
      Category = 0
    end
    object bbReport_GoodsMI_byMovementDifSale: TdxBarButton
      Action = actReport_GoodsMI_byMovementDifSale
      Category = 0
    end
    object bbReport_GoodsMI_byPriceDifSale: TdxBarButton
      Action = actReport_GoodsMI_byPriceDifSale
      Category = 0
    end
    object bbReport_GoodsMI_Income: TdxBarButton
      Action = actReport_GoodsMI_Income
      Category = 0
    end
    object bbReport_GoodsMI_IncomeByPartner: TdxBarButton
      Action = actReport_GoodsMI_IncomeByPartner
      Category = 0
    end
    object bbReport_GoodsMIReturn: TdxBarButton
      Action = actReport_GoodsMIReturn
      Category = 0
    end
    object bbReport_GoodsMI_byMovementReturn: TdxBarButton
      Action = actReport_GoodsMI_byMovementReturn
      Category = 0
    end
    object bbReport_GoodsMI_byMovementDifReturn: TdxBarButton
      Action = actReport_GoodsMI_byMovementDifReturn
      Category = 0
    end
    object bbReportHistoryCost: TdxBarButton
      Action = actReport_HistoryCost
      Category = 0
    end
    object bbReportsFinance: TdxBarSubItem
      Caption = #1054#1090#1095#1077#1090#1099' ('#1092#1080#1085'.)'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbReport_JuridicalSold'
        end
        item
          Visible = True
          ItemName = 'bbReport_JuridicalDefermentPayment'
        end
        item
          Visible = True
          ItemName = 'bbReport_JuridicalCollation'
        end
        item
          Visible = True
          ItemName = 'bbReportsFinance_Separator'
        end
        item
          Visible = True
          ItemName = 'bbReport_CheckBonus'
        end
        item
          Visible = True
          ItemName = 'bbReportsFinance_Separator'
        end
        item
          Visible = True
          ItemName = 'bbAccountReport'
        end>
    end
    object bbReportsFinance_Separator: TdxBarSeparator
      Caption = 'bbReportsFinance_Separator'
      Category = 0
      Hint = 'bbReportsFinance_Separator'
      Visible = ivAlways
      ShowCaption = False
    end
    object bbReport_JuridicalSold: TdxBarButton
      Action = actReport_JuridicalSold
      Category = 0
    end
    object bbReport_JuridicalDefermentPayment: TdxBarButton
      Action = actReport_JuridicalDefermentPayment
      Category = 0
    end
    object bbReport_JuridicalCollation: TdxBarButton
      Action = actReport_JuridicalCollation
      Category = 0
    end
    object bbAccountReport: TdxBarButton
      Action = actReport_Account
      Category = 0
    end
    object bbReportMain: TdxBarSubItem
      Caption = #1054#1090#1095#1077#1090#1099' ('#1059#1055')'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbReportBalance'
        end
        item
          Visible = True
          ItemName = 'bbReportProfitLoss'
        end>
    end
    object bbReportMain_Separator: TdxBarSeparator
      Caption = 'bbReportMain_Separator'
      Category = 0
      Hint = 'bbReportMain_Separator'
      Visible = ivAlways
      ShowCaption = False
    end
    object bbReportBalance: TdxBarButton
      Action = actReport_Balance
      Category = 0
    end
    object bbReportProfitLoss: TdxBarButton
      Action = actReport_ProfitLoss
      Category = 0
    end
    object bbGuides_Separator: TdxBarSeparator
      Caption = 'bbGuides_Separator'
      Category = 0
      Hint = 'bbGuides_Separator'
      Visible = ivAlways
      ShowCaption = False
    end
    object bbJuridicalGroup: TdxBarButton
      Action = actJuridicalGroup
      Category = 0
    end
    object bbJuridical_List: TdxBarButton
      Action = actJuridical_List
      Category = 0
    end
    object bbJuridical: TdxBarButton
      Action = actJuridical
      Category = 0
    end
    object bbPartner: TdxBarButton
      Action = actPartner
      Category = 0
    end
    object bbRouteSorting: TdxBarButton
      Action = actRouteSorting
      Category = 0
    end
    object bbArea: TdxBarButton
      Action = actArea
      Category = 0
    end
    object bbPaidKind: TdxBarButton
      Action = actPaidKind
      Category = 0
    end
    object bbContractConditionValue: TdxBarButton
      Action = actContractConditionValue
      Category = 0
    end
    object bbContract: TdxBarButton
      Action = actContract
      Category = 0
    end
    object bbContractKind: TdxBarButton
      Action = actContractKind
      Category = 0
    end
    object bbContractArticle: TdxBarButton
      Action = actContractArticle
      Category = 0
    end
    object bbBusiness: TdxBarButton
      Action = actBusiness
      Category = 0
    end
    object bbBranch: TdxBarButton
      Action = actBranch
      Category = 0
    end
    object bbUnit_List: TdxBarButton
      Action = actUnit_List
      Category = 0
    end
    object bbUnit: TdxBarButton
      Action = actUnit
      Category = 0
    end
    object bbCash: TdxBarButton
      Action = actCash
      Category = 0
    end
    object bbBank: TdxBarButton
      Action = actBank
      Category = 0
    end
    object bbBankAccount: TdxBarButton
      Action = actBankAccount
      Category = 0
    end
    object bbCurrency: TdxBarButton
      Action = actCurrency
      Category = 0
    end
    object bbCity: TdxBarButton
      Action = actCity
      Category = 0
    end
    object bbGoodsGroup: TdxBarButton
      Action = actGoodsGroup
      Category = 0
    end
    object bbGoods_List: TdxBarButton
      Action = actGoods_List
      Category = 0
    end
    object bbGoods: TdxBarButton
      Action = actGoods
      Category = 0
    end
    object bbGoodsKind: TdxBarButton
      Action = actGoodsKind
      Category = 0
    end
    object bbMeasure: TdxBarButton
      Action = actMeasure
      Category = 0
    end
    object bbGoodsProperty: TdxBarButton
      Action = actGoodsProperty
      Category = 0
    end
    object bbGoodsPropertyValue: TdxBarButton
      Action = actGoodsPropertyValue
      Category = 0
    end
    object bbTradeMark: TdxBarButton
      Action = actTradeMark
      Category = 0
    end
    object bbPriceList: TdxBarButton
      Action = actPriceList
      Category = 0
    end
    object dxBarSubItem: TdxBarSubItem
      Caption = #1059#1087#1088#1072#1074#1083#1077#1085#1095#1077#1089#1082#1080#1077' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbInfoMoneyGroup'
        end
        item
          Visible = True
          ItemName = 'bbInfoMoneyDestination'
        end
        item
          Visible = True
          ItemName = 'bbInfoMoney'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbAccountGroup'
        end
        item
          Visible = True
          ItemName = 'bbAccountDirection'
        end
        item
          Visible = True
          ItemName = 'bbAccount'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbProfitLossGroup'
        end
        item
          Visible = True
          ItemName = 'bbProfitLossDirection'
        end
        item
          Visible = True
          ItemName = 'bbProfitLoss'
        end>
    end
    object bbInfoMoneyGroup: TdxBarButton
      Action = actInfoMoneyGroup
      Category = 0
    end
    object bbInfoMoneyDestination: TdxBarButton
      Action = actInfoMoneyDestination
      Category = 0
    end
    object bbInfoMoney: TdxBarButton
      Action = actInfoMoney
      Category = 0
    end
    object bbAccountGroup: TdxBarButton
      Action = actAccountGroup
      Category = 0
    end
    object bbAccountDirection: TdxBarButton
      Action = actAccountDirection
      Category = 0
    end
    object bbAccount: TdxBarButton
      Action = actAccount
      Category = 0
    end
    object bbProfitLossGroup: TdxBarButton
      Action = actProfitLossGroup
      Category = 0
    end
    object bbProfitLossDirection: TdxBarButton
      Action = actProfitLossDirection
      Category = 0
    end
    object bbProfitLoss: TdxBarButton
      Action = actProfitLoss
      Category = 0
    end
    object bbService_Separator: TdxBarSeparator
      Caption = 'bbService_Separator'
      Category = 0
      Hint = 'bbService_Separator'
      Visible = ivAlways
      ShowCaption = False
    end
    object bbRole: TdxBarButton
      Action = actRole
      Category = 0
    end
    object bbAction: TdxBarButton
      Action = actAction
      Category = 0
    end
    object bbUser: TdxBarButton
      Action = actUser
      Category = 0
    end
    object bbProcess: TdxBarButton
      Action = actProcess
      Category = 0
    end
    object bbProtocol: TdxBarButton
      Action = actProtocol
      Caption = #1055#1088#1086#1090#1086#1082#1086#1083' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1086#1074
      Category = 0
    end
    object bbSetUserDefaults: TdxBarButton
      Action = actSetUserDefaults
      Category = 0
    end
    object bbMovementDesc: TdxBarButton
      Action = actMovementDesc
      Category = 0
    end
    object bbPartner1CLink: TdxBarButton
      Action = actPartner1CLink
      Category = 0
    end
    object bbGoods1CLink: TdxBarButton
      Action = actGoodsByGoodsKind1CLink
      Category = 0
    end
    object bbLoad1CSale: TdxBarButton
      Action = actLoad1CSale
      Category = 0
    end
    object bbUserProtocol: TdxBarButton
      Action = actProtocolUser
      Category = 0
    end
    object bbMovementProtocol: TdxBarButton
      Action = actProtocolMovement
      Category = 0
    end
    object bbProfitLossService: TdxBarButton
      Action = actProfitLossService
      Caption = #1053#1072#1095#1080#1089#1083#1077#1085#1080#1103' '#1087#1086' '#1073#1086#1085#1091#1089#1072#1084' ('#1088#1072#1089#1093#1086#1076#1099' '#1073#1091#1076#1091#1097#1080#1093' '#1087#1077#1088#1080#1086#1076#1086#1074')'
      Category = 0
    end
    object bbPeriodClose: TdxBarButton
      Action = actPeriodClose
      Category = 0
    end
    object bbToolsWeighingTree: TdxBarButton
      Action = actToolsWeighingTree
      Category = 0
    end
    object bbWeighingPartner: TdxBarButton
      Action = actWeighingPartner
      Category = 0
    end
    object bbWeighingProduction: TdxBarButton
      Action = actWeighingProduction
      Category = 0
    end
    object bbReport_CheckBonus: TdxBarButton
      Action = actReport_CheckBonus
      Category = 0
    end
    object bbGoodsKindWeighing: TdxBarButton
      Action = actGoodsKindWeighing
      Category = 0
    end
    object bbReport_CheckContractInMovement: TdxBarButton
      Action = actReport_CheckContractInMovement
      Category = 0
    end
    object bbBankAccountContract: TdxBarButton
      Action = actBankAccountContract
      Category = 0
    end
    object bbEDI: TdxBarButton
      Action = actEDI
      Category = 0
    end
    object bbSaveDocumentTo1C: TdxBarButton
      Action = actSaveDocumentTo1C
      Category = 0
    end
    object bbReport_Goods: TdxBarButton
      Action = actReport_Goods
      Category = 0
    end
    object bbRetail: TdxBarButton
      Action = actRetail
      Category = 0
    end
    object bbPriceCorrective: TdxBarButton
      Action = actPriceCorrective
      Category = 0
    end
    object bbAdres: TdxBarSubItem
      Caption = #1040#1076#1088#1077#1089#1072' '#1076#1086#1089#1090#1072#1074#1082#1080
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbRegion'
        end
        item
          Visible = True
          ItemName = 'bb'#1056#1072#1081#1086#1085
        end
        item
          Visible = True
          ItemName = 'bbProvinceCity'
        end
        item
          Visible = True
          ItemName = 'bbCity'
        end
        item
          Visible = True
          ItemName = 'bbCityKind'
        end
        item
          Visible = True
          ItemName = 'bbStreet'
        end
        item
          Visible = True
          ItemName = 'bbStreetKind'
        end>
    end
    object bbContactPerson: TdxBarButton
      Action = actContactPerson
      Category = 0
    end
    object bbContactPersonKind: TdxBarButton
      Action = actContactPersonKind
      Category = 0
    end
    object bbRegion: TdxBarButton
      Action = actRegion
      Category = 0
    end
    object bbРайон: TdxBarButton
      Action = actProvince
      Category = 0
    end
    object bbCityKind: TdxBarButton
      Action = actCityKind
      Category = 0
    end
    object bbProvinceCity: TdxBarButton
      Action = actProvinceCity
      Category = 0
    end
    object bbStreetKind: TdxBarButton
      Action = actStreetKind
      Category = 0
    end
    object bbStreet: TdxBarButton
      Action = actStreet
      Category = 0
    end
    object bbPartnerAddress: TdxBarButton
      Action = actPartnerAddress
      Category = 0
    end
  end
  inherited ActionList: TActionList
    object actAssetGroup: TdsdOpenForm
      Category = #1054#1057
      MoveParams = <>
      Caption = #1043#1088#1091#1087#1087#1099' '#1054#1057
      Hint = #1043#1088#1091#1087#1087#1099' '#1086#1089#1085#1086#1074#1085#1099#1093' '#1089#1088#1077#1076#1089#1090#1074' '
      FormName = 'TAssetGroupForm'
      FormNameParam.Value = 'TAssetGroupForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actContactPersonKind: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1042#1080#1076' '#1082#1086#1085#1090#1072#1082#1090#1072
      Hint = #1042#1080#1076' '#1082#1086#1085#1090#1072#1082#1090#1072
      FormName = 'TContactPersonKindForm'
      FormNameParam.Value = 'TContactPersonKindForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actAsset: TdsdOpenForm
      Category = #1054#1057
      MoveParams = <>
      Caption = #1054#1089#1085#1086#1074#1085#1099#1077' '#1089#1088#1077#1076#1089#1090#1074#1072' '
      Hint = #1054#1089#1085#1086#1074#1085#1099#1077' '#1089#1088#1077#1076#1089#1090#1074#1072' '
      FormName = 'TAssetForm'
      FormNameParam.Value = 'TAssetForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actContactPerson: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1050#1086#1085#1090#1072#1082#1090#1085#1099#1077' '#1083#1080#1094#1072
      Hint = #1050#1086#1085#1090#1072#1082#1090#1085#1099#1077' '#1083#1080#1094#1072
      FormName = 'TContactPersonForm'
      FormNameParam.Value = 'TContactPersonForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actProvinceCity: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1056#1072#1081#1086#1085' '#1074' '#1085#1072#1089#1077#1083#1077#1085#1085#1086#1084' '#1087#1091#1085#1082#1090#1077
      Hint = #1056#1072#1081#1086#1085' '#1074' '#1085#1072#1089#1077#1083#1077#1085#1085#1086#1084' '#1087#1091#1085#1082#1090#1077
      FormName = 'TProvinceCityForm'
      FormNameParam.Value = 'TProvinceCityForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actProvince: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1056#1072#1081#1086#1085
      Hint = #1056#1072#1081#1086#1085
      FormName = 'TProvinceForm'
      FormNameParam.Value = 'TProvinceForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actMaker: TdsdOpenForm
      Category = #1054#1057
      MoveParams = <>
      Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100' '#1054#1057
      Hint = #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100' ('#1054#1057')'
      FormName = 'TMakerForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actReport_JuridicalSold: TdsdOpenForm
      Category = #1054#1090#1095#1077#1090#1099' ('#1092#1080#1085'.)'
      MoveParams = <>
      Caption = #1054#1073#1086#1088#1086#1090#1099' '#1087#1086' '#1102#1088'.'#1083#1080#1094#1072#1084
      FormName = 'TReport_JuridicalSoldForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actStreet: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1059#1083#1080#1094#1072'/'#1087#1088#1086#1089#1087#1077#1082#1090
      Hint = #1059#1083#1080#1094#1072'/'#1087#1088#1086#1089#1087#1077#1082#1090
      FormName = 'TStreetForm'
      FormNameParam.Value = 'TStreetForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actStreetKind: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1042#1080#1076'('#1091#1083#1080#1094#1072','#1087#1088#1086#1089#1087#1077#1082#1090')'
      Hint = #1042#1080#1076'('#1091#1083#1080#1094#1072','#1087#1088#1086#1089#1087#1077#1082#1090')'
      FormName = 'TStreetKindForm'
      FormNameParam.Value = 'TStreetKindForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actBankAccountContract: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1056#1072#1089#1095#1077#1090#1085#1099#1077' '#1089#1095#1077#1090#1072' '#1076#1083#1103' '#1074#1089#1077#1093' ('#1074#1093'.'#1087#1083#1072#1090#1077#1078')'
      Hint = #1056#1072#1089#1095#1077#1090#1085#1099#1077' '#1089#1095#1077#1090#1072' '#1076#1083#1103' '#1074#1089#1077#1093' ('#1074#1093'.'#1087#1083#1072#1090#1077#1078')'
      FormName = 'TBankAccountContractForm'
      FormNameParam.Value = 'TBankAccountContractForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actCityKind: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1042#1080#1076' '#1085#1072#1089#1077#1083#1077#1085#1085#1086#1075#1086' '#1087#1091#1085#1082#1090#1072
      Hint = #1042#1080#1076' '#1085#1072#1089#1077#1083#1077#1085#1085#1086#1075#1086' '#1087#1091#1085#1082#1090#1072
      FormName = 'TCityKindForm'
      FormNameParam.Value = 'TCityKindForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actReport_JuridicalDefermentPayment: TdsdOpenForm
      Category = #1054#1090#1095#1077#1090#1099' ('#1092#1080#1085'.)'
      MoveParams = <>
      Caption = #1044#1086#1083#1075#1080' '#1089' '#1086#1090#1089#1088#1086#1095#1082#1086#1081
      FormName = 'TReport_JuridicalDefermentPayment'
      FormNameParam.Value = 'TReport_JuridicalDefermentPayment'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actTransport: TdsdOpenForm
      Category = #1058#1088#1072#1085#1089#1087#1086#1088#1090
      MoveParams = <>
      Caption = #1055#1091#1090#1077#1074#1086#1081' '#1083#1080#1089#1090
      Hint = #1055#1091#1090#1077#1074#1086#1081' '#1083#1080#1089#1090
      FormName = 'TTransportJournalForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actIncomeFuel: TdsdOpenForm
      Category = #1058#1088#1072#1085#1089#1087#1086#1088#1090
      MoveParams = <>
      Caption = #1055#1088#1080#1093#1086#1076' '#1086#1090' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1072' ('#1047#1072#1087#1088#1072#1074#1082#1072' '#1072#1074#1090#1086') '
      Hint = #1055#1088#1080#1093#1086#1076' '#1086#1090' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1072' ('#1079#1072#1087#1088#1072#1074#1082#1072' '#1072#1074#1090#1086') '
      FormName = 'TIncomeFuelJournalForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actPersonalSendCash: TdsdOpenForm
      Category = #1058#1088#1072#1085#1089#1087#1086#1088#1090
      MoveParams = <>
      Caption = #1056#1072#1089#1093#1086#1076' '#1076#1077#1085#1077#1075' '#1089' '#1087#1086#1076#1086#1090#1095#1077#1090#1072' '#1085#1072' '#1087#1086#1076#1086#1090#1095#1077#1090
      Hint = #1056#1072#1089#1093#1086#1076' '#1076#1077#1085#1077#1075' '#1089' '#1087#1086#1076#1086#1090#1095#1077#1090#1072' '#1085#1072' '#1087#1086#1076#1086#1090#1095#1077#1090
      FormName = 'TPersonalSendCashJournalForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actPersonalGroup: TdsdOpenForm
      Category = #1055#1077#1088#1089#1086#1085#1072#1083
      MoveParams = <>
      Caption = #1043#1088#1091#1087#1087#1080#1088#1086#1074#1082#1080' '#1057#1086#1090#1088#1091#1076#1085#1080#1082#1086#1074' '
      Hint = #1043#1088#1091#1087#1087#1080#1088#1086#1074#1082#1080' '#1057#1086#1090#1088#1091#1076#1085#1080#1082#1086#1074' '
      FormName = 'TPersonalGroupForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actRetail: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1058#1086#1088#1075#1086#1074#1072#1103' '#1089#1077#1090#1100
      Hint = #1058#1086#1088#1075#1086#1074#1072#1103' '#1089#1077#1090#1100
      FormName = 'TRetailForm'
      FormNameParam.Value = 'TRetailForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actPersonal: TdsdOpenForm
      Category = #1055#1077#1088#1089#1086#1085#1072#1083
      MoveParams = <>
      Caption = #1057#1086#1090#1088#1091#1076#1085#1080#1082#1080' '
      Hint = #1057#1086#1090#1088#1091#1076#1085#1080#1082#1080' '
      FormName = 'TPersonalForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actPosition: TdsdOpenForm
      Category = #1055#1077#1088#1089#1086#1085#1072#1083
      MoveParams = <>
      Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1080' '
      Hint = #1044#1086#1083#1078#1085#1086#1089#1090#1080' '
      FormName = 'TPositionForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actCalendar: TdsdOpenForm
      Category = #1055#1077#1088#1089#1086#1085#1072#1083
      MoveParams = <>
      Caption = #1050#1072#1083#1077#1085#1076#1072#1088#1100' '#1088#1072#1073#1086#1095#1080#1093' '#1076#1085#1077#1081
      Hint = #1050#1072#1083#1077#1085#1076#1072#1088#1100' '#1088#1072#1073#1086#1095#1080#1093' '#1076#1085#1077#1081
      FormName = 'TCalendarForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actProtocolUser: TdsdOpenForm
      Category = #1057#1083#1091#1078#1077#1073#1085#1099#1077
      MoveParams = <>
      Caption = #1055#1088#1086#1090#1086#1082#1086#1083' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
      Hint = #1055#1088#1086#1090#1086#1082#1086#1083' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
      FormName = 'TUserProtocolForm'
      FormNameParam.Value = 'TUserProtocolForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actProtocolMovement: TdsdOpenForm
      Category = #1057#1083#1091#1078#1077#1073#1085#1099#1077
      MoveParams = <>
      Caption = #1055#1088#1086#1090#1086#1082#1086#1083' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
      Hint = #1055#1088#1086#1090#1086#1082#1086#1083' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
      FormName = 'TMovementProtocolForm'
      FormNameParam.Value = 'TMovementProtocolForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actPersonalAccount: TdsdOpenForm
      Category = #1058#1088#1072#1085#1089#1087#1086#1088#1090
      MoveParams = <>
      Caption = #1056#1072#1089#1095#1077#1090#1099' '#1087#1086#1076#1086#1090#1095#1077#1090#1072' '#1089' '#1102#1088'.'#1083#1080#1094#1086#1084
      Hint = #1056#1072#1089#1095#1077#1090#1099' '#1087#1086#1076#1086#1090#1095#1077#1090#1072' '#1089' '#1102#1088'.'#1083#1080#1094#1086#1084
      FormName = 'TPersonalAccountJournalForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actMember: TdsdOpenForm
      Category = #1055#1077#1088#1089#1086#1085#1072#1083
      MoveParams = <>
      Caption = #1060#1080#1079#1080#1095#1077#1089#1082#1080#1077' '#1083#1080#1094#1072
      Hint = #1060#1080#1079#1080#1095#1077#1089#1082#1080#1077' '#1083#1080#1094#1072
      FormName = 'TMemberForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actTransportService: TdsdOpenForm
      Category = #1058#1088#1072#1085#1089#1087#1086#1088#1090
      MoveParams = <>
      Caption = #1053#1072#1095#1080#1089#1083#1077#1085#1080#1103' '#1085#1072#1077#1084#1085#1099#1081' '#1090#1088#1072#1085#1089#1087#1086#1088#1090
      Hint = #1056#1072#1089#1095#1077#1090#1099' '#1087#1086#1076#1086#1090#1095#1077#1090#1072' '#1089' '#1102#1088'.'#1083#1080#1094#1086#1084
      FormName = 'TTransportServiceJournalForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actSendTicketFuel: TdsdOpenForm
      Category = #1058#1088#1072#1085#1089#1087#1086#1088#1090
      MoveParams = <>
      Caption = #1055#1077#1088#1077#1084#1077#1097#1077#1085#1080#1077' ('#1058#1072#1083#1086#1085#1099' '#1085#1072' '#1090#1086#1087#1083#1080#1074#1086')'
      Hint = #1055#1077#1088#1077#1084#1077#1097#1077#1085#1080#1077' ('#1058#1072#1083#1086#1085#1099' '#1085#1072' '#1090#1086#1087#1083#1080#1074#1086')'
      FormName = 'TSendTicketFuelJournalForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actStaffListData: TdsdOpenForm
      Category = #1055#1077#1088#1089#1086#1085#1072#1083
      MoveParams = <>
      Caption = #1064#1090#1072#1090#1085#1086#1077' '#1088#1072#1089#1087#1080#1089#1072#1085#1080#1077
      Hint = #1096#1090#1072#1090#1085#1086#1077' '#1088#1072#1089#1087#1080#1089#1072#1085#1080#1077
      FormName = 'TStaffListDataForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actCar: TdsdOpenForm
      Category = #1058#1088#1072#1085#1089#1087#1086#1088#1090
      MoveParams = <>
      Caption = #1040#1074#1090#1086#1084#1086#1073#1080#1083#1080
      Hint = #1040#1074#1090#1086#1084#1086#1073#1080#1083#1080
      FormName = 'TCarForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actRoute: TdsdOpenForm
      Category = #1058#1088#1072#1085#1089#1087#1086#1088#1090
      MoveParams = <>
      Caption = #1052#1072#1088#1096#1088#1091#1090#1099
      Hint = #1052#1072#1088#1096#1088#1091#1090#1099
      FormName = 'TRouteForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actCarModel: TdsdOpenForm
      Category = #1058#1088#1072#1085#1089#1087#1086#1088#1090
      MoveParams = <>
      Caption = #1052#1072#1088#1082#1080' '#1072#1074#1090#1086#1084#1086#1073#1080#1083#1077#1081
      Hint = #1052#1072#1088#1082#1080' '#1072#1074#1090#1086#1084#1086#1073#1080#1083#1077#1081
      FormName = 'TCarModelForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actFuel: TdsdOpenForm
      Category = #1058#1088#1072#1085#1089#1087#1086#1088#1090
      MoveParams = <>
      Caption = #1042#1080#1076#1099' '#1090#1086#1087#1083#1080#1074#1072
      Hint = #1042#1080#1076#1099' '#1090#1086#1087#1083#1080#1074#1072
      FormName = 'TFuelForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actPartnerAddress: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090#1099' ('#1072#1076#1088#1077#1089#1072')'
      Hint = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090#1099' ('#1072#1076#1088#1077#1089#1072')'
      FormName = 'TPartnerAddressForm'
      FormNameParam.Value = 'TPartnerAddressForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actRateFuelKind: TdsdOpenForm
      Category = #1058#1088#1072#1085#1089#1087#1086#1088#1090
      MoveParams = <>
      Caption = #1042#1080#1076#1099' '#1085#1086#1088#1084' '#1090#1086#1087#1083#1080#1074#1072
      Hint = #1042#1080#1076#1099' '#1085#1086#1088#1084' '#1090#1086#1087#1083#1080#1074#1072
      FormName = 'TRateFuelKindForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actReport_Balance: TdsdOpenForm
      Category = #1054#1090#1095#1077#1090#1099' ('#1059#1055')'
      MoveParams = <>
      Caption = #1041#1072#1083#1072#1085#1089
      FormName = 'TReport_BalanceForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actReport_ProfitLoss: TdsdOpenForm
      Category = #1054#1090#1095#1077#1090#1099' ('#1059#1055')'
      MoveParams = <>
      Caption = #1054#1090#1095#1077#1090' '#1086' '#1055#1088#1080#1073#1099#1083#1103#1093' '#1080' '#1059#1073#1099#1090#1082#1072#1093
      FormName = 'TReport_ProfitLossForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actProcess: TdsdOpenForm
      Category = #1057#1083#1091#1078#1077#1073#1085#1099#1077
      MoveParams = <>
      Caption = #1055#1088#1086#1094#1077#1089#1089#1099
      Hint = #1055#1088#1086#1094#1077#1089#1089#1099
      FormName = 'TProcessForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actIncome: TdsdOpenForm
      Category = #1058#1086#1074#1072#1088#1085#1099#1081' '#1091#1095#1077#1090
      MoveParams = <>
      Caption = #1055#1088#1080#1093#1086#1076' '#1086#1090' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1072
      FormName = 'TIncomeJournalForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actReport_HistoryCost: TdsdOpenForm
      Category = #1054#1090#1095#1077#1090#1099' ('#1090#1086#1074'.)'
      MoveParams = <>
      Caption = #1057#1077#1073#1077#1089#1090#1086#1080#1084#1086#1089#1090#1100
      FormName = 'TReport_HistoryCostForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actReturnOut: TdsdOpenForm
      Category = #1058#1086#1074#1072#1088#1085#1099#1081' '#1091#1095#1077#1090
      MoveParams = <>
      Caption = #1042#1086#1079#1074#1088#1072#1090' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1091
      FormName = 'TReturnOutJournalForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actSale: TdsdOpenForm
      Category = #1058#1086#1074#1072#1088#1085#1099#1081' '#1091#1095#1077#1090
      MoveParams = <>
      Caption = #1055#1088#1086#1076#1072#1078#1072' '#1087#1086#1082#1091#1087#1072#1090#1077#1083#1102' ('#1074#1089#1077')'
      FormName = 'TSaleJournalForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actSale_Partner: TdsdOpenForm
      Category = #1058#1086#1074#1072#1088#1085#1099#1081' '#1091#1095#1077#1090
      MoveParams = <>
      Caption = #1055#1088#1086#1076#1072#1078#1072' '#1087#1086#1082#1091#1087#1072#1090#1077#1083#1102
      FormName = 'TSale_PartnerJournalForm'
      FormNameParam.Value = 'TSale_PartnerJournalForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actReturnIn: TdsdOpenForm
      Category = #1058#1086#1074#1072#1088#1085#1099#1081' '#1091#1095#1077#1090
      MoveParams = <>
      Caption = #1042#1086#1079#1074#1088#1072#1090' '#1086#1090' '#1087#1086#1082#1091#1087#1072#1090#1077#1083#1103
      FormName = 'TReturnInJournalForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actSendOnPrice: TdsdOpenForm
      Category = #1058#1086#1074#1072#1088#1085#1099#1081' '#1091#1095#1077#1090
      MoveParams = <>
      Caption = #1055#1077#1088#1077#1084#1077#1097#1077#1085#1080#1077' '#1087#1086' '#1094#1077#1085#1077
      FormName = 'TSendOnPriceJournalForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actRegion: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1054#1073#1083#1072#1089#1090#1100
      Hint = #1054#1073#1083#1072#1089#1090#1100
      FormName = 'TRegionForm'
      FormNameParam.Value = 'TRegionForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actSend: TdsdOpenForm
      Category = #1058#1086#1074#1072#1088#1085#1099#1081' '#1091#1095#1077#1090
      MoveParams = <>
      Caption = #1055#1077#1088#1077#1084#1077#1097#1077#1085#1080#1077
      FormName = 'TSendJournalForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actProductionSeparate: TdsdOpenForm
      Category = #1058#1086#1074#1072#1088#1085#1099#1081' '#1091#1095#1077#1090
      MoveParams = <>
      Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1086' - '#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
      FormName = 'TProductionSeparateJournalForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actProductionUnion: TdsdOpenForm
      Category = #1058#1086#1074#1072#1088#1085#1099#1081' '#1091#1095#1077#1090
      MoveParams = <>
      Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1086' - '#1089#1084#1077#1096#1080#1074#1072#1085#1080#1077
      FormName = 'TProductionUnionJournalForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actLoss: TdsdOpenForm
      Category = #1058#1086#1074#1072#1088#1085#1099#1081' '#1091#1095#1077#1090
      MoveParams = <>
      Caption = #1057#1087#1080#1089#1072#1085#1080#1077
      FormName = 'TLossJournalForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actInventory: TdsdOpenForm
      Category = #1058#1086#1074#1072#1088#1085#1099#1081' '#1091#1095#1077#1090
      MoveParams = <>
      Caption = #1048#1085#1074#1077#1085#1090#1072#1088#1080#1079#1072#1094#1080#1103
      FormName = 'TInventoryJournalForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actBank: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1041#1072#1085#1082#1080
      Hint = #1041#1072#1085#1082#1080
      FormName = 'TBankForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actBankAccount: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1056#1072#1089#1095#1077#1090#1085#1099#1077' '#1089#1095#1077#1090#1072
      Hint = #1056#1072#1089#1095#1077#1090#1085#1099#1077' '#1089#1095#1077#1090#1072
      FormName = 'TBankAccountForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actBranch: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1060#1080#1083#1080#1072#1083#1099
      Hint = #1060#1080#1083#1080#1072#1083#1099
      FormName = 'TBranchForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actBusiness: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1041#1080#1079#1085#1077#1089#1099
      Hint = #1041#1080#1079#1085#1077#1089#1099
      FormName = 'TBusinessForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actCash: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1050#1072#1089#1089#1072
      Hint = #1050#1072#1089#1089#1072
      FormName = 'TCashForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actContractKind: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1042#1080#1076#1099' '#1076#1086#1075#1086#1074#1086#1088#1086#1074
      Hint = #1042#1080#1076#1099' '#1076#1086#1075#1086#1074#1086#1088#1086#1074
      FormName = 'TContractKindForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actContractConditionValue: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1044#1086#1075#1086#1074#1086#1088#1072' ('#1089' '#1091#1089#1083#1086#1074#1080#1103#1084#1080')'
      Hint = #1044#1086#1075#1086#1074#1086#1088#1072' ('#1089' '#1091#1089#1083#1086#1074#1080#1103#1084#1080')'
      FormName = 'TContractConditionValueForm'
      FormNameParam.Value = 'TContractConditionValueForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actContract: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1044#1086#1075#1086#1074#1086#1088#1072
      Hint = #1044#1086#1075#1086#1074#1086#1088#1072
      FormName = 'TContractForm'
      FormNameParam.Value = 'TContractForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actContractArticle: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1055#1088#1077#1076#1084#1077#1090' '#1076#1086#1075#1086#1074#1086#1088#1072
      Hint = #1055#1088#1077#1076#1084#1077#1090' '#1076#1086#1075#1086#1074#1086#1088#1072
      FormName = 'TContractArticleForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actArea: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1056#1077#1075#1080#1086#1085#1099
      Hint = #1056#1077#1075#1080#1086#1085#1099
      FormName = 'TAreaForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actCurrency: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1042#1072#1083#1102#1090#1099
      Hint = #1042#1072#1083#1102#1090#1099
      FormName = 'TCurrencyForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actGoods_List: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1058#1086#1074#1072#1088#1099' ('#1089#1087#1080#1089#1086#1082')'
      Hint = #1058#1086#1074#1072#1088#1099
      FormName = 'TGoodsForm'
      FormNameParam.Value = 'TGoodsForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actGoods: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1058#1086#1074#1072#1088#1099
      Hint = #1058#1086#1074#1072#1088#1099
      FormName = 'TGoodsTreeForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actGoodsGroup: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1043#1088#1091#1087#1087#1099' '#1090#1086#1074#1072#1088#1086#1074
      Hint = #1043#1088#1091#1087#1087#1099' '#1090#1086#1074#1072#1088#1086#1074
      FormName = 'TGoodsGroupForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actGoodsKind: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1042#1080#1076#1099' '#1090#1086#1074#1072#1088#1086#1074
      Hint = #1042#1080#1076#1099' '#1090#1086#1074#1072#1088#1086#1074
      FormName = 'TGoodsKindForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actGoodsProperty: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1050#1083#1072#1089#1089#1080#1092#1080#1082#1072#1090#1086#1088' '#1089#1074#1086#1081#1089#1090#1074' '#1090#1086#1074#1072#1088#1086#1074
      Hint = #1050#1083#1072#1089#1089#1080#1092#1080#1082#1072#1090#1086#1088' '#1089#1074#1086#1081#1089#1090#1074' '#1090#1086#1074#1072#1088#1086#1074
      FormName = 'TGoodsPropertyForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actGoodsPropertyValue: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1047#1085#1072#1095#1077#1085#1080#1103' '#1076#1083#1103' '#1089#1074#1086#1081#1089#1090#1074' '#1090#1086#1074#1072#1088#1086#1074
      Hint = #1047#1085#1072#1095#1077#1085#1080#1103' '#1076#1083#1103' '#1089#1074#1086#1081#1089#1090#1074' '#1090#1086#1074#1072#1088#1086#1074
      FormName = 'TGoodsPropertyValueForm'
      FormNameParam.Value = 'TGoodsPropertyValueForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actJuridical_List: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1070#1088#1080#1076#1080#1095#1077#1089#1082#1080#1077' '#1083#1080#1094#1072' ('#1089#1087#1080#1089#1086#1082')'
      Hint = #1070#1088#1080#1076#1080#1095#1077#1089#1082#1080#1077' '#1083#1080#1094#1072
      FormName = 'TJuridicalForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actJuridical: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1070#1088#1080#1076#1080#1095#1077#1089#1082#1080#1077' '#1083#1080#1094#1072
      Hint = #1070#1088#1080#1076#1080#1095#1077#1089#1082#1080#1077' '#1083#1080#1094#1072
      FormName = 'TJuridicalTreeForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actJuridicalGroup: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1043#1088#1091#1087#1087#1099' '#1102#1088#1080#1076#1080#1095#1077#1089#1082#1080#1093' '#1083#1080#1094
      Hint = #1043#1088#1091#1087#1087#1099' '#1102#1088#1080#1076#1080#1095#1077#1089#1082#1080#1093' '#1083#1080#1094
      FormName = 'TJuridicalGroupForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actMeasure: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1045#1076#1080#1085#1080#1094#1099' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
      Hint = #1045#1076#1080#1085#1080#1094#1099' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
      FormName = 'TMeasureForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actPaidKind: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1042#1080#1076#1099' '#1092#1086#1088#1084' '#1086#1087#1083#1072#1090#1099
      Hint = #1042#1080#1076#1099' '#1092#1086#1088#1084' '#1086#1087#1083#1072#1090#1099
      FormName = 'TPaidKindForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actPartner: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090#1099
      Hint = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090#1099
      FormName = 'TPartnerForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actUnit_List: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103' ('#1089#1087#1080#1089#1086#1082')'
      Hint = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103
      FormName = 'TUnitForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actUnit: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103
      Hint = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103
      FormName = 'TUnitTreeForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actPriceList: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1055#1088#1072#1081#1089'-'#1083#1080#1089#1090#1099
      Hint = #1055#1088#1072#1081#1089'-'#1083#1080#1089#1090#1099
      FormName = 'TPriceListForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actInfoMoneyGroup: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1043#1088#1091#1087#1087#1099' '#1091#1087#1088#1072#1074#1083#1077#1085#1095#1077#1089#1082#1080#1093' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1081
      Hint = #1043#1088#1091#1087#1087#1099' '#1091#1087#1088#1072#1074#1083#1077#1085#1095#1077#1089#1082#1080#1093' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1081
      FormName = 'TInfoMoneyGroupForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actInfoMoneyDestination: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1059#1087#1088#1072#1074#1083#1077#1085#1095#1077#1089#1082#1080#1077' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1103
      Hint = #1059#1087#1088#1072#1074#1083#1077#1085#1095#1077#1089#1082#1080#1077' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1103
      FormName = 'TInfoMoneyDestinationForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actInfoMoney: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1057#1090#1072#1090#1100#1080' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1103
      Hint = #1057#1090#1072#1090#1100#1080' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1103
      FormName = 'TInfoMoneyForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actAccountGroup: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1043#1088#1091#1087#1087#1099' '#1089#1095#1077#1090#1086#1074
      Hint = #1043#1088#1091#1087#1087#1099' '#1089#1095#1077#1090#1086#1074
      FormName = 'TAccountGroupForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actAccountDirection: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1040#1085#1072#1083#1080#1090#1080#1082#1080' '#1089#1095#1077#1090#1086#1074' - '#1085#1072#1087#1088#1072#1074#1083#1077#1085#1080#1103
      Hint = #1040#1085#1072#1083#1080#1090#1080#1082#1080' '#1089#1095#1077#1090#1086#1074' - '#1085#1072#1087#1088#1072#1074#1083#1077#1085#1080#1103
      FormName = 'TAccountDirectionForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actProfitLossGroup: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1043#1088#1091#1087#1087#1099' '#1089#1090#1072#1090#1077#1081' '#1086#1090#1095#1077#1090#1072' '#1086' '#1087#1088#1080#1073#1099#1083#1103#1093' '#1080' '#1091#1073#1099#1090#1082#1072#1093
      Hint = #1043#1088#1091#1087#1087#1099' '#1089#1090#1072#1090#1077#1081' '#1086#1090#1095#1077#1090#1072' '#1086' '#1087#1088#1080#1073#1099#1083#1103#1093' '#1080' '#1091#1073#1099#1090#1082#1072#1093
      FormName = 'TProfitLossGroupForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actProfitLossDirection: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1040#1085#1072#1083#1080#1090#1080#1082#1080' '#1089#1090#1072#1090#1077#1081' '#1086#1090#1095#1077#1090#1072' '#1086' '#1087#1088#1080#1073#1099#1083#1103#1093' '#1080' '#1091#1073#1099#1090#1082#1072#1093' - '#1085#1072#1087#1088#1072#1074#1083#1077#1085#1080#1103
      Hint = #1040#1085#1072#1083#1080#1090#1080#1082#1080' '#1089#1090#1072#1090#1077#1081' '#1086#1090#1095#1077#1090#1072' '#1086' '#1087#1088#1080#1073#1099#1083#1103#1093' '#1080' '#1091#1073#1099#1090#1082#1072#1093' - '#1085#1072#1087#1088#1072#1074#1083#1077#1085#1080#1103
      FormName = 'TProfitLossDirectionForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actAccount: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1057#1095#1077#1090#1072
      Hint = #1057#1095#1077#1090#1072
      FormName = 'TAccountForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actProfitLoss: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1057#1090#1072#1090#1100#1080' '#1086#1090#1095#1077#1090#1072' '#1086' '#1087#1088#1080#1073#1099#1083#1103#1093' '#1080' '#1091#1073#1099#1090#1082#1072#1093
      Hint = #1057#1090#1072#1090#1100#1080' '#1086#1090#1095#1077#1090#1072' '#1086' '#1087#1088#1080#1073#1099#1083#1103#1093' '#1080' '#1091#1073#1099#1090#1082#1072#1093
      FormName = 'TProfitLossForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actTradeMark: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1058#1086#1088#1075#1086#1074#1099#1077' '#1084#1072#1088#1082#1080
      Hint = #1058#1086#1088#1075#1086#1074#1099#1077' '#1084#1072#1088#1082#1080
      FormName = 'TTradeMarkForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actRouteSorting: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1082#1080' '#1084#1072#1088#1096#1088#1091#1090#1086#1074
      Hint = #1057#1086#1088#1090#1080#1088#1086#1074#1082#1080' '#1084#1072#1088#1096#1088#1091#1090#1086#1074
      FormName = 'TRouteSortingForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actOrderExternal: TdsdOpenForm
      Category = #1058#1086#1074#1072#1088#1085#1099#1081' '#1091#1095#1077#1090
      MoveParams = <>
      Caption = #1047#1072#1103#1074#1082#1072' '#1086#1090' '#1087#1086#1082#1091#1087#1072#1090#1077#1083#1103
      FormName = 'TOrderExternalJournalForm'
      FormNameParam.Value = 'TOrderExternalJournalForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actPriceListItem: TdsdOpenForm
      Category = #1048#1089#1090#1086#1088#1080#1080
      MoveParams = <>
      Caption = #1048#1089#1090#1086#1088#1080#1080' '#1094#1077#1085' '#1090#1086#1074#1072#1088#1086#1074
      Hint = #1048#1089#1090#1086#1088#1080#1080' '#1094#1077#1085' '#1090#1086#1074#1072#1088#1086#1074
      FormName = 'TPriceListItemForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actOrderInternal: TdsdOpenForm
      Category = #1058#1086#1074#1072#1088#1085#1099#1081' '#1091#1095#1077#1090
      MoveParams = <>
      Caption = #1047#1072#1103#1074#1082#1072' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1077#1085#1085#1072#1103
      FormName = 'TOrderInternalJournalForm'
      FormNameParam.Value = 'TOrderInternalJournalForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actCashOperation: TdsdOpenForm
      Category = #1060#1080#1085#1072#1085#1089#1086#1074#1099#1081' '#1091#1095#1077#1090
      MoveParams = <>
      Caption = #1050#1072#1089#1089#1072', '#1087#1088#1080#1093#1086#1076'/'#1088#1072#1089#1093#1086#1076
      Hint = #1054#1087#1077#1088#1072#1094#1080#1080' '#1089' '#1082#1072#1089#1089#1086#1081
      FormName = 'TCashJournalForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actReport_MotionGoods: TdsdOpenForm
      Category = #1054#1090#1095#1077#1090#1099' ('#1090#1086#1074'.)'
      MoveParams = <>
      Caption = #1044#1074#1080#1078#1077#1085#1080#1077' '#1090#1086#1074#1072#1088#1072
      FormName = 'TReport_MotionGoodsForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actRole: TdsdOpenForm
      Category = #1057#1083#1091#1078#1077#1073#1085#1099#1077
      MoveParams = <>
      Caption = #1056#1086#1083#1080' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      FormName = 'TRoleForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actAction: TdsdOpenForm
      Category = #1057#1083#1091#1078#1077#1073#1085#1099#1077
      MoveParams = <>
      Caption = #1044#1077#1081#1089#1090#1074#1080#1103
      Hint = #1044#1077#1081#1089#1090#1074#1080#1103
      FormName = 'TActionForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actUser: TdsdOpenForm
      Category = #1057#1083#1091#1078#1077#1073#1085#1099#1077
      MoveParams = <>
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
      Hint = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
      FormName = 'TUserForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actRateFuel: TdsdOpenForm
      Category = #1058#1088#1072#1085#1089#1087#1086#1088#1090
      MoveParams = <>
      Caption = #1053#1086#1088#1084#1099' '#1090#1086#1087#1083#1080#1074#1072
      Hint = #1053#1086#1088#1084#1099' '#1090#1086#1087#1083#1080#1074#1072
      FormName = 'TRateFuelForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actFreight: TdsdOpenForm
      Category = #1058#1088#1072#1085#1089#1087#1086#1088#1090
      MoveParams = <>
      Caption = #1053#1072#1079#1074#1072#1085#1080#1103' '#1075#1088#1091#1079#1086#1074
      Hint = #1053#1072#1079#1074#1072#1085#1080#1103' '#1075#1088#1091#1079#1086#1074
      FormName = 'TFreightForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actCardFuel: TdsdOpenForm
      Category = #1058#1088#1072#1085#1089#1087#1086#1088#1090
      MoveParams = <>
      Caption = #1058#1086#1087#1083#1080#1074#1085#1099#1077' '#1082#1072#1088#1090#1099
      Hint = #1058#1086#1087#1083#1080#1074#1085#1099#1077' '#1082#1072#1088#1090#1099
      FormName = 'TCardFuelForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actTicketFuel: TdsdOpenForm
      Category = #1058#1088#1072#1085#1089#1087#1086#1088#1090
      MoveParams = <>
      Caption = #1058#1072#1083#1086#1085#1099' '#1085#1072' '#1090#1086#1087#1083#1080#1074#1086' '
      Hint = #1058#1072#1083#1086#1085#1099' '#1085#1072' '#1090#1086#1087#1083#1080#1074#1086' '
      FormName = 'TTicketFuelForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actReport_Fuel: TdsdOpenForm
      Category = #1058#1088#1072#1085#1089#1087#1086#1088#1090
      MoveParams = <>
      Caption = #1042#1077#1076#1086#1084#1086#1089#1090#1100' '#1088#1072#1089#1093#1086#1076#1072' '#1090#1086#1087#1083#1080#1074#1072
      Hint = #1042#1077#1076#1086#1084#1086#1089#1090#1100' '#1088#1072#1089#1093#1086#1076#1072' '#1090#1086#1087#1083#1080#1074#1072
      FormName = 'TReport_FuelForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actReport_Transport: TdsdOpenForm
      Category = #1058#1088#1072#1085#1089#1087#1086#1088#1090
      MoveParams = <>
      Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1087#1091#1090#1077#1074#1099#1084' '#1083#1080#1089#1090#1072#1084
      Hint = #1054#1090#1095#1077#1090' '#1087#1086' '#1087#1091#1090#1077#1074#1099#1084' '#1083#1080#1089#1090#1072#1084
      FormName = 'TReport_TransportForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actReport_TransportHoursWork: TdsdOpenForm
      Category = #1058#1088#1072#1085#1089#1087#1086#1088#1090
      MoveParams = <>
      Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1074#1086#1076#1080#1090#1077#1083#1103#1084' ('#1088#1072#1073#1086#1095#1077#1077' '#1074#1088#1077#1084#1103')'
      Hint = #1054#1090#1095#1077#1090' '#1087#1086' '#1074#1086#1076#1080#1090#1077#1083#1103#1084' ('#1088#1072#1073#1086#1095#1077#1077' '#1074#1088#1077#1084#1103')'
      FormName = 'TReport_TransportHoursWorkForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actWorkTimeKind: TdsdOpenForm
      Category = #1055#1077#1088#1089#1086#1085#1072#1083
      MoveParams = <>
      Caption = #1058#1080#1087#1099' '#1088#1072#1073#1086#1095#1077#1075#1086' '#1074#1088#1077#1084#1077#1085#1080
      Hint = #1058#1080#1087#1099' '#1088#1072#1073#1086#1095#1077#1075#1086' '#1074#1088#1077#1084#1077#1085#1080
      FormName = 'TWorkTimeKindForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actSheetWorkTime: TdsdOpenForm
      Category = #1055#1077#1088#1089#1086#1085#1072#1083
      MoveParams = <>
      Caption = #1058#1072#1073#1077#1083#1100' '#1091#1095#1077#1090#1072' '#1088#1072#1073#1086#1095#1077#1075#1086' '#1074#1088#1077#1084#1077#1085#1080
      Hint = #1058#1072#1073#1077#1083#1100' '#1091#1095#1077#1090#1072' '#1088#1072#1073#1086#1095#1077#1075#1086' '#1074#1088#1077#1084#1077#1085#1080
      FormName = 'TSheetWorkTimeJournalForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actPersonalService: TdsdOpenForm
      Category = #1055#1077#1088#1089#1086#1085#1072#1083
      MoveParams = <>
      Caption = #1053#1072#1095#1080#1089#1083#1077#1085#1080#1077' '#1079#1072#1088#1087#1083#1072#1090#1099
      Hint = #1053#1072#1095#1080#1089#1083#1077#1085#1080#1077' '#1079#1072#1088#1087#1083#1072#1090#1099
      FormName = 'TPersonalServiceForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actReport_Account: TdsdOpenForm
      Category = #1058#1088#1072#1085#1089#1087#1086#1088#1090
      MoveParams = <>
      Caption = #1054#1073#1086#1088#1086#1090#1099' '#1087#1086' '#1089#1095#1077#1090#1091
      Hint = #1054#1090#1095#1077#1090' '#1087#1086' '#1089#1095#1077#1090#1091
      FormName = 'TReport_AccountForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actReport_GoodsTax: TdsdOpenForm
      Category = #1054#1090#1095#1077#1090#1099' ('#1090#1086#1074'.)'
      MoveParams = <>
      Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1090#1086#1074#1072#1088#1091'  ('#1053#1072#1083#1086#1075#1086#1074#1099#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099')'
      Hint = #1054#1090#1095#1077#1090' '#1087#1086' '#1090#1086#1074#1072#1088#1091'  ('#1053#1072#1083#1086#1075#1086#1074#1099#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099')'
      FormName = 'TReport_GoodsTaxForm'
      FormNameParam.Value = 'TReport_GoodsTaxForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actPositionLevel: TdsdOpenForm
      Category = #1055#1077#1088#1089#1086#1085#1072#1083
      MoveParams = <>
      Caption = #1056#1072#1079#1088#1103#1076#1099' '#1076#1086#1083#1078#1085#1086#1089#1090#1077#1081' '
      Hint = #1056#1072#1079#1088#1103#1076#1099' '#1076#1086#1083#1078#1085#1086#1089#1090#1077#1081' '
      FormName = 'TPositionLevelForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actModelService: TdsdOpenForm
      Category = #1055#1077#1088#1089#1086#1085#1072#1083
      MoveParams = <>
      Caption = #1052#1086#1076#1077#1083#1080' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1103
      Hint = #1052#1086#1076#1077#1083#1080' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1103
      FormName = 'TModelServiceForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actProtocol: TdsdOpenForm
      Category = #1057#1083#1091#1078#1077#1073#1085#1099#1077
      MoveParams = <>
      Caption = #1055#1088#1086#1090#1086#1082#1086#1083
      Hint = #1055#1088#1086#1090#1086#1082#1086#1083
      FormName = 'TProtocolForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actService: TdsdOpenForm
      Category = #1060#1080#1085#1072#1085#1089#1086#1074#1099#1081' '#1091#1095#1077#1090
      MoveParams = <>
      Caption = #1053#1072#1095#1080#1089#1083#1077#1085#1080#1077' '#1091#1089#1083#1091#1075
      FormName = 'TServiceJournalForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actBankLoad: TdsdOpenForm
      Category = #1060#1080#1085#1072#1085#1089#1086#1074#1099#1081' '#1091#1095#1077#1090
      MoveParams = <>
      Caption = #1041#1072#1085#1082#1086#1074#1089#1082#1080#1077' '#1074#1099#1087#1080#1089#1082#1080
      FormName = 'TBankStatementJournalForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actBankAccountDocument: TdsdOpenForm
      Category = #1060#1080#1085#1072#1085#1089#1086#1074#1099#1081' '#1091#1095#1077#1090
      MoveParams = <>
      Caption = #1056#1072#1089#1095#1077#1090#1085#1099#1081' '#1089#1095#1077#1090', '#1087#1088#1080#1093#1086#1076'/'#1088#1072#1089#1093#1086#1076
      FormName = 'TBankAccountJournalForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actSetUserDefaults: TdsdOpenForm
      Category = #1057#1083#1091#1078#1077#1073#1085#1099#1077
      MoveParams = <>
      Caption = #1044#1077#1092#1086#1083#1090#1099' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
      Hint = #1044#1077#1092#1086#1083#1090#1099' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
      FormName = 'TSetUserDefaultsForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actLossDebt: TdsdOpenForm
      Category = #1060#1080#1085#1072#1085#1089#1086#1074#1099#1081' '#1091#1095#1077#1090
      MoveParams = <>
      Caption = #1050#1086#1088#1088#1077#1082#1090#1080#1088#1086#1074#1082#1072' '#1079#1072#1076#1086#1083#1078#1077#1085#1085#1086#1089#1090#1080' ('#1102#1088'.'#1083#1080#1094#1072')'
      FormName = 'TLossDebtJournalForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actCity: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1043#1086#1088#1086#1076#1072
      Hint = #1043#1086#1088#1086#1076#1072
      FormName = 'TCityForm'
      FormNameParam.Value = 'TCityForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actReport_JuridicalCollation: TdsdOpenForm
      Category = #1054#1090#1095#1077#1090#1099' ('#1092#1080#1085'.)'
      MoveParams = <>
      Caption = #1040#1082#1090' '#1089#1074#1077#1088#1082#1080
      FormName = 'TReport_JuridicalCollationForm'
      FormNameParam.Value = ''
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actMovementDesc: TdsdOpenForm
      Category = #1057#1083#1091#1078#1077#1073#1085#1099#1077
      MoveParams = <>
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
      FormName = 'TMovementDescDataForm'
      FormNameParam.Value = 'TMovementDescDataForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actReport_GoodsMISale: TdsdOpenForm
      Category = #1054#1090#1095#1077#1090#1099' ('#1090#1086#1074'.)'
      MoveParams = <>
      Caption = #1055#1088#1086#1076#1072#1078#1072' '#1087#1086#1082#1091#1087#1072#1090#1077#1083#1102
      FormName = 'TReport_GoodsMIForm'
      FormNameParam.Value = 'TReport_GoodsMIForm'
      FormNameParam.DataType = ftString
      FormNameParam.ParamType = ptResult
      GuiParams = <
        item
          Name = 'inDescId'
          Value = 5
        end
        item
          Name = 'inDescName'
          Value = #1055#1088#1086#1076#1072#1078#1072' '#1087#1086#1082#1091#1087#1072#1090#1077#1083#1102
          DataType = ftString
        end>
      isShowModal = False
    end
    object actReport_GoodsMIReturn: TdsdOpenForm
      Category = #1054#1090#1095#1077#1090#1099' ('#1090#1086#1074'.)'
      MoveParams = <>
      Caption = #1042#1086#1079#1074#1088#1072#1090' '#1086#1090' '#1087#1086#1082#1091#1087#1072#1090#1077#1083#1103
      FormName = 'TReport_GoodsMIForm'
      FormNameParam.Value = 'TReport_GoodsMIForm'
      FormNameParam.DataType = ftString
      GuiParams = <
        item
          Name = 'inDescId'
          Value = 6
        end
        item
          Name = 'inDescName'
          Value = #1042#1086#1079#1074#1088#1072#1090' '#1086#1090' '#1087#1086#1082#1091#1087#1072#1090#1077#1083#1103
          DataType = ftString
        end>
      isShowModal = False
    end
    object actSendDebt: TdsdOpenForm
      Category = #1060#1080#1085#1072#1085#1089#1086#1074#1099#1081' '#1091#1095#1077#1090
      MoveParams = <>
      Caption = #1042#1079#1072#1080#1084#1086#1079#1072#1095#1077#1090' ('#1070#1088'. '#1083#1080#1094#1072')'
      FormName = 'TSendDebtJournalForm'
      FormNameParam.Value = 'TSendDebtJournalForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actPartner1CLink: TdsdOpenForm
      Category = #1057#1083#1091#1078#1077#1073#1085#1099#1077
      MoveParams = <>
      Caption = #1057#1074#1103#1079#1100' '#1090#1086#1095#1077#1082' '#1076#1086#1089#1090#1072#1074#1082#1080' '#1089' 1'#1057
      FormName = 'TPartner1CLinkForm'
      FormNameParam.Value = 'TPartner1CLinkForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actGoodsByGoodsKind1CLink: TdsdOpenForm
      Category = #1057#1083#1091#1078#1077#1073#1085#1099#1077
      MoveParams = <>
      Caption = #1057#1074#1103#1079#1100' '#1090#1086#1074#1072#1088#1086#1074' '#1089' 1'#1057
      FormName = 'TGoodsByGoodsKind1CLinkForm'
      FormNameParam.Value = 'TGoodsByGoodsKind1CLinkForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actLoad1CSale: TdsdOpenForm
      Category = #1057#1083#1091#1078#1077#1073#1085#1099#1077
      MoveParams = <>
      Caption = #1047#1072#1075#1088#1091#1079#1082#1072' '#1088#1072#1089#1093#1086#1076#1085#1099#1093' '#1085#1072#1082#1083#1072#1076#1085#1099#1093
      FormName = 'TLoadSaleFrom1CForm'
      FormNameParam.Value = 'TLoadSaleFrom1CForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actReport_GoodsMI_byMovementSale: TdsdOpenForm
      Category = #1054#1090#1095#1077#1090#1099' ('#1090#1086#1074'.)'
      MoveParams = <>
      Caption = #1055#1088#1086#1076#1072#1078#1072' '#1087#1086#1082#1091#1087#1072#1090#1077#1083#1102' ('#1087#1086' '#1085#1072#1082#1083#1072#1076#1085#1099#1084')'
      FormName = 'TReport_GoodsMI_byMovementForm'
      FormNameParam.Value = 'TReport_GoodsMI_byMovementForm'
      FormNameParam.DataType = ftString
      FormNameParam.ParamType = ptResult
      GuiParams = <
        item
          Name = 'inDescId'
          Value = 5
        end
        item
          Name = 'InDescName'
          Value = #1055#1088#1086#1076#1072#1078#1072' '#1087#1086#1082#1091#1087#1072#1090#1077#1083#1102
          DataType = ftString
        end>
      isShowModal = False
    end
    object actReport_GoodsMI_byMovementReturn: TdsdOpenForm
      Category = #1054#1090#1095#1077#1090#1099' ('#1090#1086#1074'.)'
      MoveParams = <>
      Caption = #1042#1086#1079#1074#1088#1072#1090' '#1086#1090' '#1087#1086#1082#1091#1087#1072#1090#1077#1083#1103' ('#1087#1086' '#1085#1072#1082#1083#1072#1076#1085#1099#1084')'
      FormName = 'TReport_GoodsMI_byMovementForm'
      FormNameParam.Value = 'TReport_GoodsMI_byMovementForm'
      FormNameParam.DataType = ftString
      GuiParams = <
        item
          Name = 'inDescId'
          Value = 6
        end
        item
          Name = 'inDescName'
          Value = #1042#1086#1079#1074#1088#1072#1090' '#1086#1090' '#1087#1086#1082#1091#1087#1072#1090#1077#1083#1103
          DataType = ftString
        end>
      isShowModal = False
    end
    object actReport_GoodsMI_SaleReturnIn: TdsdOpenForm
      Category = #1054#1090#1095#1077#1090#1099' ('#1090#1086#1074'.)'
      MoveParams = <>
      Caption = #1055#1088#1086#1076#1072#1078#1072' / '#1042#1086#1079#1074#1088#1072#1090' '#1087#1086' '#1087#1086#1082#1091#1087#1072#1090#1077#1083#1103#1084
      FormName = 'TReport_GoodsMI_SaleReturnInForm'
      FormNameParam.Value = 'TReport_GoodsMI_SaleReturnInForm'
      FormNameParam.DataType = ftString
      FormNameParam.ParamType = ptResult
      GuiParams = <>
      isShowModal = False
    end
    object actReport_Production_Union: TdsdOpenForm
      Category = #1054#1090#1095#1077#1090#1099' ('#1087#1088'-'#1074#1086')'
      MoveParams = <>
      Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1086' '#1087#1088#1086#1076#1091#1082#1094#1080#1080
      FormName = 'TReport_Production_Union'
      FormNameParam.Value = 'TReport_Production_Union'
      FormNameParam.DataType = ftString
      FormNameParam.ParamType = ptResult
      GuiParams = <>
      isShowModal = False
    end
    object actReport_GoodsMI_Income: TdsdOpenForm
      Category = #1054#1090#1095#1077#1090#1099' ('#1090#1086#1074'.)'
      MoveParams = <>
      Caption = #1055#1088#1080#1093#1086#1076' '#1086#1090' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1072
      FormName = 'TReport_GoodsMI_IncomeForm'
      FormNameParam.Value = 'TReport_GoodsMI_IncomeForm'
      FormNameParam.DataType = ftString
      FormNameParam.ParamType = ptResult
      GuiParams = <
        item
          Name = 'inDescId'
          Value = 1
        end
        item
          Name = 'InDescName'
          Value = #1055#1088#1080#1093#1086#1076' '#1086#1090' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1086#1074' ('#1080#1090#1086#1075')'
          DataType = ftString
        end>
      isShowModal = False
    end
    object actReport_GoodsMI_IncomeByPartner: TdsdOpenForm
      Category = #1054#1090#1095#1077#1090#1099' ('#1090#1086#1074'.)'
      MoveParams = <>
      Caption = #1055#1088#1080#1093#1086#1076' '#1087#1086' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1072#1084
      FormName = 'TReport_GoodsMI_IncomeByPartnerForm'
      FormNameParam.Value = 'TReport_GoodsMI_IncomeByPartnerForm'
      FormNameParam.DataType = ftString
      FormNameParam.ParamType = ptResult
      GuiParams = <
        item
          Name = 'inDescId'
          Value = 1
        end
        item
          Name = 'InDescName'
          Value = #1055#1088#1080#1093#1086#1076' '#1086#1090' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1086#1074
          DataType = ftString
        end>
      isShowModal = False
    end
    object actTax: TdsdOpenForm
      Category = #1053#1072#1083#1086#1075#1086#1074#1099#1081' '#1091#1095#1077#1090
      MoveParams = <>
      Caption = #1053#1072#1083#1086#1075#1086#1074#1099#1077' '#1085#1072#1082#1083#1072#1076#1085#1099#1077
      FormName = 'TTaxJournalForm'
      FormNameParam.Name = 'TTaxJournalForm'
      FormNameParam.Value = 'TTaxJournalForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actTaxCorrection: TdsdOpenForm
      Category = #1053#1072#1083#1086#1075#1086#1074#1099#1081' '#1091#1095#1077#1090
      MoveParams = <>
      Caption = #1050#1086#1088#1088#1077#1082#1090#1080#1088#1086#1074#1082#1080' '#1082' '#1085#1072#1083#1086#1075#1086#1074#1099#1084' '#1085#1072#1082#1083#1072#1076#1085#1099#1084
      FormName = 'TTaxCorrectiveJournalForm'
      FormNameParam.Name = 'TTaxCorrectiveJournalForm'
      FormNameParam.Value = 'TTaxCorrectiveJournalForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actCountry: TdsdOpenForm
      Category = #1054#1057
      MoveParams = <>
      Caption = #1057#1090#1088#1072#1085#1099'-'#1087#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100' '#1054#1057
      Hint = #1057#1090#1088#1072#1085#1099
      FormName = 'TCountryForm'
      FormNameParam.Value = 'TCountryForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actReport_CheckTax: TdsdOpenForm
      Category = #1053#1072#1083#1086#1075#1086#1074#1099#1081' '#1091#1095#1077#1090
      MoveParams = <>
      Caption = #1055#1088#1086#1074#1077#1088#1082#1072' '#1053#1072#1083#1086#1075#1086#1074#1099#1093' '#1085#1072#1082#1083#1072#1076#1085#1099#1093
      FormName = 'TReport_CheckTaxForm'
      FormNameParam.Value = 'TReport_CheckTaxForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actProfitLossService: TdsdOpenForm
      Category = #1060#1080#1085#1072#1085#1089#1086#1074#1099#1081' '#1091#1095#1077#1090
      MoveParams = <>
      Caption = 'actProfitLossService'
      FormName = 'TProfitLossServiceJournalForm'
      FormNameParam.Name = 'TProfitLossServiceJournalForm'
      FormNameParam.Value = 'TProfitLossServiceJournalForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actReport_CheckTaxCorrective: TdsdOpenForm
      Category = #1053#1072#1083#1086#1075#1086#1074#1099#1081' '#1091#1095#1077#1090
      MoveParams = <>
      Caption = #1055#1088#1086#1074#1077#1088#1082#1072' '#1050#1086#1088#1088#1077#1082#1090#1080#1088#1086#1074#1086#1082' '#1082' '#1085#1072#1083#1086#1075#1086#1074#1099#1084' '#1085#1072#1082#1083#1072#1076#1085#1099#1084
      FormName = 'TReport_CheckTaxCorrectiveForm'
      FormNameParam.Value = 'TReport_CheckTaxCorrectiveForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actPeriodClose: TdsdOpenForm
      Category = #1057#1083#1091#1078#1077#1073#1085#1099#1077
      MoveParams = <>
      Caption = #1047#1072#1082#1088#1099#1090#1080#1077' '#1087#1077#1088#1080#1086#1076#1072
      FormName = 'TPeriodCloseForm'
      FormNameParam.Value = 'TPeriodCloseForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actSaveTaxDocument: TdsdOpenForm
      Category = #1057#1083#1091#1078#1077#1073#1085#1099#1077
      MoveParams = <>
      Caption = #1042#1099#1075#1088#1091#1079#1082#1072' '#1085#1072#1083#1086#1075#1086#1074#1099#1093' '#1085#1072#1082#1083#1072#1076#1085#1099#1093
      FormName = 'TSaveTaxDocumentForm'
      FormNameParam.Value = 'TSaveTaxDocumentForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actToolsWeighingTree: TdsdOpenForm
      Category = #1057#1083#1091#1078#1077#1073#1085#1099#1077
      MoveParams = <>
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1074#1079#1074#1077#1096#1080#1074#1072#1085#1080#1103
      Hint = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1074#1079#1074#1077#1096#1080#1074#1072#1085#1080#1103
      FormName = 'TToolsWeighingTreeForm'
      FormNameParam.Value = 'TToolsWeighingTreeForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actWeighingPartner: TdsdOpenForm
      Category = #1058#1086#1074#1072#1088#1085#1099#1081' '#1091#1095#1077#1090
      MoveParams = <>
      Caption = #1042#1079#1074#1077#1096#1080#1074#1072#1085#1080#1077' ('#1082#1086#1085#1090#1088#1072#1075#1077#1085#1090')'
      FormName = 'TWeighingPartnerJournalForm'
      FormNameParam.Value = 'TWeighingPartnerJournalForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actWeighingProduction: TdsdOpenForm
      Category = #1058#1086#1074#1072#1088#1085#1099#1081' '#1091#1095#1077#1090
      MoveParams = <>
      Caption = #1042#1079#1074#1077#1096#1080#1074#1072#1085#1080#1077' ('#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1086')'
      FormName = 'TWeighingProductionJournalForm'
      FormNameParam.Value = 'TWeighingProductionJournalForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actReport_CheckBonus: TdsdOpenForm
      Category = #1054#1090#1095#1077#1090#1099' ('#1092#1080#1085'.)'
      MoveParams = <>
      Caption = #1055#1088#1086#1074#1077#1088#1082#1072' '#1085#1072#1095#1080#1089#1083#1077#1085#1080#1081' '#1087#1086' '#1073#1086#1085#1091#1089#1072#1084
      FormName = 'TReport_CheckBonusForm'
      FormNameParam.Value = 'TReport_CheckBonusForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actGoodsKindWeighing: TdsdOpenForm
      Category = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      MoveParams = <>
      Caption = #1042#1080#1076#1099' '#1091#1087#1072#1082#1086#1074#1082#1080' '#1076#1083#1103' '#1074#1079#1074#1077#1096#1080#1074#1072#1085#1080#1103
      Hint = #1042#1080#1076#1099' '#1091#1087#1072#1082#1086#1074#1082#1080' '#1076#1083#1103' '#1074#1079#1074#1077#1096#1080#1074#1072#1085#1080#1103
      FormName = 'TGoodsKindWeighingTreeForm'
      FormNameParam.Value = 'TGoodsKindWeighingTreeForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actReport_GoodsMI_byMovementDifSale: TdsdOpenForm
      Category = #1054#1090#1095#1077#1090#1099' ('#1090#1086#1074'.)'
      MoveParams = <>
      Caption = #1055#1088#1086#1076#1072#1078#1072' '#1087#1086#1082#1091#1087#1072#1090#1077#1083#1102' ('#1088#1072#1079#1085#1080#1094#1072' '#1074' '#1085#1072#1082#1083#1072#1076#1085#1099#1093')'
      FormName = 'TReport_GoodsMI_byMovementDifForm'
      FormNameParam.Value = 'TReport_GoodsMI_byMovementDifForm'
      FormNameParam.DataType = ftString
      FormNameParam.ParamType = ptResult
      GuiParams = <
        item
          Name = 'inDescId'
          Value = 5
        end
        item
          Name = 'InDescName'
          Value = #1055#1088#1086#1076#1072#1078#1072' '#1087#1086#1082#1091#1087#1072#1090#1077#1083#1102
          DataType = ftString
        end>
      isShowModal = False
    end
    object actReport_GoodsMI_byMovementDifReturn: TdsdOpenForm
      Category = #1054#1090#1095#1077#1090#1099' ('#1090#1086#1074'.)'
      MoveParams = <>
      Caption = #1042#1086#1079#1074#1088#1072#1090' '#1086#1090' '#1087#1086#1082#1091#1087#1072#1090#1077#1083#1103' ('#1088#1072#1079#1085#1080#1094#1072' '#1074' '#1085#1072#1082#1083#1072#1076#1085#1099#1093')'
      FormName = 'TReport_GoodsMI_byMovementDifForm'
      FormNameParam.Value = 'TReport_GoodsMI_byMovementDifForm'
      FormNameParam.DataType = ftString
      FormNameParam.ParamType = ptResult
      GuiParams = <
        item
          Name = 'inDescId'
          Value = 6
        end
        item
          Name = 'InDescName'
          Value = #1042#1086#1079#1074#1088#1072#1090' '#1086#1090' '#1087#1086#1082#1091#1087#1072#1090#1077#1083#1103
          DataType = ftString
        end>
      isShowModal = False
    end
    object actReport_GoodsMI_byPriceDifSale: TdsdOpenForm
      Category = #1054#1090#1095#1077#1090#1099' ('#1090#1086#1074'.)'
      MoveParams = <>
      Caption = #1055#1088#1086#1076#1072#1078#1072' '#1087#1086#1082#1091#1087#1072#1090#1077#1083#1102' ('#1088#1072#1079#1085#1080#1094#1072' '#1074' '#1094#1077#1085#1072#1093')'
      FormName = 'TReport_GoodsMI_byPriceDifForm'
      FormNameParam.Value = 'TReport_GoodsMI_byPriceDifForm'
      FormNameParam.DataType = ftString
      FormNameParam.ParamType = ptResult
      GuiParams = <
        item
          Name = 'inDescId'
          Value = 5
        end
        item
          Name = 'InDescName'
          Value = #1055#1088#1086#1076#1072#1078#1072' '#1087#1086#1082#1091#1087#1072#1090#1077#1083#1102
          DataType = ftString
        end>
      isShowModal = False
    end
    object actReport_CheckContractInMovement: TdsdOpenForm
      Category = #1054#1090#1095#1077#1090#1099' ('#1090#1086#1074'.)'
      MoveParams = <>
      Caption = #1055#1088#1086#1074#1077#1088#1082#1072' '#1079#1072#1087#1086#1083#1085#1077#1085#1080#1103' '#1076#1086#1075#1086#1074#1086#1088#1086#1074' '#1074' '#1076#1086#1082#1091#1084#1077#1085#1090#1072#1093
      FormName = 'TReport_CheckContractInMovementForm'
      FormNameParam.Value = 'TReport_CheckContractInMovementForm'
      FormNameParam.DataType = ftString
      FormNameParam.ParamType = ptResult
      GuiParams = <
        item
          Name = 'inDescId'
          Value = 6
        end
        item
          Name = 'InDescName'
          Value = #1042#1086#1079#1074#1088#1072#1090' '#1087#1086#1082#1091#1087#1072#1090#1077#1083#1103#1084' ('#1088#1072#1079#1085#1080#1094#1072')'
          DataType = ftString
        end>
      isShowModal = False
    end
    object actTransferDebtOut: TdsdOpenForm
      Category = #1053#1072#1083#1086#1075#1086#1074#1099#1081' '#1091#1095#1077#1090
      MoveParams = <>
      Caption = #1055#1077#1088#1077#1074#1086#1076' '#1076#1086#1083#1075#1072' ('#1088#1072#1089#1093#1086#1076')'
      FormName = 'TTransferDebtOutJournalForm'
      FormNameParam.Name = 'TTransferDebtOutJournalForm'
      FormNameParam.Value = 'TTransferDebtOutJournalForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actTransferDebtIn: TdsdOpenForm
      Category = #1053#1072#1083#1086#1075#1086#1074#1099#1081' '#1091#1095#1077#1090
      MoveParams = <>
      Caption = #1055#1077#1088#1077#1074#1086#1076' '#1076#1086#1083#1075#1072' ('#1087#1088#1080#1093#1086#1076')'
      FormName = 'TTransferDebtInJournalForm'
      FormNameParam.Name = 'TTransferDebtOutJournalForm'
      FormNameParam.Value = 'TTransferDebtInJournalForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actEDI: TdsdOpenForm
      Category = #1057#1083#1091#1078#1077#1073#1085#1099#1077
      MoveParams = <>
      Caption = 'EDI'
      Hint = 'EDI'
      FormName = 'TEDIJournalForm'
      FormNameParam.Value = 'TEDIJournalForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actReport_GoodsMI_TransferDebtIn: TdsdOpenForm
      Category = #1053#1072#1083#1086#1075#1086#1074#1099#1081' '#1091#1095#1077#1090
      MoveParams = <>
      Caption = #1054#1090#1095#1077#1090' - '#1055#1077#1088#1077#1074#1086#1076' '#1076#1086#1083#1075#1072' ('#1087#1088#1080#1093#1086#1076')'
      FormName = 'TReport_GoodsMI_TransferDebtForm'
      FormNameParam.Value = 'TReport_GoodsMI_TransferDebtForm'
      FormNameParam.DataType = ftString
      FormNameParam.ParamType = ptResult
      GuiParams = <
        item
          Name = 'inDescId'
          Value = 34
        end
        item
          Name = 'inDescName'
          Value = #1055#1077#1088#1077#1074#1086#1076' '#1076#1086#1083#1075#1072' ('#1087#1088#1080#1093#1086#1076')'
          DataType = ftString
        end>
      isShowModal = False
    end
    object actReport_GoodsMI_TransferDebtOut: TdsdOpenForm
      Category = #1053#1072#1083#1086#1075#1086#1074#1099#1081' '#1091#1095#1077#1090
      MoveParams = <>
      Caption = #1054#1090#1095#1077#1090' - '#1055#1077#1088#1077#1074#1086#1076' '#1076#1086#1083#1075#1072' ('#1088#1072#1089#1093#1086#1076')'
      FormName = 'TReport_GoodsMI_TransferDebtForm'
      FormNameParam.Value = 'TReport_GoodsMI_TransferDebtForm'
      FormNameParam.DataType = ftString
      FormNameParam.ParamType = ptResult
      GuiParams = <
        item
          Name = 'inDescId'
          Value = 33
        end
        item
          Name = 'inDescName'
          Value = #1055#1077#1088#1077#1074#1086#1076' '#1076#1086#1083#1075#1072' ('#1088#1072#1089#1093#1086#1076')'
          DataType = ftString
        end>
      isShowModal = False
    end
    object actSaveDocumentTo1C: TdsdOpenForm
      Category = #1057#1083#1091#1078#1077#1073#1085#1099#1077
      MoveParams = <>
      Caption = #1042#1099#1075#1088#1091#1079#1082#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074' '#1074' 1'#1057
      Hint = #1042#1099#1075#1088#1091#1079#1082#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074' '#1074' 1'#1057
      FormName = 'TSaveDocumentTo1CForm'
      FormNameParam.Value = 'TSaveDocumentTo1CForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actReport_Goods: TdsdOpenForm
      Category = #1054#1090#1095#1077#1090#1099' ('#1090#1086#1074'.)'
      MoveParams = <>
      Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1090#1086#1074#1072#1088#1091
      Hint = #1054#1090#1095#1077#1090' '#1087#1086' '#1090#1086#1074#1072#1088#1091
      FormName = 'TReport_GoodsForm'
      FormNameParam.Value = 'TReport_GoodsForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
    object actPriceCorrective: TdsdOpenForm
      Category = #1053#1072#1083#1086#1075#1086#1074#1099#1081' '#1091#1095#1077#1090
      MoveParams = <>
      Caption = #1050#1086#1088#1088#1077#1082#1090#1080#1088#1086#1074#1082#1072' '#1094#1077#1085#1099
      FormName = 'TPriceCorrectiveJournalForm'
      FormNameParam.Name = 'TPriceCorrectiveJournalForm'
      FormNameParam.Value = 'TPriceCorrectiveJournalForm'
      FormNameParam.DataType = ftString
      GuiParams = <>
      isShowModal = False
    end
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
    Top = 56
  end
  object frxReport1: TfrxReport
    Version = '4.12'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41656.828892581000000000
    ReportOptions.LastChange = 41666.626382175900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var'
      ''
      '  JuridicalLine: Integer;'
      '  SumStartAmount, '
      '  SumEndAmount,'
      '  SumOther: real;'
      '  SumSumStartAmount, '
      '  SumSumEndAmount,'
      '  SumSumOther: real;'
      '      '
      '    '
      'procedure GroupHeader1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  JuridicalLine := JuridicalLine + 1;                           ' +
        '  '
      'end;'
      ''
      'procedure GroupFooter1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  SumStartAmount := SUM(<frxDBDataset."startamount">, MasterData' +
        '1, 1);'
      
        '  SumEndAmount := SUM(<frxDBDataset."endamount">, MasterData1, 1' +
        ');'
      
        '  SumOther := SUM(<frxDBDataset."othersumm">, MasterData1, 1);  ' +
        '                   '
      'end;'
      ''
      'procedure ReportSummary1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  SumSumStartAmount := SUM(<frxDBDataset."startamount">, MasterD' +
        'ata1, 1);'
      
        '  SumSumEndAmount := SUM(<frxDBDataset."endamount">, MasterData1' +
        ', 1);'
      
        '  SumSumOther := SUM(<frxDBDataset."othersumm">, MasterData1, 1)' +
        ';                     '
      'end;'
      ''
      'begin'
      '  JuridicalLine := 0;          '
      'end.')
    Left = 360
    Top = 88
    Datasets = <
      item
      end>
    Variables = <
      item
        Name = 'StartDate'
        Value = #39'01.01.2014'#39
      end
      item
        Name = 'EndDate'
        Value = #39'31.12.2014 23:59:00'#39
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.001250000000000000
      RightMargin = 10.001250000000000000
      TopMargin = 10.001250000000000000
      BottomMargin = 10.001250000000000000
      object MasterData1: TfrxMasterData
        Height = 20.000000000000000000
        Top = 243.000000000000000000
        Visible = False
        Width = 1046.920361175000000000
        RowCount = 0
      end
      object Header1: TfrxHeader
        Height = 31.000000000000000000
        Top = 154.000000000000000000
        Width = 1046.920361175000000000
        object Memo3: TfrxMemoView
          Top = 1.000000000000000000
          Width = 33.000000000000000000
          Height = 32.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            #8470' '#1087'/'#1087)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Left = 33.000000000000000000
          Top = 1.000000000000000000
          Width = 217.000000000000000000
          Height = 32.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            #1055#1086#1082#1091#1087#1072#1090#1077#1083#1100)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 250.000000000000000000
          Top = 1.000000000000000000
          Width = 156.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1044#1086#1083#1075' '#1085#1072#1095'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 406.000000000000000000
          Top = 1.000000000000000000
          Width = 156.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1044#1086#1083#1075' '#1082#1086#1085'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 562.000000000000000000
          Top = 17.000000000000000000
          Width = 85.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            #1055#1088#1086#1076#1072#1085#1086' '#1087#1086#1082#1091#1087'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 647.000000000000000000
          Top = 17.000000000000000000
          Width = 78.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            #1059#1089#1083#1091#1075#1080)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 803.000000000000000000
          Top = 17.000000000000000000
          Width = 78.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            #1055#1088#1080#1093#1086#1076' '#1076#1077#1085#1077#1075)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Left = 881.101251180000000000
          Top = 17.000000000000000000
          Width = 78.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            #1054#1089#1090#1072#1083#1100#1085#1086#1077)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 250.000000000000000000
          Top = 17.000000000000000000
          Width = 78.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            ' '#1044#1077#1073#1077#1090)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Left = 328.000000000000000000
          Top = 17.000000000000000000
          Width = 78.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            #1050#1088#1077#1076#1080#1090)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Left = 406.000000000000000000
          Top = 17.000000000000000000
          Width = 78.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            ' '#1044#1077#1073#1077#1090)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo24: TfrxMemoView
          Left = 484.000000000000000000
          Top = 17.000000000000000000
          Width = 78.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            #1050#1088#1077#1076#1080#1090)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo26: TfrxMemoView
          Left = 562.000000000000000000
          Top = 1.000000000000000000
          Width = 241.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1056#1072#1089#1093#1086#1076)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo27: TfrxMemoView
          Left = 725.000000000000000000
          Top = 17.000000000000000000
          Width = 78.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            #1054#1089#1090#1072#1083#1100#1085#1086#1077)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo29: TfrxMemoView
          Left = 803.000000000000000000
          Top = 1.000000000000000000
          Width = 156.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1055#1088#1080#1093#1086#1076)
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ReportTitle1: TfrxReportTitle
        Height = 46.000000000000000000
        Top = 16.000000000000000000
        Width = 1046.920361175000000000
        object Memo2: TfrxMemoView
          Align = baWidth
          Top = 20.000000000000000000
          Width = 1046.920361175000000000
          Height = 22.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            #1054#1090#1095#1077#1090' '#1087#1086' '#1087#1086#1082#1091#1087#1072#1090#1077#1083#1103#1084' '#1089' [StartDate] '#1087#1086' [Copy(<EndDate>, 1, 10)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Align = baWidth
          Top = 1.920361180000000000
          Width = 1046.920361175000000000
          Height = 17.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            #1074#1088#1077#1084#1103' '#1092#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1103' [Date] [Time]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object GroupHeader1: TfrxGroupHeader
        Height = 18.000000000000000000
        Top = 205.000000000000000000
        Visible = False
        Width = 1046.920361175000000000
        OnBeforePrint = 'GroupHeader1OnBeforePrint'
        Condition = 'frxDBDataset."juridicalname"'
      end
      object GroupFooter1: TfrxGroupFooter
        Height = 17.000000000000000000
        Top = 283.000000000000000000
        Width = 1046.920361175000000000
        OnBeforePrint = 'GroupFooter1OnBeforePrint'
        Stretched = True
        object Memo1: TfrxMemoView
          Top = 2.000000000000000000
          Width = 33.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[JuridicalLine]')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxDBDatasetjuridicalname: TfrxMemoView
          Left = 33.000000000000000000
          Top = 2.000000000000000000
          Width = 217.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'juridicalname'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDBDataset."juridicalname"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxDBDatasetstartamount: TfrxMemoView
          Left = 250.000000000000000000
          Top = 2.000000000000000000
          Width = 78.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(SumStartAmount > 0, SumStartAmount, 0)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxDBDatasetendamount: TfrxMemoView
          Left = 406.000000000000000000
          Top = 2.000000000000000000
          Width = 78.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(SumEndAmount > 0, SumEndAmount, 0)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxDBDatasetsalesumm: TfrxMemoView
          Left = 562.000000000000000000
          Top = 2.000000000000000000
          Width = 85.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDataset."salesumm">,MasterData1,1)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxDBDatasetservicesumm: TfrxMemoView
          Left = 647.000000000000000000
          Top = 2.000000000000000000
          Width = 78.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDataset."servicesumm">,MasterData1,1)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxDBDatasetmoneysumm: TfrxMemoView
          Left = 803.000000000000000000
          Top = 2.000000000000000000
          Width = 78.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDataset."moneysumm">,MasterData1,1)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxDBDatasetothersumm: TfrxMemoView
          Left = 881.101251180000000000
          Top = 2.000000000000000000
          Width = 78.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(SumOther > 0, SumOther, 0)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Left = 328.000000000000000000
          Top = 2.000000000000000000
          Width = 78.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(<frxDBDataset."startamount">,MasterData1,1) < 0, - SumS' +
              'tartAmount, 0)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Left = 484.000000000000000000
          Top = 2.000000000000000000
          Width = 78.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(<frxDBDataset."endamount">,MasterData1,1) < 0, - SumEnd' +
              'Amount, 0)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          Left = 725.000000000000000000
          Top = 2.000000000000000000
          Width = 78.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(<frxDBDataset."othersumm">,MasterData1,1) < 0, - SumOth' +
              'er, 0)]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ReportSummary1: TfrxReportSummary
        Height = 18.000000000000000000
        Top = 360.000000000000000000
        Width = 1046.920361175000000000
        OnBeforePrint = 'ReportSummary1OnBeforePrint'
        object Memo30: TfrxMemoView
          Left = 250.000000000000000000
          Width = 78.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(SumSumStartAmount > 0, SumSumStartAmount, 0)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo31: TfrxMemoView
          Left = 406.000000000000000000
          Width = 78.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(SumSumEndAmount > 0, SumSumEndAmount, 0)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo32: TfrxMemoView
          Left = 562.000000000000000000
          Width = 85.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDataset."salesumm">,MasterData1,1)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo33: TfrxMemoView
          Left = 647.000000000000000000
          Width = 78.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDataset."servicesumm">,MasterData1,1)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo34: TfrxMemoView
          Left = 803.000000000000000000
          Width = 78.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDataset."moneysumm">,MasterData1,1)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo35: TfrxMemoView
          Left = 881.101251180000000000
          Width = 78.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[IIF(SumSumOther > 0, SumSumOther, 0)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo36: TfrxMemoView
          Left = 328.000000000000000000
          Width = 78.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(<frxDBDataset."startamount">,MasterData1,1) < 0, - SumS' +
              'umStartAmount, 0)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo37: TfrxMemoView
          Left = 484.000000000000000000
          Width = 78.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(<frxDBDataset."endamount">,MasterData1,1) < 0, - SumSum' +
              'EndAmount, 0)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo38: TfrxMemoView
          Left = 725.000000000000000000
          Width = 78.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(<frxDBDataset."othersumm">,MasterData1,1) < 0, - SumSum' +
              'Other, 0)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Width = 250.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            #1048#1090#1086#1075#1086':')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageHeader1: TfrxPageHeader
        Height = 12.000000000000000000
        Top = 82.000000000000000000
        Width = 1046.920361175000000000
        PrintOnFirstPage = False
        object Memo12: TfrxMemoView
          Align = baClient
          Width = 1046.920361175000000000
          Height = 12.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              #1054#1090#1095#1077#1090' '#1087#1086' '#1087#1086#1082#1091#1087#1072#1090#1077#1083#1103#1084' '#1089' [StartDate] '#1087#1086' [EndDate]           '#1074#1088#1077#1084#1103' ' +
              #1092#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1103' [Date] [Time]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageFooter1: TfrxPageFooter
        Height = 20.000000000000000000
        Top = 398.000000000000000000
        Width = 1046.920361175000000000
        PrintOnFirstPage = False
        object Memo11: TfrxMemoView
          Align = baWidth
          Top = 3.000000000000000000
          Width = 1046.920361175000000000
          Height = 16.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            #1057#1090#1088#1072#1085#1080#1094#1072' '#8470' [Page]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
    end
  end
end