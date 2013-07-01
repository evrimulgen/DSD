unit dbMovementTest;

interface
uses TestFramework, dbObjectTest;

type

  TdbMovementTest = class (TTestCase)
  private
    // �������� ���������
    procedure DeleteMovement(Id: integer);
  protected
    // �������������� ������ ��� ������������
    procedure SetUp; override;
    // ���������� ������ ��� ������������
    procedure TearDown; override;
  published
    procedure MovementIncomeTest;
    procedure MovementProductionUnionTest;
  end;

  TMovementIncomeTest = class(TObjectTest)
  private
    function InsertDefault: integer; override;
  protected
    procedure SetDataSetParam; override;
  public
    function InsertUpdateMovementIncome(Id: Integer; InvNumber: String; OperDate: TDateTime;
             OperDatePartner: TDateTime; InvNumberPartner: String; PriceWithVAT: Boolean;
             VATPercent, DiscountPercent, ExtraChargesPercent: double;
             FromId, ToId, PaidKindId, ContractId, CarId, PersonalDriverId, PersonalPackerId: Integer
             ): integer;
    constructor Create; override;
  end;

  TMovementProductionUnionTest = class(TObjectTest)
  private
    function InsertDefault: integer; override;
  protected
    procedure SetDataSetParam; override;
  public
    function InsertUpdateMovementProductionUnion(Id: Integer; InvNumber: String;
             OperDate: TDateTime; FromId, ToId: Integer): integer;
    constructor Create; override;
  end;

implementation

uses DB, Storage, SysUtils;
{ TDataBaseObjectTest }
{------------------------------------------------------------------------------}
procedure TdbMovementTest.TearDown;
begin
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TdbMovementTest.DeleteMovement(Id: integer);
const
   pXML =
  '<xml Session = "">' +
    '<lpDelete_Movement OutputType="otResult">' +
       '<inId DataType="ftInteger" Value="%d"/>' +
    '</lpDelete_Movement>' +
  '</xml>';
begin
  TStorageFactory.GetStorage.ExecuteProc(Format(pXML, [Id]))
end;
{------------------------------------------------------------------------------}
procedure TdbMovementTest.MovementIncomeTest;
var
  MovementIncome: TMovementIncomeTest;
  Id: Integer;
begin
  MovementIncome := TMovementIncomeTest.Create;
  Id := MovementIncome.InsertDefault;
  // �������� ���������
  try
  // ��������������
  finally
    // ��������
    DeleteMovement(Id);
  end;
end;

procedure TdbMovementTest.MovementProductionUnionTest;
var
  MovementProductionUnion: TMovementProductionUnionTest;
  Id: Integer;
begin
  MovementProductionUnion := TMovementProductionUnionTest.Create;
  Id := MovementProductionUnion.InsertDefault;
  // �������� ���������
  try
  // ��������������
  finally
    // ��������
    DeleteMovement(Id);
  end;
end;

procedure TdbMovementTest.SetUp;
begin
  inherited;
end;
{------------------------------------------------------------------------------}
{ TMovementIncome }

constructor TMovementIncomeTest.Create;
begin
  inherited;
  spInsertUpdate := 'gpInsertUpdate_Movement_Income';
  spSelect := 'gpSelect_Movement_Income';
  spGet := 'gpGet_Movement_Income';
end;

function TMovementIncomeTest.InsertDefault: integer;
var Id: Integer;
    InvNumber: String;
    OperDate: TDateTime;
    OperDatePartner: TDateTime;
    InvNumberPartner: String;
    PriceWithVAT: Boolean;
    VATPercent, DiscountPercent, ExtraChargesPercent: double;
    FromId, ToId, PaidKindId, ContractId, CarId, PersonalDriverId, PersonalPackerId: Integer;
begin
  Id:=0;
  InvNumber:='1';
  OperDate:= Date;

  OperDatePartner:= Date;
  InvNumberPartner:='InvNumberPartner';

  PriceWithVAT:=true;
  VATPercent:=20;
  DiscountPercent:=0;
  ExtraChargesPercent:=0;

  FromId := TPartnerTest.Create.GetDefault;
  ToId := TUnitTest.Create.GetDefault;
  PaidKindId:=0;
  ContractId:=0;
  CarId:=0;
  PersonalDriverId:=0;
  PersonalPackerId:=0;
  //
  result := InsertUpdateMovementIncome(Id, InvNumber, OperDate,
             OperDatePartner, InvNumberPartner, PriceWithVAT,
             VATPercent, DiscountPercent, ExtraChargesPercent,
             FromId, ToId, PaidKindId, ContractId, CarId, PersonalDriverId, PersonalPackerId);
end;

function TMovementIncomeTest.InsertUpdateMovementIncome(Id: Integer; InvNumber: String; OperDate: TDateTime;
             OperDatePartner: TDateTime; InvNumberPartner: String; PriceWithVAT: Boolean;
             VATPercent, DiscountPercent, ExtraChargesPercent: double;
             FromId, ToId, PaidKindId, ContractId, CarId, PersonalDriverId, PersonalPackerId: Integer):Integer;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, Id);
  FParams.AddParam('inInvNumber', ftString, ptInput, InvNumber);
  FParams.AddParam('inOperDate', ftDateTime, ptInput, OperDate);

  FParams.AddParam('inOperDatePartner', ftDateTime, ptInput, OperDatePartner);
  FParams.AddParam('inInvNumberPartner', ftString, ptInput, InvNumberPartner);

  FParams.AddParam('inPriceWithVAT', ftBoolean, ptInput, PriceWithVAT);
  FParams.AddParam('inVATPercent', ftFloat, ptInput, VATPercent);
  FParams.AddParam('inDiscountPercent', ftFloat, ptInput, DiscountPercent);
  FParams.AddParam('inExtraChargesPercent', ftFloat, ptInput, ExtraChargesPercent);

  FParams.AddParam('inFromId', ftInteger, ptInput, FromId);
  FParams.AddParam('inToId', ftInteger, ptInput, ToId);
  FParams.AddParam('inPaidKindId', ftInteger, ptInput, PaidKindId);
  FParams.AddParam('inContractId', ftInteger, ptInput, ContractId);
  FParams.AddParam('inCarId', ftInteger, ptInput, CarId);
  FParams.AddParam('inPersonalDriverId', ftInteger, ptInput, PersonalDriverId);
  FParams.AddParam('inPersonalPackerId', ftInteger, ptInput, PersonalPackerId);

  result := InsertUpdate(FParams);
end;

procedure TMovementIncomeTest.SetDataSetParam;
begin
  inherited;
  FParams.AddParam('inStartDate', ftDateTime, ptInput, Date);
  FParams.AddParam('inEndDate', ftDateTime, ptInput, Date);
end;

{ TMovementProductionUnionTest }

constructor TMovementProductionUnionTest.Create;
begin
  inherited;
  spInsertUpdate := 'gpInsertUpdate_Movement_ProductionUnion';
  spSelect := 'gpSelect_Movement_ProductionUnion';
  spGet := 'gpGet_Movement_ProductionUnion';
end;

function TMovementProductionUnionTest.InsertDefault: integer;
begin
  result := InsertUpdateMovementProductionUnion(0, '����� 1', Date, 0, 0);
end;

function TMovementProductionUnionTest.InsertUpdateMovementProductionUnion(
  Id: Integer; InvNumber: String; OperDate: TDateTime; FromId,
  ToId: Integer): integer;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, Id);
  FParams.AddParam('inInvNumber', ftString, ptInput, InvNumber);
  FParams.AddParam('inOperDate', ftDateTime, ptInput, OperDate);
  FParams.AddParam('inFromId', ftInteger, ptInput, FromId);
  FParams.AddParam('inToId', ftInteger, ptInput, ToId);
  result := InsertUpdate(FParams);
end;

procedure TMovementProductionUnionTest.SetDataSetParam;
begin
  inherited;
  FParams.AddParam('inStartDate', ftDateTime, ptInput, Date);
  FParams.AddParam('inEndDate', ftDateTime, ptInput, Date);
end;

initialization
  TestFramework.RegisterTest('���������', TdbMovementTest.Suite);

end.

implementation

end.
