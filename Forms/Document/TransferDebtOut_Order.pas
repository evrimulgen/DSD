unit TransferDebtOut_Order;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AncestorDocument, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxPCdxBarPopupMenu, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, Data.DB, cxDBData,
  cxContainer, Vcl.ComCtrls, dxCore, cxDateUtils, dxSkinsdxBarPainter, dsdAddOn,
  dsdGuides, dsdDB, Vcl.Menus, dxBarExtItems, dxBar, cxClasses,
  Datasnap.DBClient, dsdAction, Vcl.ActnList, cxPropertiesStore, cxButtonEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxLabel, cxTextEdit, Vcl.ExtCtrls,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCustomView, cxGrid, cxPC, cxCurrencyEdit, cxCheckBox, frxClass, frxDBSet,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter, cxImageComboBox;

type
  TTransferDebtOut_OrderForm = class(TAncestorDocumentForm)
    cxLabel3: TcxLabel;
    edFrom: TcxButtonEdit;
    edTo: TcxButtonEdit;
    cxLabel4: TcxLabel;
    edContractFrom: TcxButtonEdit;
    cxLabel9: TcxLabel;
    cxLabel6: TcxLabel;
    edPaidKindFrom: TcxButtonEdit;
    edPriceWithVAT: TcxCheckBox;
    edVATPercent: TcxCurrencyEdit;
    cxLabel7: TcxLabel;
    edChangePercent: TcxCurrencyEdit;
    cxLabel8: TcxLabel;
    GuidesFrom: TdsdGuides;
    GuidesTo: TdsdGuides;
    PaidKindFromGuides: TdsdGuides;
    ContractFromGuides: TdsdGuides;
    colCode: TcxGridDBColumn;
    colName: TcxGridDBColumn;
    colGoodsKindName: TcxGridDBColumn;
    colAmount: TcxGridDBColumn;
    colChangePercentAmount: TcxGridDBColumn;
    colPrice: TcxGridDBColumn;
    colCountForPrice: TcxGridDBColumn;
    colAmountSumm: TcxGridDBColumn;
    actGoodsKindChoice: TOpenChoiceForm;
    spSelectPrint: TdsdStoredProc;
    N2: TMenuItem;
    N3: TMenuItem;
    mactPrint_Sale: TMultiAction;
    actSPPrintSaleProcName: TdsdExecStoredProc;
    spGetReportName: TdsdStoredProc;
    RefreshDispatcher: TRefreshDispatcher;
    actRefreshPrice: TdsdDataSetRefresh;
    PrintHeaderCDS: TClientDataSet;
    mactPrint_Tax_Us: TMultiAction;
    actPrintTax_Us: TdsdPrintAction;
    spGetReporNameTax: TdsdStoredProc;
    bbPrintTax: TdxBarButton;
    actSPPrintSaleTaxProcName: TdsdExecStoredProc;
    PrintItemsCDS: TClientDataSet;
    edDocumentTaxKind: TcxButtonEdit;
    cxLabel14: TcxLabel;
    DocumentTaxKindGuides: TdsdGuides;
    cxLabel16: TcxLabel;
    edTax: TcxTextEdit;
    actTax: TdsdExecStoredProc;
    spTax: TdsdStoredProc;
    bbTax: TdxBarButton;
    mactPrint_Tax_Client: TMultiAction;
    actPrintTax_Client: TdsdPrintAction;
    spSelectTax_Client: TdsdStoredProc;
    bbPrintTax_Client: TdxBarButton;
    spSelectTax_Us: TdsdStoredProc;
    spGetReporNameBill: TdsdStoredProc;
    mactPrint_Bill: TMultiAction;
    actSPPrintSaleBillProcName: TdsdExecStoredProc;
    actPrint_Bill: TdsdPrintAction;
    bbPrint_Bill: TdxBarButton;
    colMeasureName: TcxGridDBColumn;
    PrintItemsSverkaCDS: TClientDataSet;
    cxLabel10: TcxLabel;
    edPaidKindTo: TcxButtonEdit;
    PaidKindToGuides: TdsdGuides;
    cxLabel11: TcxLabel;
    edContractTo: TcxButtonEdit;
    ContractToGuides: TdsdGuides;
    cxLabel5: TcxLabel;
    edPriceList: TcxButtonEdit;
    PriceListGuides: TdsdGuides;
    cxLabel12: TcxLabel;
    edPartner: TcxButtonEdit;
    GuidesPartner: TdsdGuides;
    actPrint_TransferDebtOut: TdsdPrintAction;
    bbPrint_DebtOut: TdxBarButton;
    cxLabel13: TcxLabel;
    edInvNumberPartner: TcxTextEdit;
    edIsChecked: TcxCheckBox;
    TaxCDS: TClientDataSet;
    TaxDS: TDataSource;
    gpUpdateTax: TdsdStoredProc;
    spSelectTax: TdsdStoredProc;
    spMovementSetErasedTax: TdsdStoredProc;
    spMovementCompleteTax: TdsdStoredProc;
    spMovementUnCompleteTax: TdsdStoredProc;
    actUnCompleteTaxCorrective: TdsdChangeMovementStatus;
    actSetErasedTaxCorrective: TdsdChangeMovementStatus;
    actCompleteTaxCorrective: TdsdChangeMovementStatus;
    bbCompleteTaxCorrective: TdxBarButton;
    bbUnCompleteTaxCorrective: TdxBarButton;
    bbSetErasedTaxCorrective: TdxBarButton;
    cxLabel17: TcxLabel;
    edInvNumberOrder: TcxButtonEdit;
    GuidesInvNumberOrder: TdsdGuides;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

initialization
  RegisterClass(TTransferDebtOut_OrderForm);

end.