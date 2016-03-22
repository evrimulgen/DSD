unit Report_Profit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AncestorReport, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxPCdxBarPopupMenu, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, Data.DB, cxDBData,
  cxContainer, Vcl.ComCtrls, dxCore, cxDateUtils, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, dsdGuides, cxButtonEdit, dxBarExtItems,
  dsdAddOn, ChoicePeriod, Vcl.Menus, dxBar, cxClasses, dsdDB, Datasnap.DBClient,
  dsdAction, Vcl.ActnList, cxPropertiesStore, cxLabel, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, Vcl.ExtCtrls, cxGridLevel, cxGridCustomView,
  cxGrid, cxPC, cxCurrencyEdit, cxCheckBox, cxPivotGridChartConnection,
  cxCustomPivotGrid, cxDBPivotGrid, cxGridChartView, cxGridDBChartView,
  cxSplitter, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  dxSkinsdxBarPainter;

type
  TReport_ProfitForm = class(TAncestorReportForm)
    dxBarControlContainerItem1: TdxBarControlContainerItem;
    bbStart: TdxBarControlContainerItem;
    cxLabel3: TcxLabel;
    dxBarControlContainerItem3: TdxBarControlContainerItem;
    ceJuridical1: TcxButtonEdit;
    Juridical1Guides: TdsdGuides;
    dxBarControlContainerItem4: TdxBarControlContainerItem;
    JuridicalMainName: TcxGridDBColumn;
    colUnitName: TcxGridDBColumn;
    clSumma: TcxGridDBColumn;
    SummaProfit: TcxGridDBColumn;
    tsPivot: TcxTabSheet;
    cxSplitter1: TcxSplitter;
    grChart: TcxGrid;
    grChartDBChartView1: TcxGridDBChartView;
    dgJuridicalMainName: TcxGridDBChartDataGroup;
    dgUnit: TcxGridDBChartDataGroup;
    grChartLevel1: TcxGridLevel;
    cxDBPivotGrid1: TcxDBPivotGrid;
    pcolJuridicalMainName: TcxDBPivotGridField;
    pcolUnitName: TcxDBPivotGridField;
    pcolSummaSale: TcxDBPivotGridField;
    pcolSumma: TcxDBPivotGridField;
    pcolSummaProfit: TcxDBPivotGridField;
    actGet_UserUnit: TdsdExecStoredProc;
    actRefreshStart: TdsdDataSetRefresh;
    actQuasiSchedule: TBooleanStoredProcAction;
    bbQuasiSchedule: TdxBarButton;
    cxLabel4: TcxLabel;
    bb122: TdxBarControlContainerItem;
    bbEnd: TdxBarControlContainerItem;
    ExecuteDialog: TExecuteDialog;
    bbExecuteDialog: TdxBarButton;
    cxLabel5: TcxLabel;
    ceJuridical2: TcxButtonEdit;
    Juridical2Guides: TdsdGuides;
    SummaWithVAT2: TcxGridDBColumn;
    SummaWithVAT1: TcxGridDBColumn;
    pcolPersentProfit: TcxDBPivotGridField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Report_ProfitForm: TReport_ProfitForm;

implementation

{$R *.dfm}

initialization
  RegisterClass(TReport_ProfitForm);

end.
