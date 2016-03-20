unit ReceiptComponents;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, DataModul, ParentForm,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, Data.DB, cxDBData,
  cxImageComboBox, cxButtonEdit, cxContainer, Vcl.ComCtrls, dxCore, cxDateUtils,
  dsdAddOn, ChoicePeriod, dsdDB, dsdAction, System.Classes, Vcl.ActnList,
  dxBarExtItems, dxBar, cxClasses, cxPropertiesStore, Datasnap.DBClient,
  cxCheckBox, cxLabel, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCustomView, Vcl.Controls, cxGrid, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, dxSkinsdxBarPainter, cxSplitter, cxCurrencyEdit;

type
  TReceiptComponentsForm = class(TParentForm)
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    clValue: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    MasterDS: TDataSource;
    MasterCDS: TClientDataSet;
    cxPropertiesStore: TcxPropertiesStore;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    bbRefresh: TdxBarButton;
    bbInsert: TdxBarButton;
    bbEdit: TdxBarButton;
    bbSetErased: TdxBarButton;
    bbSetUnErased: TdxBarButton;
    bbGridToExcel: TdxBarButton;
    dxBarStatic1: TdxBarStatic;
    bbChoiceGuides: TdxBarButton;
    ActionList: TActionList;
    actRefresh: TdsdDataSetRefresh;
    actInsert: TdsdInsertUpdateAction;
    actUpdate: TdsdInsertUpdateAction;
    dsdSetErased: TdsdUpdateErased;
    dsdSetUnErased: TdsdUpdateErased;
    dsdGridToExcel: TdsdGridToExcel;
    spSelect: TdsdStoredProc;
    dsdUserSettingsStorageAddOn: TdsdUserSettingsStorageAddOn;
    dsdDBViewAddOn: TdsdDBViewAddOn;
    clIsMain: TcxGridDBColumn;
    dsdChoiceGuides: TdsdChoiceGuides;
    clName: TcxGridDBColumn;
    clGoodsCode: TcxGridDBColumn;
    clGoodsName: TcxGridDBColumn;
    clGoodsKindName: TcxGridDBColumn;
    clGoodsKindCompleteName: TcxGridDBColumn;
    clReceiptKindName: TcxGridDBColumn;
    clIsErased: TcxGridDBColumn;
    spInsertUpdateReceiptChild: TdsdStoredProc;
    ReceiptChildChoiceForm: TOpenChoiceForm;
    InsertRecordCCK: TInsertRecord;
    bbInsertRecCCK: TdxBarButton;
    actReceiptChild: TdsdUpdateDataSet;
    actUpdateDataSet: TdsdUpdateDataSet;
    clReceiptCode: TcxGridDBColumn;
    Goods_ObjectChoiceForm: TOpenChoiceForm;
    clTaxExit: TcxGridDBColumn;
    bbStartDate: TdxBarControlContainerItem;
    bbEnd: TdxBarControlContainerItem;
    bbEndDate: TdxBarControlContainerItem;
    bbIsEndDate: TdxBarControlContainerItem;
    bbIsPeriod: TdxBarControlContainerItem;
    PeriodChoice: TPeriodChoice;
    RefreshDispatcher: TRefreshDispatcher;
    clCode: TcxGridDBColumn;
    cxBottomSplitter: TcxSplitter;
    clTotalWeightMain: TcxGridDBColumn;
    clTotalWeight: TcxGridDBColumn;
    clMeasureName: TcxGridDBColumn;
    actShowAll: TBooleanStoredProcAction;
    bbShowAll: TdxBarButton;
    GoodsGroupAnalystName: TcxGridDBColumn;
    GoodsTagName: TcxGridDBColumn;
    TradeMarkName: TcxGridDBColumn;
    GoodsGroupNameFull: TcxGridDBColumn;
    actInsertMask: TdsdInsertUpdateAction;
    bbInsertMask: TdxBarButton;
    actPrint: TdsdPrintAction;
    actPrintDetail: TdsdPrintAction;
    bbPrint: TdxBarButton;
    bbPrintDetail: TdxBarButton;
    spPrintReceiptChildDetail: TdsdStoredProc;
    clTaxLoss: TcxGridDBColumn;
    ValueWeight: TcxGridDBColumn;
    PrintMasterCDS: TClientDataSet;
    spPrintReceipt: TdsdStoredProc;
    ProtocolOpenForm: TdsdOpenForm;
    bbProtocol: TdxBarButton;
    ProtocolOpenFormChild: TdsdOpenForm;
    bbProtocolChild: TdxBarButton;
    spUpdateTaxExit: TdsdStoredProc;
    actUpdateTaxExit: TdsdExecStoredProc;
    actUpdateWeightMain: TdsdExecStoredProc;
    spUpdateWeightMain: TdsdStoredProc;
    bbUpdateTaxExit: TdxBarButton;
    bbUpdateWeightMain: TdxBarButton;
    spErasedUnErasedReceiptChild: TdsdStoredProc;
    dsdSetErasedReceiptChild: TdsdUpdateErased;
    bbSetErasedReceiptChild: TdxBarButton;
    dsdSetUnErasedReceiptChild: TdsdUpdateErased;
    bb: TdxBarButton;
    spErasedUnErasedReceipt: TdsdStoredProc;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

initialization
  RegisterClass(TReceiptComponentsForm);

end.

{
OperCount_TotalMaterialBasis - �����~��� �����
case when Receipt_byHistory.KindPackageId in (zc_KindPackage_PF(),zc_KindPackage_groupPF())
          then fCalc_OperCount_TotalMaterialBasis_byReceipt(Receipt_byHistory.ReceiptId,Receipt_byHistory.StartDate)
     else isnull(fromReceipt_byHistory.OperCount,isnull(fromReceipt_byHistoryTwo.OperCount,0))
end as OperCount_TotalMaterialBasis

case when Receipt_byHistory.KindPackageId in (zc_KindPackage_PF(),zc_KindPackage_groupPF())
          then fCalc_OperCount_TotalVes_byReceipt(Receipt_byHistory.ReceiptId,Receipt_byHistory.StartDate)
     else isnull(ReceiptItem_byHistory_find.OperCount,0)
end as OperCount_TotalVes

(case when Receipt_byHistory.KindPackageId in (zc_KindPackage_PF(),zc_KindPackage_groupPF())
            then (OperCount_byVes-OperCount_TotalVes)
       when ReceiptItem_byHistory_find.ReceiptId is not null or isnull(fromReceipt_byHistory.ReceiptId,fromReceipt_byHistoryTwo.ReceiptId) is not null
            then OperCount_TotalVes-OperCount_TotalMaterialBasis
       else 0 end)as checkOperCount = Check_Weight



,Receipt_byHistory.OperCount*case when GoodsProperty.MeasureId=zc_measure_Sht(*) then isnull(GoodsProperty_Detail.Ves_onMeasure,0) else 1 end as OperCount_byVes
,isnull(toReceipt_byHistory.OperCount,toReceipt_byHistoryTwo.OperCount)as toOperCount
,case when Receipt_byHistory.KindPackageId=zc_KindPackage_PF()
           then (Receipt_byHistory.TaxExit-toOperCount)

      when ReceiptItem_byHistory_find.ReceiptId is not null and isnull(fromReceipt_byHistory.TaxExit,isnull(fromReceipt_byHistoryTwo.TaxExit,0))<>Receipt_byHistory.TaxExit
           then isnull(fromReceipt_byHistory.TaxExit,isnull(fromReceipt_byHistoryTwo.TaxExit,0))-Receipt_byHistory.TaxExit

      when ReceiptItem_byHistory_find.ReceiptId is not null
           then Receipt_byHistory.TaxExit-OperCount_byVes

      else Receipt_byHistory.TaxExit-100
end as checkTaxExit




(case when Receipt_byHistory.KindPackageId in (zc_KindPackage_PF(),zc_KindPackage_groupPF())
           then (OperCount_byVes-Receipt_byHistory.PartionValue)
      else Receipt_byHistory.PartionValue
end)as checkPartionValue = Check_PartionValue
}