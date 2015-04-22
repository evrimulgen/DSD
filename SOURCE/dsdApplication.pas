unit dsdApplication;

interface

uses Forms, SysUtils, cxLocalization, Windows, Messages, dsdDB;

type

  TdsdApplication = class
  strict private
    class var
      Instance: TdsdApplication;
  private
    cxLocalizer: TcxLocalizer;
    spUserProtocol: TdsdStoredProc;
    procedure OnException(Sender: TObject; E: Exception);
    procedure OnShortCut(var Msg: TWMKey; var Handled: Boolean);
  public
    class function NewInstance: TObject; override;
  end;

implementation

uses Storage, Variants, DBClient, dsdException, MessagesUnit, UtilConst,
     Dialogs, DB, UtilConvert;

{$R DevExpressRus.res}

{ TdsdApplication }

class function TdsdApplication.NewInstance: TObject;
begin
  if not Assigned(Instance) then begin
     Instance := TdsdApplication(inherited NewInstance);
     Application.OnException := Instance.OnException;
     Application.OnShortCut := Instance.OnShortCut;
     Instance.spUserProtocol := TdsdStoredProc.Create(nil);
     Instance.spUserProtocol.StoredProcName := 'gpInsert_UserProtocol';
     Instance.spUserProtocol.OutputType := otResult;
     Instance.spUserProtocol.Params.AddParam('inProtocolData', ftBlob, ptInput, null);

     // ���������� ��������� DevExpress
     Instance.cxLocalizer := TcxLocalizer.Create(nil);
     Instance.cxLocalizer.StorageType := lstResource;
     Instance.cxLocalizer.Active:= True;
     Instance.cxLocalizer.Locale:= 1049;
  end;
  NewInstance := Instance;
end;

procedure TdsdApplication.OnException(Sender: TObject; E: Exception);
  function GetTextMessage(E: Exception; var isMessage: boolean): string;
  begin
    isMessage := false;
    if E is EStorageException then begin
       isMessage := (E as EStorageException).ErrorCode = 'P0001';
       if pos('context', AnsilowerCase(E.Message)) = 0 then
          Result := E.Message
       else
          // ����������� ��� ��� ����� Context
          Result := Copy(E.Message, 1, pos('context', AnsilowerCase(E.Message)) - 1);
       exit;
    end;
    if (E is EOutOfMemory) or (E is EVariantOutOfMemoryError)
        or ((E is EDBClient) and (EDBClient(E).ErrorCode = 9473)) then begin
       Result := '���������� �������� ������� ����� ������.'#10#13'�������� ������ ����������.'#10#13'��� ���������� ������ ������� ��� ������ ������.';
       exit;
    end;
    Result := E.Message;
  end;
var TextMessage: String;
    isMessage: boolean;
begin
  if E is ESortException then
     exit;
  TMessagesForm.Create(nil).Execute(GetTextMessage(E, isMessage), E.Message);
  if not isMessage then begin
    // ��������� �������� � ����
    try
      spUserProtocol.ParamByName('inProtocolData').Value := gfStrToXmlStr(E.Message);
      spUserProtocol.Execute;
    except
      // ����������� ���, ������ ��� ����� �� ����� �����������.
    end;
  end;
end;

procedure TdsdApplication.OnShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  // Ctrl + Shift + S
  if (Msg.CharCode = $53) and ShiftDown and CtrlDown then begin
     gc_isDebugMode := not gc_isDebugMode;
     if gc_isDebugMode then
        ShowMessage('���������� ����� �������')
      else
        ShowMessage('���� ����� �������');
  end;
  // Ctrl + Shift + T
  if (Msg.CharCode = $54) and ShiftDown and CtrlDown then begin
     gc_isShowTimeMode := not gc_isShowTimeMode;
     if gc_isShowTimeMode then
        ShowMessage('���������� ����� �������� �������')
      else
        ShowMessage('���� ����� �������� �������');
  end;
  // Ctrl + Shift + D
  if (Msg.CharCode = $44) and ShiftDown and CtrlDown then begin
     gc_isSetDefault := not gc_isSetDefault;
     if gc_isSetDefault then
        ShowMessage('��������� ������������ �� �����������')
      else
        ShowMessage('��������� ������������ �����������');
  end;
end;

end.