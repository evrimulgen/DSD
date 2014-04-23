unit GoodsByGoodsKind1CLink;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AncestorDBGrid, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxPCdxBarPopupMenu, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, Data.DB, cxDBData,
  Vcl.Menus, dsdAddOn, dxBarExtItems, dxBar, cxClasses, dsdDB,
  Datasnap.DBClient, dsdAction, Vcl.ActnList, cxPropertiesStore, cxGridLevel,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, cxPC, cxSplitter, cxContainer, cxTextEdit, cxMaskEdit, cxButtonEdit,
  dsdGuides, dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  dxSkinsdxBarPainter, DataModul, cxLabel;

type
  TGoodsByGoodsKind1CLinkForm = class(TAncestorDBGridForm)
    colGoodsCode: TcxGridDBColumn;
    colGoodsName: TcxGridDBColumn;
    colDetailCode: TcxGridDBColumn;
    colDetailName: TcxGridDBColumn;
    colDetailBranch: TcxGridDBColumn;
    dxBarControlContainerItem: TdxBarControlContainerItem;
    edBranch: TcxButtonEdit;
    BranchGuides: TdsdGuides;
    spInsertUpdate: TdsdStoredProc;
    actUpdateDataSet: TdsdUpdateDataSet;
    actChoiceBranchForm: TOpenChoiceForm;
    colGoodsKindName: TcxGridDBColumn;
    bbInsertRecord: TdxBarButton;
    cxLabel1: TcxLabel;
    bbJuridicalLabel: TdxBarControlContainerItem;
    actChoiceGoodsKindForm: TOpenChoiceForm;
    colPrice: TcxGridDBColumn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

initialization
  RegisterClass(TGoodsByGoodsKind1CLinkForm);

end.
