unit GuideGoodsMovement;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, GuideGoods, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinsDefaultPainters, Data.DB, Datasnap.DBClient, dsdDB, cxTextEdit,
  cxCurrencyEdit, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.Grids,
  Vcl.DBGrids;

type
  TGuideGoodsMovementForm = class(TGuideGoodsForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GuideGoodsMovementForm: TGuideGoodsMovementForm;

implementation

{$R *.dfm}

end.