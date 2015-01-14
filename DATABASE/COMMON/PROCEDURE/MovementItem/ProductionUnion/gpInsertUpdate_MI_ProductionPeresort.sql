-- Function: gpInsertUpdate_MI_ProductionPeresort()

DROP FUNCTION IF EXISTS gpInsertUpdate_MI_ProductionPeresort  (Integer, Integer, Integer, TFloat, TVarChar, TVarChar, Integer, Integer, TVarChar, Integer, TVarChar);
DROP FUNCTION IF EXISTS gpInsertUpdate_MI_ProductionPeresort  (Integer, Integer, Integer, TFloat, TVarChar, TDateTime, TVarChar, Integer, Integer, TVarChar, TDateTime, Integer, Integer, TVarChar, TVarChar);
DROP FUNCTION IF EXISTS gpInsertUpdate_MI_ProductionPeresort  (Integer, Integer, Integer, TFloat, TVarChar, TDateTime, TVarChar, Integer, Integer, TVarChar, TDateTime, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_MI_ProductionPeresort(
 INOUT ioId                     Integer   , -- ���� ������� <������� ���������>
    IN inMovementId             Integer   , -- ���� ������� <��������>
    IN inGoodsId                Integer   , -- �����
    IN inAmount                 TFloat    , -- ����������
    IN inPartionGoods           TVarChar  , -- ������ ������
    IN inPartionGoodsDate       TDateTime , -- ������ ������
    IN inComment                TVarChar  , -- �����������	                   
    IN inGoodsKindId            Integer   , -- ���� ������� 
 INOUT ioGoodsChildId           Integer   , -- ������
    IN inPartionGoodsChild      TVarChar  , -- ������ ������  
    IN inPartionGoodsDateChild  TDateTime , -- ������ ������    
    IN inGoodsKindChildId       Integer   , -- ���� �������
   OUT outGoodsChilCode         Integer   , --
   OUT outGoodsChildName        TVarChar  , --
    IN inSession                TVarChar    -- ������ ������������
)                              
RETURNS Record AS
$BODY$
   DECLARE vbUserId  Integer;
   DECLARE vbChildId Integer;
BEGIN
   -- �������� ���� ������������ �� ����� ���������
   vbUserId:= lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_MI_ProductionUnion());
   
   -- ������ ��������
   IF COALESCE (ioGoodsChildId, 0) = 0 
   THEN
       ioGoodsChildId:= inGoodsId;
   END IF;
   --
   outGoodsChildName:= (SELECT ValueData FROM Object WHERE Id = ioGoodsChildId);
   outGoodsChilCode:= (SELECT ObjectCode FROM Object WHERE Id = ioGoodsChildId);

   -- ������ ��������
   IF inPartionGoodsDate <= '01.01.1900' THEN inPartionGoodsDate:= NULL; END IF;
   IF inPartionGoodsDateChild <= '01.01.1900' THEN inPartionGoodsDateChild:= NULL; END IF;
   
   IF COALESCE (ioId,0) <> 0
   THEN
      vbChildId := (SELECT Id FROM MovementItem WHERE MovementId = inMovementId 
                                                  AND ParentId   = ioId
                                                  AND DescId     = zc_MI_Child());
   END IF;

   -- ��������� <Master>
   ioId :=lpInsertUpdate_MI_ProductionUnion_Master (ioId               := ioId
                                                  , inMovementId       := inMovementId
                                                  , inGoodsId          := inGoodsId
                                                  , inAmount           := inAmount
                                                  , inPartionClose     := NULL-- ''::Boolean
                                                  , inCount            := 0 ::TFloat
                                                  , inRealWeight       := 0 ::TFloat
                                                  , inCuterCount       := 0 ::TFloat
                                                  , inPartionGoods     := inPartionGoods
                                                  , inComment          := inComment
                                                  , inGoodsKindId      := inGoodsKindId
                                                  , inGoodsKindCompleteId:= NULL--0 ::integer
                                                  , inReceiptId        := NULL--0 ::integer
                                                  , inUserId           := vbUserId
                                                  );


   -- ��������� �������� <������ ������> ��� �������
   PERFORM lpInsertUpdate_MovementItemDate (zc_MIDate_PartionGoods(), ioId, inPartionGoodsDate);

   -- ��������� <Child>
   vbChildId := lpInsertUpdate_MI_ProductionUnion_Child(ioId          := vbChildId
                                                 , inMovementId       := inMovementId
                                                 , inGoodsId          := ioGoodsChildId
                                                 , inAmount           := inAmount
                                                 , inParentId         := ioId
                                                 , inAmountReceipt    := 0 ::TFloat
                                                 , inPartionGoodsDate := inPartionGoodsDateChild
                                                 , inPartionGoods     := inPartionGoodsChild
                                                 , inComment          := NULL--'' ::TVarChar
                                                 , inGoodsKindId      := inGoodsKindChildId
                                                 , inUserId           := vbUserId
                                                 );


END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 26.12.14                                        *
 11.12.14         *
*/

-- ����
-- SELECT * FROM gpInsertUpdate_MI_ProductionPeresort (ioId:= 0, inMovementId:= 10, inGoodsId:= 1, inAmount:= 0, inPartionClose:= FALSE, inComment:= '', inCount:= 1, inRealWeight:= 1, inCuterCount:= 0, inReceiptId:= 0, inSession:= '2')
-- select * from gpInsertUpdate_MI_ProductionPeresort(ioId := 0 , inMovementId := 597577 , inGoodsId := 2589 , inAmount := 5 , inPartionGoods := '' , inComment := '' , inGoodsKindId := 8330 , inGoodsChildId := 0 , inPartionGoodsChild := '' , inGoodsKindChildId := 0 ,  inSession := '5');