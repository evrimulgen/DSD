unit CashFactory;

interface
uses CashInterface;
type
  TCashFactory = class
    class function GetCash(CashType: string): ICash;
  end;

implementation

uses Cash_FP3530T, Cash_FP3530T_NEW, {CashApp,} SysUtils;
{ TCashFactory }
class function TCashFactory.GetCash(CashType: string): ICash;
begin
  if CashType = 'FP3530T' then
     result := TCashFP3530T.Create;
  if CashType = 'FP3530T_NEW' then
     result := TCashFP3530T_NEW.Create;
  if not Assigned(Result) then
     raise Exception.Create('�� ��������� ������ ��� ����� � Ini �����');
(*CashSamsung:=TCashSamsung.Create(GetDefaultValue_fromFile(ifDefaults,Self.ClassName,'ComPort','COM2:'));
  with CashSamsung do begin
       test:=GetDefaultValue_fromFile(ifDefaults,Self.ClassName,'Cashtest','1')='0';
       DelayForSoldPC:=StrToInt(GetDefaultValue_fromFile(ifDefaults,Self.ClassName,'DelayForSoldPC','20'));
       DelayBetweenLine:=StrToInt(GetDefaultValue_fromFile(ifDefaults,Self.ClassName,'DelayBetweenLine','500'));
       SoldInEightReg:=SoldEightReg;
  end;*)
  
end;

end.