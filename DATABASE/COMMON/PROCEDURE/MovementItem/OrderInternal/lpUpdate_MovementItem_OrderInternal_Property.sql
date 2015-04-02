-- Function: lpUpdate_MovementItem_OrderInternal_Property()


DROP FUNCTION IF EXISTS lpUpdate_MovementItem_OrderInternal_Property (Integer, Integer, Integer, Integer, TFloat, Integer, TFloat, Integer, TFloat, TFloat, Integer);

CREATE OR REPLACE FUNCTION lpUpdate_MovementItem_OrderInternal_Property(
    IN inId                  Integer   , -- ���� ������� <������� ���������>
    IN inMovementId          Integer   , -- ���� ������� <��������>
    IN inGoodsId             Integer   , -- ������
    IN inGoodsKindId         Integer   , -- ���� �������
    IN inAmount_Param        TFloat    , -- 
    IN inDescId_Param        Integer  ,
    IN inAmount_ParamOrder   TFloat    , -- 
    IN inDescId_ParamOrder   Integer  ,
    IN inUserId              Integer     -- ������������
)
RETURNS VOID AS--RECORD AS
$BODY$
   DECLARE vbIsInsert Boolean;
   --DECLARE vbinId Integer;   
BEGIN
     -- ������������ ������� ��������/�������������
     vbIsInsert:= COALESCE (inId, 0) = 0;

     IF COALESCE (inId, 0) = 0 
     THEN
       -- ��������� <������� ���������>
       inId := lpInsertUpdate_MovementItem (inId, zc_MI_Master(), inGoodsId, inMovementId, 0, NULL);

       -- ��������� ����� � <���� �������>
       PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_GoodsKind(), inId, inGoodsKindId);
  
     END IF;

     -- ��������� ��������
     PERFORM lpInsertUpdate_MovementItemFloat (inDescId_Param, inId, inAmount_Param);
     -- ��������� ��������
     IF inDescId_ParamOrder <> 0
     THEN
         PERFORM lpInsertUpdate_MovementItemFloat (inDescId_ParamOrder, inId, inAmount_ParamOrder);
     END IF;

     -- ��������� ��������
     PERFORM lpInsert_MovementItemProtocol (inId, inUserId, vbIsInsert);

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 02.03.15         *
*/

-- ����
-- SELECT * FROM lpUpdate_MovementItem_OrderInternal_Property (inId:= 10696633, inMovementId:= 869524, inGoodsId:= 7402,  inGoodsKindId := 8328 , inAmount:= 45::TFloat, inAmountParam:= 777::TFloat, inDescCode:= 'zc_MIFloat_AmountRemains'::TVarChar, inSession:= lpCheckRight ('5', zc_Enum_Process_InsertUpdate_MI_OrderInternal()))

--select * from gpInsertUpdate_MovementItem_OrderInternal(ioId := 10696633 , inMovementId := 869524 , inGoodsId := 7402 , inAmount := 45 , inAmountSecond := 0 , inGoodsKindId := 8328 , inPrice := 68.75 , ioCountForPrice := 1 ,  inSession := '5');

-- select lpCheckRight ('5', zc_Enum_Process_InsertUpdate_MI_OrderInternal());