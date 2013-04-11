unit JuridicalEditUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxPropertiesStore, dsdDataSetWrapperUnit,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, Vcl.Menus, Vcl.StdCtrls, cxButtons, cxLabel, cxTextEdit, Vcl.ActnList,
  Vcl.StdActns, dsdActionUnit, FormUnit, cxCurrencyEdit, cxCheckBox,
  dsdGuidesUtilUnit, Data.DB, Datasnap.DBClient, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox;

type
  TJuridicalEditForm = class(TParentForm)
    edName: TcxTextEdit;
    cxLabel1: TcxLabel;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    ActionList: TActionList;
    spInsertUpdate: TdsdStoredProc;
    dsdFormParams: TdsdFormParams;
    spGet: TdsdStoredProc;
    dsdDataSetRefresh: TdsdDataSetRefresh;
    dsdExecStoredProc: TdsdExecStoredProc;
    dsdFormClose1: TdsdFormClose;
    ���: TcxLabel;
    ceCode: TcxCurrencyEdit;
    cxLabel2: TcxLabel;
    edGLNCode: TcxTextEdit;
    cbisCorporate: TcxCheckBox;
    cxLabel3: TcxLabel;
    ceParentGroup: TcxLookupComboBox;
    JuridicalGroupDataSet: TClientDataSet;
    spGetJuridicalGroup: TdsdStoredProc;
    JuridicalGroupDS: TDataSource;
    dsdJuridicalGroupGuides: TdsdGuides;
    cxLabel4: TcxLabel;
    ceGoodsProperty: TcxLookupComboBox;
    GoodsPropertyDataSet: TClientDataSet;
    spGetGoodsProperty: TdsdStoredProc;
    GoodsPropertyDS: TDataSource;
    dsdGoodsPropertyGuides: TdsdGuides;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

initialization
  RegisterClass(TJuridicalEditForm);

end.
