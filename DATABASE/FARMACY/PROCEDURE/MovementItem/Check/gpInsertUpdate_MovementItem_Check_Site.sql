-- Function: gpInsertUpdate_MovementItem_Check_Site()

DROP FUNCTION IF EXISTS gpInsertUpdate_MovementItem_Check_Site (Integer, Integer, Integer, TFloat, TFloat, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_MovementItem_Check_Site(
 INOUT ioId                  Integer   , -- ���� ������� <������ ���������>
    IN inMovementId          Integer   , -- ���� ������� <��������>
    IN inGoodsId             Integer   , -- ������
    IN inAmount              TFloat    , -- ����������
    IN inPrice               TFloat    , -- ����
    IN inSession             TVarChar    -- ������ ������������
)
RETURNS Integer
AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbIsInsert Boolean;
   DECLARE vbAmount_old TFloat;
BEGIN

    -- �������� ���� ������������ �� ����� ���������
    -- PERFORM lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_MovementItem_Income());
    vbUserId := lpGetUserBySession (inSession);

    -- ������� ������� �� ��������� � ������
    IF (COALESCE(ioId,0) = 0)
       or
       (NOT EXISTS(SELECT 1 FROM MovementItem Where Id = ioId))       
    THEN
        SELECT 
            Id, Amount
        INTO 
            ioId, vbAmount_old
        FROM MovementItem
        WHERE MovementId = inMovementId 
          AND ObjectId = inGoodsId 
          AND DescId = zc_MI_Master();
    END IF;

     -- ������������ ������� ��������/�������������
     vbIsInsert:= COALESCE (ioId, 0) = 0;

    -- ��������� <������� ���������>
    ioId := lpInsertUpdate_MovementItem (ioId, zc_MI_Master(), inGoodsId, inMovementId, inAmount + COALESCE (vbAmount_old, 0), NULL);

    -- ��������� �������� <���-�� ������>
    PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_AmountOrder(), ioId, inAmount);

    -- ��������� �������� <����>
    PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_Price(), ioId, inPrice);
     
    -- ��������� �������� <���� ��� ������>
    PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_PriceSale(), ioId, inPrice);

    -- ����������� �������� �����
    PERFORM lpInsertUpdate_MovementFloat_TotalSummCheck (inMovementId);

    -- ��������� ��������
    PERFORM lpInsert_MovementItemProtocol (ioId, vbUserId, vbIsInsert);

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION gpInsertUpdate_MovementItem_Check_Site(Integer, Integer, Integer, TFloat, TFloat, TVarChar) OWNER TO postgres;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.   ��������� �.�.
 17.12.2015                                                                      *
*/

-- ����
-- SELECT * FROM gpInsertUpdate_MovementItem_Check_Site (ioId:= 0, inMovementId:= 2335122, inGoodsId:= 51922, inAmount:= 10, inPrice:= 1, inSession := '3')
