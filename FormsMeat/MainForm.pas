unit MainForm;

interface

uses
  DataModul, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxBar, cxClasses, Vcl.ActnList,
  Vcl.StdActns, Vcl.StdCtrls, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan,
  dsdAction, cxLocalization, frxExportRTF, frxExportXML, frxClass, frxExportXLS,
  Data.DB, Datasnap.DBClient, dsdDB, cxPropertiesStore, dsdAddOn, dxSkinsCore,
  dxSkinsDefaultPainters, AncestorMain, dxSkinsdxBarPainter;

type
  TMainForm = class(TAncestorMainForm)
    bbGoodsDocuments: TdxBarSubItem;
    actMeasure: TdsdOpenForm;
    bbMeasure: TdxBarButton;
    actJuridicalGroup: TdsdOpenForm;
    bbJuridicalGroup: TdxBarButton;
    actGoodsProperty: TdsdOpenForm;
    bbGoodsProperty: TdxBarButton;
    bbJuridical: TdxBarButton;
    actJuridical: TdsdOpenForm;
    actBusiness: TdsdOpenForm;
    bbBusiness: TdxBarButton;
    actBranch: TdsdOpenForm;
    bbBranch: TdxBarButton;
    actPartner: TdsdOpenForm;
    actIncome: TdsdOpenForm;
    bbIncome: TdxBarButton;
    bbPartner: TdxBarButton;
    bbGuides_Separator: TdxBarSeparator;
    actPaidKind: TdsdOpenForm;
    actContractKind: TdsdOpenForm;
    actUnit: TdsdOpenForm;
    actGoodsGroup: TdsdOpenForm;
    actGoods: TdsdOpenForm;
    actGoodsKind: TdsdOpenForm;
    bbPaidKind: TdxBarButton;
    bbContractKind: TdxBarButton;
    bbUnit: TdxBarButton;
    bbGoodsGroup: TdxBarButton;
    bbGoods: TdxBarButton;
    actBank: TdsdOpenForm;
    actBankAccount: TdsdOpenForm;
    actCash: TdsdOpenForm;
    actCurrency: TdsdOpenForm;
    bbGoodsKind: TdxBarButton;
    actReport_Balance: TdsdOpenForm;
    bbReportBalance: TdxBarButton;
    bbReportsGoods: TdxBarSubItem;
    bbBank: TdxBarButton;
    actPriceList: TdsdOpenForm;
    bbPriceList: TdxBarButton;
    bbCash: TdxBarButton;
    bbCurrency: TdxBarButton;
    actInfoMoneyGroup: TdsdOpenForm;
    actInfoMoneyDestination: TdsdOpenForm;
    actInfoMoney: TdsdOpenForm;
    actAccountGroup: TdsdOpenForm;
    actAccountDirection: TdsdOpenForm;
    actProfitLossGroup: TdsdOpenForm;
    actProfitLossDirection: TdsdOpenForm;
    bbInfoMoneyGroup: TdxBarButton;
    bbInfoMoneyDestination: TdxBarButton;
    bbInfoMoney: TdxBarButton;
    bbAccountGroup: TdxBarButton;
    bbAccountDirection: TdxBarButton;
    bbProfitLossGroup: TdxBarButton;
    bbProfitLossDirection: TdxBarButton;
    dxBarSubItem: TdxBarSubItem;
    actAccount: TdsdOpenForm;
    actProfitLoss: TdsdOpenForm;
    bbAccount: TdxBarButton;
    bbProfitLoss: TdxBarButton;
    actTradeMark: TdsdOpenForm;
    actAsset: TdsdOpenForm;
    actRoute: TdsdOpenForm;
    actRouteSorting: TdsdOpenForm;
    actMember: TdsdOpenForm;
    actPosition: TdsdOpenForm;
    actPersonal: TdsdOpenForm;
    actCar: TdsdOpenForm;
    actCarModel: TdsdOpenForm;
    bbCar: TdxBarButton;
    bbCarModel: TdxBarButton;
    bbPersonal: TdxBarButton;
    bbRoute: TdxBarButton;
    bbRouteSorting: TdxBarButton;
    bbTradeMark: TdxBarButton;
    bbAsset: TdxBarButton;
    bbPosition: TdxBarButton;
    bbMember: TdxBarButton;
    actSend: TdsdOpenForm;
    bbSend: TdxBarButton;
    actSale: TdsdOpenForm;
    bbSale: TdxBarButton;
    actReturnOut: TdsdOpenForm;
    actReturnIn: TdsdOpenForm;
    actLoss: TdsdOpenForm;
    bbLoss: TdxBarButton;
    bbReturnIn: TdxBarButton;
    bbReturnOut: TdxBarButton;
    actSendOnPrice: TdsdOpenForm;
    bbSendOnPrice: TdxBarButton;
    actInventory: TdsdOpenForm;
    actProductionSeparate: TdsdOpenForm;
    actProductionUnion: TdsdOpenForm;
    bbInventory: TdxBarButton;
    bbProductionSeparate: TdxBarButton;
    bbProductionUnion: TdxBarButton;
    cxPropertiesStore: TcxPropertiesStore;
    actReport_HistoryCost: TdsdOpenForm;
    bbReportProfitLoss: TdxBarButton;
    bbReportHistoryCost: TdxBarButton;
    actReport_ProfitLoss: TdsdOpenForm;
    actContract: TdsdOpenForm;
    bbContract: TdxBarButton;
    actPriceListItem: TdsdOpenForm;
    bbHistory: TdxBarSubItem;
    bbPriceListItem: TdxBarButton;
    actOrderExternal: TdsdOpenForm;
    bbZakazExternal: TdxBarButton;
    bbZakazInternal: TdxBarButton;
    actOrderInternal: TdsdOpenForm;
    bbFinanceDocuments: TdxBarSubItem;
    bbIncomeCash: TdxBarButton;
    actCashOperation: TdsdOpenForm;
    bbBankAccount: TdxBarButton;
    actReport_MotionGoods: TdsdOpenForm;
    bbReport_MotionGoods: TdxBarButton;
    actRole: TdsdOpenForm;
    bbRole: TdxBarButton;
    actAction: TdsdOpenForm;
    bbAction: TdxBarButton;
    actUser: TdsdOpenForm;
    bbUser: TdxBarButton;
    actProcess: TdsdOpenForm;
    bbProcess: TdxBarButton;
    bbTransportDocuments: TdxBarSubItem;
    bbTransport: TdxBarButton;
    bbFuel: TdxBarButton;
    actTransport: TdsdOpenForm;
    actFuel: TdsdOpenForm;
    actRateFuelKind: TdsdOpenForm;
    bbRateFuelKind: TdxBarButton;
    actIncomeFuel: TdsdOpenForm;
    bbIncomeFuel: TdxBarButton;
    bbTransportDocuments_Separator: TdxBarSeparator;
    actPersonalSendCash: TdsdOpenForm;
    bbPersonalSendCash: TdxBarButton;
    bbRateFuel: TdxBarButton;
    actRateFuel: TdsdOpenForm;
    bbFreight: TdxBarButton;
    actFreight: TdsdOpenForm;
    bbReport_Fuel: TdxBarButton;
    bbtReport_Transport: TdxBarButton;
    actReport_Transport: TdsdOpenForm;
    actReport_Fuel: TdsdOpenForm;
    actPersonalGroup: TdsdOpenForm;
    actWorkTimeKind: TdsdOpenForm;
    actSheetWorkTime: TdsdOpenForm;
    actPersonalService: TdsdOpenForm;
    bbPersonalDocuments: TdxBarSubItem;
    bbWorkTimeKind: TdxBarButton;
    bbPersonalGroup: TdxBarButton;
    bbPersonalDocuments_Separator: TdxBarSeparator;
    bbSheetWorkTime: TdxBarButton;
    bbPersonalService: TdxBarButton;
    actReport_Account: TdsdOpenForm;
    bbAccountReport: TdxBarButton;
    actCardFuel: TdsdOpenForm;
    actTicketFuel: TdsdOpenForm;
    bbCardFuel: TdxBarButton;
    bbTicketFuel: TdxBarButton;
    actPositionLevel: TdsdOpenForm;
    bbPositionLevel: TdxBarButton;
    actStaffListData: TdsdOpenForm;
    bbStaffListData: TdxBarButton;
    actModelService: TdsdOpenForm;
    bbModelService: TdxBarButton;
    actReport_TransportHoursWork: TdsdOpenForm;
    bbReport_TransportHoursWork: TdxBarButton;
    actProtocol: TdsdOpenForm;
    bbProtocol: TdxBarButton;
    actService: TdsdOpenForm;
    bbJuridicalService: TdxBarButton;
    actReport_GoodsTax: TdsdOpenForm;
    bbReport_GoodsTax: TdxBarButton;
    actSendTicketFuel: TdsdOpenForm;
    bbSendTicketFuel: TdxBarButton;
    actBankLoad: TdsdOpenForm;
    bbBankLoad: TdxBarButton;
    actArea: TdsdOpenForm;
    bbArea: TdxBarButton;
    actContractArticle: TdsdOpenForm;
    bbContractArticle: TdxBarButton;
    actCalendar: TdsdOpenForm;
    bbCalendar: TdxBarButton;
    actSetUserDefaults: TdsdOpenForm;
    bbSetUserDefaults: TdxBarButton;
    actPersonalAccount: TdsdOpenForm;
    bbPersonalAccount: TdxBarButton;
    actTransportService: TdsdOpenForm;
    bbTransportService: TdxBarButton;
    actJuridical_List: TdsdOpenForm;
    bbJuridical_List: TdxBarButton;
    actUnit_List: TdsdOpenForm;
    bbUnit_List: TdxBarButton;
    actLossDebt: TdsdOpenForm;
    bbLossDebt: TdxBarButton;
    actBankAccountDocument: TdsdOpenForm;
    bbBankAccountDocument: TdxBarButton;
    actCity: TdsdOpenForm;
    bbCity: TdxBarButton;
    bbFinanceDocuments_Separator: TdxBarSeparator;
    actReport_JuridicalSold: TdsdOpenForm;
    bbReport_JuridicalSold: TdxBarButton;
    actReport_JuridicalCollation: TdsdOpenForm;
    bbReport_JuridicalCollation: TdxBarButton;
    actMovementDesc: TdsdOpenForm;
    bbMovementDesc: TdxBarButton;
    actReport_GoodsMISale: TdsdOpenForm;
    bbReport_GoodsMISale: TdxBarButton;
    actSendDebt: TdsdOpenForm;
    bbSendDebt: TdxBarButton;
    actPartner1CLink: TdsdOpenForm;
    actGoodsByGoodsKind1CLink: TdsdOpenForm;
    bbPartner1CLink: TdxBarButton;
    bbGoods1CLink: TdxBarButton;
    actLoad1CSale: TdsdOpenForm;
    bbLoad1CSale: TdxBarButton;
    actReport_GoodsMIReturn: TdsdOpenForm;
    bbReport_GoodsMIReturn: TdxBarButton;
    actReport_GoodsMI_byMovementSale: TdsdOpenForm;
    actReport_GoodsMI_byMovementReturn: TdsdOpenForm;
    bbReport_GoodsMI_byMovementSale: TdxBarButton;
    bbReport_GoodsMI_byMovementReturn: TdxBarButton;
    actReport_GoodsMI_SaleReturnIn: TdsdOpenForm;
    bbReport_GoodsMI_SaleReturnIn: TdxBarButton;
    bbReportsFinance: TdxBarSubItem;
    bbReportMain: TdxBarSubItem;
    bbReportsProduction: TdxBarSubItem;
    actReport_Production_Union: TdsdOpenForm;
    bbGoodsDocuments_Separator: TdxBarSeparator;
    bbReportsProduction_Separator: TdxBarSeparator;
    bbHistory_Separator: TdxBarSeparator;
    bbReportsGoods_Separator: TdxBarSeparator;
    bbReportsFinance_Separator: TdxBarSeparator;
    bbReportMain_Separator: TdxBarSeparator;
    bbService_Separator: TdxBarSeparator;
    bbReportProductionUnion: TdxBarButton;
    actContractConditionValue: TdsdOpenForm;
    bbContractConditionValue: TdxBarButton;
    actReport_GoodsMI_Income: TdsdOpenForm;
    bbReport_GoodsMI_Income: TdxBarButton;
    actReport_GoodsMI_IncomeByPartner: TdsdOpenForm;
    bbReport_GoodsMI_IncomeByPartner: TdxBarButton;
    actReport_JuridicalDefermentPayment: TdsdOpenForm;
    bbReport_JuridicalDefermentPayment: TdxBarButton;
    actTax: TdsdOpenForm;
    bbTax: TdxBarButton;
    actTaxCorrection: TdsdOpenForm;
    bbTaxCorrective: TdxBarButton;
    bbAssetDocuments: TdxBarSubItem;
    bbAsset_Separator: TdxBarSeparator;
    actGoods_List: TdsdOpenForm;
    bbGoods_List: TdxBarButton;
    actAssetGroup: TdsdOpenForm;
    bbAssetGroup: TdxBarButton;
    actMaker: TdsdOpenForm;
    actCountry: TdsdOpenForm;
    bbCountry: TdxBarButton;
    bbMaker: TdxBarButton;
    actProtocolUser: TdsdOpenForm;
    actProtocolMovement: TdsdOpenForm;
    bbUserProtocol: TdxBarButton;
    bbMovementProtocol: TdxBarButton;
    actReport_CheckTax: TdsdOpenForm;
    bbReport_CheckTax: TdxBarButton;
    actProfitLossService: TdsdOpenForm;
    bbProfitLossService: TdxBarButton;
    actReport_CheckTaxCorrective: TdsdOpenForm;
    bbReport_CheckTaxCorrective: TdxBarButton;
    actPeriodClose: TdsdOpenForm;
    bbPeriodClose: TdxBarButton;
    actSaveTaxDocument: TdsdOpenForm;
    bbSaveTaxDocument: TdxBarButton;
    actToolsWeighingTree: TdsdOpenForm;
    bbToolsWeighingTree: TdxBarButton;
    actGoodsPropertyValue: TdsdOpenForm;
    bbGoodsPropertyValue: TdxBarButton;
    actWeighingPartner: TdsdOpenForm;
    bbWeighingPartner: TdxBarButton;
    actWeighingProduction: TdsdOpenForm;
    bbWeighingProduction: TdxBarButton;
    actReport_CheckBonus: TdsdOpenForm;
    bbReport_CheckBonus: TdxBarButton;
    actGoodsKindWeighing: TdsdOpenForm;
    bbGoodsKindWeighing: TdxBarButton;
    bbTaxDocuments: TdxBarSubItem;
    bbTaxDocuments_Separator: TdxBarSeparator;
    actReport_GoodsMI_byMovementDifSale: TdsdOpenForm;
    actReport_GoodsMI_byMovementDifReturn: TdsdOpenForm;
    bbReport_GoodsMI_byMovementDifReturn: TdxBarButton;
    bbReport_GoodsMI_byMovementDifSale: TdxBarButton;
    actSale_Partner: TdsdOpenForm;
    bbSale_Partner: TdxBarButton;
    actReport_CheckContractInMovement: TdsdOpenForm;
    bbReport_CheckContractInMovement: TdxBarButton;
    actTransferDebtOut: TdsdOpenForm;
    bbTransferDebtOut: TdxBarButton;
    actTransferDebtIn: TdsdOpenForm;
    bbTransferDebtIn: TdxBarButton;
    actBankAccountContract: TdsdOpenForm;
    bbBankAccountContract: TdxBarButton;
    actEDI: TdsdOpenForm;
    bbEDI: TdxBarButton;
    actReport_GoodsMI_TransferDebtIn: TdsdOpenForm;
    actReport_GoodsMI_TransferDebtOut: TdsdOpenForm;
    bbReport_GoodsMI_TransferDebtIn: TdxBarButton;
    bbReport_GoodsMI_TransferDebtOut: TdxBarButton;
    actSaveDocumentTo1C: TdsdOpenForm;
    bbSaveDocumentTo1C: TdxBarButton;
    actReport_Goods: TdsdOpenForm;
    bbReport_Goods: TdxBarButton;
    actReport_GoodsMI_byPriceDifSale: TdsdOpenForm;
    bbReport_GoodsMI_byPriceDifSale: TdxBarButton;
    actRetail: TdsdOpenForm;
    bbRetail: TdxBarButton;
    actPriceCorrective: TdsdOpenForm;
    bbPriceCorrective: TdxBarButton;
    bbAdres: TdxBarSubItem;
    actRegion: TdsdOpenForm;
    actProvince: TdsdOpenForm;
    actCityKind: TdsdOpenForm;
    actProvinceCity: TdsdOpenForm;
    actStreetKind: TdsdOpenForm;
    actStreet: TdsdOpenForm;
    actContactPersonKind: TdsdOpenForm;
    actContactPerson: TdsdOpenForm;
    bbContactPerson: TdxBarButton;
    bbContactPersonKind: TdxBarButton;
    bbRegion: TdxBarButton;
    bb�����: TdxBarButton;
    bbCityKind: TdxBarButton;
    bbProvinceCity: TdxBarButton;
    bbStreetKind: TdxBarButton;
    bbStreet: TdxBarButton;
    actPartnerAddress: TdsdOpenForm;
    bbPartnerAddress: TdxBarButton;
    actStorage_Object: TdsdOpenForm;
    bbStorage_Object: TdxBarButton;
    actCurrencyMovement: TdsdOpenForm;
    bbCurrencyMovement: TdxBarButton;
    bbReport_GoodsMI_OrderExternal: TdxBarButton;
    actReport_OrderExternal: TdsdOpenForm;
    actReport_GoodsMI_ProductionUnionIncome: TdsdOpenForm;
    bbReport_GoodsMI_Production: TdxBarButton;
    actReport_GoodsMI_ProductionUnionReturn: TdsdOpenForm;
    actReport_GoodsMI_ProductionSeparateIncome: TdsdOpenForm;
    actReport_GoodsMI_ProductionSeparateReturn: TdsdOpenForm;
    bbReport_GoodsMI_ProductionUnionReturn: TdxBarButton;
    bbReport_GoodsMI_ProductionSeparateIncome: TdxBarButton;
    bbReport_GoodsMI_ProductionSeparateReturn: TdxBarButton;
    actReport_GoodsMI_ProductionSeparate: TdsdOpenForm;
    bbReport_GoodsMI_ProductionSeparate: TdxBarButton;
    actCashOperationOld: TdsdOpenForm;
    bbIncomeCashOld: TdxBarButton;
    actLoad1CMoney: TdsdOpenForm;
    bbLoad1CMoney: TdxBarButton;
    actReport_GoodsMI_ProductionSeparatePart: TdsdOpenForm;
    bbReport_GoodsMI_ProductionSeparatePart: TdxBarButton;
    actFounder: TdsdOpenForm;
    bbFounder: TdxBarButton;
    actArticleLoss: TdsdOpenForm;
    bbArticleLoss: TdxBarButton;
    actReport_OrderExternal_Sale: TdsdOpenForm;
    bbReport_OrderExternal_Sale: TdxBarButton;
    actGoodsGroupStat: TdsdOpenForm;
    bbGoodsGroupStat: TdxBarButton;
  public
    { Public declarations }
  end;

var
  MainFormInstance: TMainForm;

implementation

{$R *.dfm}

end.
