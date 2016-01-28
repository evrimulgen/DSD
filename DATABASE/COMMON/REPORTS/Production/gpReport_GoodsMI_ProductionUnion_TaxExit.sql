-- Function: gpReport_GoodsMI_ProductionUnion_TaxExit () - <������������ � ������� ������ (�����) or (��������)>

DROP FUNCTION IF EXISTS gpReport_GoodsMI_ProductionUnion_TaxExit (TDateTime, TDateTime, Integer, Integer, TVarChar);
DROP FUNCTION IF EXISTS gpReport_GoodsMI_ProductionUnion_TaxExit (TDateTime, TDateTime, Integer, Integer, Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpReport_GoodsMI_ProductionUnion_TaxExit (
    IN inStartDate    TDateTime ,  
    IN inEndDate      TDateTime ,
    IN inFromId       Integer   , 
    IN inToId         Integer   , 
    IN inIsDetail     Boolean   , -- 
    IN inSession      TVarChar    -- ������ ������������
)
RETURNS TABLE (GoodsGroupNameFull TVarChar
             , GoodsCode Integer, GoodsName TVarChar, GoodsKindName_Complete TVarChar, MeasureName TVarChar
             , PartionGoodsDate TDateTime
             , Amount_WorkProgress_in TFloat
             , CuterCount TFloat
             , RealWeight TFloat
             , Amount_GP_in_calc TFloat
             , Amount_GP_in TFloat
             , AmountReceipt_out TFloat
             , TaxExit TFloat
             , TaxExit_calc TFloat
             , TaxExit_real TFloat
             , TaxLoss TFloat
             , TaxLoss_calc TFloat
             , TaxLoss_real TFloat
             , Comment TVarChar
              )
AS
$BODY$
BEGIN

    -- ���������
    RETURN QUERY
         -- ������� �/� ��
    WITH tmpMI_WorkProgress_in AS
                     (SELECT MIContainer.MovementItemId              AS MovementItemId
                           , MIContainer.ContainerId                 AS ContainerId
                           , MIContainer.ObjectId_Analyzer           AS GoodsId
                           , COALESCE (CLO_PartionGoods.ObjectId, 0) AS PartionGoodsId
                           , CASE WHEN MIContainer.IsActive = TRUE THEN MIContainer.Amount ELSE 0 END AS Amount
                      FROM MovementItemContainer AS MIContainer
                           /*INNER JOIN ContainerLinkObject AS CLO_GoodsKind
                                                          ON CLO_GoodsKind.ContainerId = MIContainer.ContainerId
                                                         AND CLO_GoodsKind.DescId = zc_ContainerLinkObject_GoodsKind()
                                                         AND CLO_GoodsKind.ObjectId = zc_GoodsKind_WorkProgress() -- ����������� ��� ��� �/� ��*/
                           LEFT JOIN ContainerLinkObject AS CLO_PartionGoods
                                                         ON CLO_PartionGoods.ContainerId = MIContainer.ContainerId
                                                        AND CLO_PartionGoods.DescId = zc_ContainerLinkObject_PartionGoods()
                      WHERE MIContainer.OperDate BETWEEN inStartDate AND inEndDate
                        AND MIContainer.DescId = zc_MIContainer_Count()
                        AND MIContainer.WhereObjectId_Analyzer = inFromId
                        AND MIContainer.MovementDescId = zc_Movement_ProductionUnion()
                        AND MIContainer.IsActive = TRUE
                        AND MIContainer.Amount <> 0
                        AND MIContainer.ObjectIntId_Analyzer = zc_GoodsKind_WorkProgress() -- ����������� ��� ��� �/� ��
                      )
         -- ������� �/� �� - ��� � �������� ������ ������� ��� � tmpMI_WorkProgress_in
       , tmpMI_WorkProgress_find AS
                     (SELECT MIContainer.ContainerId                 AS ContainerId
                           , MIContainer.ObjectId_Analyzer           AS GoodsId
                           , COALESCE (CLO_PartionGoods.ObjectId, 0) AS PartionGoodsId
                           , COALESCE (MIContainer.ObjectIntId_Analyzer, 0) AS GoodsKindId_Complete
                      FROM ObjectDate AS ObjectDate_PartionGoods_Value
                           INNER JOIN ContainerLinkObject AS CLO_PartionGoods
                                                          ON CLO_PartionGoods.ObjectId = ObjectDate_PartionGoods_Value.ObjectId
                                                         AND CLO_PartionGoods.DescId = zc_ContainerLinkObject_PartionGoods()
                           INNER JOIN ContainerLinkObject AS CLO_Unit
                                                          ON CLO_Unit.ContainerId = CLO_PartionGoods.ContainerId
                                                         AND CLO_Unit.DescId = zc_ContainerLinkObject_Unit()
                                                         AND CLO_Unit.ObjectId = inFromId
                           INNER JOIN Container ON Container.Id = CLO_PartionGoods.ContainerId AND Container.DescId = zc_Container_Count()
                           LEFT JOIN tmpMI_WorkProgress_in ON tmpMI_WorkProgress_in.ContainerId = CLO_PartionGoods.ContainerId

                           INNER JOIN MovementItemContainer AS MIContainer
                                                            ON MIContainer.ContainerId = Container.Id
                                                           AND MIContainer.MovementDescId = zc_Movement_ProductionUnion()
                                                           AND MIContainer.IsActive = FALSE
                                                           AND MIContainer.Amount <> 0
                           LEFT JOIN MovementItem ON MovementItem.Id = MIContainer.MovementItemId
                           /*LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                                            ON MILinkObject_GoodsKind.MovementItemId = MovementItem.ParentId
                                                           AND MILinkObject_GoodsKind.DescId = zc_ContainerLinkObject_GoodsKind()*/
                      WHERE ObjectDate_PartionGoods_Value.DescId = zc_ObjectDate_PartionGoods_Value()
                        AND ObjectDate_PartionGoods_Value.ValueData BETWEEN inStartDate AND inEndDate
                        AND tmpMI_WorkProgress_in.ContainerId IS NULL
                      GROUP BY MIContainer.ContainerId
                             , MIContainer.ObjectId_Analyzer
                             , CLO_PartionGoods.ObjectId
                             , MIContainer.ObjectIntId_Analyzer
                     )
         -- ������� �/� �� - �������������
       , tmpMI_WorkProgress_in_group AS (SELECT ContainerId, GoodsId, PartionGoodsId FROM tmpMI_WorkProgress_in GROUP BY ContainerId, GoodsId, PartionGoodsId
                                   UNION SELECT ContainerId, GoodsId, PartionGoodsId FROM tmpMI_WorkProgress_find GROUP BY ContainerId, GoodsId, PartionGoodsId)
         -- ������� �/� �� � ������� ParentId
       , tmpMI_WorkProgress_out AS
                     (SELECT MIContainer.ParentId
                           , tmpMI_WorkProgress_in_group.ContainerId
                           -- , 0 AS ContainerId
                           , tmpMI_WorkProgress_in_group.GoodsId
                           , tmpMI_WorkProgress_in_group.PartionGoodsId
                           , SUM (MIContainer.Amount) AS Amount
                      FROM tmpMI_WorkProgress_in_group
                           INNER JOIN MovementItemContainer AS MIContainer
                                                            ON MIContainer.ContainerId = tmpMI_WorkProgress_in_group.ContainerId
                                                           AND MIContainer.MovementDescId = zc_Movement_ProductionUnion()
                                                           AND MIContainer.IsActive = FALSE
                     GROUP BY MIContainer.ParentId
                            , tmpMI_WorkProgress_in_group.ContainerId
                            , tmpMI_WorkProgress_in_group.GoodsId
                            , tmpMI_WorkProgress_in_group.PartionGoodsId
                     )
         -- ������������� �� ������ "������� ������� �����"
       , tmpUnit_oth AS (SELECT tmpSelect.UnitId FROM lfSelect_Object_Unit_byGroup (8439) AS tmpSelect)
         -- ������� �/� �� � ������� ParentId - ���� ��� ���� �� "�����������"
       , tmpMI_WorkProgress_oth AS
                     (SELECT tmpMI_WorkProgress_out.ContainerId
                           , -1 * SUM (tmpMI_WorkProgress_out.Amount) AS Amount
                      FROM tmpMI_WorkProgress_out
                           INNER JOIN MovementItemContainer AS MIContainer
                                                            ON MIContainer.Id = tmpMI_WorkProgress_out.ParentId
                           INNER JOIN tmpUnit_oth ON tmpUnit_oth.UnitId = MIContainer.WhereObjectId_Analyzer
                     GROUP BY tmpMI_WorkProgress_out.ContainerId
                     )
         -- ������� �� � ������� GoodsId (�/� ��) + GoodsKindId_Complete + !!!���� "������������ ��"!!!
       , tmpMI_GP_in AS
                     (SELECT tmpMI_WorkProgress_out.GoodsId
                           , tmpMI_WorkProgress_out.PartionGoodsId
                           , COALESCE (MIContainer.ObjectIntId_Analyzer, 0) AS GoodsKindId_Complete
                           , SUM (MIContainer.Amount)             AS Amount
                           , SUM (CASE WHEN ObjectFloat_Value_master.ValueData <> 0 THEN COALESCE (ObjectFloat_Value_child.ValueData, 0) * MIContainer.Amount / ObjectFloat_Value_master.ValueData ELSE 0 END) AS AmountReceipt
                      FROM tmpMI_WorkProgress_out
                           INNER JOIN MovementItemContainer AS MIContainer
                                                            ON MIContainer.Id = tmpMI_WorkProgress_out.ParentId
                                                           AND MIContainer.WhereObjectId_Analyzer <> inFromId -- !!!���� "������������ ��"!!!
                           /*LEFT JOIN ContainerLinkObject AS CLO_GoodsKind
                                                         ON CLO_GoodsKind.ContainerId = MIContainer.ContainerId
                                                        AND CLO_GoodsKind.DescId = zc_ContainerLinkObject_GoodsKind()*/
                           LEFT JOIN MovementItemLinkObject AS MILO_Receipt
                                                            ON MILO_Receipt.MovementItemId = MIContainer.MovementItemId
                                                           AND MILO_Receipt.DescId = zc_MILinkObject_Receipt()
                           LEFT JOIN ObjectFloat AS ObjectFloat_Value_master
                                                 ON ObjectFloat_Value_master.ObjectId = MILO_Receipt.ObjectId
                                                AND ObjectFloat_Value_master.DescId = zc_ObjectFloat_Receipt_Value()
                           LEFT JOIN ObjectLink AS ObjectLink_Receipt_Parent
                                                ON ObjectLink_Receipt_Parent.ObjectId = MILO_Receipt.ObjectId
                                               AND ObjectLink_Receipt_Parent.DescId = zc_ObjectLink_Receipt_Parent()
                           LEFT JOIN ObjectLink AS ObjectLink_Receipt_Goods_parent
                                                ON ObjectLink_Receipt_Goods_parent.ObjectId = ObjectLink_Receipt_Parent.ChildObjectId
                                               AND ObjectLink_Receipt_Goods_parent.DescId = zc_ObjectLink_Receipt_Goods()

                           LEFT JOIN ObjectLink AS ObjectLink_ReceiptChild_Receipt
                                                ON ObjectLink_ReceiptChild_Receipt.ChildObjectId = MILO_Receipt.ObjectId
                                               AND ObjectLink_ReceiptChild_Receipt.DescId = zc_ObjectLink_ReceiptChild_Receipt()
                           INNER JOIN ObjectLink AS ObjectLink_ReceiptChild_Goods
                                                 ON ObjectLink_ReceiptChild_Goods.ObjectId = ObjectLink_ReceiptChild_Receipt.ObjectId
                                                AND ObjectLink_ReceiptChild_Goods.DescId = zc_ObjectLink_ReceiptChild_Goods()
                                                AND ObjectLink_ReceiptChild_Goods.ChildObjectId = ObjectLink_Receipt_Goods_parent.ChildObjectId
                           INNER JOIN ObjectFloat AS ObjectFloat_Value_child
                                                  ON ObjectFloat_Value_child.ObjectId = ObjectLink_ReceiptChild_Receipt.ObjectId
                                                 AND ObjectFloat_Value_child.DescId = zc_ObjectFloat_ReceiptChild_Value()
                                                 AND ObjectFloat_Value_child.ValueData <> 0
                      GROUP BY tmpMI_WorkProgress_out.GoodsId
                             , tmpMI_WorkProgress_out.PartionGoodsId
                             , MIContainer.ObjectIntId_Analyzer

                     )
         -- ��������� - ������������
       , tmpResult AS
                     (SELECT tmp.GoodsId
                           , tmp.PartionGoodsId
                           , tmp.GoodsKindId_Complete
                           , SUM (tmp.Amount_WorkProgress_in) AS Amount_WorkProgress_in
                           , SUM (tmp.CuterCount)             AS CuterCount
                           , SUM (tmp.RealWeight)             AS RealWeight
                           , SUM (tmp.Amount_GP_in_calc)      AS Amount_GP_in_calc
                           , SUM (tmp.Amount_GP_in)           AS Amount_GP_in
                           , SUM (tmp.AmountReceipt_out)      AS AmountReceipt_out
                           , SUM (tmp.calcIn)                 AS calcIn
                           , SUM (tmp.calcOut)                AS calcOut
                           , MAX (tmp.TaxExit)                AS TaxExit
                           , MAX (tmp.Comment)                AS Comment
                      FROM
                     (-- ������������ �/� ��
                      SELECT tmpMI_WorkProgress_in.GoodsId
                           , tmpMI_WorkProgress_in.PartionGoodsId
                           , COALESCE (MILO_GoodsKindComplete.ObjectId, 0)      AS GoodsKindId_Complete
                           , SUM (tmpMI_WorkProgress_in.Amount)                 AS Amount_WorkProgress_in
                           , SUM (COALESCE (MIFloat_CuterCount.ValueData, 0))   AS CuterCount
                           , SUM (COALESCE (MIFloat_RealWeight.ValueData, 0))   AS RealWeight
                           , SUM (CASE WHEN ObjectFloat_TotalWeight.ValueData <> 0
                                            THEN (tmpMI_WorkProgress_in.Amount - COALESCE (tmpMI_WorkProgress_oth.Amount, 0)) * COALESCE (ObjectFloat_TaxExit.ValueData, 0) / ObjectFloat_TotalWeight.ValueData
                                       ELSE 0
                                  END)                                          AS Amount_GP_in_calc
                           , AVG (COALESCE (ObjectFloat_TaxExit.ValueData, 0))  AS TaxExit
                           , SUM (COALESCE (MIFloat_CuterCount.ValueData, 0) * COALESCE (ObjectFloat_TaxExit.ValueData, 0))     AS calcIn
                           , SUM (COALESCE (MIFloat_CuterCount.ValueData, 0) * COALESCE (ObjectFloat_TotalWeight.ValueData, 0)) AS calcOut
                           , MAX (COALESCE (MIString_Comment.ValueData, ''))    AS Comment
                           , 0                                                  AS Amount_GP_in
                           , 0                                                  AS AmountReceipt_out
                      FROM tmpMI_WorkProgress_in
                           LEFT JOIN tmpMI_WorkProgress_oth ON tmpMI_WorkProgress_oth.ContainerId = tmpMI_WorkProgress_in.ContainerId

                           LEFT JOIN MovementItemFloat AS MIFloat_CuterCount
                                                       ON MIFloat_CuterCount.MovementItemId = tmpMI_WorkProgress_in.MovementItemId
                                                      AND MIFloat_CuterCount.DescId = zc_MIFloat_CuterCount()
                           LEFT JOIN MovementItemFloat AS MIFloat_RealWeight
                                                       ON MIFloat_RealWeight.MovementItemId = tmpMI_WorkProgress_in.MovementItemId
                                                      AND MIFloat_RealWeight.DescId = zc_MIFloat_RealWeight()
                           LEFT JOIN MovementItemLinkObject AS MILO_GoodsKindComplete
                                                            ON MILO_GoodsKindComplete.MovementItemId = tmpMI_WorkProgress_in.MovementItemId
                                                           AND MILO_GoodsKindComplete.DescId = zc_MILinkObject_GoodsKindComplete()
                           LEFT JOIN MovementItemLinkObject AS MILO_Receipt
                                                            ON MILO_Receipt.MovementItemId = tmpMI_WorkProgress_in.MovementItemId
                                                           AND MILO_Receipt.DescId = zc_MILinkObject_Receipt()
                           LEFT JOIN MovementItemString AS MIString_Comment
                                                        ON MIString_Comment.MovementItemId = tmpMI_WorkProgress_in.MovementItemId
                                                       AND MIString_Comment.DescId = zc_MIString_Comment()

                           LEFT JOIN ObjectFloat AS ObjectFloat_TaxExit
                                                 ON ObjectFloat_TaxExit.ObjectId = MILO_Receipt.ObjectId
                                                AND ObjectFloat_TaxExit.DescId = zc_ObjectFloat_Receipt_TaxExit()
                           LEFT JOIN ObjectFloat AS ObjectFloat_TotalWeight
                                                 ON ObjectFloat_TotalWeight.ObjectId = MILO_Receipt.ObjectId
                                                AND ObjectFloat_TotalWeight.DescId = zc_ObjectFloat_Receipt_TotalWeight()

                           /*LEFT JOIN ObjectLink AS ObjectLink_Goods_Measure ON ObjectLink_Goods_Measure.ObjectId = tmpMI_WorkProgress_in.GoodsId
                                                                           AND ObjectLink_Goods_Measure.DescId = zc_ObjectLink_Goods_Measure()
                           LEFT JOIN ObjectFloat AS ObjectFloat_Weight	
                                                 ON ObjectFloat_Weight.ObjectId = tmpMI_WorkProgress_in.GoodsId
                                                AND ObjectFloat_Weight.DescId = zc_ObjectFloat_Goods_Weight()*/

                      GROUP BY tmpMI_WorkProgress_in.GoodsId
                             , tmpMI_WorkProgress_in.PartionGoodsId
                             , MILO_GoodsKindComplete.ObjectId
                     UNION ALL
                      -- ������ ��
                      SELECT tmpMI_GP_in.GoodsId
                           , tmpMI_GP_in.PartionGoodsId
                           , tmpMI_GP_in.GoodsKindId_Complete
                           , 0 AS Amount_WorkProgress_in
                           , 0 AS CuterCount
                           , 0 AS RealWeight
                           , 0 AS Amount_GP_in_calc
                           , 0 AS TaxExit
                           , 0 AS calcIn
                           , 0 AS calcOut
                           , '' AS Comment
                           , tmpMI_GP_in.Amount * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN COALESCE (ObjectFloat_Weight.ValueData, 0) ELSE 1 END AS Amount_GP_in
                           , tmpMI_GP_in.AmountReceipt * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN COALESCE (ObjectFloat_Weight.ValueData, 0) ELSE 1 END AS AmountReceipt_out
                      FROM tmpMI_GP_in
                           LEFT JOIN ObjectLink AS ObjectLink_Goods_Measure ON ObjectLink_Goods_Measure.ObjectId = tmpMI_GP_in.GoodsId
                                                                           AND ObjectLink_Goods_Measure.DescId = zc_ObjectLink_Goods_Measure()
                           LEFT JOIN ObjectFloat AS ObjectFloat_Weight	
                                                 ON ObjectFloat_Weight.ObjectId = tmpMI_GP_in.GoodsId
                                                AND ObjectFloat_Weight.DescId = zc_ObjectFloat_Goods_Weight()
                     UNION ALL
                      -- ������ �/� �� ������� ��� � ������������
                      SELECT tmpMI_WorkProgress_find.GoodsId
                           , tmpMI_WorkProgress_find.PartionGoodsId
                           , tmpMI_WorkProgress_find.GoodsKindId_Complete
                           , 0 AS Amount_WorkProgress_in
                           , 0 AS CuterCount
                           , 0 AS RealWeight
                           , 0 AS Amount_GP_in_calc
                           , 0 AS TaxExit
                           , 0 AS calcIn
                           , 0 AS calcOut
                           , '' AS Comment
                           , 0 AS Amount_GP_in
                           , 0 AS AmountReceipt_out
                      FROM tmpMI_WorkProgress_find
                     ) AS tmp
                      GROUP BY tmp.GoodsId
                             , tmp.PartionGoodsId
                             , tmp.GoodsKindId_Complete
                     )

    SELECT ObjectString_Goods_GroupNameFull.ValueData AS GoodsGroupNameFull
         , Object_Goods.ObjectCode                AS GoodsCode
         , Object_Goods.ValueData                 AS GoodsName
         , Object_GoodsKindComplete.ValueData     AS GoodsKindName_Complete
         , Object_Measure.ValueData               AS MeasureName
         , ObjectDate_PartionGoods.ValueData      AS PartionGoodsDate

         , tmpResult.Amount_WorkProgress_in :: TFloat   AS Amount_WorkProgress_in
         , tmpResult.CuterCount :: TFloat               AS CuterCount
         , tmpResult.RealWeight :: TFloat               AS RealWeight
         , tmpResult.Amount_GP_in_calc :: TFloat        AS Amount_GP_in_calc
         , tmpResult.Amount_GP_in :: TFloat             AS Amount_GP_in
         , tmpResult.AmountReceipt_out :: TFloat        AS AmountReceipt_out

         , tmpResult.TaxExit :: TFloat                  AS TaxExit
         , CASE WHEN tmpResult.CuterCount <> 0 AND tmpResult.calcOut <> 0
                     THEN (tmpResult.Amount_WorkProgress_in / tmpResult.CuterCount)
                        * (tmpResult.calcIn / tmpResult.CuterCount)
                        / (tmpResult.calcOut / tmpResult.CuterCount)
           END :: TFloat AS TaxExit_calc
         /*, CASE WHEN tmpResult.CuterCount <> 0 AND tmpResult.calcOut <> 0
                     THEN (tmpResult.Amount_WorkProgress_in / tmpResult.CuterCount)
                        * (tmpResult.Amount_GP_in / tmpResult.CuterCount)
                        / (tmpResult.calcOut / tmpResult.CuterCount)
           END :: TFloat AS TaxExit_real*/
         , CASE WHEN tmpResult.CuterCount <> 0
                     THEN (tmpResult.Amount_GP_in / tmpResult.CuterCount)
           END :: TFloat AS TaxExit_real

         , CASE WHEN tmpResult.AmountReceipt_out <> 0
                     THEN 100 - 100 * (tmpResult.Amount_GP_in / tmpResult.AmountReceipt_out)
           END :: TFloat AS TaxLoss
         , CASE WHEN tmpResult.RealWeight <> 0
                     THEN 100 - 100 * (tmpResult.Amount_GP_in / tmpResult.RealWeight)
           END :: TFloat AS TaxLoss_calc
         , CASE WHEN tmpResult.Amount_WorkProgress_in <> 0
                     THEN 100 - 100 * (tmpResult.Amount_GP_in / tmpResult.Amount_WorkProgress_in)
           END :: TFloat AS TaxLoss_real

         , tmpResult.Comment :: TVarChar                AS Comment

     FROM tmpResult
          LEFT JOIN Object AS Object_Goods on Object_Goods.Id = tmpResult.GoodsId
          LEFT JOIN Object AS Object_GoodsKindComplete ON Object_GoodsKindComplete.Id = tmpResult.GoodsKindId_Complete

          LEFT JOIN ObjectLink AS ObjectLink_Goods_Measure ON ObjectLink_Goods_Measure.ObjectId = Object_Goods.Id 
                                                          AND ObjectLink_Goods_Measure.DescId = zc_ObjectLink_Goods_Measure()
          LEFT JOIN Object AS Object_Measure ON Object_Measure.Id = ObjectLink_Goods_Measure.ChildObjectId

          LEFT JOIN ObjectString AS ObjectString_Goods_GroupNameFull
                                 ON ObjectString_Goods_GroupNameFull.ObjectId = Object_Goods.Id
                                AND ObjectString_Goods_GroupNameFull.DescId = zc_ObjectString_Goods_GroupNameFull()

          LEFT JOIN ObjectDate AS ObjectDate_PartionGoods
                               ON ObjectDate_PartionGoods.ObjectId = tmpResult.PartionGoodsId
                              AND ObjectDate_PartionGoods.DescId = zc_ObjectDate_PartionGoods_Value()
    ;
         
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpReport_GoodsMI_ProductionUnion_TaxExit (TDateTime, TDateTime, Integer, Integer, Boolean, TVarChar) OWNER TO postgres;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 17.03.15                                        *
*/

-- ����
-- SELECT * FROM gpReport_GoodsMI_ProductionUnion_TaxExit (inStartDate:= '01.06.2015', inEndDate:= '01.06.2015', inFromId:= 8447, inToId:= 0, inIsDetail:= FALSE, inSession:= zfCalc_UserAdmin()) ORDER BY 2;
