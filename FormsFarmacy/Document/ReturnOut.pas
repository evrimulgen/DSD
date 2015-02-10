unit ReturnOut;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AncestorDocument, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxPCdxBarPopupMenu, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, Data.DB, cxDBData,
  cxContainer, Vcl.ComCtrls, dxCore, cxDateUtils, cxCurrencyEdit, dsdAddOn,
  dsdAction, cxCheckBox, dsdGuides, dsdDB, Vcl.Menus, dxBarExtItems, dxBar,
  cxClasses, Datasnap.DBClient, Vcl.ActnList, cxPropertiesStore, cxButtonEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxLabel, cxTextEdit, Vcl.ExtCtrls,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCustomView, cxGrid, cxPC;

type
  TReturnOutForm = class(TAncestorDocumentForm)
    cxLabel3: TcxLabel;
    edFrom: TcxButtonEdit;
    edTo: TcxButtonEdit;
    cxLabel4: TcxLabel;
    GuidesFrom: TdsdGuides;
    GuidesTo: TdsdGuides;
    colCode: TcxGridDBColumn;
    colName: TcxGridDBColumn;
    colAmount: TcxGridDBColumn;
    actGoodsKindChoice: TOpenChoiceForm;
    spSelectPrint: TdsdStoredProc;
    N2: TMenuItem;
    N3: TMenuItem;
    RefreshDispatcher: TRefreshDispatcher;
    actRefreshPrice: TdsdDataSetRefresh;
    PrintHeaderCDS: TClientDataSet;
    bbPrintTax: TdxBarButton;
    PrintItemsCDS: TClientDataSet;
    bbTax: TdxBarButton;
    bbPrintTax_Client: TdxBarButton;
    bbPrint_Bill: TdxBarButton;
    PrintItemsSverkaCDS: TClientDataSet;
    colSumm: TcxGridDBColumn;
    edPriceWithVAT: TcxCheckBox;
    cxLabel10: TcxLabel;
    edNDSKind: TcxButtonEdit;
    NDSKindGuides: TdsdGuides;
    colPrice: TcxGridDBColumn;
    colPartnerGoodsCode: TcxGridDBColumn;
    colPartnerGoodsName: TcxGridDBColumn;
    ContractGuides: TdsdGuides;
    edPaymentDate: TcxDateEdit;
    cxLabel6: TcxLabel;
    colExpirationDate: TcxGridDBColumn;
    ceTotalSummMVAT: TcxCurrencyEdit;
    ceTotalSummPVAT: TcxCurrencyEdit;
    cxLabel7: TcxLabel;
    cxLabel8: TcxLabel;
    colPartitionGoods: TcxGridDBColumn;
    colMakerName: TcxGridDBColumn;
    actRefreshGoodsCode: TdsdExecStoredProc;
    bbRefreshGoodsCode: TdxBarButton;
    spIncome_GoodsId: TdsdStoredProc;
    cxLabel5: TcxLabel;
    cxButtonEdit1: TcxButtonEdit;
    GuidesIncome: TdsdGuides;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

initialization
  RegisterClass(TReturnOutForm);

end.