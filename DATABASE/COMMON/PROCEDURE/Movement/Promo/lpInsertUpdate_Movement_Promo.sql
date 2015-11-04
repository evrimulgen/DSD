-- Function: lpInsertUpdate_Movement_Promo()

DROP FUNCTION IF EXISTS lpInsertUpdate_Movement_Promo (
Integer    , -- ���� ������� <�������� �������>
    TVarChar   , -- ����� ���������
    TDateTime  , -- ���� ���������
    Integer    , -- ��� �����
    TDateTime  , -- ���� ������ �����
    TDateTime  , -- ���� ��������� �����
    TDateTime  , -- ���� ������ �������� �� ��������� ����
    TDateTime  , -- ���� ��������� �������� �� ��������� ����
    TDateTime  , -- ���� ������ ����. ������ �� �����
    TDateTime  , -- ���� ��������� ����. ������ �� �����
    TFloat     , -- ��������� ������� � �����
    TVarChar   , -- ����������
    Integer    , -- ��������� ���������
    Integer    , -- �������������
    Integer    , -- ������������� ������������� ������������� ������
    Integer    , -- ������������� ������������� �������������� ������	
    Integer );  -- ������������

CREATE OR REPLACE FUNCTION lpInsertUpdate_Movement_Promo(
 INOUT ioId                    Integer    , -- ���� ������� <�������� �������>
    IN inInvNumber             TVarChar   , -- ����� ���������
    IN inOperDate              TDateTime  , -- ���� ���������
    IN inPromoKindId           Integer    , -- ��� �����
    IN inStartPromo            TDateTime  , -- ���� ������ �����
    IN inEndPromo              TDateTime  , -- ���� ��������� �����
    IN inStartSale             TDateTime  , -- ���� ������ �������� �� ��������� ����
    IN inEndSale               TDateTime  , -- ���� ��������� �������� �� ��������� ����
    IN inOperDateStart         TDateTime  , -- ���� ������ ����. ������ �� �����
    IN inOperDateEnd           TDateTime  , -- ���� ��������� ����. ������ �� �����
    IN inCostPromo             TFloat     , -- ��������� ������� � �����
    IN inComment               TVarChar   , -- ����������
    IN inAdvertisingId         Integer    , -- ��������� ���������
    IN inUnitId                Integer    , -- �������������
    IN inPersonalTradeId       Integer    , -- ������������� ������������� ������������� ������
    IN inPersonalId            Integer    , -- ������������� ������������� �������������� ������
    IN inUserId                Integer      -- ������������
)
RETURNS Integer AS
$BODY$
   DECLARE vbIsInsert Boolean;
BEGIN
    -- ��������
    IF inOperDate <> DATE_TRUNC ('DAY', inOperDate)
    THEN
        RAISE EXCEPTION '������.�������� ������ ����.';
    END IF;
    
    -- ���������� ������� ��������/�������������
    vbIsInsert:= COALESCE (ioId, 0) = 0;
    
    -- ��������� <��������>
    ioId := lpInsertUpdate_Movement (ioId, zc_Movement_Promo(), inInvNumber, inOperDate, NULL, 0);
    
    -- ��������� ����� � <�� ���� (�������������)>
    PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_Unit(), ioId, inUnitId);
    
    -- ��� �����
    PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_PromoKindId(), ioId, inPromoKindId);
    -- ���� ������ �����
    PERFORM lpInsertUpdate_MovementDate (zc_MovementDate_StartPromo(), ioId, inStartPromo);
    -- ���� ��������� �����
    PERFORM lpInsertUpdate_MovementDate (zc_MovementDate_EndPromo(), ioId, inEndPromo);
    -- ���� ������ �������� �� ��������� ����
    PERFORM lpInsertUpdate_MovementDate (zc_MovementDate_StartSale(), ioId, inStartSale);
    -- ���� ��������� �������� �� ��������� ����
    PERFORM lpInsertUpdate_MovementDate (zc_MovementDate_EndSale(), ioId, inEndSale);
    -- ���� ������ ����. ������ �� �����
    PERFORM lpInsertUpdate_MovementDate (zc_MovementDate_OperDateStart(), ioId, inOperDateStart);
    -- ���� ��������� ����. ������ �� �����
    PERFORM lpInsertUpdate_MovementDate (zc_MovementDate_OperDateEnd(), ioId, inOperDateEnd);
    -- ��������� ������� � �����
    PERFORM lpInsertUpdate_MovementFloat (zc_MovementDate_CostPromo(), ioId, inCostPromo);
    -- ����������
    PERFORM lpInsertUpdate_MovementString (zc_MovementDate_Comment(), ioId, inComment);
    -- ��������� ���������
    PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_Advertising(), ioId, inAdvertisingId);
    -- �������������
    PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_Unit(), ioId, inUnitId);
    -- ������������� ������������� ������������� ������
    PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_PersonalTrade(), ioId, inPersonalTradeId);
    -- ������������� ������������� �������������� ������
    PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_Personal(), ioId, inPersonalId);
    
    -- ��������� ��������
    PERFORM lpInsert_MovementProtocol (ioId, inUserId, vbIsInsert);

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.   ��������� �.�.
 31.10.15                                                                       *
*/