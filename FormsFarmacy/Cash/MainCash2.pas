unit MainCash2;

interface

uses
  DataModul, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AncestorBase, Vcl.ActnList, dsdAction,
  cxPropertiesStore, dsdAddOn, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, Data.DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, Vcl.ExtCtrls, cxSplitter, dsdDB, Datasnap.DBClient, cxContainer,
  cxTextEdit, cxCurrencyEdit, cxLabel, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, Vcl.Menus, cxCheckBox, Vcl.StdCtrls,
  cxButtons, cxNavigator, CashInterface, IniFIles, cxImageComboBox, dxmdaset,
  ActiveX,  Math, ShellApi,
  VKDBFDataSet, FormStorage, CommonData, ParentForm, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter;

type
  THeadRecord = record
    ID: Integer;//id ����
    PAIDTYPE:Integer; //��� ������
    MANAGER:Integer; //Id ��������� (VIP)
    NOTMCS:Boolean; //�� ��� ���
    COMPL:Boolean; //���������
    SAVE:Boolean; //��������
    NEEDCOMPL: Boolean; //���������� ����������
    DATE: TDateTime; //����/����� ����
    UID: String[50];//uid ����
    CASH: String[20]; //�������� ��������
    BAYER:String[254]; //���������� (VIP)
    FISCID:String[50]; //����� ����������� ����
    //***20.07.16
    DISCOUNTID : Integer;     //Id ������� ���������� ����
    DISCOUNTN  : String[254]; //�������� ������� ���������� ����
    DISCOUNT   : String[50];  //� ���������� �����
    //***16.08.16
    BAYERPHONE  : String[50];  //���������� ������� (����������) - BayerPhone
    CONFIRMED   : String[50];  //������ ������ (��������� VIP-����) - ConfirmedKind
    NUMORDER    : String[50];  //����� ������ (� �����) - InvNumberOrder
    CONFIRMEDC  : String[50];  //������ ������ (��������� VIP-����) - ConfirmedKindClient
    // ��� ������� �������� ������� ����� ��� ������� ���� �������
    USERSESION: string[50]; // ����� ��������������� �����
  end;
  TBodyRecord = record
    ID: Integer;            //�� ������
    GOODSID: Integer;       //�� ������
    GOODSCODE: Integer;     //��� ������
    NDS: Currency;          //��� ������
    AMOUNT: Currency;       //���-��
    PRICE: Currency;        //����, � 20.07.16 ���� ���� ������ �� ������� ��������, ����� ����� ���� � ������ ������
    CH_UID: String[50];     //uid ����
    GOODSNAME: String[254]; //������������ ������
    //***20.07.16
    PRICESALE: Currency;    // ���� ��� ������
    CHPERCENT: Currency;    // % ������
    SUMMCH: Currency;       // ����� ������
    //***19.08.16
    AMOUNTORD: Currency;    // ���-�� ������
    //***10.08.16
    LIST_UID: String[50]    // UID ������ �������
  end;
  TBodyArr = Array of TBodyRecord;

  TMainCashForm2 = class(TAncestorBaseForm)
    MainGridDBTableView: TcxGridDBTableView;
    MainGridLevel: TcxGridLevel;
    MainGrid: TcxGrid;
    BottomPanel: TPanel;
    CheckGridDBTableView: TcxGridDBTableView;
    CheckGridLevel: TcxGridLevel;
    CheckGrid: TcxGrid;
    AlternativeGridDBTableView: TcxGridDBTableView;
    AlternativeGridLevel: TcxGridLevel;
    AlternativeGrid: TcxGrid;
    cxSplitter1: TcxSplitter;
    SearchPanel: TPanel;
    cxSplitter2: TcxSplitter;
    MainPanel: TPanel;
    CheckGridColCode: TcxGridDBColumn;
    CheckGridColName: TcxGridDBColumn;
    CheckGridColPrice: TcxGridDBColumn;
    CheckGridColAmount: TcxGridDBColumn;
    CheckGridColSumm: TcxGridDBColumn;
    AlternativeGridColGoodsCode: TcxGridDBColumn;
    AlternativeGridColGoodsName: TcxGridDBColumn;
    MainColCode: TcxGridDBColumn;
    MainColName: TcxGridDBColumn;
    MainColRemains: TcxGridDBColumn;
    MainColPrice: TcxGridDBColumn;
    MainColReserved: TcxGridDBColumn;
    dsdDBViewAddOnMain: TdsdDBViewAddOn;
    spSelectRemains: TdsdStoredProc;
    RemainsDS: TDataSource;
    RemainsCDS: TClientDataSet;
    ceAmount: TcxCurrencyEdit;
    cxLabel1: TcxLabel;
    lcName: TcxLookupComboBox;
    actChoiceGoodsInRemainsGrid: TAction;
    actSold: TAction;
    PopupMenu: TPopupMenu;
    actSold1: TMenuItem;
    N1: TMenuItem;
    FormParams: TdsdFormParams;
    cbSpec: TcxCheckBox;
    actCheck: TdsdOpenForm;
    btnCheck: TcxButton;
    actInsertUpdateCheckItems: TAction;
    spSelectCheck: TdsdStoredProc;
    CheckDS: TDataSource;
    CheckCDS: TClientDataSet;
    MainColMCSValue: TcxGridDBColumn;
    cxLabel2: TcxLabel;
    lblTotalSumm: TcxLabel;
    dsdDBViewAddOnCheck: TdsdDBViewAddOn;
    actPutCheckToCash: TAction;
    AlternativeGridColLinkType: TcxGridDBColumn;
    AlternativeCDS: TClientDataSet;
    AlternativeDS: TDataSource;
    spSelect_Alternative: TdsdStoredProc;
    dsdDBViewAddOnAlternative: TdsdDBViewAddOn;
    actSetVIP: TAction;
    VIP1: TMenuItem;
    AlternativeGridColTypeColor: TcxGridDBColumn;
    AlternativeGridDColPrice: TcxGridDBColumn;
    AlternativeGridColRemains: TcxGridDBColumn;
    btnVIP: TcxButton;
    actOpenCheckVIP: TOpenChoiceForm;
    actLoadVIP: TMultiAction;
    actUpdateRemains: TAction;
    actCalcTotalSumm: TAction;
    actCashWork: TAction;
    N3: TMenuItem;
    actClearAll: TAction;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    lblMoneyInCash: TcxLabel;
    actClearMoney: TAction;
    N7: TMenuItem;
    actGetMoneyInCash: TAction;
    N8: TMenuItem;
    spGetMoneyInCash: TdsdStoredProc;
    spGet_Password_MoneyInCash: TdsdStoredProc;
    actSpec: TAction;
    N9: TMenuItem;
    actRefreshLite: TdsdDataSetRefresh;
    actOpenMCS_LiteForm: TdsdOpenForm;
    btnOpenMCSForm: TcxButton;
    spGet_User_IsAdmin: TdsdStoredProc;
    actSetFocus: TAction;
    N10: TMenuItem;
    actRefreshRemains: TAction;
    spDelete_CashSession: TdsdStoredProc;
    DiffCDS: TClientDataSet;
    spSelect_CashRemains_Diff: TdsdStoredProc;
    actExecuteLoadVIP: TAction;
    actRefreshAll: TAction;
    ShapeState: TShape;
    actSelectCheck: TdsdExecStoredProc;
    TimerSaveAll: TTimer;
    pnlVIP: TPanel;
    Label1: TLabel;
    lblCashMember: TLabel;
    Label2: TLabel;
    lblBayer: TLabel;
    chbNotMCS: TcxCheckBox;
    mainColor_calc: TcxGridDBColumn;
    MaincolisFirst: TcxGridDBColumn;
    MaincolisSecond: TcxGridDBColumn;
    cxButton1: TcxButton;
    actChoiceGoodsFromRemains: TOpenChoiceForm;
    TimerMoneyInCash: TTimer;
    mainColisPromo: TcxGridDBColumn;
    actSelectLocalVIPCheck: TAction;
    actCheckConnection: TAction;
    N2: TMenuItem;
    N11: TMenuItem;
    spUpdate_UnitForFarmacyCash: TdsdStoredProc;
    CheckGridColPriceSale: TcxGridDBColumn;
    CheckGridColChangePercent: TcxGridDBColumn;
    CheckGridColSummChangePercent: TcxGridDBColumn;
    CheckGridColAmountOrder: TcxGridDBColumn;
    pnlDiscount: TPanel;
    Label3: TLabel;
    lblDiscountExternalName: TLabel;
    Label5: TLabel;
    lblDiscountCardNumber: TLabel;
    VIP2: TMenuItem;
    actSetDiscountExternal: TAction;
    TimerBlinkBtn: TTimer;
    spGet_BlinkVIP: TdsdStoredProc;
    actSetConfirmedKind_UnComplete: TAction;
    actSetConfirmedKind_Complete: TAction;
    N12: TMenuItem;
    VIP3: TMenuItem;
    VIP4: TMenuItem;
    spUpdate_ConfirmedKind: TdsdStoredProc;
    mainMinExpirationDate: TcxGridDBColumn;
    MainColor_ExpirationDate: TcxGridDBColumn;
    actOpenMCSForm: TdsdOpenForm;
    N13: TMenuItem;
    N14: TMenuItem;
    spGet_BlinkCheck: TdsdStoredProc;
    actOpenCheckVIP_Error: TOpenChoiceForm;
    actOpenCheckVIPError1: TMenuItem;
    spCheck_RemainsError: TdsdStoredProc;
    actShowMessage: TShowMessageAction;
    MainConditionsKeepName: TcxGridDBColumn;
    MainGoodsGroupName: TcxGridDBColumn;
    MainAmountIncome: TcxGridDBColumn;
    MainPriceSaleIncome: TcxGridDBColumn;
    MainNDS: TcxGridDBColumn;
    Panel1: TPanel;
    ceScaner: TcxCurrencyEdit;
    lbScaner: TLabel;
    GoodsId_main: TcxGridDBColumn;    
    MemData: TdxMemData;
    MemDataID: TIntegerField;
    MemDataGOODSCODE: TIntegerField;
    MemDataGOODSNAME: TStringField;
    MemDataPRICE: TFloatField;
    MemDataREMAINS: TFloatField;
    MemDataMCSVALUE: TFloatField;
    MemDataRESERVED: TFloatField;
    MemDataNEWROW: TBooleanField;
    actAddDiffMemdata: TAction;
    actSetRimainsFromMemdata: TAction;
    actSaveCashSesionIdToFile: TAction;
    actServiseRun: TAction;
    actSetMemdataFromDBF: TAction;
    actSetUpdateFromMemdata: TAction;
    procedure WM_KEYDOWN(var Msg: TWMKEYDOWN);
    procedure FormCreate(Sender: TObject);
    procedure actChoiceGoodsInRemainsGridExecute(Sender: TObject);
    procedure lcNameKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actSoldExecute(Sender: TObject);
    procedure actInsertUpdateCheckItemsExecute(Sender: TObject);
    procedure ceAmountKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ceAmountExit(Sender: TObject);
    procedure actPutCheckToCashExecute(Sender: TObject);           {********************}
    procedure ParentFormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actSetVIPExecute(Sender: TObject);
    procedure RemainsCDSAfterScroll(DataSet: TDataSet);
    procedure actCalcTotalSummExecute(Sender: TObject);
    procedure MainColReservedGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure actCashWorkExecute(Sender: TObject);
    procedure actClearAllExecute(Sender: TObject);
    procedure actClearMoneyExecute(Sender: TObject);
    procedure actGetMoneyInCashExecute(Sender: TObject);
    procedure actSpecExecute(Sender: TObject);
    procedure ParentFormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure lcNameExit(Sender: TObject);
    procedure actUpdateRemainsExecute(Sender: TObject);
    procedure actSetFocusExecute(Sender: TObject);
    procedure actRefreshRemainsExecute(Sender: TObject);
    procedure actExecuteLoadVIPExecute(Sender: TObject);
    procedure actRefreshAllExecute(Sender: TObject);
    procedure SaveLocalVIP;
    procedure MainGridDBTableViewFocusedRecordChanged(
      Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure TimerSaveAllTimer(Sender: TObject);
    procedure lcNameEnter(Sender: TObject);
    procedure TimerMoneyInCashTimer(Sender: TObject);
    procedure ParentFormShow(Sender: TObject);
    procedure actSelectLocalVIPCheckExecute(Sender: TObject);
    procedure actCheckConnectionExecute(Sender: TObject);
    procedure actSetDiscountExternalExecute(Sender: TObject);  //***20.07.16
    procedure CheckCDSBeforePost(DataSet: TDataSet);
    procedure TimerBlinkBtnTimer(Sender: TObject);
    procedure actSetConfirmedKind_CompleteExecute(Sender: TObject);
    procedure actSetConfirmedKind_UnCompleteExecute(Sender: TObject);
    procedure btnCheckClick(Sender: TObject);
    procedure ParentFormDestroy(Sender: TObject);
    procedure ceScanerKeyPress(Sender: TObject; var Key: Char); //***10.08.16   
    procedure actAddDiffMemdataExecute(Sender: TObject);
    procedure actSetRimainsFromMemdataExecute(Sender: TObject);
    procedure actSaveCashSesionIdToFileExecute(Sender: TObject);
    procedure actServiseRunExecute(Sender: TObject);
    procedure actSetMemdataFromDBFExecute(Sender: TObject);
    procedure actSetUpdateFromMemdataExecute(Sender: TObject); //***10.08.16
  private
    isScaner: Boolean;
    FSoldRegim: boolean;
    fShift: Boolean;
    FTotalSumm: Currency;
    Cash: ICash;
    SoldParallel: Boolean;
    SourceClientDataSet: TClientDataSet;
    ThreadErrorMessage:String;
    ASalerCash{,ASdacha}: Currency;
    PaidType: TPaidType;
    FiscalNumber: String;
    difUpdate: Boolean;
    VipCDS, VIPListCDS: TClientDataSet;
    VIPForm: TParentForm;
    // ��� ������� ������
    fBlinkVIP, fBlinkCheck : Boolean;
    time_onBlink, time_onBlinkCheck :TDateTime;
    MovementId_BlinkVIP:String;
    procedure SetBlinkVIP (isRefresh : boolean);
    procedure SetBlinkCheck (isRefresh : boolean);

    procedure SetSoldRegim(const Value: boolean);
    // ��������� ��������� ��������� ��� �������� ������ ����
    procedure NewCheck(ANeedRemainsRefresh: Boolean = True);
    // ��������� ���� ����
    procedure InsertUpdateBillCheckItems;
    //�������� ������� �������� ��������� �������
    procedure UpdateRemainsFromDiff(ADiffCDS : TClientDataSet);
    //���������� ����� � ������� ����
    procedure UpdateRemainsFromCheck(AGoodsId: Integer = 0; AAmount: Currency = 0; APriceSale: Currency = 0);

    //��������� "�����" ���-�� - ������� ��� ������� � ������� � � ���� ��������� ��� ���������� "�����" ���-��
    function fGetCheckAmountTotal(AGoodsId: Integer = 0; AAmount: Currency = 0) : Currency;

    // ��������� ����� �� ����
    procedure CalcTotalSumm;
    // ��� � �������� ������ - ������� � ��� ��� - �� ����� �������� ���� ����� ����
    procedure Add_Log_XML(AMessage: String);
    // ��������� ��� ����� ����
    function PutCheckToCash(SalerCash: Currency; PaidType: TPaidType;
      out AFiscalNumber, ACheckNumber: String): boolean;
    //����������� � ��������� ���� ������
    function InitLocalStorage: Boolean;
    //���������� ���� � ��������� ����. ���������� ���
    function SaveLocal(ADS :TClientDataSet; AManagerId: integer; AManagerName: String;
      ABayerName, ABayerPhone, AConfirmedKindName, AInvNumberOrder, AConfirmedKindClientName: String;
      ADiscountExternalId: integer; ADiscountExternalName, ADiscountCardNumber: String;
      NeedComplete: Boolean; FiscalCheckNumber: String; out AUID: String): Boolean;
    //��������� ��� � �������� ����
    procedure SaveReal(AUID: String; ANeedComplete: boolean = False);

    //������������ �������
    procedure StartRefreshDiffThread;

    //��������� ��� ���� �������
    function fCheck_RemainsError : Boolean;

    //������� � ��������� ���� � �������� �������
    procedure SaveRealAll;
    property SoldRegim: boolean read FSoldRegim write SetSoldRegim;
    procedure Thread_Exception(var Msg: TMessage); message UM_THREAD_EXCEPTION;
    procedure ConnectionModeChange(var Msg: TMessage); message UM_LOCAL_CONNECTION;
    procedure SetWorkMode(ALocal: Boolean);
    procedure AppMsgHandler(var Msg: TMsg; var Handled: Boolean);
  public
  end;



var
  MainCashForm: TMainCashForm2;
  CountRRT: Integer = 0;
  CountSaveThread: Integer = 0;
  ActualRemainSession: Integer = 0;
  FLocalDataBaseHead : TVKSmartDBF;
  FLocalDataBaseBody : TVKSmartDBF;
  FLocalDataBaseDiff : TVKSmartDBF;
  LocalDataBaseisBusy: Integer = 0;
  csCriticalSection,
  csCriticalSection_Save,
  csCriticalSection_All: TRTLCriticalSection;

  MutexDBF, MutexDBFDiff, MutexVip, MutexRemains, MutexAlternative, MutexAllowedConduct : THandle;
  LastErr: Integer;
  FM_SERVISE: Integer;  // ��� �������� ��������� ����� ���������� � ��������
  function GetSumm(Amount,Price:currency): currency;
  function GenerateGUID: String;

implementation

{$R *.dfm}

uses CashFactory, IniUtils, CashCloseDialog, VIPDialog, DiscountDialog, CashWork, MessagesUnit,
     LocalWorkUnit, Splash, DiscountService, MainCash, UnilWin;

const
  StatusUnCompleteCode = 1;
  StatusCompleteCode = 2;
  StatusUnCompleteId = 14;
  StatusCompleteId = 15;

procedure TMainCashForm2.AppMsgHandler(var Msg: TMsg; var Handled: Boolean);
begin
  Handled := (Msg.hwnd = Application.Handle) and (Msg.message = FM_SERVISE);
  if Handled and (Msg.wParam = 1) then   //   WPARAM = 1 ������ ��������� �� ������� � ����������  WPARAM = 2 �� ���������� � ������
    case Msg.lParam of
     1: // �������� ��������� �� ���������� diff ������� �� ���
        begin
         if difUpdate then
         begin
          difUpdate:=false;
//         ShowMessage('�������� ��������� �� ���������� diff ������� �� ���');
         actAddDiffMemdata.Execute;   // ���������� ��� � �������
         actSetRimainsFromMemdata.Execute; // ��������� ������� � ������� � ����� � ������ ��������� �������� � �������

         end;
        end;
     2:  // ������� ������ �� ���������� CashSessionId �  CashSessionId.ini
        begin
//         ShowMessage('������� ������ �� ���������� CashSessionId �  CashSessionId.ini');
         actSaveCashSesionIdToFile.Execute;
        end;


    end;
end;



function GetSumm(Amount,Price:currency): currency;
var
  A, P, RI: Cardinal;
  S1,S2:String;
begin
  if (Amount = 0) or (Price = 0) then
  Begin
    result := 0;
    exit;
  End;
  A := trunc(Amount * 1000);
  P := trunc(Price * 100);
  RI := A*P;
  S1 := IntToStr(RI);
  if Length(S1) < 4 then
    RI := 0
  else
    RI := StrToInt(Copy(S1,1,length(S1)-3));
  if (Length(S1)>=3) AND
     (StrToint(S1[length(S1)-2])>=5) then
    RI := RI + 1;
  Result := (RI / 100);
end;

function GenerateGUID: String;
var
  G: TGUID;
begin
  CreateGUID(G);
  Result := GUIDToString(G);
end;



procedure TMainCashForm2.actAddDiffMemdataExecute(Sender: TObject);
begin
//  ShowMessage('memdat-begin');
  WaitForSingleObject(MutexDBFDiff, INFINITE);
  FLocalDataBaseDiff.Open;
  if not MemData.Active then
  MemData.Open;
  MemData.DisableControls;
  FLocalDataBaseDiff.First;
    while not FLocalDataBaseDiff.Eof  do
     begin
      MemData.Append;
      MemData.FieldByName('ID').AsInteger:=FLocalDataBaseDiff.FieldByName('ID').AsInteger;
      MemData.FieldByName('GOODSCODE').AsInteger:=FLocalDataBaseDiff.FieldByName('GOODSCODE').AsInteger;
      MemData.FieldByName('GOODSNAME').AsString:=FLocalDataBaseDiff.FieldByName('GOODSNAME').AsString;
      MemData.FieldByName('PRICE').AsFloat:=FLocalDataBaseDiff.FieldByName('PRICE').AsFloat;
      MemData.FieldByName('REMAINS').AsFloat:=FLocalDataBaseDiff.FieldByName('REMAINS').AsFloat;
      MemData.FieldByName('MCSVALUE').AsFloat:=FLocalDataBaseDiff.FieldByName('MCSVALUE').AsFloat;
      MemData.FieldByName('RESERVED').AsFloat:=FLocalDataBaseDiff.FieldByName('RESERVED').AsFloat;
      MemData.FieldByName('NEWROW').AsBoolean:=FLocalDataBaseDiff.FieldByName('NEWROW').AsBoolean;
      FLocalDataBaseDiff.Edit;
      FLocalDataBaseDiff.DeleteRecord;
      FLocalDataBaseDiff.Post;
      MemData.Post;
      FLocalDataBaseDiff.Next;
     end;
  FLocalDataBaseDiff.Pack;
  FLocalDataBaseDiff.Close;
  MemData.EnableControls;
  ReleaseMutex(MutexDBFDiff);
// ShowMessage('memdat-end');
// ShowMessage(inttostr(MemData.RecordCount));
end;

procedure TMainCashForm2.actCalcTotalSummExecute(Sender: TObject);
begin
  CalcTotalSumm;
end;

procedure TMainCashForm2.actCashWorkExecute(Sender: TObject);
begin
  inherited;
  with TCashWorkForm.Create(Cash, RemainsCDS) do begin
    ShowModal;
    Free;
  end;
end;

procedure TMainCashForm2.actChoiceGoodsInRemainsGridExecute(Sender: TObject);
begin
  if MainGrid.IsFocused then
  Begin
    if RemainsCDS.isempty then exit;
    if RemainsCDS.FieldByName('Remains').asCurrency>0 then begin
       SourceClientDataSet := RemainsCDS;
       SoldRegim := true;
       lcName.Text := RemainsCDS.FieldByName('GoodsName').asString;
       ceAmount.Enabled := true;
       ceAmount.Value := 1;
       ActiveControl := ceAmount;
    end
  end
  else
  if AlternativeGrid.IsFocused then
  Begin
    if AlternativeCDS.isempty then exit;
    if AlternativeCDS.FieldByName('Remains').asCurrency>0 then begin
       SourceClientDataSet := AlternativeCDS;
       SoldRegim := true;
       lcName.Text := AlternativeCDS.FieldByName('GoodsName').asString;
       ceAmount.Enabled := true;
       ceAmount.Value := 1;
       ActiveControl := ceAmount;
    end
  End
  else
  Begin
    if CheckCDS.isEmpty then exit;
    if CheckCDS.FieldByName('Amount').asCurrency>0 then begin
       SourceClientDataSet := CheckCDS;
       SoldRegim := False;
       lcName.Text := CheckCDS.FieldByName('GoodsName').asString;
       ceAmount.Enabled := true;
       ceAmount.Value := -1;
       ActiveControl := ceAmount;
    end;
  End;
end;

procedure TMainCashForm2.actClearAllExecute(Sender: TObject);
begin
  //if CheckCDS.IsEmpty then exit;
  if MessageDlg('�������� ���?',mtConfirmation,mbYesNo,0)<>mrYes then exit;
  //������� ����� � ������� ����
  FormParams.ParamByName('CheckId').Value   := 0;
  FormParams.ParamByName('ManagerId').Value := 0;
  FormParams.ParamByName('BayerName').Value := '';
  //***20.07.16
  FormParams.ParamByName('DiscountExternalId').Value   := 0;
  FormParams.ParamByName('DiscountExternalName').Value := '';
  FormParams.ParamByName('DiscountCardNumber').Value   := '';
  //***16.08.16
  FormParams.ParamByName('BayerPhone').Value              := '';
  FormParams.ParamByName('ConfirmedKindName').Value       := '';
  FormParams.ParamByName('InvNumberOrder').Value          := '';
  FormParams.ParamByName('ConfirmedKindClientName').Value := '';

  FiscalNumber := '';
  pnlVIP.Visible := False;
  pnlDiscount.Visible := False;
  lblCashMember.Caption := '';
  lblBayer.Caption := '';
  chbNotMCS.Checked := False;
  UpdateRemainsFromCheck;
  CheckCDS.EmptyDataSet;
  StartRefreshDiffThread;
end;

procedure TMainCashForm2.actClearMoneyExecute(Sender: TObject);
begin
  lblMoneyInCash.Caption := '0.00';
end;

procedure TMainCashForm2.actExecuteLoadVIPExecute(Sender: TObject);
var lMsg: String;
begin
  inherited;
  //
  SetBlinkVIP(true);
  //
  if not CheckCDS.IsEmpty then
  Begin
    ShowMessage('������� ��� �� ������. ������� �������� ���!');
    exit;
  End;
  if gc_User.Local then
  Begin
    WaitForSingleObject(MutexVip, INFINITE);
    LoadLocalData(vipCDS, Vip_lcl);
    LoadLocalData(vipListCDS, VipList_lcl);
    ReleaseMutex(MutexVip);
  End;
  if actLoadVIP.Execute then
  Begin
    //������� "������" ���������-Main ***20.07.16
    DiscountServiceForm.pGetDiscountExternal (FormParams.ParamByName('DiscountExternalId').Value, FormParams.ParamByName('DiscountCardNumber').Value);
    // ***20.07.16
    if FormParams.ParamByName('DiscountExternalId').Value > 0 then
    begin
         //�������� ����� + �������� "�������" ���������-Main
         if not DiscountServiceForm.fCheckCard (lMsg
                                               ,DiscountServiceForm.gURL
                                               ,DiscountServiceForm.gService
                                               ,DiscountServiceForm.gPort
                                               ,DiscountServiceForm.gUserName
                                               ,DiscountServiceForm.gPassword
                                               ,FormParams.ParamByName('DiscountCardNumber').Value
                                               ,FormParams.ParamByName('DiscountExternalId').Value
                                               )
         then begin
            // �������, ����� ��������� ������ ������
            FormParams.ParamByName('DiscountExternalId').Value:= 0;
            // ������� "������" ���������-Item
            //DiscountServiceForm.pSetParamItemNull;
         end;

    end;
    // Update ������� � CDS - �� ���� "�������" �������
    DiscountServiceForm.fUpdateCDS_Discount (CheckCDS, lMsg, FormParams.ParamByName('DiscountExternalId').Value, FormParams.ParamByName('DiscountCardNumber').Value);
    //***20.07.16
    lblDiscountExternalName.Caption:= '  ' + FormParams.ParamByName('DiscountExternalName').Value + '  ';
    lblDiscountCardNumber.Caption  := '  ' + FormParams.ParamByName('DiscountCardNumber').Value + '  ';
    pnlDiscount.Visible            := FormParams.ParamByName('DiscountExternalId').Value > 0;

    lblCashMember.Caption := FormParams.ParamByName('ManagerName').AsString;
    if (FormParams.ParamByName('ConfirmedKindName').AsString <> '')
    then lblCashMember.Caption := lblCashMember.Caption + ' * ' + FormParams.ParamByName('ConfirmedKindName').AsString;
    if (FormParams.ParamByName('InvNumberOrder').AsString <> '')
    then lblCashMember.Caption := lblCashMember.Caption + ' * ' + '� ' + FormParams.ParamByName('InvNumberOrder').AsString;

    lblBayer.Caption := FormParams.ParamByName('BayerName').AsString;
    if (FormParams.ParamByName('BayerPhone').AsString <> '')
    then lblBayer.Caption := lblBayer.Caption + ' * ' + FormParams.ParamByName('BayerPhone').AsString;

    pnlVIP.Visible := true;
  End;
  if not gc_User.Local then
  Begin
    WaitForSingleObject(MutexVip, INFINITE);
    SaveLocalData(VIPCDS,vip_lcl);
    SaveLocalData(VIPListCDS,vipList_lcl);
    ReleaseMutex(MutexVip);
  End;
end;

procedure TMainCashForm2.actGetMoneyInCashExecute(Sender: TObject);
begin
  if gc_User.local then exit;

  spGet_Password_MoneyInCash.Execute;
  //�������� ����� ��� ������
  //if InputBox('������','������� ������:','') <> spGet_Password_MoneyInCash.ParamByName('outPassword').AsString then exit;
  //
  spGetMoneyInCash.ParamByName('inDate').Value := Date;
  spGetMoneyInCash.Execute;
  lblMoneyInCash.Caption := FormatFloat(',0.00',spGetMoneyInCash.ParamByName('outTotalSumm').AsFloat);
  //
  TimerMoneyInCash.Enabled:=True;
end;

procedure TMainCashForm2.TimerMoneyInCashTimer(Sender: TObject);
begin
 TimerMoneyInCash.Enabled:=False;
 try
  lblMoneyInCash.Caption := '0.00';
  TimerMoneyInCash.Enabled:=False;
 finally
  TimerMoneyInCash.Enabled:=True;
 end;
end;

procedure TMainCashForm2.actInsertUpdateCheckItemsExecute(Sender: TObject);
begin
  if ceAmount.Value <> 0 then begin //���� ��������� ���-�� 0 �� ������ ��������� � ���������� ����
    if not Assigned(SourceClientDataSet) then
      SourceClientDataSet := RemainsCDS;

    if SoldRegim AND (SourceClientDataSet.FieldByName('Price').asCurrency = 0) then begin
       ShowMessage('������ ������� ����� � 0 �����! ��������� � ����������');
       exit;
    end;
    InsertUpdateBillCheckItems;
  end;
  SoldRegim := true;
  if isScaner = true
  then ActiveControl := ceScaner
  else ActiveControl := lcName;
end;

//��������� ��� ���� �������
function TMainCashForm2.fCheck_RemainsError : Boolean;
var GoodsId_list, Amount_list : String;
    B:TBookmark;
begin
  Result:=false;
  //
  GoodsId_list:= '';
  Amount_list:= '';
  //
  //����������� ������ �������
  with CheckCDS do
  begin
    B:= GetBookmark;
    DisableControls;
    try
      First;
      while Not Eof do
      Begin
        if GoodsId_list <> '' then begin GoodsId_list :=  GoodsId_list + ';'; Amount_list :=  Amount_list + ';';end;
        GoodsId_list:= GoodsId_list + IntToStr(FieldByName('GoodsId').AsInteger);
        Amount_list:= Amount_list + FloatToStr(FieldByName('Amount').asCurrency);
        Next;
      End;
      GotoBookmark(B);
      FreeBookmark(B);
    finally
      EnableControls;
    end;
  end;
  //
  //������ �����
  with spCheck_RemainsError do
  try
      ParamByName('inGoodsId_list').Value := GoodsId_list;
      ParamByName('inAmount_list').Value := Amount_list;
      Execute;
      Result:=ParamByName('outMessageText').Value = '';
      //if not Result then ShowMessage(ParamByName('outMessageText').Value);
  except
       //�.�. ��� ����� � ��� �� �������� �������
       Result:=true;
  end;
  if not Result then
  begin actShowMessage.MessageText:= spCheck_RemainsError.ParamByName('outMessageText').Value;
        actShowMessage.Execute;
  end;
end;

procedure TMainCashForm2.actPutCheckToCashExecute(Sender: TObject);
var
  UID,CheckNumber: String;
  lMsg: String;
  fErr: Boolean;
  dsdSave: TdsdStoredProc;
begin
  if CheckCDS.RecordCount = 0 then exit;
  PaidType:=ptMoney;
  //�������� ����� � ��� ������
  if not fShift then
  begin// ���� � Shift, �� �������, ��� ���� ��� �����
    if not CashCloseDialogExecute(FTotalSumm,ASalerCash,PaidType) then
    Begin
      if Self.ActiveControl <> ceAmount then
        Self.ActiveControl := MainGrid;
      exit;
    End;
  end
  else
    ASalerCash:=FTotalSumm;
  //�������� ��� �������� ������
  ShapeState.Brush.Color := clYellow;
  ShapeState.Repaint;
  application.ProcessMessages;

  //��������� ��� ���� �������
  if fCheck_RemainsError = false then exit;

 //��������� ��� ���� ��� �� ��� �������� ������ ������ - 04.02.2017
  dsdSave := TdsdStoredProc.Create(nil);
  try
     //��������� � ����� ��������� ��������.
     dsdSave.StoredProcName := 'gpGet_Movement_CheckState';
     dsdSave.OutputType := otResult;
     dsdSave.Params.Clear;
     dsdSave.Params.AddParam('inId',ftInteger,ptInput,FormParams.ParamByName('CheckId').Value);
     dsdSave.Params.AddParam('outState',ftInteger,ptOutput,Null);
     dsdSave.Execute(False,False);
     if VarToStr(dsdSave.Params.ParamByName('outState').Value) = '2' then //��������
     Begin
          ShowMessage ('������.������ ��� ��� �������� ������ ������.��� ����������� - ���������� �������� ��� � ������� ������� ������.');
          exit;
     End;
  finally
     freeAndNil(dsdSave);
  end;

  //������� �� ������
  try
    if PutCheckToCash(MainCashForm.ASalerCash, MainCashForm.PaidType, FiscalNumber, CheckNumber) then
    Begin

      if (FormParams.ParamByName('DiscountExternalId').Value > 0)
      then fErr:= not DiscountServiceForm.fCommitCDS_Discount (CheckNumber, CheckCDS, lMsg , FormParams.ParamByName('DiscountExternalId').Value, FormParams.ParamByName('DiscountCardNumber').Value)
      else fErr:= false;

      if fErr = true
      then ShowMessage ('������.��� ����������.������� �� ���������')
      else
      begin
       ShapeState.Brush.Color := clRed;
       ShapeState.Repaint;
              if SaveLocal(CheckCDS,
                           FormParams.ParamByName('ManagerId').Value,
                           FormParams.ParamByName('ManagerName').Value,
                           FormParams.ParamByName('BayerName').Value,
                           //***16.08.16
                           FormParams.ParamByName('BayerPhone').Value,
                           FormParams.ParamByName('ConfirmedKindName').Value,
                           FormParams.ParamByName('InvNumberOrder').Value,
                           FormParams.ParamByName('ConfirmedKindClientName').Value,
                           //***20.07.16
                           FormParams.ParamByName('DiscountExternalId').Value,
                           FormParams.ParamByName('DiscountExternalName').Value,
                           FormParams.ParamByName('DiscountCardNumber').Value,

                           True,  // NEEDCOMPL
                           CheckNumber,
                           UID) then
              Begin
                SaveReal(UID, True);
                NewCheck(false);

              End;
      end; // else if fErr = true
    End;
  finally
    ShapeState.Brush.Color := clGreen;
    ShapeState.Repaint;
  end;
end;

procedure TMainCashForm2.actRefreshAllExecute(Sender: TObject);
var
  AfterScr: TDataSetNotifyEvent;
  lMsg: String;
begin
  startSplash('������ ���������� ������ � �������');
  try
    if  gc_User.Local AND RemainsCDS.IsEmpty then
    begin
//      ShowMessage('�������� �� Remains');
      MainGridDBTableView.BeginUpdate;
      AfterScr := RemainsCDS.AfterScroll;
      RemainsCDS.AfterScroll := nil;
      RemainsCDS.DisableControls;
      AlternativeCDS.DisableControls;
      try
        if not FileExists(Remains_lcl) or
           not FileExists(Alternative_lcl) then
        Begin
          ShowMessage('��� ���������� ���������. ���������� ������ ����������!');
          Close;
        End;
        WaitForSingleObject(MutexRemains, INFINITE);
        LoadLocalData(RemainsCDS, Remains_lcl);
        ReleaseMutex(MutexRemains);
        WaitForSingleObject(MutexAlternative, INFINITE);
        LoadLocalData(AlternativeCDS, Alternative_lcl);
        ReleaseMutex(MutexAlternative);
      finally
        RemainsCDS.EnableControls;
        AlternativeCDS.EnableControls;
        MainGridDBTableView.EndUpdate;
        RemainsCDS.AfterScroll := AfterScr;
        RemainsCDS.AfterScroll(RemainsCDS);
      end;
    end
    else
    if   not gc_User.Local then
    Begin
        MutexAllowedConduct := CreateMutex(nil, false, 'farmacycashMutexAlternative');
        LastErr := GetLastError;
//        ShowMessage(inttostr(LastErr));
        if LastErr = 183 then
         begin
          WaitForSingleObject(MutexAllowedConduct, INFINITE);


         end
          else
          begin
            // �������� ��������� � ����������� ������ ���������� �����
            PostMessage(HWND_BROADCAST, FM_SERVISE, 2, 10);
            WaitForSingleObject(MutexAllowedConduct, INFINITE);  // ������� �������� � �������

          end;
      //

      if Sender <> nil then
        InterlockedIncrement(ActualRemainSession); //��������� ������ ��������
      MainGridDBTableView.BeginUpdate;
      RemainsCDS.DisableControls;
      AlternativeCDS.DisableControls;
      AfterScr := RemainsCDS.AfterScroll;
      RemainsCDS.AfterScroll := nil;
      try
        ChangeStatus('�������� ��������� ��������� �� ������������� � ��������� Pfizer ���');
        lMsg:= '';
        if not DiscountServiceForm.fPfizer_Send(lMsg) then
        begin
             ChangeStatus('������ � ���������� Pfizer ��� :' + lMsg);
             sleep(10000);
        end
        else
        begin
             ChangeStatus('��������� ���������������� � ���������� Pfizer ��� ������� :' + lMsg);
             sleep(2000);
        end;


        ChangeStatus('��������� ��������');
        actRefresh.Execute;

        ChangeStatus('���������� �������� � ��������� ����');
        WaitForSingleObject(MutexRemains, INFINITE);
        SaveLocalData(RemainsCDS,Remains_lcl);
        ReleaseMutex(MutexRemains);
        WaitForSingleObject(MutexAlternative, INFINITE);
        SaveLocalData(AlternativeCDS,Alternative_lcl);
        ReleaseMutex(MutexAlternative);

        ChangeStatus('��������� ��� �����');

        SaveLocalVIP;
        ChangeStatus('���������� ��� ����� � ��������� ����');
      finally
        ChangeStatus('������������ ������ � ���� ���������');
        RemainsCDS.EnableControls;
        AlternativeCDS.EnableControls;
        MainGridDBTableView.EndUpdate;
        RemainsCDS.AfterScroll := AfterScr;
        RemainsCDS.AfterScroll(RemainsCDS);
      end;

      // ������   �������� �� ��� � �������� ������� � �����

      actSetMemdataFromDBF.Execute;

      actSetUpdateFromMemdata.Execute;


      ReleaseMutex(MutexAllowedConduct);
      // �����    �������� �� ��� � �������� ������� � �����


    End;
  finally
    EndSplash;
  end;
end;

procedure TMainCashForm2.actRefreshRemainsExecute(Sender: TObject);
begin
  StartRefreshDiffThread;
end;

procedure TMainCashForm2.actSaveCashSesionIdToFileExecute(Sender: TObject);
var
  myFile : TextFile;
  text   : string;

begin
  // ������� ������� Test.txt ���� ��� ������
  AssignFile(myFile, 'CashSessionId.ini');
  ReWrite(myFile);
  // ������ ���������� ��������� ���� � ���� ����
  WriteLn(myFile, FormParams.ParamByName('CashSessionId').Value);
  // �������� �����
  CloseFile(myFile);
  PostMessage(HWND_BROADCAST, FM_SERVISE, 2, 2);  // ���������� ��������� ��� ����� �������� ����� � ���������
end;



procedure TMainCashForm2.actSelectLocalVIPCheckExecute(Sender: TObject);
var
  vip,vipList: TClientDataSet;
begin
  inherited;
  vip := TClientDataSet.Create(Nil);
  vipList := TClientDataSet.Create(nil);
  try
    WaitForSingleObject(MutexVip, INFINITE);
    LoadLocalData(vip,vip_lcl);
    LoadLocalData(vipList,vipList_lcl);
    ReleaseMutex(MutexVip);
    if VIP.Locate('Id',FormParams.ParamByName('CheckId').Value,[]) then
    Begin
      vipList.Filter := 'MovementId = '+FormParams.ParamByName('CheckId').AsString;
      vipList.Filtered := True;
      vipList.First;
      While not vipList.Eof do
      Begin
        CheckCDS.Append;
        CheckCDS.FieldByName('Id').AsInteger := VipList.FieldByName('Id').AsInteger;
        CheckCDS.FieldByName('GoodsId').AsInteger := VipList.FieldByName('GoodsId').AsInteger;
        CheckCDS.FieldByName('GoodsCode').AsInteger := VipList.FieldByName('GoodsCode').AsInteger;
        CheckCDS.FieldByName('GoodsName').AsString := VipList.FieldByName('GoodsName').AsString;
        CheckCDS.FieldByName('Amount').AsFloat := 0;//VipList.FieldByName('Amount').AsFloat; //��������� ��������, �������� 0, ***20.07.16
        CheckCDS.FieldByName('Price').AsFloat := VipList.FieldByName('Price').AsFloat;
        CheckCDS.FieldByName('Summ').AsFloat := VipList.FieldByName('Summ').AsFloat;
        CheckCDS.FieldByName('NDS').AsFloat := VipList.FieldByName('NDS').AsFloat;
        //***20.07.16
        checkCDS.FieldByName('PriceSale').asCurrency         :=VipList.FieldByName('PriceSale').asCurrency;
        checkCDS.FieldByName('ChangePercent').asCurrency     :=VipList.FieldByName('ChangePercent').asCurrency;
        checkCDS.FieldByName('SummChangePercent').asCurrency :=VipList.FieldByName('SummChangePercent').asCurrency;
        //***19.08.16
        checkCDS.FieldByName('AmountOrder').asCurrency :=VipList.FieldByName('AmountOrder').asCurrency;
        //***10.08.16
        checkCDS.FieldByName('List_UID').AsString := VipList.FieldByName('List_UID').AsString;

        CheckCDS.Post;
        if FormParams.ParamByName('CheckId').Value > 0 then
          //UpdateRemainsFromCheck(CheckCDS.FieldByName('GoodsId').AsInteger, CheckCDS.FieldByName('Amount').AsFloat);
          //��������� ��������, ��������� � VipList, ***20.07.16
          UpdateRemainsFromCheck(VipList.FieldByName('GoodsId').AsInteger, VipList.FieldByName('Amount').AsFloat, VipList.FieldByName('PriceSale').asCurrency);
        vipList.Next;
      End;
    End;

  finally
    vip.Close;
    vip.Free;
    vipList.Close;
    vipList.Free;
  end;
end;

procedure TMainCashForm2.actServiseRunExecute(Sender: TObject);
var
SEInfo: TShellExecuteInfo;
ExitCode: DWORD;
ExecuteFile, ParamString, StartInString: string;
begin
  ExecuteFile := 'FarmacyCashServise.exe';
  FillChar(SEInfo, SizeOf(SEInfo), 0);
  SEInfo.cbSize := SizeOf(TShellExecuteInfo);
  with SEInfo do
    begin
      fMask := SEE_MASK_NOCLOSEPROCESS;
      Wnd := Application.Handle;
      lpFile := PChar(ExecuteFile);
      ParamString:='"'+IniUtils.gUserName+'" "'+iniutils.gPassValue+'"'; // ������� �����������

      // ParamString:= gc_User.Session;
      {ParamString can contain theapplication parameters.}
       lpParameters := PChar(ParamString);
      {StartInString specifies thename of the working
      directory.If ommited, the current directory is used.}
      // lpDirectory := PChar(StartInString);
      nShow := SW_SHOWNORMAL;
    end;

    if ShellExecuteEx(@SEInfo) then
    begin
//      repeat Application.HandleMessage;
//        GetExitCodeProcess(SEInfo.hProcess, ExitCode);
//      until (ExitCode <> STILL_ACTIVE) or Application.Terminated;
//     ShowMessage('��������� ����������');
    end
    else
      ShowMessage('������ ������� �������');
end;

procedure TMainCashForm2.actSetFocusExecute(Sender: TObject);
begin
  if isScaner = true
  then ActiveControl := ceScaner
  else ActiveControl := lcName;
end;

procedure TMainCashForm2.actSetMemdataFromDBFExecute(Sender: TObject);
begin
//  ShowMessage('actSetMemdataFromDBFExecute-begin');
  WaitForSingleObject(MutexDBF, INFINITE);
  FLocalDataBaseBody.Open;
  FLocalDataBaseHead.Open;
  if not MemData.Active then
  MemData.Open;
  MemData.DisableControls;
  FLocalDataBaseHead.First;
  while not  FLocalDataBaseHead.Eof do
    begin
        FLocalDataBaseBody.First;
          while not FLocalDataBaseBody.Eof  do
           begin
             if FLocalDataBaseHead.FieldByName('UID').AsString = FLocalDataBaseBody.FieldByName('CH_UID').AsString then
             begin

                MemData.Append;
                MemData.FieldByName('ID').AsInteger:=FLocalDataBaseBody.FieldByName('GOODSID').AsInteger;
                MemData.FieldByName('GOODSCODE').AsInteger:=FLocalDataBaseBody.FieldByName('GOODSCODE').AsInteger;
                MemData.FieldByName('GOODSNAME').AsString:=FLocalDataBaseBody.FieldByName('GOODSNAME').AsString;
                MemData.FieldByName('PRICE').AsFloat:=FLocalDataBaseBody.FieldByName('PRICE').AsFloat;


                if (FLocalDataBaseHead.FieldByName('MANAGER').AsInteger<> 0) or (Trim(FLocalDataBaseHead.FieldByName('BAYER').AsString)<>'')   then
                 begin
                  MemData.FieldByName('REMAINS').asCurrency:=0;
                  MemData.FieldByName('RESERVED').asCurrency:=FLocalDataBaseBody.FieldByName('AMOUNT').asCurrency;

                 end
                else
                 begin
                  MemData.FieldByName('REMAINS').asCurrency:=FLocalDataBaseBody.FieldByName('AMOUNT').asCurrency;
                  MemData.FieldByName('RESERVED').asCurrency:=0;
                 end;


                MemData.FieldByName('NEWROW').AsBoolean:=False;
                MemData.Post;

             end;
            FLocalDataBaseBody.Next;
           end;


     FLocalDataBaseHead.Next;
    end;

  FLocalDataBaseBody.Close;
  FLocalDataBaseHead.Close;
  MemData.EnableControls;
  ReleaseMutex(MutexDBF);
//  ShowMessage('actSetMemdataFromDBFExecute-end');
//  ShowMessage('MemData.RecordCount - ' +  inttostr(MemData.RecordCount));

end;

procedure TMainCashForm2.actSetRimainsFromMemdataExecute(Sender: TObject);
var
  GoodsId: Integer;
  Amount_find: Currency;
  oldFilter:String;
  oldFiltered:Boolean;
begin
//  ShowMessage('actSetRimainsFromMemdataExecute - begin');
  AlternativeCDS.DisableControls;
  RemainsCDS.AfterScroll := Nil;
  RemainsCDS.DisableControls;
  GoodsId := RemainsCDS.FieldByName('Id').asInteger;
  RemainsCDS.Filtered := False;
  AlternativeCDS.Filtered := False;
  CheckCDS.DisableControls;
  oldFilter:= CheckCDS.Filter;
  oldFiltered:= CheckCDS.Filtered;
  try
    MemData.First;
    while not MemData.eof do
    begin
          // ������� ������ ���-�� � �����
          CheckCDS.Filter:='GoodsId = ' + IntToStr(MemData.FieldByName('Id').AsInteger);
          CheckCDS.Filtered:=true;
          CheckCDS.First;
          Amount_find:=0;
          while not CheckCDS.EOF do begin
              Amount_find:= Amount_find + CheckCDS.FieldByName('Amount').asCurrency;
              CheckCDS.Next;
          end;
          CheckCDS.Filter := oldFilter;
          CheckCDS.Filtered:= oldFiltered;

      if not RemainsCDS.Locate('Id',MemData.FieldByName('Id').AsInteger,[]) and  MemData.FieldByName('NewRow').AsBoolean then
      Begin
        RemainsCDS.Append;
        RemainsCDS.FieldByName('Id').AsInteger := MemData.FieldByName('Id').AsInteger;
        RemainsCDS.FieldByName('GoodsCode').AsInteger := MemData.FieldByName('GoodsCode').AsInteger;
        RemainsCDS.FieldByName('GoodsName').AsString := MemData.FieldByName('GoodsName').AsString;
        RemainsCDS.FieldByName('Price').asCurrency := MemData.FieldByName('Price').asCurrency;
        RemainsCDS.FieldByName('Remains').asCurrency := MemData.FieldByName('Remains').asCurrency;
        RemainsCDS.FieldByName('MCSValue').asCurrency := MemData.FieldByName('MCSValue').asCurrency;
        RemainsCDS.FieldByName('Reserved').asCurrency := MemData.FieldByName('Reserved').asCurrency;
        RemainsCDS.Post;
      End
      else
      Begin
        if RemainsCDS.Locate('Id',MemData.FieldByName('Id').AsInteger,[]) then
        Begin
          RemainsCDS.Edit;
          RemainsCDS.FieldByName('Price').asCurrency := MemData.FieldByName('Price').asCurrency;
          RemainsCDS.FieldByName('Remains').asCurrency := MemData.FieldByName('Remains').asCurrency;
          RemainsCDS.FieldByName('MCSValue').asCurrency := MemData.FieldByName('MCSValue').asCurrency;
          RemainsCDS.FieldByName('Reserved').asCurrency := MemData.FieldByName('Reserved').asCurrency;
          {12.10.2016 - ������ �� �������, �.�. � CheckCDS ������ ����� ����������� GoodsId
          if CheckCDS.Locate('GoodsId',ADIffCDS.FieldByName('Id').AsInteger,[]) then
            RemainsCDS.FieldByName('Remains').asCurrency := RemainsCDS.FieldByName('Remains').asCurrency
              - CheckCDS.FieldByName('Amount').asCurrency;}
          RemainsCDS.FieldByName('Remains').asCurrency := RemainsCDS.FieldByName('Remains').asCurrency
                                                        - Amount_find;
          RemainsCDS.Post;
        End;
      End;
      MemData.Next;
    end;

    AlternativeCDS.First;
    while Not AlternativeCDS.eof do
    Begin
      if MemData.locate('Id',AlternativeCDS.fieldByName('Id').AsInteger,[]) then
      Begin
        if AlternativeCDS.FieldByName('Remains').asCurrency <> MemData.FieldByName('Remains').asCurrency then
        Begin
          AlternativeCDS.Edit;
          AlternativeCDS.FieldByName('Remains').asCurrency := MemData.FieldByName('Remains').asCurrency;
          {12.10.2016 - ������ �� �������, �.�. � CheckCDS ������ ����� ����������� GoodsId
          if CheckCDS.Locate('GoodsId',ADIffCDS.FieldByName('Id').AsInteger,[]) then
            AlternativeCDS.FieldByName('Remains').asCurrency := AlternativeCDS.FieldByName('Remains').asCurrency
              - CheckCDS.FieldByName('Amount').asCurrency;}
          AlternativeCDS.FieldByName('Remains').asCurrency := AlternativeCDS.FieldByName('Remains').asCurrency
                                                            - Amount_find;
          AlternativeCDS.Post;
        End;
      End;
      AlternativeCDS.Next;
    End;
    MemData.Close;
  finally
    RemainsCDS.Filtered := True;
    RemainsCDS.Locate('Id',GoodsId,[]);
    RemainsCDS.EnableControls;
    RemainsCDS.AfterScroll := RemainsCDSAfterScroll;
    AlternativeCDS.Filtered := true;
    RemainsCDSAfterScroll(RemainsCDS);
    AlternativeCDS.EnableControls;
    CheckCDS.EnableControls;
    CheckCDS.Filter := oldFilter;
    CheckCDS.Filtered:= oldFiltered;
    difUpdate:=true;
  end;

//  ShowMessage('actSetRimainsFromMemdataExecute - end');

end;

procedure TMainCashForm2.actSetUpdateFromMemdataExecute(Sender: TObject);
var
  GoodsId: Integer;
  Amount_find: Currency;
  oldFilter:String;
  oldFiltered:Boolean;
begin
//  ShowMessage('actSetUpdateFromMemdataExecute - begin');
  AlternativeCDS.DisableControls;
  RemainsCDS.AfterScroll := Nil;
  RemainsCDS.DisableControls;
  GoodsId := RemainsCDS.FieldByName('Id').asInteger;
  RemainsCDS.Filtered := False;
  AlternativeCDS.Filtered := False;
  CheckCDS.DisableControls;
  oldFilter:= CheckCDS.Filter;
  oldFiltered:= CheckCDS.Filtered;
  try
    MemData.First;
    while not MemData.eof do
    begin
          // ������� ������ ���-�� � �����
          CheckCDS.Filter:='GoodsId = ' + IntToStr(MemData.FieldByName('Id').AsInteger);
          CheckCDS.Filtered:=true;
          CheckCDS.First;
          Amount_find:=0;
          while not CheckCDS.EOF do begin
              Amount_find:= Amount_find + CheckCDS.FieldByName('Amount').asCurrency;
              CheckCDS.Next;
          end;
          CheckCDS.Filter := oldFilter;
          CheckCDS.Filtered:= oldFiltered;

      if not RemainsCDS.Locate('Id',MemData.FieldByName('Id').AsInteger,[]) and  MemData.FieldByName('NewRow').AsBoolean then
      Begin
        RemainsCDS.Append;
        RemainsCDS.FieldByName('Id').AsInteger := MemData.FieldByName('Id').AsInteger;
        RemainsCDS.FieldByName('GoodsCode').AsInteger := MemData.FieldByName('GoodsCode').AsInteger;
        RemainsCDS.FieldByName('GoodsName').AsString := MemData.FieldByName('GoodsName').AsString;
        RemainsCDS.FieldByName('Price').asCurrency := MemData.FieldByName('Price').asCurrency;
        RemainsCDS.FieldByName('Remains').asCurrency := RemainsCDS.FieldByName('Remains').asCurrency - MemData.FieldByName('Remains').asCurrency - MemData.FieldByName('Reserved').asCurrency;
        RemainsCDS.FieldByName('Reserved').asCurrency :=  RemainsCDS.FieldByName('Reserved').asCurrency + MemData.FieldByName('Reserved').asCurrency;
        RemainsCDS.Post;
      End
      else
      Begin
        if RemainsCDS.Locate('Id',MemData.FieldByName('Id').AsInteger,[]) then
        Begin
          RemainsCDS.Edit;
          RemainsCDS.FieldByName('Price').asCurrency := MemData.FieldByName('Price').asCurrency;
          RemainsCDS.FieldByName('Remains').asCurrency := RemainsCDS.FieldByName('Remains').asCurrency - MemData.FieldByName('Remains').asCurrency -  MemData.FieldByName('Reserved').asCurrency;
          RemainsCDS.FieldByName('Reserved').asCurrency := RemainsCDS.FieldByName('Reserved').asCurrency + MemData.FieldByName('Reserved').asCurrency;
          {12.10.2016 - ������ �� �������, �.�. � CheckCDS ������ ����� ����������� GoodsId
          if CheckCDS.Locate('GoodsId',ADIffCDS.FieldByName('Id').AsInteger,[]) then
            RemainsCDS.FieldByName('Remains').asCurrency := RemainsCDS.FieldByName('Remains').asCurrency
              - CheckCDS.FieldByName('Amount').asCurrency;}
          RemainsCDS.FieldByName('Remains').asCurrency := RemainsCDS.FieldByName('Remains').asCurrency
                                                        - Amount_find;
          RemainsCDS.Post;
        End;
      End;
      MemData.Next;
    end;

    AlternativeCDS.First;
    while Not AlternativeCDS.eof do
    Begin
      if MemData.locate('Id',AlternativeCDS.fieldByName('Id').AsInteger,[]) then
      Begin
        if AlternativeCDS.FieldByName('Remains').asCurrency <> MemData.FieldByName('Remains').asCurrency then
        Begin
          AlternativeCDS.Edit;
          AlternativeCDS.FieldByName('Remains').asCurrency := AlternativeCDS.FieldByName('Remains').asCurrency - MemData.FieldByName('Remains').asCurrency -  MemData.FieldByName('Reserved').asCurrency;
          {12.10.2016 - ������ �� �������, �.�. � CheckCDS ������ ����� ����������� GoodsId
          if CheckCDS.Locate('GoodsId',ADIffCDS.FieldByName('Id').AsInteger,[]) then
            AlternativeCDS.FieldByName('Remains').asCurrency := AlternativeCDS.FieldByName('Remains').asCurrency
              - CheckCDS.FieldByName('Amount').asCurrency;}
          AlternativeCDS.FieldByName('Remains').asCurrency :=  AlternativeCDS.FieldByName('Remains').asCurrency
                                                            - Amount_find;
          AlternativeCDS.Post;
        End;
      End;
      AlternativeCDS.Next;
    End;
    MemData.Close;
  finally
    RemainsCDS.Filtered := True;
    RemainsCDS.Locate('Id',GoodsId,[]);
    RemainsCDS.EnableControls;
    RemainsCDS.AfterScroll := RemainsCDSAfterScroll;
    AlternativeCDS.Filtered := true;
    RemainsCDSAfterScroll(RemainsCDS);
    AlternativeCDS.EnableControls;
    CheckCDS.EnableControls;
    CheckCDS.Filter := oldFilter;
    CheckCDS.Filtered:= oldFiltered;
    difUpdate:=true;
  end;

//  ShowMessage('actSetUpdateFromMemdataExecute - end');


end;

procedure TMainCashForm2.actSetConfirmedKind_CompleteExecute(Sender: TObject);
var UID: String;
    lConfirmedKindName:String;
begin
  if FormParams.ParamByName('CheckId').Value = 0 then
  begin
       ShowMessage('������.VIP-��� �� ��������.');
       exit
  end;

  // �������� <������ ������> � �������� ��� ��������
  with spUpdate_ConfirmedKind do
  try
      ParamByName('inMovementId').Value := FormParams.ParamByName('CheckId').Value;
      ParamByName('inDescName').Value := 'zc_Enum_ConfirmedKind_Complete';
      Execute;
      lConfirmedKindName:=ParamByName('ouConfirmedKindName').Value;
  except
        ShowMessage('������.��� ����� � ��������');
  end;

  if spUpdate_ConfirmedKind.ParamByName('outMessageText').Value <> '' then
  begin actShowMessage.MessageText:= spUpdate_ConfirmedKind.ParamByName('outMessageText').Value;
        actShowMessage.Execute;
  end;

  if lConfirmedKindName = '' then
  begin
        ShowMessage('������.������ �������� ������ ����');
        exit;
  end;

  FormParams.ParamByName('ConfirmedKindName').Value:= lConfirmedKindName;

  if SaveLocal(CheckCDS
              ,FormParams.ParamByName('ManagerId').Value
              ,FormParams.ParamByName('ManagerName').Value
              ,FormParams.ParamByName('BayerName').Value
               //***16.08.16
              ,FormParams.ParamByName('BayerPhone').Value
              ,lConfirmedKindName
              ,FormParams.ParamByName('InvNumberOrder').Value
              ,FormParams.ParamByName('ConfirmedKindClientName').Value
               //***20.07.16
              ,FormParams.ParamByName('DiscountExternalId').Value
              ,FormParams.ParamByName('DiscountExternalName').Value
              ,FormParams.ParamByName('DiscountCardNumber').Value

              ,False,'',UID)
  then begin
    SaveReal(UID);
    //
    NewCheck(False);
    //
    lblCashMember.Caption := FormParams.ParamByName('ManagerName').AsString
                   + ' * ' + FormParams.ParamByName('ConfirmedKindName').AsString
                   + ' * ' + '� ' + FormParams.ParamByName('InvNumberOrder').AsString;
  End;

  //
  SetBlinkVIP (true);
end;

procedure TMainCashForm2.actSetConfirmedKind_UnCompleteExecute(Sender: TObject);
var UID: String;
    lConfirmedKindName:String;
begin
  if FormParams.ParamByName('CheckId').Value = 0 then
  begin
       ShowMessage('������.VIP-��� �� ��������.');
       exit
  end;

  // �������� <������ ������> � �������� ��� ��������
  with spUpdate_ConfirmedKind do
  try
      ParamByName('inMovementId').Value := FormParams.ParamByName('CheckId').Value;
      ParamByName('inDescName').Value := 'zc_Enum_ConfirmedKind_UnComplete';
      Execute;
      lConfirmedKindName:=ParamByName('ouConfirmedKindName').Value;
  except
        ShowMessage('������.��� ����� � ��������');
  end;

  if lConfirmedKindName = '' then
  begin
        ShowMessage('������.������ �������� ������ ����');
        exit;
  end;

  FormParams.ParamByName('ConfirmedKindName').Value:= lConfirmedKindName;

  if SaveLocal(CheckCDS
              ,FormParams.ParamByName('ManagerId').Value
              ,FormParams.ParamByName('ManagerName').Value
              ,FormParams.ParamByName('BayerName').Value
               //***16.08.16
              ,FormParams.ParamByName('BayerPhone').Value
              ,lConfirmedKindName
              ,FormParams.ParamByName('InvNumberOrder').Value
              ,FormParams.ParamByName('ConfirmedKindClientName').Value
               //***20.07.16
              ,FormParams.ParamByName('DiscountExternalId').Value
              ,FormParams.ParamByName('DiscountExternalName').Value
              ,FormParams.ParamByName('DiscountCardNumber').Value

              ,False,'',UID)
  then begin
    SaveReal(UID);
    //
    NewCheck(False);
    //
    lblCashMember.Caption := FormParams.ParamByName('ManagerName').AsString
                   + ' * ' + FormParams.ParamByName('ConfirmedKindName').AsString
                   + ' * ' + '� ' + FormParams.ParamByName('InvNumberOrder').AsString;
  End;

  //
  SetBlinkVIP (true);
end;

//***20.07.16
procedure TMainCashForm2.actSetDiscountExternalExecute(Sender: TObject);
var
  DiscountExternalId:Integer;
  DiscountExternalName,DiscountCardNumber: String;
  lMsg: String;
begin
  with TDiscountDialogForm.Create(nil) do
  try
     DiscountExternalId  := Self.FormParams.ParamByName('DiscountExternalId').Value;
     DiscountExternalName:= Self.FormParams.ParamByName('DiscountExternalName').Value;
     DiscountCardNumber  := Self.FormParams.ParamByName('DiscountCardNumber').Value;
     if not DiscountDialogExecute(DiscountExternalId,DiscountExternalName,DiscountCardNumber)
     then exit;
  finally
     Free;
  end;
  //
  FormParams.ParamByName('DiscountExternalId').Value := DiscountExternalId;
  FormParams.ParamByName('DiscountExternalName').Value := DiscountExternalName;
  FormParams.ParamByName('DiscountCardNumber').Value := DiscountCardNumber;
  // update DataSet - ��� ��� �� ���� "�������" �������
  DiscountServiceForm.fUpdateCDS_Discount (CheckCDS, lMsg, FormParams.ParamByName('DiscountExternalId').Value, FormParams.ParamByName('DiscountCardNumber').Value);
  //
  pnlDiscount.Visible    := DiscountExternalId > 0;
  lblDiscountExternalName.Caption:= '  ' + DiscountExternalName + '  ';
  lblDiscountCardNumber.Caption  := '  ' + DiscountCardNumber + '  ';
end;

procedure TMainCashForm2.actSetVIPExecute(Sender: TObject);
var
  ManagerID:Integer;
  ManagerName,BayerName: String;
  ConfirmedKindName_calc: String;
  UID: String;
begin
 // ShowMessage('actSetVIPExecute');
  if not VIPDialogExecute(ManagerID,ManagerName,BayerName) then exit;
  //
  FormParams.ParamByName('ManagerId').Value   := ManagerId;
  FormParams.ParamByName('ManagerName').Value := ManagerName;
  FormParams.ParamByName('BayerName').Value   := BayerName;
  if FormParams.ParamByName('ConfirmedKindName').Value = ''
  then FormParams.ParamByName('ConfirmedKindName').Value:= '�����������';
  ConfirmedKindName_calc:=FormParams.ParamByName('ConfirmedKindName').Value;
  //
  if SaveLocal(CheckCDS,ManagerId,ManagerName,BayerName
               //***16.08.16
              ,FormParams.ParamByName('BayerPhone').Value
              ,ConfirmedKindName_calc
              ,FormParams.ParamByName('InvNumberOrder').Value
              ,FormParams.ParamByName('ConfirmedKindClientName').Value
               //***20.07.16
              ,FormParams.ParamByName('DiscountExternalId').Value
              ,FormParams.ParamByName('DiscountExternalName').Value
              ,FormParams.ParamByName('DiscountCardNumber').Value

              ,False,'',UID)
  then begin
    NewCheck(False);
    SaveReal(UID);
  End;
end;

procedure TMainCashForm2.actSoldExecute(Sender: TObject);
begin
  SoldRegim:= not SoldRegim;
  ceAmount.Enabled := false;
  lcName.Text := '';
  if isScaner = true
  then ActiveControl := ceScaner
  else ActiveControl := lcName;
end;

procedure TMainCashForm2.actSpecExecute(Sender: TObject);
begin
  if Assigned(Cash) then
    Cash.AlwaysSold := actSpec.Checked;
end;

procedure TMainCashForm2.actUpdateRemainsExecute(Sender: TObject);
begin
  UpdateRemainsFromDiff(nil);
end;

procedure TMainCashForm2.btnCheckClick(Sender: TObject);
begin
  SetBlinkCheck(true);
  if fBlinkCheck = true
  then actOpenCheckVIP_Error.Execute
  else actCheck.Execute;
end;

procedure TMainCashForm2.ceAmountExit(Sender: TObject);
begin
  ceAmount.Enabled := false;
  lcName.Text := '';
end;

procedure TMainCashForm2.ceAmountKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_Return then
     actInsertUpdateCheckItems.Execute
end;

procedure TMainCashForm2.ceScanerKeyPress(Sender: TObject; var Key: Char);
var isFind : Boolean;
    Key2 : Word;
begin
   isFind:= false;
   isScaner:= true;
   //
   if Key = #13 then
   begin
       try
           StrToInt(Copy(ceScaner.Text,4, 9));
           //
           RemainsCDS.AfterScroll := nil;
           RemainsCDS.DisableConstraints;
           //�����
           isFind:= RemainsCDS.Locate('GoodsId_main', StrToInt(Copy(ceScaner.Text,4, 9)), []);
           //��� ��������� ��� �����...
           isFind:= (isFind) and (RemainsCDS.FieldByName('GoodsId_main').AsInteger = StrToInt(Copy(ceScaner.Text,4, 9)));
           //
           if isFind
           then lbScaner.Caption:='������� ' + ceScaner.Text
           else lbScaner.Caption:='�� ������� ' + ceScaner.Text;
           //
           ceScaner.Text:='';
       except
            lbScaner.Caption:='������ � �/�';
       end;
       //
       RemainsCDS.EnableConstraints;
       RemainsCDS.AfterScroll := RemainsCDSAfterScroll;
   end;

   if isFind = true then
   begin
        isScaner:=true;
        //
        lcName.Text:= RemainsCDS.FieldByName('GoodsName').AsString;
        Key2:= VK_Return;
        lcNameKeyDown(Self, Key2, []);
    end;

end;

procedure TMainCashForm2.actCheckConnectionExecute(Sender: TObject);
begin
  try
    spGet_User_IsAdmin.Execute;
    gc_User.Local := False;
    ShowMessage('����� ������: � ����');
  except
    Begin
      gc_User.Local := True;
      ShowMessage('����� ������: ���������');
    End;
  end;
end;

procedure TMainCashForm2.CheckCDSBeforePost(DataSet: TDataSet);

begin
  inherited;
  if DataSet.FieldByName('List_UID').AsString = '' then
    DataSet.FieldByName('List_UID').AsString := GenerateGUID;
end;

procedure TMainCashForm2.ConnectionModeChange(var Msg: TMessage);
begin
  SetWorkMode(gc_User.Local);
end;

procedure TMainCashForm2.FormCreate(Sender: TObject);
var
  F: String;
begin
  inherited;

  Application.OnMessage := AppMsgHandler;
  isScaner:= false;
  //���
  // ������� ������� ���� �� �������
  MutexDBF := CreateMutex(nil, false, 'farmacycashMutexDBF');
  LastErr := GetLastError;
  MutexDBFDiff := CreateMutex(nil, false, 'farmacycashMutexDBFDiff');
  LastErr := GetLastError;
  MutexVip := CreateMutex(nil, false, 'farmacycashMutexVip');
  LastErr := GetLastError;
  MutexRemains := CreateMutex(nil, false, 'farmacycashMutexRemains');
  LastErr := GetLastError;
  MutexAlternative := CreateMutex(nil, false, 'farmacycashMutexAlternative');
  LastErr := GetLastError;


  DiscountServiceForm:= TDiscountServiceForm.Create(Self);


  //��������� ���� ��� ����������� ������
  ChangeStatus('��������� �������������� ����������');
  FormParams.ParamByName('CashSessionId').Value := GenerateGUID;
  actSaveCashSesionIdToFile.Execute;

  FormParams.ParamByName('ClosedCheckId').Value := 0;
  FormParams.ParamByName('CheckId').Value := 0;
  ShapeState.Brush.Color := clGreen;
  if NOT GetIniFile(F) then
  Begin
    Application.Terminate;
    exit;
  End;
  ChangeStatus('�������� ������� ������������');
  UserSettingsStorageAddOn.LoadUserSettings;
  try
    ChangeStatus('������������� ������������');
    Cash:=TCashFactory.GetCash(iniCashType);

    if (Cash <> nil) AND (Cash.FiscalNumber = '') then
    Begin
      MessageDlg('������ ������������� ��������� ��������. ���������� ������ ��������� ����������.' + #13#10 +
                 '��� ��������� ������� ���� "DATECS FP-320" ' + #13#10 +
                 '���������� ������ ��� �������� ����� � ���� ��������' + #13#10 +
                 '(������ [TSoldWithCompMainForm] �������� "FP320SERIAL")', mtError, [mbOK], 0);

      Application.Terminate;
      exit;
    End;

  except
    Begin
      ShowMessage('��������! ��������� �� ����� ������������ � ����������� ��������.'+#13+
                  '���������� ������ ��������� �������� ������ � ������������ ������!');
    End;
  end;

  ChangeStatus('������������� ���������� ���������');
  if not InitLocalStorage then
  Begin
    Application.Terminate;
    exit;
  End;

 // SetWorkMode(gc_User.Local);

  SoldParallel:=iniSoldParallel;
  CheckCDS.CreateDataSet;
  ChangeStatus('���������� ������ ����');
  NewCheck;
  OnCLoseQuery := ParentFormCloseQuery;
  OnShow := ParentFormShow;

//   TimerSaveAll.Enabled := true;
// �������� ��������

  SetBlinkVIP (true);
  SetBlinkCheck (true);
  TimerBlinkBtn.Enabled := true;

  actServiseRun.Execute; // ������ �������
end;

function TMainCashForm2.InitLocalStorage: Boolean;
var fields11, fields12, fields13, fields14, fields15, fields16, fields17, fields18: TVKDBFFieldDefs;
    fields21, fields22, fields23, fields24, fields25: TVKDBFFieldDefs;
  procedure InitTable(DS: TVKSmartDBF; AFileName: String);
  Begin
    DS.DBFFileName := AnsiString(AFileName);
    DS.OEM := False;
    DS.AccessMode.OpenReadWrite := true;
  End;
begin
  result := False;
  WaitForSingleObject(MutexDBF, INFINITE);
  WaitForSingleObject(MutexDBFDiff, INFINITE);
  InitTable(FLocalDataBaseHead, iniLocalDataBaseHead);
  InitTable(FLocalDataBaseBody, iniLocalDataBaseBody);
  InitTable(FLocalDataBaseDiff, iniLocalDataBaseDiff);
   if (not FileExists(iniLocalDataBaseDiff)) then
  begin
    AddIntField(FLocalDataBaseDiff,'ID'); //id ������
    AddIntField(FLocalDataBaseDiff,'GOODSCODE'); //��� ������
    AddStrField(FLocalDataBaseDiff,'GOODSNAME',254); //������������ ������
    AddFloatField(FLocalDataBaseDiff,'PRICE'); //����
    AddFloatField(FLocalDataBaseDiff,'REMAINS'); // �������
    AddFloatField(FLocalDataBaseDiff,'MCSVALUE'); //
    AddFloatField(FLocalDataBaseDiff,'RESERVED'); //
    AddBoolField(FLocalDataBaseDiff,'NEWROW'); //

    try
      FLocalDataBaseDiff.CreateTable;
    except ON E: Exception do
      Begin
        Application.OnException(Application.MainForm,E);
//        ShowMessage('������ �������� ���������� ���������: '+E.Message);
        Exit;
      End;
    end;
  end;

  if (not FileExists(iniLocalDataBaseHead)) then
  begin
    AddIntField(FLocalDataBaseHead,'ID');//id ����
    AddStrField(FLocalDataBaseHead,'UID',50);//uid ����
    AddDateField(FLocalDataBaseHead,'DATE'); //����/����� ����
    AddIntField(FLocalDataBaseHead,'PAIDTYPE'); //��� ������
    AddStrField(FLocalDataBaseHead,'CASH',20); //�������� ��������
    AddIntField(FLocalDataBaseHead,'MANAGER'); //Id ��������� (VIP)
    AddStrField(FLocalDataBaseHead,'BAYER',254); //���������� (VIP)
    AddBoolField(FLocalDataBaseHead,'SAVE'); //���������� (VIP)
    AddBoolField(FLocalDataBaseHead,'COMPL'); //���������� (VIP)
    AddBoolField(FLocalDataBaseHead,'NEEDCOMPL'); //����� �������� ��������
    AddBoolField(FLocalDataBaseHead,'NOTMCS'); //�� ��������� � ������� ���
    AddStrField(FLocalDataBaseHead,'FISCID',50); //����� ����������� ����
    //***20.07.16
    AddIntField(FLocalDataBaseHead,'DISCOUNTID');    //Id ������� ���������� ����
    AddStrField(FLocalDataBaseHead,'DISCOUNTN',254); //�������� ������� ���������� ����
    AddStrField(FLocalDataBaseHead,'DISCOUNT',50);   //� ���������� �����
    //***16.08.16
    AddStrField(FLocalDataBaseHead,'BAYERPHONE',50); //���������� ������� (����������) - BayerPhone
    AddStrField(FLocalDataBaseHead,'CONFIRMED',50);  //������ ������ (��������� VIP-����) - ConfirmedKind
    AddStrField(FLocalDataBaseHead,'NUMORDER',50);   //����� ������ (� �����) - InvNumberOrder
    AddStrField(FLocalDataBaseHead,'CONFIRMEDC',50); //������ ������ (��������� VIP-����) - ConfirmedKindClient

      // ��� ������� �������� ������� ����� ��� ������� ���� ������� // ����� ��������������� �����
    AddStrField(FLocalDataBaseHead,'USERSESION',50);
    try
      FLocalDataBaseHead.CreateTable;
    except ON E: Exception do
      Begin
        Application.OnException(Application.MainForm,E);
//        ShowMessage('������ �������� ���������� ���������: '+E.Message);
        Exit;
      End;
    end;
     FLocalDataBaseHead.Close;
  end
  // !!!��������� ����� ����
  else begin
          FLocalDataBaseHead.Open;

          //
          if FLocalDataBaseHead.FindField('DISCOUNTID') = nil then
          begin
               fields11:=TVKDBFFieldDefs.Create(self);
               with fields11.Add as TVKDBFFieldDef do
               begin
                    Name := 'DISCOUNTID';
                    field_type := 'N';
                    len := 10;
               end;
               FLocalDataBaseHead.AddFields(fields11,1000);
           end;
          //
          if FLocalDataBaseHead.FindField('DISCOUNTN') = nil then
          begin
               fields12:=TVKDBFFieldDefs.Create(self);
               with fields12.Add as TVKDBFFieldDef do
               begin
                    Name := 'DISCOUNTN';
                    field_type := 'C';
                    len := 254;
               end;
               FLocalDataBaseHead.AddFields(fields12,1000);
           end;
          //
          if FLocalDataBaseHead.FindField('DISCOUNT') = nil then
          begin
               fields13:=TVKDBFFieldDefs.Create(self);
               with fields13.Add as TVKDBFFieldDef do
               begin
                    Name := 'DISCOUNT';
                    field_type := 'C';
                    len := 50;
               end;
               FLocalDataBaseHead.AddFields(fields13,1000);
           end;
          //***16.08.16
          if FLocalDataBaseHead.FindField('BAYERPHONE') = nil then
          begin
               fields14:=TVKDBFFieldDefs.Create(self);
               with fields14.Add as TVKDBFFieldDef do
               begin
                    Name := 'BAYERPHONE';
                    field_type := 'C';
                    len := 50;
               end;
               FLocalDataBaseHead.AddFields(fields14,1000);
           end;
          //***16.08.16
          if FLocalDataBaseHead.FindField('CONFIRMED') = nil then
          begin
               fields15:=TVKDBFFieldDefs.Create(self);
               with fields15.Add as TVKDBFFieldDef do
               begin
                    Name := 'CONFIRMED';
                    field_type := 'C';
                    len := 50;
               end;
               FLocalDataBaseHead.AddFields(fields15,1000);
           end;
          //***16.08.16
          if FLocalDataBaseHead.FindField('NUMORDER') = nil then
          begin
               fields16:=TVKDBFFieldDefs.Create(self);
               with fields16.Add as TVKDBFFieldDef do
               begin
                    Name := 'NUMORDER';
                    field_type := 'C';
                    len := 50;
               end;
               FLocalDataBaseHead.AddFields(fields16,1000);
           end;
          //***25.08.16
          if FLocalDataBaseHead.FindField('CONFIRMEDC') = nil then
          begin
               fields17:=TVKDBFFieldDefs.Create(self);
               with fields17.Add as TVKDBFFieldDef do
               begin
                    Name := 'CONFIRMEDC';
                    field_type := 'C';
                    len := 50;
               end;
               FLocalDataBaseHead.AddFields(fields17,1000);
           end;
           //
              if FLocalDataBaseHead.FindField('USERSESION') = nil then
          begin
               fields18:=TVKDBFFieldDefs.Create(self);
               with fields18.Add as TVKDBFFieldDef do
               begin
                    Name := 'USERSESION';
                    field_type := 'C';
                    len := 50;
               end;
               FLocalDataBaseHead.AddFields(fields18,1000);
           end;


           FLocalDataBaseHead.Close;
  end;// !!!��������� ����� ����


  if (not FileExists(iniLocalDataBaseBody)) then
  begin
    AddIntField(FLocalDataBaseBody,'ID'); //id ������
    AddStrField(FLocalDataBaseBody,'CH_UID',50); //uid ����
    AddIntField(FLocalDataBaseBody,'GOODSID'); //�� ������
    AddIntField(FLocalDataBaseBody,'GOODSCODE'); //��� ������
    AddStrField(FLocalDataBaseBody,'GOODSNAME',254); //������������ ������
    AddFloatField(FLocalDataBaseBody,'NDS'); //��� ������
    AddFloatField(FLocalDataBaseBody,'AMOUNT'); //���-��
    AddFloatField(FLocalDataBaseBody,'PRICE'); //����, � 20.07.16 ���� ���� ������ �� ������� ��������, ����� ����� ���� � ������ ������
    //***20.07.16
    AddFloatField(FLocalDataBaseBody,'PRICESALE'); //���� ��� ������
    AddFloatField(FLocalDataBaseBody,'CHPERCENT'); //% ������
    AddFloatField(FLocalDataBaseBody,'SUMMCH');    //����� ������
    //***19.08.16
    AddFloatField(FLocalDataBaseBody,'AMOUNTORD'); //���-�� ������
    //***10.08.16
    AddStrField(FLocalDataBaseBody,'LIST_UID',50); //UID ������ �������
    try
      FLocalDataBaseBody.CreateTable;
    except ON E: Exception do
      Begin
        Application.OnException(Application.MainForm,E);
//        ShowMessage('������ �������� ���������� ���������: '+E.Message);
        Exit;
      End;
    end;
  end
  // !!!��������� ����� ����
  else begin
          FLocalDataBaseBody.Open;
          //
          if FLocalDataBaseBody.FindField('PRICESALE') = nil then
          begin
               fields21:=TVKDBFFieldDefs.Create(self);
               with fields21.Add as TVKDBFFieldDef do
               begin
                    Name := 'PRICESALE';
                    field_type := 'N';
                    len := 10;
                    dec := 4;
               end;
               FLocalDataBaseBody.AddFields(fields21,1000);
           end;
          //
          if FLocalDataBaseBody.FindField('CHPERCENT') = nil then
          begin
               fields22:=TVKDBFFieldDefs.Create(self);
               with fields22.Add as TVKDBFFieldDef do
               begin
                    Name := 'CHPERCENT';
                    field_type := 'N';
                    len := 10;
                    dec := 4;
               end;
               FLocalDataBaseBody.AddFields(fields22,1000);
           end;
          //
          if FLocalDataBaseBody.FindField('SUMMCH') = nil then
          begin
               fields23:=TVKDBFFieldDefs.Create(self);
               with fields23.Add as TVKDBFFieldDef do
               begin
                    Name := 'SUMMCH';
                    field_type := 'N';
                    len := 10;
                    dec := 4;
               end;
               FLocalDataBaseBody.AddFields(fields23,1000);
          end;
          //***19.08.16
          if FLocalDataBaseBody.FindField('AMOUNTORD') = nil then
          begin
               fields24:=TVKDBFFieldDefs.Create(self);
               with fields24.Add as TVKDBFFieldDef do
               begin
                    Name := 'AMOUNTORD';
                    field_type := 'N';
                    len := 10;
                    dec := 4;
               end;
               FLocalDataBaseBody.AddFields(fields24,1000);
          end;
          //***10.08.16
          if FLocalDataBaseBody.FindField('LIST_UID') = nil then
          begin
               fields25:=TVKDBFFieldDefs.Create(self);
               with fields25.Add as TVKDBFFieldDef do
               begin
                    Name := 'LIST_UID';
                    field_type := 'C';
                    len := 50;
               end;
               FLocalDataBaseBody.AddFields(fields25,1000);
          end;
          //
          FLocalDataBaseBody.Close;
  end; // !!!��������� ����� ����

  try
    FLocalDataBaseHead.Open;
    FLocalDataBaseBody.Open;
    FLocalDataBaseDiff.Open;
  except ON E: Exception do
    Begin
        Application.OnException(Application.MainForm,E);
//      ShowMessage('������ �������� ���������� ���������: '+E.Message);
      Exit;
    End;
  end;
  //�������� ���������
  if (FLocalDataBaseHead.FindField('ID') = nil) or
     (FLocalDataBaseHead.FindField('UID') = nil) or
     (FLocalDataBaseHead.FindField('DATE') = nil) or
     (FLocalDataBaseHead.FindField('PAIDTYPE') = nil) or
     (FLocalDataBaseHead.FindField('CASH') = nil) or
     (FLocalDataBaseHead.FindField('MANAGER') = nil) or
     (FLocalDataBaseHead.FindField('BAYER') = nil) or
     (FLocalDataBaseHead.FindField('COMPL') = nil) or
     (FLocalDataBaseHead.FindField('SAVE') = nil) or
     (FLocalDataBaseHead.FindField('NEEDCOMPL') = nil) or
     (FLocalDataBaseHead.FindField('NOTMCS') = nil) or
     (FLocalDataBaseHead.FindField('FISCID') = nil) or
      //***20.07.16
     (FLocalDataBaseHead.FindField('DISCOUNTID') = nil) or
     (FLocalDataBaseHead.FindField('DISCOUNTN') = nil) or
     (FLocalDataBaseHead.FindField('DISCOUNT') = nil) or
      //***16.08.16
     (FLocalDataBaseHead.FindField('BAYERPHONE') = nil) or
     (FLocalDataBaseHead.FindField('CONFIRMED') = nil) or
     (FLocalDataBaseHead.FindField('NUMORDER') = nil) or
     (FLocalDataBaseHead.FindField('CONFIRMEDC') = nil) or
     (FLocalDataBaseHead.FindField('USERSESION') = nil)

  then begin
    ShowMessage('�������� ��������� ����� ���������� ��������� ('+FLocalDataBaseHead.DBFFileName+')');
    Exit;
  End;

  if (FLocalDataBaseBody.FindField('ID') = nil) or
     (FLocalDataBaseBody.FindField('CH_UID') = nil) or
     (FLocalDataBaseBody.FindField('GOODSID') = nil) or
     (FLocalDataBaseBody.FindField('GOODSCODE') = nil) or
     (FLocalDataBaseBody.FindField('GOODSNAME') = nil) or
     (FLocalDataBaseBody.FindField('NDS') = nil) or
     (FLocalDataBaseBody.FindField('AMOUNT') = nil) or
     (FLocalDataBaseBody.FindField('PRICE') = nil) or
      //***20.07.16
     (FLocalDataBaseBody.FindField('PRICESALE') = nil) or
     (FLocalDataBaseBody.FindField('CHPERCENT') = nil) or
     (FLocalDataBaseBody.FindField('SUMMCH') = nil) or
      //***19.08.16
     (FLocalDataBaseBody.FindField('AMOUNTORD') = nil) or
      //***10.08.16
     (FLocalDataBaseBody.FindField('LIST_UID') = nil)
  then begin
    ShowMessage('�������� ��������� ����� ���������� ��������� ('+FLocalDataBaseBody.DBFFileName+')');
    Exit;
  End;


  Result := FLocalDataBaseHead.Active AND FLocalDataBaseBody.Active and FLocalDataBaseDiff.Active;

  if Result then
  begin
   FLocalDataBaseHead.Active:=False;
   FLocalDataBaseBody.Active:=False;
   FLocalDataBaseDiff.Active:=False;
  end;
  ReleaseMutex(MutexDBF);
  ReleaseMutex(MutexDBFDiff);
end;

procedure TMainCashForm2.InsertUpdateBillCheckItems;
var lQuantity, lPrice, lPriceSale, lChangePercent, lSummChangePercent : Currency;
    lMsg : String;
    lGoodsId_bySoldRegim : Integer;
    lPriceSale_bySoldRegim : Currency;
begin
  if ceAmount.Value = 0 then
     exit;
  if not assigned(SourceClientDataSet) then
    SourceClientDataSet := RemainsCDS;
  if SoldRegim AND
     (ceAmount.Value > 0) and
     (ceAmount.Value > SourceClientDataSet.FieldByName('Remains').asFloat) then
  begin
    ShowMessage('�� ������� ���������� ��� �������!');
    exit;
  end;
  if not SoldRegim AND
     (ceAmount.Value < 0) and
     (abs(ceAmount.Value) > abs(CheckCDS.FieldByName('Amount').asFloat)) then
  begin
    ShowMessage('�� ������� ���������� ��� ��������!');
    exit;
  end;
  //
  // ������ ��� �����, ���� ��������� ���������� ����� + ���� ��� ������
  if SoldRegim
  then begin lGoodsId_bySoldRegim   := SourceClientDataSet.FieldByName('Id').asInteger;
             lPriceSale_bySoldRegim := SourceClientDataSet.FieldByName('Price').asCurrency;
       end
  else begin lGoodsId_bySoldRegim   := CheckCDS.FieldByName('GoodsId').AsInteger;
             if CheckCDS.FieldByName('PriceSale').asCurrency > 0 // !!!�� ���� ������, ��������
             then lPriceSale_bySoldRegim := CheckCDS.FieldByName('PriceSale').asCurrency
             else lPriceSale_bySoldRegim := CheckCDS.FieldByName('Price').asCurrency;
       end;
  {
  //��������� "�����" ���-�� - ������� ��� ������� � ������� � � ���� ��������� ��� ���������� "�����" ���-��
  lQuantity := fGetCheckAmountTotal (lGoodsId_bySoldRegim, ceAmount.Value);
  //���� ���������� ������ (���������� �����) ***20.07.16
  if (FormParams.ParamByName('DiscountExternalId').Value > 0)
    and (lQuantity > 0)
  then begin
         // ���� ��� ������
         lPriceSale := lPriceSale_bySoldRegim;
         // ��������� �������� �������
         if not DiscountServiceForm.fGetSale (lMsg, lPrice, lChangePercent, lSummChangePercent
                                            , FormParams.ParamByName('DiscountCardNumber').Value
                                            , FormParams.ParamByName('DiscountExternalId').Value
                                            , lGoodsId_bySoldRegim
                                            , lQuantity // ��� "�����" ���-��
                                            , lPriceSale
                                            , SourceClientDataSet.FieldByName('GoodsCode').asInteger
                                            , SourceClientDataSet.FieldByName('GoodsName').AsString
                                             )
         then if lMsg = ''
              then // �� ������ ����� ��� � �������� ��� ������
              else exit // !!!����� ???� ��� ��� ���������
         else // ��� ������ � �������� ������
  end
  else} begin
         lPrice             := lPriceSale_bySoldRegim;
         lPriceSale         := lPriceSale_bySoldRegim;
         lChangePercent     := 0;
         lSummChangePercent := 0;
         // ������� "������" ���������-Item
         //DiscountServiceForm.pSetParamItemNull;
  end; // else ���� ���������� ������ (���������� �����) ***20.07.16
  //
  //
  if SoldRegim AND (ceAmount.Value > 0) then
  Begin
    CheckCDS.DisableControls;
    try
      CheckCDS.Filtered := False;
      if not checkCDS.Locate('GoodsId;PriceSale',VarArrayOf([SourceClientDataSet.FieldByName('Id').asInteger,lPriceSale]),[]) then
      Begin
        checkCDS.Append;
        checkCDS.FieldByName('Id').AsInteger:=0;
        checkCDS.FieldByName('ParentId').AsInteger:=0;
        checkCDS.FieldByName('GoodsId').AsInteger:=SourceClientDataSet.FieldByName('Id').asInteger;
        checkCDS.FieldByName('GoodsCode').AsInteger:=SourceClientDataSet.FieldByName('GoodsCode').asInteger;
        checkCDS.FieldByName('GoodsName').AsString:=SourceClientDataSet.FieldByName('GoodsName').AsString;
        checkCDS.FieldByName('Amount').asCurrency:= 0;
        checkCDS.FieldByName('Price').asCurrency:= lPrice;
        checkCDS.FieldByName('Summ').asCurrency:=0;
        checkCDS.FieldByName('NDS').asCurrency:=SourceClientDataSet.FieldByName('NDS').asCurrency;
        checkCDS.FieldByName('isErased').AsBoolean:=False;
        //***20.07.16
        checkCDS.FieldByName('PriceSale').asCurrency         :=lPriceSale;
        checkCDS.FieldByName('ChangePercent').asCurrency     :=lChangePercent;
        checkCDS.FieldByName('SummChangePercent').asCurrency :=lSummChangePercent;
        //***19.08.16
        checkCDS.FieldByName('AmountOrder').asCurrency       :=0;
        //***10.08.16
        checkCDS.FieldByName('List_UID').AsString := GenerateGUID;
        checkCDS.Post;
      End;
    finally
      CheckCDS.Filtered := True;
      CheckCDS.EnableControls;
    end;
    UpdateRemainsFromCheck(SourceClientDataSet.FieldByName('Id').asInteger,ceAmount.Value, lPriceSale);
    //Update ������� � CDS - �� ���� "�������" �������
    if FormParams.ParamByName('DiscountExternalId').Value > 0
    then DiscountServiceForm.fUpdateCDS_Discount (CheckCDS, lMsg, FormParams.ParamByName('DiscountExternalId').Value, FormParams.ParamByName('DiscountCardNumber').Value);

    CalcTotalSumm;
  End
  else
  if not SoldRegim AND (ceAmount.Value < 0) then
  Begin
    UpdateRemainsFromCheck(CheckCDS.FieldByName('GoodsId').AsInteger,ceAmount.Value,CheckCDS.FieldByName('PriceSale').asCurrency);
    //Update ������� � CDS - �� ���� "�������" �������
    if FormParams.ParamByName('DiscountExternalId').Value > 0
    then DiscountServiceForm.fUpdateCDS_Discount (CheckCDS, lMsg, FormParams.ParamByName('DiscountExternalId').Value, FormParams.ParamByName('DiscountCardNumber').Value);

    CalcTotalSumm;
  End
  else
  if SoldRegim AND (ceAmount.Value < 0) then
    ShowMessage('��� ������� ����� ��������� ������ ���������� ������ 0!')
  else
  if not SoldRegim AND (ceAmount.Value > 0) then
    ShowMessage('��� �������� ����� ��������� ������ ���������� ������ 0!');
end;

{------------------------------------------------------------------------------}

procedure TMainCashForm2.UpdateRemainsFromDiff(ADiffCDS : TClientDataSet);
var
  GoodsId: Integer;
  Amount_find: Currency;
  oldFilter:String;
  oldFiltered:Boolean;
begin
  //���� ��� ����������� - ������ �� ������
  if ADiffCDS = nil then
    ADiffCDS := DiffCDS;
  if ADIffCDS.IsEmpty then
    exit;
  //��������� �������

  AlternativeCDS.DisableControls;
  RemainsCDS.AfterScroll := Nil;
  RemainsCDS.DisableControls;
  GoodsId := RemainsCDS.FieldByName('Id').asInteger;
  RemainsCDS.Filtered := False;
  AlternativeCDS.Filtered := False;
  ADIffCDS.DisableControls;
  CheckCDS.DisableControls;
  oldFilter:= CheckCDS.Filter;
  oldFiltered:= CheckCDS.Filtered;

  try
    ADIffCDS.First;
    while not ADIffCDS.eof do
    begin
          // ������� ������ ���-�� � �����
          CheckCDS.Filter:='GoodsId = ' + IntToStr(ADIffCDS.FieldByName('Id').AsInteger);
          CheckCDS.Filtered:=true;
          CheckCDS.First;
          Amount_find:=0;
          while not CheckCDS.EOF do begin
              Amount_find:= Amount_find + CheckCDS.FieldByName('Amount').asCurrency;
              CheckCDS.Next;
          end;
          CheckCDS.Filter := oldFilter;
          CheckCDS.Filtered:= oldFiltered;

      if ADIffCDS.FieldByName('NewRow').AsBoolean then
      Begin
        RemainsCDS.Append;
        RemainsCDS.FieldByName('Id').AsInteger := ADIffCDS.FieldByName('Id').AsInteger;
        RemainsCDS.FieldByName('GoodsCode').AsInteger := ADIffCDS.FieldByName('GoodsCode').AsInteger;
        RemainsCDS.FieldByName('GoodsName').AsString := ADIffCDS.FieldByName('GoodsName').AsString;
        RemainsCDS.FieldByName('Price').asCurrency := ADIffCDS.FieldByName('Price').asCurrency;
        RemainsCDS.FieldByName('Remains').asCurrency := ADIffCDS.FieldByName('Remains').asCurrency;
        RemainsCDS.FieldByName('MCSValue').asCurrency := ADIffCDS.FieldByName('MCSValue').asCurrency;
        RemainsCDS.FieldByName('Reserved').asCurrency := ADIffCDS.FieldByName('Reserved').asCurrency;
        RemainsCDS.Post;
      End
      else
      Begin
        if RemainsCDS.Locate('Id',ADIffCDS.FieldByName('Id').AsInteger,[]) then
        Begin
          RemainsCDS.Edit;
          RemainsCDS.FieldByName('Price').asCurrency := ADIffCDS.FieldByName('Price').asCurrency;
          RemainsCDS.FieldByName('Remains').asCurrency := ADIffCDS.FieldByName('Remains').asCurrency;
          RemainsCDS.FieldByName('MCSValue').asCurrency := ADIffCDS.FieldByName('MCSValue').asCurrency;
          RemainsCDS.FieldByName('Reserved').asCurrency := ADIffCDS.FieldByName('Reserved').asCurrency;
          {12.10.2016 - ������ �� �������, �.�. � CheckCDS ������ ����� ����������� GoodsId
          if CheckCDS.Locate('GoodsId',ADIffCDS.FieldByName('Id').AsInteger,[]) then
            RemainsCDS.FieldByName('Remains').asCurrency := RemainsCDS.FieldByName('Remains').asCurrency
              - CheckCDS.FieldByName('Amount').asCurrency;}
          RemainsCDS.FieldByName('Remains').asCurrency := RemainsCDS.FieldByName('Remains').asCurrency
                                                        - Amount_find;
          RemainsCDS.Post;
        End;
      End;
      ADIffCDS.Next;
    end;

    AlternativeCDS.First;
    while Not AlternativeCDS.eof do
    Begin
      if ADIffCDS.locate('Id',AlternativeCDS.fieldByName('Id').AsInteger,[]) then
      Begin
        if AlternativeCDS.FieldByName('Remains').asCurrency <> ADIffCDS.FieldByName('Remains').asCurrency then
        Begin
          AlternativeCDS.Edit;
          AlternativeCDS.FieldByName('Remains').asCurrency := ADIffCDS.FieldByName('Remains').asCurrency;
          {12.10.2016 - ������ �� �������, �.�. � CheckCDS ������ ����� ����������� GoodsId
          if CheckCDS.Locate('GoodsId',ADIffCDS.FieldByName('Id').AsInteger,[]) then
            AlternativeCDS.FieldByName('Remains').asCurrency := AlternativeCDS.FieldByName('Remains').asCurrency
              - CheckCDS.FieldByName('Amount').asCurrency;}
          AlternativeCDS.FieldByName('Remains').asCurrency := AlternativeCDS.FieldByName('Remains').asCurrency
                                                            - Amount_find;
          AlternativeCDS.Post;
        End;
      End;
      AlternativeCDS.Next;
    End;
  finally
    RemainsCDS.Filtered := True;
    RemainsCDS.Locate('Id',GoodsId,[]);
    RemainsCDS.EnableControls;
    RemainsCDS.AfterScroll := RemainsCDSAfterScroll;
    AlternativeCDS.Filtered := true;
    RemainsCDSAfterScroll(RemainsCDS);
    AlternativeCDS.EnableControls;
    CheckCDS.EnableControls;
    CheckCDS.Filter := oldFilter;
    CheckCDS.Filtered:= oldFiltered;
  end;
end;

procedure TMainCashForm2.CalcTotalSumm;
var
  B:TBookmark;
Begin
  FTotalSumm := 0;
  WITH CheckCDS DO
  Begin
    B:= GetBookmark;
    DisableControls;
    try
      First;
      while Not Eof do
      Begin
        FTotalSumm := FTotalSumm + FieldByName('Summ').asCurrency;
        Next;
      End;
      GotoBookmark(B);
      FreeBookmark(B);
    finally
      EnableControls;
    end;
  End;
  lblTotalSumm.Caption := FormatFloat(',0.00',FTotalSumm);
End;

procedure TMainCashForm2.WM_KEYDOWN(var Msg: TWMKEYDOWN);
begin
  if (Msg.charcode = VK_TAB) and (ActiveControl=lcName) then
     ActiveControl:=MainGrid;
end;

procedure TMainCashForm2.lcNameEnter(Sender: TObject);
begin
  inherited;
  SourceClientDataSet := nil;
  isScaner:= false;
end;

procedure TMainCashForm2.lcNameExit(Sender: TObject);
begin
  inherited;
  if (GetKeyState(VK_TAB)<0) and (GetKeyState(VK_CONTROL)<0) then begin
     ActiveControl:=CheckGrid;
     exit
  end;
  if GetKeyState(VK_TAB)<0 then
     ActiveControl:=MainGrid;
end;

procedure TMainCashForm2.lcNameKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = VK_Return)
     and
     (
       (
         SoldRegim
         AND
         (lcName.Text = RemainsCDS.FieldByName('GoodsName').AsString)
       )
       or
       (
         not SoldRegim
         AND
         (lcName.Text = CheckCDS.FieldByName('GoodsName').AsString)
       )
     ) then begin
     ceAmount.Enabled := true;
     if SoldRegim then
        ceAmount.Value := 1
     else
        ceAmount.Value := - 1;
     ActiveControl := ceAmount;
  end;
  if Key = VK_TAB then
    ActiveControl:=MainGrid;
end;

procedure TMainCashForm2.MainColReservedGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  if AText = '0' then
    AText := '';
end;

procedure TMainCashForm2.MainGridDBTableViewFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
var
 Cnt: integer;
begin
  if MainGrid.IsFocused then exit;

  Cnt := Sender.ViewInfo.RecordsViewInfo.VisibleCount;
  Sender.Controller.TopRecordIndex := Sender.Controller.FocusedRecordIndex - Round((Cnt+1)/2);
end;

// ��������� ��������� ��������� ��� �������� ������ ����
procedure TMainCashForm2.NewCheck(ANeedRemainsRefresh: Boolean = True);
begin
  FormParams.ParamByName('CheckId').Value := 0;
  FormParams.ParamByName('ManagerId').Value := 0;
  FormParams.ParamByName('ManagerName').Value := '';
  FormParams.ParamByName('BayerName').Value := '';
  //***20.07.16
  FormParams.ParamByName('DiscountExternalId').Value := 0;
  FormParams.ParamByName('DiscountExternalName').Value := '';
  FormParams.ParamByName('DiscountCardNumber').Value := '';
  //***16.08.16
  FormParams.ParamByName('BayerPhone').Value        := '';
  FormParams.ParamByName('ConfirmedKindName').Value := '';
  FormParams.ParamByName('InvNumberOrder').Value    := '';
  FormParams.ParamByName('ConfirmedKindClientName').Value := '';
  FormParams.ParamByName('USERSESION').Value:=gc_User.Session;


  FiscalNumber := '';
  pnlVIP.Visible := False;
  pnlDiscount.Visible := False;
  lblCashMember.Caption := '';
  lblBayer.Caption := '';
  CheckCDS.DisableControls;
  chbNotMCS.Checked := False;
  try
    CheckCDS.EmptyDataSet;
  finally
    CheckCDS.EnableControls;
  end;

  MainCashForm.SoldRegim := true;
  MainCashForm.actSpec.Checked := false;
  if Assigned(MainCashForm.Cash) AND MainCashForm.Cash.AlwaysSold then
    MainCashForm.Cash.AlwaysSold := False;

  if Self.Visible then
   Begin
//     ShowMessage('��� ������');
    if ANeedRemainsRefresh then
      StartRefreshDiffThread;
   End
  else
   Begin
//    ShowMessage('��� ������');
    actRefreshAllExecute(nil);

   End;
  CalcTotalSumm;
  ceAmount.Value := 0;
  isScaner:=false;
  ActiveControl := lcName;
end;

procedure TMainCashForm2.ParentFormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if not CheckCDS.IsEmpty then
  Begin
    CanClose := False;
    ShowMessage('������� �������� ���.');
  End
  else
    CanClose := MessageDlg('�� ������������� ������ �����?',mtConfirmation,[mbYes,mbCancel], 0) = mrYes;
  while CountRRT>0 do //���� ���� ��������� ��� ������
    Application.ProcessMessages;
  if CanClose then
  Begin
    try
      if not gc_User.Local then
      Begin
        actRefreshAllExecute(nil);
        spDelete_CashSession.Execute;
        
      End
      else
      begin
        WaitForSingleObject(MutexRemains, INFINITE);
        SaveLocalData(RemainsCDS,remains_lcl);
        ReleaseMutex(MutexRemains);
        WaitForSingleObject(MutexAlternative, INFINITE);
        SaveLocalData(AlternativeCDS,Alternative_lcl);
        ReleaseMutex(MutexAlternative);
      end;
    Except
    end;
        PostMessage(HWND_BROADCAST, FM_SERVISE, 2, 9);
  End;
end;

procedure TMainCashForm2.ParentFormDestroy(Sender: TObject);
begin
  inherited;
 CloseHandle(MutexDBF);
 CloseHandle(MutexDBFDiff);
 CloseHandle(MutexVip);
 CloseHandle(MutexRemains);
 CloseHandle(MutexAlternative);
end;

procedure TMainCashForm2.ParentFormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=VK_Tab) and (CheckGrid.IsFocused) 
   then if isScaner = true
       then ActiveControl := ceScaner
       else ActiveControl := lcName;
  if (Key = VK_ADD) or ((Key = VK_Return) AND (ssShift in Shift)) then
  Begin
    Key := 0;
    fShift := ssShift in Shift;
    actPutCheckToCashExecute(nil);
  End;
end;

procedure TMainCashForm2.ParentFormShow(Sender: TObject);
  procedure SetVIPCDS;
  var
    C: TComponent;
  Begin
    for C in VIPForm do
    begin
      if (C is TClientDataSet) then
      Begin
        with (C as TClientDataSet) do
        begin
          if sametext(Name, 'MasterCDS') then
            VIPCDS := (C as TClientDataSet)
          else
          if sametext(Name, 'ClientDataSet1') then
            VIPListCDS := (C as TClientDataSet);
        end;
      End;
    end;
  End;
begin
  inherited;
  if not gc_User.Local then
  Begin
    VIPForm := TdsdFormStorageFactory.GetStorage.Load('TCheckVIPForm');
    WriteComponentResFile(VipDfm_lcl,VIPForm);
    SetVIPCDS;
  End
  else
  Begin
    Application.CreateForm(TParentForm, VIPForm);
    VIPForm.FormClassName := 'TCheckVIPForm';
    ReadComponentResFile(VipDfm_lcl, VIPForm);
    VIPForm.AddOnFormData.isAlwaysRefresh := False;
    VIPForm.AddOnFormData.isSingle := true;
    VIPForm.isAlreadyOpen := True;
    SetVIPCDS;
    VipCDS.LoadFromFile(Vip_lcl);
    VIPListCDS.LoadFromFile(VipList_lcl);
  End;
end;

// ��� � �������� ������ - ������� � ��� ��� - �� ����� �������� ���� ����� ����
procedure TMainCashForm2.Add_Log_XML(AMessage: String);
var F: TextFile;
begin
  try
    AssignFile(F,ChangeFileExt(Application.ExeName,'_log.xml'));
    if not fileExists(ChangeFileExt(Application.ExeName,'_log.xml')) then
    begin
      Rewrite(F);
      Writeln(F,'<?xml version="1.0" encoding="Windows-1251"?>');
    end
    else
      Append(F);
    //
    try  Writeln(F,AMessage);
    finally CloseFile(F);
    end;
  except
  end;
end;

function TMainCashForm2.PutCheckToCash(SalerCash: Currency;
  PaidType: TPaidType; out AFiscalNumber, ACheckNumber: String): boolean;
var str_log_xml : String;
    i : Integer;
{------------------------------------------------------------------------------}
  function PutOneRecordToCash: boolean; //������� ������ ������������
  begin
     // �������� ������ � ����� � ���� ��� OK, �� ������ ����� � �������
     if not Assigned(Cash) or Cash.AlwaysSold then
        result := true
     else
       if not SoldParallel then
         with CheckCDS do begin
            result := Cash.SoldFromPC(FieldByName('GoodsCode').asInteger,
                                      AnsiUpperCase(FieldByName('GoodsName').Text),
                                      FieldByName('Amount').asCurrency,
                                      FieldByName('Price').asCurrency,
                                      FieldByName('NDS').asCurrency)
         end
       else result:=true;
  end;
{------------------------------------------------------------------------------}
begin
  ACheckNumber := '';
  try
    if Assigned(Cash) AND NOT Cash.AlwaysSold then
      AFiscalNumber := Cash.FiscalNumber
    else
      AFiscalNumber := '';
    str_log_xml:=''; i:=0;
    result := not Assigned(Cash) or Cash.AlwaysSold or Cash.OpenReceipt;
    with CheckCDS do
    begin
      First;
      while not EOF do
      begin
        if result then
           begin
             if CheckCDS.FieldByName('Amount').asCurrency >= 0.001 then
              begin
                  //������� ������ � �����
                  result := PutOneRecordToCash;
                  //��������� ������ � ���
                  i:= i + 1;
                  if str_log_xml<>'' then str_log_xml:=str_log_xml + #10 + #13;
                  try
                  str_log_xml:= str_log_xml
                              + '<Items num="' +IntToStr(i)+ '">'
                              + '<GoodsCode>"' + FieldByName('GoodsCode').asString + '"</GoodsCode>'
                              + '<GoodsName>"' + AnsiUpperCase(FieldByName('GoodsName').Text) + '"</GoodsName>'
                              + '<Amount>"' + FloatToStr(FieldByName('Amount').asCurrency) + '"</Amount>'
                              + '<Price>"' + FloatToStr(FieldByName('Price').asCurrency) + '"</Price>'
                              + '<List_UID>"' + FieldByName('List_UID').AsString + '"</List_UID>'
                              + '</Items>';
                  except
                  str_log_xml:= str_log_xml
                              + '<Items="' +IntToStr(i)+ '">'
                              + '<GoodsCode>"' + FieldByName('GoodsCode').asString + '"</GoodsCode>'
                              + '<GoodsName>"???"</GoodsName>'
                              + '<List_UID>"' + FieldByName('List_UID').AsString + '"</List_UID>'
                              + '</Items>';
                  end;
              end;
           end;
        Next;
      end;
      if Assigned(Cash) AND not Cash.AlwaysSold then
      begin
        Cash.SubTotal(true, true, 0, 0);
        Cash.TotalSumm(SalerCash, PaidType);
        result := Cash.CloseReceiptEx(ACheckNumber); //������� ���
      end;
    end;
  except
    result := false;
    raise;
  end;
  //
  // ��� � �������� ������ - ������� � ��� ��� - �� ����� �������� ���� ����� ����
  Add_Log_XML('<Head now="'+FormatDateTime('YYYY.MM.DD hh:mm:ss',now)+'">'
     +#10+#13+'<CheckNumber>"'  + ACheckNumber  + '"</CheckNumber>'
             +'<FiscalNumber>"' + AFiscalNumber + '"</FiscalNumber>'
             +'<Summa>"' + FloatToStr(SalerCash) + '"</Summa>'
     +#10+#13+str_log_xml
     +#10+#13+'</Head>'
             );
end;

procedure TMainCashForm2.RemainsCDSAfterScroll(DataSet: TDataSet);
begin
  if RemainsCDS.FieldByName('AlternativeGroupId').AsInteger = 0 then
    AlternativeCDS.Filter := 'Remains > 0 AND MainGoodsId='+RemainsCDS.FieldByName('Id').AsString
  else
    AlternativeCDS.Filter := '(Remains > 0 AND MainGoodsId='+RemainsCDS.FieldByName('Id').AsString +
      ') or (Remains > 0 AND AlternativeGroupId='+RemainsCDS.FieldByName('AlternativeGroupId').AsString+
           ' AND Id <> '+RemainsCDS.FieldByName('Id').AsString+')';
end;

//��������� "�����" ���-�� - ������� ��� ������� � ������� � � ���� ��������� ��� ���������� "�����" ���-��
function TMainCashForm2.fGetCheckAmountTotal(AGoodsId: Integer = 0; AAmount: Currency = 0) : Currency;
var
  GoodsId: Integer;
begin
  Result :=AAmount;
  //���� ����� - ������ �� ������
  CheckCDS.DisableControls;
  CheckCDS.filtered := False;
  if CheckCDS.IsEmpty then
  Begin
    CheckCDS.filtered := true;
    CheckCDS.EnableControls;
    exit;
  End;

  //��������� �������
  GoodsId := RemainsCDS.FieldByName('Id').asInteger;

  try
    CheckCDS.First;
    while not CheckCDS.Eof do
    begin
      if (CheckCDS.FieldByName('GoodsId').AsInteger = AGoodsId) then
      Begin
        if (AAmount = 0) or
           (
             (AAmount < 0)
             AND
             (ABS(AAmount) >= CheckCDS.FieldByName('Amount').asCurrency)
           ) then
          Result := 0
        else
          Result := CheckCDS.FieldByName('Amount').asCurrency + AAmount;
      End;
      CheckCDS.Next;
    end;
  finally
    CheckCDS.Filtered := True;
    if AGoodsId <> 0 then
      CheckCDS.Locate('GoodsId',AGoodsId,[]);
    CheckCDS.EnableControls;
  end;
end;

procedure TMainCashForm2.UpdateRemainsFromCheck(AGoodsId: Integer = 0; AAmount: Currency = 0; APriceSale: Currency = 0);
var
  GoodsId: Integer;
  //lPriceSale : Currency;
begin
  //���� ����� - ������ �� ������
  CheckCDS.DisableControls;
  CheckCDS.filtered := False;
  if CheckCDS.IsEmpty then
  Begin
    CheckCDS.filtered := true;
    CheckCDS.EnableControls;
    exit;
  End;
  //��������� �������
  AlternativeCDS.DisableControls;
  RemainsCDS.AfterScroll := Nil;
  RemainsCDS.DisableControls;
  GoodsId := RemainsCDS.FieldByName('Id').asInteger;
  RemainsCDS.Filtered := False;
  AlternativeCDS.Filtered := False;
  try
    CheckCDS.First;
    while not CheckCDS.eof do
    begin
      if (AGoodsId = 0) or ((CheckCDS.FieldByName('GoodsId').AsInteger = AGoodsId) and (CheckCDS.FieldByName('PriceSale').AsCurrency = APriceSale)) then
      Begin
        if RemainsCDS.Locate('Id',CheckCDS.FieldByName('GoodsId').AsInteger,[]) then
        Begin
          RemainsCDS.Edit;
          if (AAmount = 0)
             or
             (
               (AAmount < 0)
               AND
               (ABS(AAmount) >= CheckCDS.FieldByName('Amount').asCurrency)
             ) then
            RemainsCDS.FieldByName('Remains').asCurrency := RemainsCDS.FieldByName('Remains').asCurrency
              + CheckCDS.FieldByName('Amount').asCurrency
          else
            RemainsCDS.FieldByName('Remains').asCurrency := RemainsCDS.FieldByName('Remains').asCurrency
              - AAmount;
          RemainsCDS.Post;
        End;
      End;
      CheckCDS.Next;
    end;

    AlternativeCDS.First;
    while Not AlternativeCDS.eof do
    Begin
      if (AGoodsId = 0) or ((AlternativeCDS.FieldByName('Id').AsInteger = AGoodsId) and (AlternativeCDS.FieldByName('Price').AsFloat = APriceSale)) then
      Begin
        //if (AAmount < 0) and (CheckCDS.FieldByName('PriceSale').asCurrency > 0)
        //then lPriceSale:= CheckCDS.FieldByName('PriceSale').asCurrency
        //else lPriceSale:= AlternativeCDS.fieldByName('Price').asCurrency;

        if CheckCDS.locate('GoodsId;PriceSale',VarArrayOf([AlternativeCDS.fieldByName('Id').AsInteger,APriceSale]),[]) then
        Begin
          AlternativeCDS.Edit;
          if (AAmount = 0) or
             (
               (AAmount < 0)
               AND
               (abs(AAmount) >= CheckCDS.FieldByName('Amount').asCurrency)
             ) then
            AlternativeCDS.FieldByName('Remains').asCurrency := AlternativeCDS.FieldByName('Remains').asCurrency
              + CheckCDS.FieldByName('Amount').asCurrency
          else
            AlternativeCDS.FieldByName('Remains').asCurrency := AlternativeCDS.FieldByName('Remains').asCurrency
              - AAmount;
          AlternativeCDS.Post;
        End;
      End;
      AlternativeCDS.Next;
    End;

    CheckCDS.First;
    while not CheckCDS.Eof do
    begin
      if (AGoodsId = 0) or ((CheckCDS.FieldByName('GoodsId').AsInteger = AGoodsId) and (CheckCDS.FieldByName('PriceSale').asCurrency = APriceSale)) then
      Begin
        CheckCDS.Edit;
        {
        //������� ������� ������, � ������� ����, ������� ��� ��������� ��������� ***20.07.16
        if (FormParams.ParamByName('DiscountExternalId').Value > 0) and (AGoodsId <> 0)
          // �� ���� ������ �������
          and (DiscountServiceForm.gGoodsId = AGoodsId)
          and (DiscountServiceForm.gDiscountExternalId = FormParams.ParamByName('DiscountExternalId').Value)
        then begin
            // �� ���� ������ ������� - ����������� ���� ���� �� ������� ���� ��������
            if DiscountServiceForm.gPrice > 0
            then checkCDS.FieldByName('Price').asCurrency        :=DiscountServiceForm.gPrice;
            checkCDS.FieldByName('ChangePercent').asCurrency     :=DiscountServiceForm.gChangePercent;
            checkCDS.FieldByName('SummChangePercent').asCurrency :=DiscountServiceForm.gSummChangePercent;
        end
        else} begin
            // �� ���� ������ ������� - ����������� ���� ���� ��� ������ ���� ��������
            if checkCDS.FieldByName('PriceSale').asCurrency > 0
            then checkCDS.FieldByName('Price').asCurrency        := checkCDS.FieldByName('PriceSale').asCurrency;
            // � ������� ������
            checkCDS.FieldByName('ChangePercent').asCurrency     := 0;
            checkCDS.FieldByName('SummChangePercent').asCurrency := 0;
        end;


        if (AAmount = 0) or
           (
             (AAmount < 0)
             AND
             (ABS(AAmount) >= CheckCDS.FieldByName('Amount').asCurrency)
           ) then
          CheckCDS.FieldByName('Amount').asCurrency := 0
        else
          CheckCDS.FieldByName('Amount').asCurrency := CheckCDS.FieldByName('Amount').asCurrency
            + AAmount;
        CheckCDS.FieldByName('Summ').asCurrency := GetSumm(CheckCDS.FieldByName('Amount').asCurrency,CheckCDS.FieldByName('Price').asCurrency);

        CheckCDS.Post;
      End;
      CheckCDS.Next;
    end;
  finally
    RemainsCDS.Filtered := True;
    RemainsCDS.Locate('Id',GoodsId,[]);
    RemainsCDS.EnableControls;
    RemainsCDS.AfterScroll := RemainsCDSAfterScroll;
    AlternativeCDS.Filtered := true;
    RemainsCDSAfterScroll(RemainsCDS);
    AlternativeCDS.EnableControls;
    CheckCDS.Filtered := True;
    if AGoodsId <> 0 then
      CheckCDS.Locate('GoodsId',AGoodsId,[]);
    CheckCDS.EnableControls;
  end;
end;

function TMainCashForm2.SaveLocal(ADS: TClientDataSet; AManagerId: integer; AManagerName: String;
  ABayerName, ABayerPhone, AConfirmedKindName, AInvNumberOrder, AConfirmedKindClientName: String;
  ADiscountExternalId: integer; ADiscountExternalName, ADiscountCardNumber: String;
  NeedComplete: Boolean; FiscalCheckNumber: String; out AUID: String): Boolean;
var
  NextVIPId: integer;
  myVIPCDS, myVIPListCDS: TClientDataSet;
  str_log_xml : String;
  i : Integer;
begin
  //���� ��� ��������� � ��� �� �������� - �� ��������� � ������� �����
  if gc_User.Local And not NeedComplete AND ((AManagerId <> 0) or (ABayerName <> '')) then
  Begin
    myVIPCDS := TClientDataSet.Create(nil);
    myVIPListCDS := TClientDataSet.Create(nil);
    AUID := GenerateGUID;
    WaitForSingleObject(MutexVip, INFINITE);
    LoadLocalData(MyVipCDS, Vip_lcl);
    LoadLocalData(MyVipListCDS, VipList_lcl);
    ReleaseMutex(MutexVip);
    if not MyVipCDS.Locate('Id',FormParams.ParamByName('CheckId').Value,[]) then
    Begin
      MyVipCDS.IndexFieldNames := 'Id';
      MyVipCDS.First;
      if MyVipCDS.FieldByName('Id').AsInteger > 0 then
        NextVIPID := -1
      else
        NextVIPId := MyVipCDS.FieldByName('Id').AsInteger - 1;

      MyVipCDS.Append;
      MyVipCDS.FieldByName('Id').AsInteger := NextVIPId;
      MyVipCDS.FieldByName('InvNumber').AsString := AUID;
      MyVipCDS.FieldByName('OperDate').AsDateTime := Now;
    end
    else
    Begin
      MyVipCDS.Edit;
      AUID := MyVipCDS.FieldByName('InvNumber').AsString;

    end;
    MyVipCDS.FieldByName('StatusId').AsInteger := StatusUncompleteID;
    MyVipCDS.FieldByName('StatusCode').AsInteger := StatusUncompleteCode;
    MyVipCDS.FieldByName('TotalCount').AsFloat := 0;
    MyVipCDS.FieldByName('TotalSumm').AsFloat := FTotalSumm;
    MyVipCDS.FieldByName('UnitName').AsString := '';
    MyVipCDS.FieldByName('CashRegisterName').AsString := '';
    MyVipCDS.FieldByName('CashMemberId').AsInteger := AManagerId;
    MyVipCDS.FieldByName('CashMember').AsString := AManagerName;
    MyVipCDS.FieldByName('Bayer').AsString := ABayerName;
    //***20.07.16
    MyVipCDS.FieldByName('DiscountExternalId').AsInteger  := ADiscountExternalId;
    MyVipCDS.FieldByName('DiscountExternalName').AsString := ADiscountExternalName;
    MyVipCDS.FieldByName('DiscountCardNumber').AsString   := ADiscountCardNumber;
    //***16.08.16
    MyVipCDS.FieldByName('BayerPhone').AsString        := ABayerPhone;
    MyVipCDS.FieldByName('ConfirmedKindName').AsString := AConfirmedKindName;
    MyVipCDS.FieldByName('InvNumberOrder').AsString    := AInvNumberOrder;
    MyVipCDS.FieldByName('ConfirmedKindClientName').AsString := AConfirmedKindClientName;

    MyVipCDS.Post;

    MyVipListCDS.Filter := 'MovementId = '+MyVipCDS.FieldByName('Id').AsString;
    MyVipListCDS.Filtered := True;
    while not MyVipListCDS.eof do
      MyVipListCDS.Delete;
    MyVipListCDS.Filtered := False;
    ADS.DisableControls;
    try
      ADS.Filtered := False;
      ADS.First;
      while not ADS.Eof do
      Begin
        MyVipListCDS.Append;
        MyVipListCDS.FieldByname('Id').Value := ADS.FieldByName('Id').AsInteger;
        MyVipListCDS.FieldByname('MovementId').Value := MyVipCDS.FieldByName('Id').AsInteger;
        MyVipListCDS.FieldByname('GoodsId').Value := ADS.FieldByName('GoodsId').AsInteger;
        MyVipListCDS.FieldByname('GoodsCode').Value := ADS.FieldByName('GoodsCode').AsInteger;
        MyVipListCDS.FieldByname('GoodsName').Value := ADS.FieldByName('GoodsName').AsString;
        MyVipListCDS.FieldByname('Amount').Value := ADS.FieldByName('Amount').AsFloat;
        MyVipListCDS.FieldByname('Price').Value := ADS.FieldByName('Price').AsFloat;
        MyVipListCDS.FieldByname('Summ').Value := GetSumm(ADS.FieldByName('Amount').AsFloat,ADS.FieldByName('Price').AsFloat);
        //***20.07.16
        MyVipListCDS.FieldByName('PriceSale').asCurrency         := ADS.FieldByName('PriceSale').asCurrency;
        MyVipListCDS.FieldByName('ChangePercent').asCurrency     := ADS.FieldByName('ChangePercent').asCurrency;
        MyVipListCDS.FieldByName('SummChangePercent').asCurrency := ADS.FieldByName('SummChangePercent').asCurrency;
        //***19.08.16
        MyVipListCDS.FieldByName('AmountOrder').asCurrency       := ADS.FieldByName('AmountOrder').asCurrency;
        //***10.08.16
        MyVipListCDS.FieldByName('List_UID').asString := ADS.FieldByName('List_UID').AsString;

        MyVipListCDS.Post;
        ADS.Next;
      End;
    finally
      ADS.Filtered := true;
      ADS.EnableControls;
    end;
    WaitForSingleObject(MutexVip, INFINITE);
    SaveLocalData(MyVipCDS, vip_lcl);
    MyVipListCDS.Filtered := False;
    SaveLocalData(MyVipListCDS, vipList_lcl);
    MyVipCDS.Free;
    MyVIPListCDS.Free;
    ReleaseMutex(MutexVip);
  End;  //���� ��� ��������� � ��� �� �������� - �� ��������� � ������� �����

  //��������� � ���
  WaitForSingleObject(MutexDBF, INFINITE);
  FLocalDataBaseHead.Active:=True;
  FLocalDataBaseBody.Active:=True;
  try
    //��������� ���� ��� ����
    if AUID = '' then
      AUID := GenerateGUID;
    Result := True;
    //��������� �����
    try
      if (FormParams.ParamByName('CheckId').Value = 0) or
         not FLocalDataBaseHead.Locate('ID',FormParams.ParamByName('CheckId').Value,[]) then
      Begin
        FLocalDataBaseHead.AppendRecord([FormParams.ParamByName('CheckId').Value, //id ����
                                         AUID,                                    //uid ����
                                         Now,                                     //����/����� ����
                                         Integer(PaidType),                       //��� ������
                                         FiscalNumber,                            //�������� ��������
                                         AManagerId,                              //Id ��������� (VIP)
                                         ABayerName,                              //���������� (VIP)
                                         False,                                   //���������� �� ���������� ������������
                                         False,                                   //�������� � �������� ���� ������
                                         NeedComplete,                            //���������� ����������
                                         chbNotMCS.Checked,                       //�� ��������� � ������� ���
                                         FiscalCheckNumber,                       //����� ����������� ����
                                         //***20.07.16
                                         ADiscountExternalId,                     //Id ������� ���������� ����
                                         ADiscountExternalName,                   //�������� ������� ���������� ����
                                         ADiscountCardNumber,                     //� ���������� �����
                                         //***20.07.16
                                         ABayerPhone,                             //���������� ������� (����������) - BayerPhone
                                         AConfirmedKindName,                      //������ ������ (��������� VIP-����) - ConfirmedKind
                                         AInvNumberOrder,                         //����� ������ (� �����) - InvNumberOrder
                                         AConfirmedKindClientName,                 //������ ������ (��������� VIP-����) - ConfirmedKindClient
                                         gc_User.Session
                                        ]);
      End
      else
      Begin
        AUID := FLocalDataBaseHead.FieldByName('UID').Value;//uid ����
        FLocalDataBaseHead.Edit;
        FLocalDataBaseHead.FieldByName('PAIDTYPE').Value := Integer(PaidType); //��� ������
        FLocalDataBaseHead.FieldByName('CASH').Value := FiscalNumber; //�������� ��������
        FLocalDataBaseHead.FieldByName('MANAGER').Value := AManagerId; //Id ��������� (VIP)
        FLocalDataBaseHead.FieldByName('BAYER').Value := ABayerName; //���������� (VIP)
        FLocalDataBaseHead.FieldByName('SAVE').Value := False; //���������� (VIP)
        FLocalDataBaseHead.FieldByName('COMPL').Value := False; //���������� (VIP)
        FLocalDataBaseHead.FieldByName('NEEDCOMPL').Value := NeedComplete; //����� �������� ��������
        FLocalDataBaseHead.FieldByName('NOTMCS').Value := chbNotMCS.Checked; //�� ��������� � ������� ���
        FLocalDataBaseHead.FieldByName('FISCID').Value := FiscalCheckNumber; //����� ����������� ����
        //***20.07.16
        FLocalDataBaseHead.FieldByName('DISCOUNTID').Value := ADiscountExternalId;   //Id ������� ���������� ����
        FLocalDataBaseHead.FieldByName('DISCOUNTN').Value  := ADiscountExternalName; //�������� ������� ���������� ����
        FLocalDataBaseHead.FieldByName('DISCOUNT').Value   := ADiscountCardNumber;   //� ���������� �����
        //***16.08.16
        FLocalDataBaseHead.FieldByName('BAYERPHONE').Value := ABayerPhone;              //���������� ������� (����������) - BayerPhone
        FLocalDataBaseHead.FieldByName('CONFIRMED').Value  := AConfirmedKindName;       //������ ������ (��������� VIP-����) - ConfirmedKind
        FLocalDataBaseHead.FieldByName('NUMORDER').Value   := AInvNumberOrder;          //����� ������ (� �����) - InvNumberOrder
        FLocalDataBaseHead.FieldByName('CONFIRMEDC').Value := AConfirmedKindClientName; //������ ������ (��������� VIP-����) - ConfirmedKindClient
        FLocalDataBaseHead.FieldByName('USERSESION').Value := gc_User.Session;
        FLocalDataBaseHead.post;
      End;
    except ON E:Exception do
      Begin
        // ��� � �������� ������ - ������� � ���
        Add_Log_XML('<Head err="'+E.Message+'">');
        Application.OnException(Application.MainForm,E);
//        ShowMessage('������ ���������� ���������� ����: '+E.Message);
        result := False;
        exit;
      End;
    end; //��������� �����

    //��������� ����
    ADS.DisableControls;
    try
      try
        ADS.Filtered := False;
        ADS.First;
        FLocalDataBaseBody.First;
        while not FLocalDataBaseBody.eof do
        Begin
          if trim(FLocalDataBaseBody.FieldByName('CH_UID').AsString) = AUID then
            FLocalDataBaseBody.Delete;
          FLocalDataBaseBody.Next;
        End;
        FLocalDataBaseBody.Pack;
        str_log_xml:=''; i:=0;
        while not ADS.Eof do
        Begin
          FLocalDataBaseBody.AppendRecord([ADS.FieldByName('Id').AsInteger,         //id ������
                                           AUID,                                    //uid ����
                                           ADS.FieldByName('GoodsId').AsInteger,    //�� ������
                                           ADS.FieldByName('GoodsCode').AsInteger,  //��� ������
                                           ADS.FieldByName('GoodsName').AsString,   //������������ ������
                                           ADS.FieldByName('NDS').asCurrency,          //��� ������
                                           ADS.FieldByName('Amount').asCurrency,       //���-��
                                           ADS.FieldByName('Price').asCurrency,        //����, � 20.07.16 ���� ���� ������ �� ������� ��������, ����� ����� ���� � ������ ������
                                           //***20.07.16
                                           ADS.FieldByName('PriceSale').asCurrency,         // ���� ��� ������
                                           ADS.FieldByName('ChangePercent').asCurrency,     // % ������
                                           ADS.FieldByName('SummChangePercent').asCurrency, // ����� ������
                                           //***19.08.16
                                           ADS.FieldByName('AmountOrder').asCurrency, // ���-�� ������
                                           //***10.08.16
                                           ADS.FieldByName('List_UID').AsString // UID ������ �������
                                           ]);
                  //��������� ������ � ���
                  i:= i + 1;
                  if str_log_xml<>'' then str_log_xml:=str_log_xml + #10 + #13;
                  try
                  str_log_xml:= str_log_xml
                              + '<Items num="' +IntToStr(i)+ '">'
                              + '<GoodsCode>"' + ADS.FieldByName('GoodsCode').asString + '"</GoodsCode>'
                              + '<GoodsName>"' + AnsiUpperCase(ADS.FieldByName('GoodsName').Text) + '"</GoodsName>'
                              + '<Amount>"' + FloatToStr(ADS.FieldByName('Amount').asCurrency) + '"</Amount>'
                              + '<Price>"' + FloatToStr(ADS.FieldByName('Price').asCurrency) + '"</Price>'
                              + '<List_UID>"' + ADS.FieldByName('List_UID').AsString + '"</List_UID>'
                              + '</Items>';
                  except
                  str_log_xml:= str_log_xml
                              + '<Items num="' +IntToStr(i)+ '">'
                              + '<GoodsCode>"' + ADS.FieldByName('GoodsCode').asString + '"</GoodsCode>'
                              + '<GoodsName>"???"</GoodsName>'
                              + '<List_UID>"' + ADS.FieldByName('List_UID').AsString + '"</List_UID>'
                              + '</Items>';
                  end;
        ADS.Next;
        End;

      Except ON E:Exception do
        Begin
      // ��� � �������� ������ - ������� � ���
        Add_Log_XML('<Body err="'+E.Message+'">');
        Application.OnException(Application.MainForm,E);
//          ShowMessage('������ ���������� ���������� ����������� ����: '+E.Message);
          result := False;
          exit;
        End;
      end;
    finally
      ADS.Filtered := true;
      ADS.EnableControls;
      FLocalDataBaseBody.Filter := '';
      FLocalDataBaseBody.Filtered := True;
    end;
  finally
    FLocalDataBaseBody.Active:=False;
    FLocalDataBaseHead.Active:=False;
    ReleaseMutex(MutexDBF);
    PostMessage(HWND_BROADCAST, FM_SERVISE, 2, 3);
  end;
  // ��� � �������� ������ - ������� � ��� ��� - �� ����� ���������� ����, �.�. ����� �������� ����� ����
  Add_Log_XML('<Save now="'+FormatDateTime('YYYY.MM.DD hh:mm:ss',now)+'">'
     +#10+#13+'<AUID>"'  + AUID  + '"</AUID>'
             +'<CheckNumber>"'  + FiscalCheckNumber  + '"</CheckNumber>'
             +'<FiscalNumber>"' + FiscalNumber + '"</FiscalNumber>'
     +#10+#13+str_log_xml
     +#10+#13+'</Save>'
             );

  // update VIP
  if ((AManagerId <> 0) or (ABayerName <> '')) and
     (gc_User.Local) and NeedComplete then
  Begin
    WaitForSingleObject(MutexVip, INFINITE);
    LoadLocalData(VipCDS, Vip_lcl);
    if (FormParams.ParamByName('CheckId').AsString <> '') and
       (StrToInt(FormParams.ParamByName('CheckId').AsString) <> 0) then
    Begin
      if VipCDS.Locate('Id', FormParams.ParamByName('CheckId').Value, []) then
        VipCDS.Delete;
    End
    else
    if VipCDS.Locate('InvNumber', AUID, []) then
      VipCDS.Delete;
    SaveLocalData(VipCDS,vip_lcl);
    ReleaseMutex(MutexVip);
  End;
end;

procedure TMainCashForm2.SaveLocalVIP;
var
  sp : TdsdStoredProc;
  ds : TClientDataSet;
begin  //+
  sp := TdsdStoredProc.Create(nil);
  try
    ds := TClientDataSet.Create(nil);
    try
      sp.OutputType := otDataSet;
      sp.DataSet := ds;

      sp.StoredProcName := 'gpSelect_Object_Member';
      sp.Params.Clear;
      sp.Params.AddParam('inIsShowAll',ftBoolean,ptInput,False);
      sp.Execute(False,False);
      SaveLocalData(ds,Member_lcl);

      sp.StoredProcName := 'gpSelect_Movement_CheckVIP';
      sp.Params.Clear;
      sp.Params.AddParam('inIsErased',ftBoolean,ptInput,False);
      sp.Execute(False,False);
      WaitForSingleObject(MutexVip, INFINITE);
      SaveLocalData(ds,Vip_lcl);
      ReleaseMutex(MutexVip);

      sp.StoredProcName := 'gpSelect_MovementItem_CheckDeferred';
      sp.Params.Clear;
      sp.Execute(False,False);
      WaitForSingleObject(MutexVip, INFINITE);
      SaveLocalData(ds,VipList_lcl);
      ReleaseMutex(MutexVip);
    finally
      ds.free;
    end;
  finally
    freeAndNil(sp);
  end;
end;

procedure TMainCashForm2.SaveReal(AUID: String; ANeedComplete: boolean = False);
Begin

End;

procedure TMainCashForm2.SaveRealAll;
begin

end;

procedure TMainCashForm2.StartRefreshDiffThread;
Begin

End;

procedure TMainCashForm2.SetSoldRegim(const Value: boolean);
begin
  FSoldRegim := Value;
  if SoldRegim then begin
     actSold.Caption := '�������';
     ceAmount.Value := 1;
  end
  else begin
     actSold.Caption := '�������';
     ceAmount.Value := -1;
  end;
end;

procedure TMainCashForm2.SetWorkMode(ALocal: Boolean);
begin
  actCheck.Enabled := not gc_User.Local;
  actGetMoneyInCash.Enabled := not gc_User.Local;
  actRefreshRemains.Enabled := not gc_User.Local;
  actOpenMCSForm.Enabled := not gc_User.Local;
  if not gc_User.Local then
  Begin
    spGet_User_IsAdmin.Execute;
    if spGet_User_IsAdmin.ParamByName('gpGet_User_IsAdmin').Value = True then
      actCheck.FormNameParam.Value := 'TCheckJournalForm'
    Else
      actCheck.FormNameParam.Value := 'TCheckJournalUserForm';
  End
  else
  Begin
    if Assigned(VIPForm) then
    Begin
      VIPForm.AddOnFormData.isAlwaysRefresh := False;
      VIPForm.AddOnFormData.isSingle := true;
      VIPForm.isAlreadyOpen := True;
    End;
  End;
  actSelectLocalVIPCheck.Enabled := gc_User.Local;
  actSelectCheck.Enabled := not gc_User.Local;
  actRefreshLite.Enabled := not gc_User.Local;
  actUpdateRemains.Enabled := not gc_User.Local;
end;

procedure TMainCashForm2.Thread_Exception(var Msg: TMessage);
var
  spUserProtocol : TdsdStoredProc;
begin
  spUserProtocol := TdsdStoredProc.Create(nil);
  try
    spUserProtocol.StoredProcName := 'gpInsert_UserProtocol';
    spUserProtocol.OutputType := otResult;
    spUserProtocol.Params.AddParam('inProtocolData', ftBlob, ptInput, ThreadErrorMessage);
    try
      spUserProtocol.Execute;
    except
    end;
  finally
    spUserProtocol.free;
  end;
//  ShowMessage('�� ����� ���������� ���� �������� ������:'+#13+
//              ThreadErrorMessage+#13#13+
//              '��������� ��������� ���� �, ��� �������������, ��������� ��� �������.');
end;


procedure TMainCashForm2.TimerBlinkBtnTimer(Sender: TObject);
begin
 TimerBlinkBtn.Enabled:=False;
 try


  SetBlinkVIP (false);
  SetBlinkCheck (false);


  if fBlinkVIP = true
  then if btnVIP.Colors.NormalText <> clDefault
       then begin btnVIP.Colors.NormalText:= clDefault; btnVIP.Colors.Default := clDefault; end
       else begin {Beep;} btnVIP.Colors.NormalText:= clYellow; btnVIP.Colors.Default := clRed; end
  else begin btnVIP.Colors.NormalText := clDefault; btnVIP.Colors.Default := clDefault; end;

  if fBlinkCheck = true
  then if btnCheck.Colors.NormalText <> clDefault
       then begin btnCheck.Colors.NormalText:= clDefault; btnCheck.Colors.Default := clDefault; end
       else begin btnCheck.Colors.NormalText:= clBlue; btnCheck.Colors.Default := clRed; end
  else begin btnCheck.Colors.NormalText := clDefault; btnCheck.Colors.Default := clDefault; end;
 finally
  TimerBlinkBtn.Enabled:=True;
 end;
end;

procedure TMainCashForm2.SetBlinkVIP (isRefresh : boolean);
var lMovementId_BlinkVIP : String;
begin
  // ���� ������ > 100 ��� - �����������
  if ((now - time_onBlink) > 0.002) or(isRefresh = true) then

  try
      //��������� ����� "���������" ��������� ���� ���������� - � ����� "�� �����������"
      time_onBlink:= now;

      //�������� ������ ���� ���������� - � ����� "�� �����������"
      spGet_BlinkVIP.Execute;
      lMovementId_BlinkVIP:=spGet_BlinkVIP.ParamByName('outMovementId_list').Value;

      // � ���� ������ ������ ����� ������
      fBlinkVIP:= lMovementId_BlinkVIP <> '';

      // ���� ���� �����, ������ ON-line ����� ����� ��� VIP-�����
      Self.Caption := '������� ('+GetFileVersionString(ParamStr(0))+')' + ' - <' + IniUtils.gUnitName + '>' + ' - <' + IniUtils.gUserName + '>';

      //���� ������ ��������� ��� ���� "�� ������ ��������" - �������� "�� ����� ������" ���������� �����
      if (lMovementId_BlinkVIP <> MovementId_BlinkVIP) or(isRefresh = true)
      then begin
                // ��������� ������ ���� ���������� - � ����� "�� �����������"
                MovementId_BlinkVIP:= lMovementId_BlinkVIP;
                // "�� ����� ������" ���������� �����
                StartRefreshDiffThread;
      end;

  except
        Self.Caption := '������� ('+GetFileVersionString(ParamStr(0))+') - OFF-line ����� ��� VIP-�����' + ' - <' + IniUtils.gUnitName + '>' + ' - <' + IniUtils.gUserName + '>'
  end;
end;

procedure TMainCashForm2.SetBlinkCheck (isRefresh : boolean);
var lMovementId_BlinkCheck : String;

begin
  // ���� ������ > 50 ��� - �����������

  if ((now - time_onBlinkCheck) > 0.0003) or(isRefresh = true) then

  try
      //��������� ����� "���������" ��������� ���� ���������� - � "������ - ����/���� �������"
      time_onBlinkCheck:= now;

      //�������� ������ ���� ���������� - � ����� "�� �����������"
      spGet_BlinkCheck.Execute;
      lMovementId_BlinkCheck:=spGet_BlinkCheck.ParamByName('outMovementId_list').Value;

      // � ���� ������ ������ ����� ������
      fBlinkCheck:= lMovementId_BlinkCheck <> '';

      // ���� ���� �����, ������ ON-line ����� ����� ��� �������� "������ - ����/���� �������"
      if fBlinkCheck = True
      then Self.Caption := '������� ('+GetFileVersionString(ParamStr(0))+') : ���� ������ - ����/���� �������' + ' - <' + IniUtils.gUnitName + '>' + ' - <' + IniUtils.gUserName + '>'
      else Self.Caption := '������� ('+GetFileVersionString(ParamStr(0))+')' + ' <' + IniUtils.gUnitName + '>' + ' - <' + IniUtils.gUserName + '>';

  except
        Self.Caption := '������� ('+GetFileVersionString(ParamStr(0))+') - OFF-line ����� ��� ����� � �������' + ' - <' + IniUtils.gUnitName + '>' + ' - <' + IniUtils.gUserName + '>'
  end;
end;


procedure TMainCashForm2.TimerSaveAllTimer(Sender: TObject);
var fEmpt  : Boolean;
    RCount : Integer;
begin
   TimerSaveAll.Enabled:=False;
 //
  try
    WaitForSingleObject(MutexDBF, INFINITE);

    try
      FLocalDataBaseHead.Active:=True;
      FLocalDataBaseHead.Pack;
      fEmpt:= FLocalDataBaseHead.IsEmpty;
      RCount:= FLocalDataBaseHead.RecordCount;
    finally
      FLocalDataBaseBody.Active:=False;
      ReleaseMutex(MutexDBF);
    end;

    //����� �������� ��� ����� � ����� ���� + ������� ����� ��� �� �����������
    try spUpdate_UnitForFarmacyCash.ParamByName('inAmount').Value:= RCount;
        spUpdate_UnitForFarmacyCash.Execute;
    except end;
    //
    if not fEmpt then
      SaveRealAll;
  finally
     //
     TimerSaveAll.Enabled:=True;
  end;
end;




initialization
  RegisterClass(TMainCashForm2);
  FLocalDataBaseHead := TVKSmartDBF.Create(nil);
  FLocalDataBaseBody := TVKSmartDBF.Create(nil);
  FLocalDataBaseDiff := TVKSmartDBF.Create(nil);
  InitializeCriticalSection(csCriticalSection);
  InitializeCriticalSection(csCriticalSection_Save);
  InitializeCriticalSection(csCriticalSection_All);
  FM_SERVISE := RegisterWindowMessage('FarmacyCashMessage');
finalization
  FLocalDataBaseHead.Free;
  FLocalDataBaseBody.Free;
  FLocalDataBaseDiff.Free;
  DeleteCriticalSection(csCriticalSection);
  DeleteCriticalSection(csCriticalSection_Save);
  DeleteCriticalSection(csCriticalSection_All);
end.
