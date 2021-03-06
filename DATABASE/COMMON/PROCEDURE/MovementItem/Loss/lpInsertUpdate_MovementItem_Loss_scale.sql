-- Function: lpInsertUpdate_MovementItem_Loss_scale() - !!!������� �.�. ��� ������ �� scale ����� ���� � �����!!!

DROP FUNCTION IF EXISTS lpInsertUpdate_MovementItem_Loss_scale (Integer, Integer, Integer, TFloat, TFloat, TFloat, TVarChar, Integer, Integer);

CREATE OR REPLACE FUNCTION lpInsertUpdate_MovementItem_Loss_scale(
 INOUT ioId                  Integer   , -- ���� ������� <������� ���������>
    IN inMovementId          Integer   , -- ���� ������� <��������>
    IN inGoodsId             Integer   , -- ������
    IN inAmount              TFloat    , -- ����������
    IN inPrice               TFloat    , -- ����
    IN inCountForPrice       TFloat    , -- ���� �� ����������
    IN inPartionGoods        TVarChar  , -- ������ ������
    IN inGoodsKindId         Integer   , -- ���� �������
    IN inUserId              Integer     -- ������������
)
RETURNS Integer
AS
$BODY$
BEGIN
     -- ���������
     ioId:= lpInsertUpdate_MovementItem_Loss (ioId                 := ioId
                                            , inMovementId         := inMovementId
                                            , inGoodsId            := inGoodsId
                                            , inAmount             := inAmount
                                            , inCount              := 0    -- !!!�� ������, ����� �� �����������!!!
                                            , inHeadCount          := 0    -- !!!�� ������, ����� �� �����������!!!
                                            , inPartionGoodsDate   := NULL -- !!!�� ������, ����� �� �����������!!!
                                            , inPartionGoods       := inPartionGoods
                                            , inGoodsKindId        := inGoodsKindId
                                            , inAssetId            := NULL -- !!!�� ������, ����� �� �����������!!!
                                            , inPartionGoodsId     := NULL -- !!!�� ������, ����� �� �����������!!!
                                            , inUserId             := inUserId
                                             );

     -- ��������� �������� <����>
     PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_Price(), ioId, inPrice);

     -- ��������� �������� <���� �� ����������>
     IF COALESCE (inCountForPrice, 0) = 0 THEN inCountForPrice := 1; END IF;
     PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_CountForPrice(), ioId, inCountForPrice);

     -- ����������� �������� ����� �� ���������
     PERFORM lpInsertUpdate_MovementFloat_TotalSumm (inMovementId);

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 29.05.15                                        *
*/

-- ����
-- SELECT * FROM lpInsertUpdate_MovementItem_Loss_scale (ioId:= 0, inMovementId:= 10, inGoodsId:= 1, inAmount:= 0, inHeadCount:= 0, inPartionGoods:= '', inGoodsKindId:= 0, inSession:= '2')
