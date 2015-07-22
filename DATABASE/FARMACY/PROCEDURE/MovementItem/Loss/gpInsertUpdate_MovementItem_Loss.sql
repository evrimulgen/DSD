-- Function: gpInsertUpdate_MovementItem_Loss()

DROP FUNCTION IF EXISTS gpInsertUpdate_MovementItem_Loss (Integer, Integer, Integer, TFloat, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_MovementItem_Loss(
 INOUT ioId                  Integer   , -- ���� ������� <������� ���������>
    IN inMovementId          Integer   , -- ���� ������� <��������>
    IN inGoodsId             Integer   , -- ������
    IN inAmount              TFloat    , -- ����������
    IN inPartionGoodsId      Integer   , -- ������ ������� (��� ������ ������� ���� � ��)
    IN inSession             TVarChar    -- ������ ������������
)
RETURNS Integer AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     --vbUserId:= lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_MI_Loss());

     -- ���������
     ioId:= lpInsertUpdate_MovementItem_Loss (ioId                 := ioId
                                            , inMovementId         := inMovementId
                                            , inGoodsId            := inGoodsId
                                            , inAmount             := inAmount
                                            , inPartionGoodsId     := inPartionGoodsId
                                            , inUserId             := vbUserId
                                             );

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpInsertUpdate_MovementItem_Loss (Integer, Integer, Integer, TFloat, Integer, TVarChar) OWNER TO postgres;
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.  ��������� �.�.
 20.07.15                                                                    *
*/

-- ����
-- SELECT * FROM gpInsertUpdate_MovementItem_Loss (ioId:= 0, inMovementId:= 10, inGoodsId:= 1, inAmount:= 0, inPartionGoodsId:= 0, inSession:= '2')
