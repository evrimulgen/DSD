-- Function: gpInsertUpdate_MovementItem_Inventory_Amount (Integer, Integer, TVarChar)

DROP FUNCTION IF EXISTS gpInsertUpdate_MovementItem_Inventory_Amount (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_MovementItem_Inventory_Amount(
    IN inMovementId          Integer   , -- ���� ������� <��������>
    IN inSession             TVarChar    -- ������ ������������
)
RETURNS VOID
AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbUnitId Integer;
   DECLARE vbInventoryDate TDateTime;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     vbUserId := lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_MI_Inventory());

    SELECT MovementLinkObject_Unit.ObjectId, OperDate INTO vbUnitID,vbInventoryDate
    FROM Movement
        INNER JOIN MovementLinkObject AS MovementLinkObject_Unit
                                      ON MovementLinkObject_Unit.MovementId = Movement.Id
                                     AND MovementLinkObject_Unit.DescId = zc_MovementLinkObject_Unit()
    WHERE Movement.Id = inMovementId;
     -- ���������
     PERFORM lpInsertUpdate_MovementItem_Inventory (ioId                 := COALESCE (tmp.MovementItemId, 0)
                                                  , inMovementId         := inMovementId
                                                  , inGoodsId            := tmp.GoodsId
                                                  , inAmount             := COALESCE(tmp.Amount_End,0)
                                                  , inPrice              := COALESCE(tmp.Price,0)
                                                  , inSumm               := COALESCE(tmp.Amount_End,0)*COALESCE(tmp.Price,0)::TFloat
                                                  , inUserId             := vbUserId
                                                   )
     FROM (SELECT tmpMI.MovementItemId                                   AS MovementItemId
                , COALESCE (tmpContainer.GoodsId, tmpMI.GoodsId)         AS GoodsId
                , COALESCE (tmpContainer.Amount_End,0)                   AS Amount_End
                , COALESCE (Object_Price.Price,0)                        AS Price
           FROM (SELECT tmpContainer.GoodsId
                      , SUM (tmpContainer.Amount_End)        AS Amount_End
                 FROM
                    (SELECT Container.Id                                                AS ContainerId
                          , Container.ObjectId                                          AS GoodsId
                          , Container.Amount  - COALESCE (SUM (MIContainer.Amount), 0)  AS Amount_End
                     FROM Container
                          INNER JOIN ContainerLinkObject AS CLO_Unit
                                                         ON CLO_Unit.ObjectId = vbUnitId
                                                        AND CLO_Unit.ContainerId = Container.Id
                                                        AND CLO_Unit.DescId = zc_ContainerLinkObject_Unit()
                          LEFT JOIN MovementItemContainer AS MIContainer
                                                          ON MIContainer.ContainerId = Container.Id
                                                         AND MIContainer.OperDate > vbInventoryDate -- �.�. ������� �� ���� + 1
                     WHERE Container.DescId = zc_Container_Count()
                     GROUP BY Container.Id
                            , Container.ObjectId
                            , Container.Amount
                     HAVING (Container.Amount - COALESCE (SUM (MIContainer.Amount), 0)) <> 0
                    ) tmpContainer
                 GROUP BY tmpContainer.GoodsId
                 HAVING SUM (tmpContainer.Amount_End) <> 0
                ) tmpContainer
                                             
                FULL JOIN (SELECT MovementItem.Id                               AS MovementItemId
                                , MovementItem.ObjectId                         AS GoodsId
                           FROM MovementItem
                           WHERE MovementItem.MovementId =  inMovementId
                             AND MovementItem.isErased = FALSE
                          ) AS tmpMI ON tmpMI.GoodsId = tmpContainer.GoodsId
                LEFT OUTER JOIN Object_Price_View AS Object_Price 
                                                  ON COALESCE(tmpMI.GoodsId,tmpContainer.GoodsId) = Object_Price.GoodsId 
                                                 AND Object_Price.UnitId = vbUnitId
                                                              
           ) AS tmp;
     -- ����������� �������� ����� �� ���������
     PERFORM lpInsertUpdate_MovementFloat_TotalSummInventory (inMovementId);

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 26.04.15                                        * all
 24.04.15          *
*/

-- ����
-- SELECT * FROM gpInsertUpdate_MovementItem_Inventory_Amount