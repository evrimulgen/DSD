-- Function: lpComplete_Movement_ProductionUnion_Partion (Integer, Integer, Integer)

DROP FUNCTION IF EXISTS lpComplete_Movement_ProductionUnion_Partion (Integer, Integer, Integer);

CREATE OR REPLACE FUNCTION lpComplete_Movement_ProductionUnion_Partion(
    IN inMovementId        Integer  , -- ���� ���������
    IN inFromId            Integer  , -- 
    IN inUserId            Integer    -- ������������
)                              
RETURNS VOID
AS
$BODY$
BEGIN
     -- �������
     DELETE FROM _tmpItem_Partion;
     -- �������
     DELETE FROM _tmpItem_Partion_child;


        -- ������ �� ��������� ������� � ������������
        WITH tmpMI_master AS (-- ����� ������ �� ��-�� MovementItemDate
                              SELECT _tmpItem.MovementItemId
                                   , _tmpItem.GoodsId
                                   , _tmpItem.GoodsKindId
                                   , _tmpItem.OperCount
                                   , MIDate_PartionGoods.ValueData AS PartionGoodsDate
                                   , COALESCE (MIFloat_Count.ValueData, 0) AS Count_onCount
                              FROM _tmpItem
                                   INNER JOIN MovementItemDate AS MIDate_PartionGoods
                                                               ON MIDate_PartionGoods.MovementItemId = _tmpItem.MovementItemId
                                                              AND MIDate_PartionGoods.DescId = zc_MIDate_PartionGoods()
                                                              AND MIDate_PartionGoods.ValueData > zc_DateStart()
                                   LEFT JOIN MovementItemFloat AS MIFloat_Count
                                                               ON MIFloat_Count.MovementItemId = _tmpItem.MovementItemId
                                                              AND MIFloat_Count.DescId = zc_MIFloat_Count()
                                   LEFT JOIN MovementItemBoolean AS MIBoolean_PartionClose ON MIBoolean_PartionClose.MovementItemId = _tmpItem.MovementItemId
                                                                                          AND MIBoolean_PartionClose.DescId         = zc_MIBoolean_PartionClose()
                                                                                          AND MIBoolean_PartionClose.ValueData      = TRUE
                              WHERE MIBoolean_PartionClose.MovementItemId IS NULL -- !!!�.�. ������ ������� � �������� ������� (� ������� ���� �� ������ ���������� ���� ������� ���������)!!!
                             )
            , tmpReceipt AS (-- ����� ��������
                             SELECT tmpGoods.GoodsId
                                  , tmpGoods.GoodsKindId
                                  , MAX (ObjectLink_Receipt_Goods.ObjectId) AS ReceiptId
                             FROM (SELECT tmpMI_master.GoodsId, tmpMI_master.GoodsKindId FROM tmpMI_master GROUP BY tmpMI_master.GoodsId, tmpMI_master.GoodsKindId) AS tmpGoods
                                  INNER JOIN ObjectLink AS ObjectLink_Receipt_Goods
                                                        ON ObjectLink_Receipt_Goods.ChildObjectId = tmpGoods.GoodsId
                                                       AND ObjectLink_Receipt_Goods.DescId = zc_ObjectLink_Receipt_Goods()
                                  INNER JOIN ObjectLink AS ObjectLink_Receipt_GoodsKind
                                                        ON ObjectLink_Receipt_GoodsKind.ObjectId = ObjectLink_Receipt_Goods.ObjectId
                                                       AND ObjectLink_Receipt_GoodsKind.DescId = zc_ObjectLink_Receipt_GoodsKind()
                                                       AND ObjectLink_Receipt_GoodsKind.ChildObjectId = tmpGoods.GoodsKindId
                                  INNER JOIN Object AS Object_Receipt ON Object_Receipt.Id = ObjectLink_Receipt_Goods.ObjectId
                                                                     AND Object_Receipt.isErased = FALSE
                                  INNER JOIN ObjectBoolean AS ObjectBoolean_Main
                                                           ON ObjectBoolean_Main.ObjectId = Object_Receipt.Id
                                                          AND ObjectBoolean_Main.DescId = zc_ObjectBoolean_Receipt_Main()
                                                          AND ObjectBoolean_Main.ValueData = TRUE
                             GROUP BY tmpGoods.GoodsId
                                    , tmpGoods.GoodsKindId
                            )
                , tmpPartion AS (-- ����� ������ - ��������� � ��������
                                 SELECT tmpMI_master.GoodsId
                                      , tmpMI_master.GoodsKindId
                                      , MAX (ObjectDate_PartionGoods_Value.ObjectId) AS PartionGoodsId -- ������ ����� ��� � ��������� ������� �� ���, ���� ��� - ��� �������� ����� �� ��������������
                                 FROM tmpMI_master
                                      INNER JOIN ObjectDate AS ObjectDate_PartionGoods_Value ON ObjectDate_PartionGoods_Value.ValueData = tmpMI_master.PartionGoodsDate
                                                                                            AND ObjectDate_PartionGoods_Value.DescId = zc_ObjectDate_PartionGoods_Value()
                                      LEFT JOIN ObjectLink AS ObjectLink_PartionGoods_Unit
                                                           ON ObjectLink_PartionGoods_Unit.ObjectId = ObjectDate_PartionGoods_Value.ObjectId
                                                          AND ObjectLink_PartionGoods_Unit.DescId = zc_ObjectLink_PartionGoods_Unit()
                                 WHERE ObjectLink_PartionGoods_Unit.ObjectId IS NULL -- �.�. ������ ��� ����� ��-��
                                 GROUP BY tmpMI_master.GoodsId
                                        , tmpMI_master.GoodsKindId
                                )
     , tmpReceipt_parent AS (-- ����� �� ���� �������� ����� + � ������� ������ ������
                             SELECT tmpPartion.PartionGoodsId
                                  , tmpPartion.GoodsId
                                  , tmpPartion.GoodsKindId
                                  , tmpReceipt.ReceiptId
                                  , ObjectLink_Receipt_Goods_parent.ChildObjectId     AS GoodsId_parent
                                  , ObjectLink_Receipt_GoodsKind_parent.ChildObjectId AS GoodsKindId_parent
                             FROM tmpPartion
                                  INNER JOIN tmpReceipt ON tmpReceipt.GoodsId     = tmpPartion.GoodsId
                                                       AND tmpReceipt.GoodsKindId = tmpPartion.GoodsKindId
                                  INNER JOIN ObjectLink AS ObjectLink_Receipt_Parent
                                                        ON ObjectLink_Receipt_Parent.ObjectId = tmpReceipt.ReceiptId
                                                       AND ObjectLink_Receipt_Parent.DescId   = zc_ObjectLink_Receipt_Parent()
                                  INNER JOIN Object AS Object_Receipt_parent ON Object_Receipt_parent.Id       = ObjectLink_Receipt_Parent.ChildObjectId
                                                                            AND Object_Receipt_parent.isErased = FALSE
                                  INNER JOIN ObjectLink AS ObjectLink_Receipt_Goods_parent
                                                        ON ObjectLink_Receipt_Goods_parent.ChildObjectId = ObjectLink_Receipt_Parent.ChildObjectId
                                                       AND ObjectLink_Receipt_Goods_parent.DescId        = zc_ObjectLink_Receipt_Goods()
                                  LEFT JOIN ObjectLink AS ObjectLink_Receipt_GoodsKind_parent
                                                       ON ObjectLink_Receipt_GoodsKind_parent.ChildObjectId = ObjectLink_Receipt_Parent.ChildObjectId
                                                      AND ObjectLink_Receipt_GoodsKind_parent.DescId        = zc_ObjectLink_Receipt_GoodsKind()
                            )
       , tmpPartionClose AS (-- ����� ��-��, � ������������ ������� �� �� ��� ������
                             SELECT tmp.PartionGoodsId, tmp.GoodsId_parent, tmp.GoodsKindId_parent
                                  , MAX (CASE WHEN COALESCE (MIBoolean_PartionClose.ValueData, FALSE) = TRUE THEN 0 ELSE 1 END) AS isPartionClose
                             FROM (SELECT tmpReceipt_parent.PartionGoodsId, tmpReceipt_parent.GoodsId_parent, tmpReceipt_parent.GoodsKindId_parent
                                   FROM tmpReceipt_parent
                                   GROUP BY tmpReceipt_parent.PartionGoodsId, tmpReceipt_parent.GoodsId_parent, tmpReceipt_parent.GoodsKindId_parent
                                  ) AS tmp
                                  INNER JOIN ContainerLinkObject AS CLO_PartionGoods
                                                                 ON CLO_PartionGoods.ObjectId = tmp.PartionGoodsId
                                                                AND CLO_PartionGoods.DescId = zc_ContainerLinkObject_PartionGoods()
                                  INNER JOIN ContainerLinkObject AS CLO_Goods
                                                                 ON CLO_Goods.ContainerId = CLO_PartionGoods.ContainerId
                                                                AND CLO_Goods.ObjectId = tmp.GoodsId_parent
                                                                AND CLO_Goods.DescId = zc_ContainerLinkObject_Goods()
                                  INNER JOIN ContainerLinkObject AS CLO_GoodsKind
                                                                 ON CLO_GoodsKind.ContainerId = CLO_PartionGoods.ContainerId
                                                                AND CLO_GoodsKind.ObjectId = tmp.GoodsKindId_parent
                                                                AND CLO_GoodsKind.DescId = zc_ContainerLinkObject_GoodsKind()
                                  INNER JOIN ContainerLinkObject AS CLO_Unit
                                                                 ON CLO_Unit.ContainerId = CLO_PartionGoods.ContainerId
                                                                AND CLO_Unit.ObjectId = inFromId
                                                                AND CLO_Unit.DescId = zc_ContainerLinkObject_Unit()
                                  INNER JOIN Container ON Container.Id = CLO_PartionGoods.ContainerId
                                                      AND Container.DescId = zc_Container_Count()
                                  INNER JOIN MovementItemContainer AS MIContainer ON MIContainer.ContainerId = Container.Id
                                                                                 AND MIContainer.MovementDescId = zc_Movement_ProductionUnion()
                                                                                 AND MIContainer.isActive = TRUE
                                  LEFT JOIN MovementItemBoolean AS MIBoolean_PartionClose ON MIBoolean_PartionClose.MovementItemId = MIContainer.MovementItemId
                                                                                         AND MIBoolean_PartionClose.DescId = zc_MIBoolean_PartionClose()
                             GROUP BY tmp.PartionGoodsId, tmp.GoodsId_parent, tmp.GoodsKindId_parent
                            )
     -- ���������: ������ �� ������ � ������� ������ �� ������� + ���� ReceiptId (�� ���� � ����� ������������� ������ �� ��-��)
     INSERT INTO _tmpItem_Partion (MovementItemId, GoodsId, GoodsKindId, ReceiptId, PartionGoodsDate, OperCount, Count_onCount)
        SELECT tmpMI_master.MovementItemId
             , tmpMI_master.GoodsId
             , tmpMI_master.GoodsKindId
             , tmpReceipt.ReceiptId
             , tmpMI_master.PartionGoodsDate
             , tmpMI_master.OperCount
             , tmpMI_master.Count_onCount
        FROM tmpMI_master
             LEFT JOIN tmpReceipt ON tmpReceipt.GoodsId     = tmpMI_master.GoodsId
                                 AND tmpReceipt.GoodsKindId = tmpMI_master.GoodsKindId
             LEFT JOIN tmpPartion ON tmpPartion.GoodsId     = tmpMI_master.GoodsId
                                 AND tmpPartion.GoodsKindId = tmpMI_master.GoodsKindId
             LEFT JOIN tmpReceipt_parent ON tmpReceipt_parent.PartionGoodsId = tmpPartion.PartionGoodsId
                                        AND tmpReceipt_parent.GoodsId        = tmpPartion.GoodsId
                                        AND tmpReceipt_parent.GoodsKindId    = tmpPartion.GoodsKindId
             LEFT JOIN tmpPartionClose ON tmpPartionClose.PartionGoodsId     = tmpReceipt_parent.PartionGoodsId
                                      AND tmpPartionClose.GoodsId_parent     = tmpReceipt_parent.GoodsId_parent
                                      AND tmpPartionClose.GoodsKindId_parent = tmpReceipt_parent.GoodsKindId_parent
        -- !!!�������� �������!!!
        -- WHERE COALESCE (tmpPartionClose.isPartionClose, 1) = 1
       ;


     -- !!!!!!!!!!!!!!!!!!!!!!!
     ANALYZE _tmpItem_Partion;


     -- ������ �� ��������� ������ �� ������������
     WITH tmpMI_calc AS (-- ������ ������� �� ���������
                         SELECT _tmpItem_Partion.MovementItemId                                                          AS MovementItemId_parent
                              , _tmpItem_Partion.PartionGoodsDate                                                        AS PartionGoodsDate
                              , COALESCE (ObjectLink_ReceiptChild_Goods.ChildObjectId, _tmpItem_Partion.GoodsId)         AS GoodsId
                              , COALESCE (ObjectLink_ReceiptChild_GoodsKind.ChildObjectId, CASE WHEN ObjectLink_ReceiptChild_Goods.ChildObjectId > 0 THEN 0 ELSE _tmpItem_Partion.GoodsKindId END) AS GoodsKindId
                              , SUM (CASE WHEN ObjectFloat_Value_master.ValueData <> 0 THEN _tmpItem_Partion.OperCount * COALESCE (ObjectFloat_Value.ValueData, 0) / ObjectFloat_Value_master.ValueData ELSE _tmpItem_Partion.OperCount END) AS OperCount
                         FROM _tmpItem_Partion
                              LEFT JOIN ObjectFloat AS ObjectFloat_Value_master
                                                    ON ObjectFloat_Value_master.ObjectId = _tmpItem_Partion.ReceiptId
                                                   AND ObjectFloat_Value_master.DescId = zc_ObjectFloat_Receipt_Value()
                                                   AND ObjectFloat_Value_master.ValueData <> 0
                              LEFT JOIN ObjectLink AS ObjectLink_ReceiptChild_Receipt
                                                   ON ObjectLink_ReceiptChild_Receipt.ChildObjectId = _tmpItem_Partion.ReceiptId
                                                  AND ObjectLink_ReceiptChild_Receipt.DescId = zc_ObjectLink_ReceiptChild_Receipt()
                              LEFT JOIN Object AS Object_ReceiptChild ON Object_ReceiptChild.Id = ObjectLink_ReceiptChild_Receipt.ObjectId
                                                                     AND Object_ReceiptChild.isErased = FALSE
                              LEFT JOIN ObjectLink AS ObjectLink_ReceiptChild_Goods
                                                   ON ObjectLink_ReceiptChild_Goods.ObjectId = Object_ReceiptChild.Id
                                                  AND ObjectLink_ReceiptChild_Goods.DescId = zc_ObjectLink_ReceiptChild_Goods()
                              LEFT JOIN ObjectLink AS ObjectLink_ReceiptChild_GoodsKind
                                                   ON ObjectLink_ReceiptChild_GoodsKind.ObjectId = Object_ReceiptChild.Id
                                                  AND ObjectLink_ReceiptChild_GoodsKind.DescId = zc_ObjectLink_ReceiptChild_GoodsKind()
                              LEFT JOIN ObjectFloat AS ObjectFloat_Value
                                                    ON ObjectFloat_Value.ObjectId = Object_ReceiptChild.Id
                                                   AND ObjectFloat_Value.DescId = zc_ObjectFloat_ReceiptChild_Value()
                         GROUP BY _tmpItem_Partion.MovementItemId
                                , _tmpItem_Partion.PartionGoodsDate
                                , COALESCE (ObjectLink_ReceiptChild_Goods.ChildObjectId, _tmpItem_Partion.GoodsId)
                                , COALESCE (ObjectLink_ReceiptChild_GoodsKind.ChildObjectId, CASE WHEN ObjectLink_ReceiptChild_Goods.ChildObjectId > 0 THEN 0 ELSE _tmpItem_Partion.GoodsKindId END)
                         HAVING SUM (CASE WHEN ObjectFloat_Value_master.ValueData <> 0 THEN _tmpItem_Partion.OperCount * COALESCE (ObjectFloat_Value.ValueData, 0) / ObjectFloat_Value_master.ValueData ELSE _tmpItem_Partion.OperCount END) <> 0
                        )
       , tmpMI_child AS (-- ������ ������������ ��������� ������� �� ������������ (�� ���� ��������)
                         SELECT MovementItem.ParentId                         AS MovementItemId_parent
                              , MovementItem.Id                               AS MovementItemId
                              , MovementItem.ObjectId                         AS GoodsId
                              , COALESCE (MILinkObject_GoodsKind.ObjectId, 0) AS GoodsKindId
                         FROM _tmpItem_Partion
                              INNER JOIN MovementItem ON MovementItem.MovementId = inMovementId
                                                     AND MovementItem.DescId     = zc_MI_Child()
                                                     AND MovementItem.isErased   = FALSE
                                                     AND MovementItem.ParentId   = _tmpItem_Partion.MovementItemId
                              INNER JOIN MovementItemBoolean AS MIBoolean_isAuto
                                                             ON MIBoolean_isAuto.MovementItemId = MovementItem.Id
                                                            AND MIBoolean_isAuto.DescId     = zc_MIBoolean_isAuto()
                                                            AND MIBoolean_isAuto.ValueData = TRUE -- !!! ������ ���� ����������� ������������� zc_Enum_Process_Auto_PartionDate!!!
                              LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                                               ON MILinkObject_GoodsKind.MovementItemId = MovementItem.Id
                                                              AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
                        )
        , tmpMI_find AS (-- �� ������������ ��������� ���� ����� �� ��� ����� �������, ��������� ���� �������
                         SELECT tmpMI_calc.MovementItemId_parent
                              , tmpMI_calc.GoodsId
                              , tmpMI_calc.GoodsKindId
                              , MAX (tmpMI_child.MovementItemId) AS MovementItemId
                         FROM tmpMI_calc
                              LEFT JOIN tmpMI_child ON tmpMI_child.MovementItemId_parent = tmpMI_calc.MovementItemId_parent
                                                   AND tmpMI_child.GoodsId               = tmpMI_calc.GoodsId
                                                   AND tmpMI_child.GoodsKindId           = tmpMI_calc.GoodsKindId
                         GROUP BY tmpMI_calc.MovementItemId_parent
                                , tmpMI_calc.GoodsId
                                , tmpMI_calc.GoodsKindId
                        )

     -- ���������: ������ �� ������������
     INSERT INTO _tmpItem_Partion_child (MovementItemId, MovementItemId_parent, GoodsId, GoodsKindId, PartionGoodsDate, OperCount)
        SELECT tmpMI_child.MovementItemId
             , tmpMI_calc.MovementItemId_parent
             , tmpMI_calc.GoodsId
             , tmpMI_calc.GoodsKindId
             , tmpMI_calc.PartionGoodsDate
             , COALESCE (tmpMI_calc.OperCount, 0)
        FROM tmpMI_calc
             LEFT JOIN tmpMI_find ON tmpMI_find.MovementItemId_parent = tmpMI_calc.MovementItemId_parent
                                 AND tmpMI_find.GoodsId               = tmpMI_calc.GoodsId
                                 AND tmpMI_find.GoodsKindId           = tmpMI_calc.GoodsKindId
             FULL JOIN tmpMI_child ON tmpMI_child.MovementItemId = tmpMI_find.MovementItemId
       ;



     -- ��������� �������� - ������ �� ������������
     PERFORM lpSetErased_MovementItem (inMovementItemId:= _tmpItem_Partion_child.MovementItemId
                                     , inUserId        := zc_Enum_Process_Auto_PartionDate()
                                      )
     FROM _tmpItem_Partion_child
     WHERE _tmpItem_Partion_child.OperCount = 0 AND _tmpItem_Partion_child.MovementItemId <> 0
    ;

     -- ����������� �������� - ������ �� ������������
     PERFORM lpInsertUpdate_MI_ProductionUnion_Child (ioId                  := _tmpItem_Partion_child.MovementItemId
                                                    , inMovementId          := inMovementId
                                                    , inGoodsId             := _tmpItem_Partion_child.GoodsId
                                                    , inAmount              := _tmpItem_Partion_child.OperCount
                                                    , inParentId            := _tmpItem_Partion_child.MovementItemId_parent
                                                    , inPartionGoodsDate    := _tmpItem_Partion_child.PartionGoodsDate
                                                    , inPartionGoods        := NULL
                                                    , inGoodsKindId         := _tmpItem_Partion_child.GoodsKindId
                                                    , inCount_onCount       := _tmpItem_Partion.Count_onCount
                                                    , inUserId              := zc_Enum_Process_Auto_PartionDate()
                                                     )
     FROM _tmpItem_Partion_child
          LEFT JOIN _tmpItem_Partion ON _tmpItem_Partion.MovementItemId = _tmpItem_Partion_child.MovementItemId_parent
     WHERE _tmpItem_Partion_child.OperCount <> 0
    ;


END;$BODY$
  LANGUAGE plpgsql VOLATILE;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 05.07.15                                        *
*/

-- ����
-- SELECT * FROM lpComplete_Movement_ProductionUnion_Partion (inMovementId:= 1900460, inFromId:= 8448, inUserId:= zfCalc_UserAdmin() :: Integer) -- ��� �����������
-- SELECT * FROM lpComplete_Movement_ProductionUnion_Partion (inMovementId:= 1899237, inFromId:= 8447, inUserId:= zfCalc_UserAdmin() :: Integer) -- ��� ���������
