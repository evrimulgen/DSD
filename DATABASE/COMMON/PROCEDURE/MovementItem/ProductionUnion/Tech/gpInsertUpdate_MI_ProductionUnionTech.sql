-- Function: gpInsertUpdate_MI_ProductionUnionTech()

DROP FUNCTION IF EXISTS gpInsertUpdate_MI_ProductionUnionTech (Integer, Integer, Integer, TDateTime, Integer, Integer, Integer, Integer, TFloat, TFloat, TFloat, TVarChar, Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_MI_ProductionUnionTech(
    IN inMovementItemId_order Integer   , -- ���� ������� <������� ���������>
 INOUT ioMovementItemId       Integer   , -- ���� ������� <������� ���������>
 INOUT ioMovementId           Integer   , -- ���� ������� <��������>
    IN inOperDate             TDateTime , -- ���� ���������
    IN inFromId               Integer   , -- �� ���� (� ���������)
    IN inToId                 Integer   , -- ���� (� ���������)

    IN inReceiptId            Integer   , -- ���������
    IN inGoodsId              Integer   , -- ������
    IN inCount	              TFloat    , -- ���������� ������� ��� ��������
    IN inRealWeight           TFloat    , -- ����������� ���(������������)
    IN inCuterCount           TFloat    , -- ���������� �������

    IN inComment              TVarChar  , -- ����������
    IN inGoodsKindId          Integer   , -- ���� �������
    IN inGoodsKindCompleteId  Integer   , -- ���� �������  ��
    IN inSession              TVarChar    -- ������ ������������
)
RETURNS RECORD
AS
$BODY$
   DECLARE vbUserId Integer;

   DECLARE vbAmount TFloat;
BEGIN
   -- �������� ���� ������������ �� ����� ���������
   vbUserId:= lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_MI_ProductionUnionTech());


   -- ��������
   IF COALESCE (inGoodsId, 0) = 0 
   THEN
       RAISE EXCEPTION '������.�������� <�������� ������> �� �����������.';
   END IF;
   -- ��������
   IF COALESCE (inReceiptId, 0) = 0 
   THEN
       RAISE EXCEPTION '������.�������� <�������� ���������> �� �����������.';
   END IF;


   -- ��������� <��������>
   IF COALESCE (ioMovementId, 0) = 0
   THEN ioMovementId:= lpInsertUpdate_Movement_ProductionUnion (ioId        := ioMovementId
                                                              , inInvNumber := NEXTVAL ('movement_productionunion_seq') :: TVarChar
                                                              , inOperDate  := inOperDate
                                                              , inFromId    := inFromId
                                                              , inToId      := inToId
                                                              , inIsPeresort:= FALSE
                                                              , inUserId    := vbUserId
                                                               );
   ELSE
        -- 1. ����������� ��������
        PERFORM lpUnComplete_Movement (inMovementId := ioMovementId
                                     , inUserId     := vbUserId);

   END IF;


   -- ������� �������� Child
   CREATE TEMP TABLE _tmpChild (MovementItemId Integer, GoodsId Integer, GoodsKindId Integer, Amount TFloat, AmountReceipt TFloat, Amount_master TFloat, isWeightMain Boolean, isTaxExit Boolean, isErased Boolean) ON COMMIT DROP;
   --
   WITH tmpMI_Child AS (SELECT MovementItem.Id                                  AS MovementItemId
                             , MovementItem.ObjectId                            AS GoodsId
                             , COALESCE (MILO_GoodsKind.ObjectId, 0)            AS GoodsKindId
                             , MovementItem.Amount                              AS Amount
                             , COALESCE (MIFloat_AmountReceipt.ValueData, 0)    AS AmountReceipt
                        FROM MovementItem
                             LEFT JOIN MovementItemLinkObject AS MILO_GoodsKind
                                                              ON MILO_GoodsKind.MovementItemId = MovementItem.Id
                                                             AND MILO_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
                             LEFT JOIN MovementItemFloat AS MIFloat_AmountReceipt
                                                         ON MIFloat_AmountReceipt.MovementItemId = MovementItem.Id
                                                        AND MIFloat_AmountReceipt.DescId = zc_MIFloat_AmountReceipt()
                             /*LEFT JOIN MovementItemBoolean AS MIBoolean_WeightMain
                                                           ON MIBoolean_WeightMain.MovementItemId =  MovementItem.Id
                                                          AND MIBoolean_WeightMain.DescId = zc_MIBoolean_WeightMain()*/
                        WHERE MovementItem.ParentId = ioMovementItemId
                          AND MovementItem.DescId   = zc_MI_Child()
                          AND MovementItem.isErased = FALSE
                       )
      , tmpReceiptChild AS
                       (SELECT COALESCE (ObjectLink_ReceiptChild_Goods.ChildObjectId, 0)      AS GoodsId
                             , COALESCE (ObjectLink_ReceiptChild_GoodsKind.ChildObjectId, 0)  AS GoodsKindId
                             , ObjectFloat_Value.ValueData                                    AS AmountReceipt
                             , COALESCE (ObjectBoolean_TaxExit.ValueData, FALSE)              AS isTaxExit
                             , COALESCE (ObjectBoolean_WeightMain.ValueData, FALSE)           AS isWeightMain
                             , ObjectFloat_Value_master.ValueData                             AS Amount_master
                        FROM ObjectLink AS ObjectLink_ReceiptChild_Receipt
                             INNER JOIN ObjectFloat AS ObjectFloat_Value_master
                                                    ON ObjectFloat_Value_master.ObjectId = inReceiptId
                                                   AND ObjectFloat_Value_master.DescId = zc_ObjectFloat_Receipt_Value()
                                                   AND ObjectFloat_Value_master.ValueData <> 0
                             LEFT JOIN ObjectLink AS ObjectLink_ReceiptChild_Goods
                                                  ON ObjectLink_ReceiptChild_Goods.ObjectId = ObjectLink_ReceiptChild_Receipt.ObjectId
                                                 AND ObjectLink_ReceiptChild_Goods.DescId = zc_ObjectLink_ReceiptChild_Goods()
                             LEFT JOIN ObjectLink AS ObjectLink_ReceiptChild_GoodsKind
                                                  ON ObjectLink_ReceiptChild_GoodsKind.ObjectId = ObjectLink_ReceiptChild_Receipt.ObjectId
                                                 AND ObjectLink_ReceiptChild_GoodsKind.DescId = zc_ObjectLink_ReceiptChild_GoodsKind()
                             INNER JOIN ObjectFloat AS ObjectFloat_Value
                                                    ON ObjectFloat_Value.ObjectId = ObjectLink_ReceiptChild_Receipt.ObjectId
                                                   AND ObjectFloat_Value.DescId = zc_ObjectFloat_ReceiptChild_Value()
                                                   AND ObjectFloat_Value.ValueData <> 0
                             LEFT JOIN ObjectBoolean AS ObjectBoolean_WeightMain
                                                     ON ObjectBoolean_WeightMain.ObjectId = ObjectLink_ReceiptChild_Receipt.ObjectId
                                                    AND ObjectBoolean_WeightMain.DescId = zc_ObjectBoolean_ReceiptChild_WeightMain()
                             LEFT JOIN ObjectBoolean AS ObjectBoolean_TaxExit
                                                     ON ObjectBoolean_TaxExit.ObjectId = ObjectLink_ReceiptChild_Receipt.ObjectId
                                                    AND ObjectBoolean_TaxExit.DescId = zc_ObjectBoolean_ReceiptChild_TaxExit()
                        WHERE ObjectLink_ReceiptChild_Receipt.ChildObjectId = inReceiptId
                          AND ObjectLink_ReceiptChild_Receipt.DescId = zc_ObjectLink_ReceiptChild_Receipt()
                       )
      , tmpReceipt_old AS
                       (SELECT MILO_Receipt.ObjectId AS ReceiptId
                        FROM MovementItemLinkObject AS MILO_Receipt
                        WHERE MILO_Receipt.MovementItemId = ioMovementItemId
                          AND MILO_Receipt.DescId = zc_MILinkObject_Receipt()
                          AND MILO_Receipt.ObjectId <> inReceiptId
                       )
      , tmpReceiptChild_old AS
                       (SELECT COALESCE (ObjectLink_ReceiptChild_Goods.ChildObjectId, 0)      AS GoodsId
                             , COALESCE (ObjectLink_ReceiptChild_GoodsKind.ChildObjectId, 0)  AS GoodsKindId
                        FROM tmpReceipt_old
                             INNER JOIN ObjectLink AS ObjectLink_ReceiptChild_Receipt
                                                   ON ObjectLink_ReceiptChild_Receipt.ChildObjectId = tmpReceipt_old.ReceiptId
                                                  AND ObjectLink_ReceiptChild_Receipt.DescId = zc_ObjectLink_ReceiptChild_Receipt()
                             LEFT JOIN ObjectLink AS ObjectLink_ReceiptChild_Goods
                                                  ON ObjectLink_ReceiptChild_Goods.ObjectId = ObjectLink_ReceiptChild_Receipt.ObjectId
                                                 AND ObjectLink_ReceiptChild_Goods.DescId = zc_ObjectLink_ReceiptChild_Goods()
                             LEFT JOIN ObjectLink AS ObjectLink_ReceiptChild_GoodsKind
                                                  ON ObjectLink_ReceiptChild_GoodsKind.ObjectId = ObjectLink_ReceiptChild_Receipt.ObjectId
                                                 AND ObjectLink_ReceiptChild_GoodsKind.DescId = zc_ObjectLink_ReceiptChild_GoodsKind()
                             INNER JOIN ObjectFloat AS ObjectFloat_Value
                                                    ON ObjectFloat_Value.ObjectId = ObjectLink_ReceiptChild_Receipt.ObjectId
                                                   AND ObjectFloat_Value.DescId = zc_ObjectFloat_ReceiptChild_Value()
                                                   AND ObjectFloat_Value.ValueData <> 0
                       )
        , tmpResult AS (SELECT COALESCE (tmpMI_Child.MovementItemId, 0)                            AS MovementItemId
                             , COALESCE (tmpMI_Child.GoodsId, tmpReceiptChild.GoodsId)             AS GoodsId
                             , COALESCE (tmpMI_Child.GoodsKindId, tmpReceiptChild.GoodsKindId)     AS GoodsKindId
                             , CASE WHEN tmpReceiptChild_old.GoodsId > 0 AND tmpReceiptChild.GoodsId IS NULL -- ���� �������� ��������� � ������ �� ����.��������� ��� � ����� ���������, ����� ����� �������� (!!!�� �������� �� ������!!!)
                                         THEN tmpMI_Child.Amount
                                    WHEN tmpReceipt_old.ReceiptId > 0 -- ���� �������� ��������� - ��� ���-�� �� �����
                                      OR tmpMI_Child.MovementItemId IS NULL -- ��� ����� �������
                                         THEN COALESCE (inCuterCount, 0) * COALESCE (tmpReceiptChild.AmountReceipt, 0)
                                    WHEN COALESCE (tmpMI_Child.AmountReceipt, -1) = 0  -- ���� <���������� �� ��������� �� 1 �����> � ���. ���� ������� = 0, ����� ��������� ���� �� Amount
                                         THEN tmpMI_Child.Amount
                                    ELSE COALESCE (inCuterCount, 0) * COALESCE (tmpMI_Child.AmountReceipt, 0) -- ����� �������� �� <���������� �� ��������� �� 1 �����> � ���.
                               END AS Amount

                             , CASE WHEN tmpReceiptChild_old.GoodsId > 0 AND tmpReceiptChild.GoodsId IS NULL -- ���� �������� ��������� � ������ �� ����.��������� ��� � ����� ���������, ����� ����� �������� (!!!�� �������� �� ������!!!)
                                         THEN tmpMI_Child.AmountReceipt
                                    WHEN tmpReceipt_old.ReceiptId > 0 -- ���� �������� ��������� - ��� ���-�� �� �����
                                      OR tmpMI_Child.MovementItemId IS NULL -- ��� ����� �������
                                         THEN COALESCE (tmpReceiptChild.AmountReceipt, 0)
                                    ELSE COALESCE (tmpMI_Child.AmountReceipt, 0) -- ����� ��������� ��� ��������� <���������� �� ��������� �� 1 �����> � ���.
                               END AS AmountReceipt

                             , COALESCE (tmpReceiptChild.isWeightMain, FALSE)                      AS isWeightMain
                             , COALESCE (tmpReceiptChild.isTaxExit, FALSE)                         AS isTaxExit
                             , CASE WHEN tmpReceiptChild_old.GoodsId > 0 AND tmpReceiptChild.GoodsId IS NULL THEN TRUE ELSE FALSE END AS isErased -- ���� �������� ��������� � ������ �� ����.��������� ��� � ����� ���������, ����� ����� ��������
                             , tmpReceiptChild.AmountReceipt AS AmountReceipt_calc
                             , tmpReceiptChild.Amount_master AS Amount_master_calc
                        FROM tmpMI_Child
                             LEFT JOIN tmpReceipt_old ON tmpReceipt_old.ReceiptId > 0
                             LEFT JOIN tmpReceiptChild_old ON tmpReceiptChild_old.GoodsId     = tmpMI_Child.GoodsId
                                                          AND tmpReceiptChild_old.GoodsKindId = tmpMI_Child.GoodsKindId
                             FULL JOIN tmpReceiptChild ON tmpReceiptChild.GoodsId     = tmpMI_Child.GoodsId
                                                      AND tmpReceiptChild.GoodsKindId = tmpMI_Child.GoodsKindId
                       )
        , tmpIsTaxExit AS (SELECT SUM (tmpResult.Amount * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN COALESCE (ObjectFloat_Weight.ValueData, 0) ELSE 1 END) AS Amount
                           FROM tmpResult
                                LEFT JOIN ObjectLink AS ObjectLink_Goods_Measure
                                                     ON ObjectLink_Goods_Measure.ObjectId = tmpResult.GoodsId
                                                    AND ObjectLink_Goods_Measure.DescId = zc_ObjectLink_Goods_Measure()
                                LEFT JOIN ObjectFloat AS ObjectFloat_Weight
                                                      ON ObjectFloat_Weight.ObjectId = tmpResult.GoodsId
                                                     AND ObjectFloat_Weight.DescId = zc_ObjectFloat_Goods_Weight()
                           WHERE tmpResult.isTaxExit = FALSE
                             AND tmpResult.isErased = FALSE
                          )
              
   -- ������������ ������ �� ��������� Child
   INSERT INTO _tmpChild (MovementItemId, GoodsId, GoodsKindId, Amount, AmountReceipt, Amount_master, isWeightMain, isTaxExit, isErased)
      SELECT tmpResult.MovementItemId
           , tmpResult.GoodsId
           , tmpResult.GoodsKindId
           , CASE WHEN tmpResult.isTaxExit = TRUE AND tmpResult.Amount_master_calc > 0
                       THEN tmpIsTaxExit.Amount * tmpResult.AmountReceipt_calc / tmpResult.Amount_master_calc
                  WHEN tmpResult.isTaxExit = TRUE
                       THEN 0
                  ELSE tmpResult.Amount
             END AS Amount

           , CASE WHEN tmpResult.isTaxExit = TRUE AND tmpResult.Amount_master_calc > 0
                       THEN tmpResult.AmountReceipt_calc
                  ELSE tmpResult.AmountReceipt
             END AS AmountReceipt

           , tmpIsTaxExit.Amount AS Amount_master

           , tmpResult.isWeightMain
           , tmpResult.isTaxExit
           , tmpResult.isErased
      FROM tmpResult
           LEFT JOIN tmpIsTaxExit ON 1 = 1
     ;


   -- ������� <����������� ������� ���������>
   PERFORM lpSetErased_MovementItem (_tmpChild.MovementItemId, vbUserId)
         , lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_Update(), _tmpChild.MovementItemId, vbUserId)
         , lpInsertUpdate_MovementItemDate (zc_MIDate_Update(), _tmpChild.MovementItemId, CURRENT_TIMESTAMP)
   FROM _tmpChild WHERE _tmpChild.isErased = TRUE;


   -- ������ ���-��
   vbAmount = (SELECT Amount_master FROM _tmpChild LIMIT 1);

   -- ��������� <������� ������� ���������>
   ioMovementItemId:= lpInsertUpdate_MI_ProductionUnionTech_Master (ioId                 := ioMovementItemId
                                                                  , inMovementId         := ioMovementId
                                                                  , inGoodsId            := inGoodsId
                                                                  , inAmount             := COALESCE (vbAmount, 0)
                                                                  , inCount              := inCount
                                                                  , inRealWeight         := inRealWeight
                                                                  , inCuterCount         := inCuterCount
                                                                  , inComment            := inComment
                                                                  , inGoodsKindId        := inGoodsKindId
                                                                  , inGoodsKindCompleteId:= inGoodsKindCompleteId
                                                                  , inReceiptId          := inReceiptId
                                                                  , inUserId             := vbUserId
                                                                   );

   -- ��������� <����������� ������� ���������>
   UPDATE _tmpChild SET MovementItemId = lpInsertUpdate_MI_ProductionUnionTech_Child (ioId                 := _tmpChild.MovementItemId
                                                                                    , inMovementId         := ioMovementId
                                                                                    , inGoodsId            := _tmpChild.GoodsId
                                                                                    , inAmount             := _tmpChild.Amount
                                                                                    , inParentId           := ioMovementItemId
                                                                                    , inAmountReceipt      := _tmpChild.AmountReceipt
                                                                                    , inPartionGoodsDate   := CASE WHEN _tmpChild.MovementItemId > 0 THEN (SELECT MovementItemDate.ValueData FROM MovementItemDate WHERE MovementItemDate.MovementItemId = _tmpChild.MovementItemId AND MovementItemDate.DescId = zc_MIDate_PartionGoods()) ELSE NULL END
                                                                                    , inComment            := CASE WHEN _tmpChild.MovementItemId > 0 THEN (SELECT MovementItemString.ValueData FROM MovementItemString WHERE MovementItemString.MovementItemId = _tmpChild.MovementItemId AND MovementItemString.DescId = zc_MIString_Comment()) ELSE NULL END
                                                                                    , inGoodsKindId        := _tmpChild.GoodsKindId
                                                                                    , inUserId             := vbUserId
                                                                                     )
   WHERE _tmpChild.isErased = FALSE;


   -- ��������� ��-�� �� ��������� <������ � ����� ��� �����> + <������� �� % ������>
   PERFORM lpInsertUpdate_MovementItemBoolean (zc_MIBoolean_WeightMain(), _tmpChild.MovementItemId, _tmpChild.isWeightMain)
         , lpInsertUpdate_MovementItemBoolean (zc_MIBoolean_TaxExit(), _tmpChild.MovementItemId, _tmpChild.isTaxExit)
   FROM _tmpChild
   WHERE _tmpChild.isErased = FALSE;


   -- !!!��������� ��-�� <���������> � ������!!!
   IF inMovementItemId_order <> 0
   THEN
       PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_Receipt(), inMovementItemId_order, inReceiptId);
   END IF;


   -- ��������� ��������� ������� - ��� ������������ ������ ��� ��������
   PERFORM lpComplete_Movement_ProductionUnion_CreateTemp();
   -- �������� ��������
   PERFORM lpComplete_Movement_ProductionUnion (inMovementId    := ioMovementId
                                              , inIsHistoryCost := TRUE
                                              , inUserId        := vbUserId);

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 21.03.15                                        *all
 19.12.14                                                       * add zc_MILinkObject_GoodsKindComplete
 12.12.14                                                       *
*/

-- ����
-- SELECT * FROM gpInsertUpdate_MI_ProductionUnionTech (ioId:= 0, ioMovementId:= 10, inGoodsId:= 1, inAmount:= 0, inPartionClose:= FALSE, inComment:= '', inCount:= 1, inRealWeight:= 1, inCuterCount:= 0, inReceiptId:= 0, inSession:= '2')
