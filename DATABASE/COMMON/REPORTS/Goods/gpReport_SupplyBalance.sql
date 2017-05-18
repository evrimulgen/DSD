-- Function: gpReport_SupplyBalance()

DROP FUNCTION IF EXISTS gpReport_SupplyBalance (TDateTime, TDateTime, Integer, Integer, TVarChar);
DROP FUNCTION IF EXISTS gpReport_SupplyBalance (TDateTime, TDateTime, Integer, Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpReport_SupplyBalance(
    IN inStartDate          TDateTime , --
    IN inEndDate            TDateTime , --
    IN inUnitId             Integer,    -- ������������� �����
    IN inGoodsGroupId       Integer,    -- ������ ������
    IN inJuridicalId        Integer,    -- ���������
    IN inSession            TVarChar    -- ������ ������������
)
RETURNS TABLE (GoodsId              Integer
             , GoodsCode            Integer
             , GoodsName            TVarChar
             , MeasureName          TVarChar
             , GoodsGroupNameFull   TVarChar
             , GoodsGroupName       TVarChar
             , PartnerName          TVarChar
             , Comment              TVarChar
             , MovementId_List      TVarChar
             , CountDays            Integer
             , RemainsStart         TFloat
             , RemainsEnd           TFloat
             , RemainsStart_Oth     TFloat
             , RemainsEnd_Oth       TFloat
             , CountIncome          TFloat
             , CountProductionOut   TFloat
             , CountIn_oth          TFloat
             , CountOut_oth         TFloat
             , CountOnDay           TFloat
             , RemainsDays          TFloat
             , ReserveDays          TFloat
             , PlanOrder            TFloat
             , CountOrder           TFloat
             , RemainsDaysWithOrder TFloat
             , Color_RemainsDays    Integer
              )
AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbCountDays Integer;
BEGIN

    -- ����������� �� �������
    CREATE TEMP TABLE _tmpGoods (GoodsId Integer) ON COMMIT DROP;
    IF inGoodsGroupId <> 0
    THEN
        INSERT INTO _tmpGoods (GoodsId)
           SELECT lfSelect.GoodsId FROM  lfSelect_Object_Goods_byGoodsGroup (inGoodsGroupId) AS lfSelect;
    ELSE
        -- �� � ����� ����� ����������� � ���� ������
        INSERT INTO _tmpGoods (GoodsId)
           SELECT Object.Id FROM Object WHERE DescId = zc_Object_Goods();
    END IF;

    vbCountDays := (SELECT DATE_PART('day', (inEndDate - inStartDate )) + 1);

     RETURN QUERY
     WITH -- ������������� ��� "������� �������������"
          tmpUnit AS (SELECT 8448 AS UnitId       --��� �����������+
                     UNION
                      SELECT 8447 AS UnitId       -- ���������+
                     UNION
                      SELECT 8451 AS UnitId       -- ��������+
                     UNION
                      SELECT 951601 AS UnitId     -- �������� ����+
                     UNION
                      SELECT 981821 AS UnitId     -- �����������
                     )
    -- ������ �� �� ����� - !!!������ ���� ������ �� �������!!! -- !!!������ - ������ ���� ��� ��� ��� ��� �������!!!
  , tmpOrderIncome_all AS (SELECT MILinkObject_Goods.ObjectId           AS GoodsId
                                , MovementLinkObject_Juridical.ObjectId AS JuridicalId -- �� ����� ���� ��� �� ����, �� ��� ����� ������������ ���� ����� ������ ���� �� ��������
                                , MovementItem.Amount                   AS Amount
                                , COALESCE (MI_Income.Amount, 0)        AS Amount_Income
                                , ROW_NUMBER() OVER (PARTITION BY Movement.Id, MILinkObject_Goods.ObjectId) AS Ord
                                , COALESCE (MovementString_Comment.ValueData,'') AS Comment
                                , Movement.Id AS MovementId
                           FROM Movement
                                LEFT JOIN MovementBoolean AS MovementBoolean_Closed
                                                          ON MovementBoolean_Closed.MovementId = Movement.Id
                                                         AND MovementBoolean_Closed.DescId     = zc_MovementBoolean_Closed()
                                                         AND MovementBoolean_Closed.ValueData  = TRUE
                                INNER JOIN MovementLinkObject AS MovementLinkObject_Juridical
                                                              ON MovementLinkObject_Juridical.MovementId = Movement.Id
                                                             AND MovementLinkObject_Juridical.DescId     = zc_MovementLinkObject_Juridical()
                                                             -- !!!����������!!!
                                                             AND (MovementLinkObject_Juridical.ObjectId = inJuridicalId OR inJuridicalId = 0)

                                INNER JOIN MovementLinkObject AS MovementLinkObject_Unit
                                                              ON MovementLinkObject_Unit.MovementId = Movement.Id
                                                             AND MovementLinkObject_Unit.DescId = zc_MovementLinkObject_Unit()
                                                             AND MovementLinkObject_Unit.ObjectId > 0 -- !!!������ ��� ������ "���������"!!!

                                LEFT JOIN MovementString AS MovementString_Comment
                                                         ON MovementString_Comment.MovementId = Movement.Id
                                                        AND MovementString_Comment.DescId = zc_MovementString_Comment()

                                INNER JOIN MovementItem ON MovementItem.MovementId  = Movement.Id
                                                       AND MovementItem.isErased    = FALSE
                                                       AND MovementItem.DescId      = zc_MI_Master()
                                                       AND MovementItem.Amount      <> 0
                                LEFT JOIN MovementItemLinkObject AS MILinkObject_Goods
                                                                 ON MILinkObject_Goods.MovementItemId = MovementItem.Id
                                                                AND MILinkObject_Goods.DescId = zc_MILinkObject_Goods()
                                INNER JOIN _tmpGoods ON _tmpGoods.GoodsId = MILinkObject_Goods.ObjectId

                                LEFT JOIN MovementLinkMovement AS MovementLinkMovement_Income
                                                               ON MovementLinkMovement_Income.MovementChildId = Movement.Id
                                                              AND MovementLinkMovement_Income.DescId = zc_MovementLinkMovement_Order()
                                LEFT JOIN Movement AS Movement_Income
                                                   ON Movement_Income.Id       = MovementLinkMovement_Income.MovementId
                                                  AND Movement_Income.StatusId = zc_Enum_Status_Complete()
                                                  AND Movement_Income.DescId   = zc_Movement_Income()
                                LEFT JOIN MovementItem AS MI_Income
                                                       ON MI_Income.MovementId  = Movement_Income.Id
                                                      AND MI_Income.ObjectId    = MILinkObject_Goods.ObjectId
                                                      AND MI_Income.isErased    = FALSE
                                                      AND MI_Income.DescId      = zc_MI_Master()

                           WHERE Movement.DescId     = zc_Movement_OrderIncome()
                             AND Movement.StatusId   = zc_Enum_Status_Complete()
                             AND MovementBoolean_Closed.MovementId IS NULL -- �.�. ������ �� �������
                             -- AND Movement_Income.Id IS NULL -- �.�. � ������ ��� ��� ������������ �������
                           )
        -- ������ �� �� ����� - ��������: ������ - ������
   , tmpOrderIncome_gr AS (SELECT tmp.GoodsId
                                , STRING_AGG (Object.ValueData :: TVarChar, '; ') AS PartnerName -- �� ����� ���� ��� �� ����, �� ��� ����� ������������ ���� ����� ������ ���� �� ��������
                                , STRING_AGG (tmp.Comment :: TVarChar, '; ') AS Comment
                                , STRING_AGG (tmp.MovementId :: TVarChar, '; ') AS MovementId_List
                           FROM (SELECT DISTINCT tmp.GoodsId, tmp.JuridicalId, tmp.Comment, tmp.MovementId FROM tmpOrderIncome_all AS tmp) AS tmp
                                LEFT JOIN Object ON Object.Id = tmp.JuridicalId
                           GROUP BY tmp.GoodsId
                          )
        -- ������ �� �� ����� - ��������: ������ - ������
      , tmpOrderIncome AS (SELECT tmp.GoodsId
                                , tmpOrderIncome_gr.PartnerName
                                , tmpOrderIncome_gr.Comment
                                , tmpOrderIncome_gr.MovementId_List
                                , tmp.Amount - tmp.Amount_Income AS Amount
                           FROM (SELECT tmpOrderIncome_all.GoodsId
                                      -- , STRING_AGG (Object.ValueData :: TVarChar, '; ') AS PartnerName -- �� ����� ���� ��� �� ����, �� ��� ����� ������������ ���� ����� ������ ���� �� ��������
                                      -- , STRING_AGG (tmpOrderIncome_all.Comment :: TVarChar, '; ') AS Comment
                                      -- , STRING_AGG (tmpOrderIncome_all.MovementId :: TVarChar, '; ') AS MovementId_List
                                      , SUM (CASE WHEN tmpOrderIncome_all.Ord = 1 THEN tmpOrderIncome_all.Amount ELSE 0 END) AS Amount
                                      , SUM (tmpOrderIncome_all.Amount_Income) AS Amount_Income
                                 FROM tmpOrderIncome_all
                                      LEFT JOIN Object ON Object.Id = tmpOrderIncome_all.JuridicalId
                                 GROUP BY tmpOrderIncome_all.GoodsId
                                ) AS tmp
                                LEFT JOIN tmpOrderIncome_gr ON tmpOrderIncome_gr.GoodsId = tmp.GoodsId
                           WHERE tmp.Amount > tmp.Amount_Income
                          )
    -- ������ ������� �� ����������� �� ������� (���-�� ������� ������� �� �������� - �����)
  , tmpContainerIncome AS (SELECT DISTINCT
                                  MIContainer.ObjectId_Analyzer    AS GoodsId
                                , MIContainer.ObjectExtId_Analyzer AS PartnerId
                           FROM MovementItemContainer AS MIContainer
                                INNER JOIN _tmpGoods ON _tmpGoods.GoodsId = MIContainer.ObjectId_Analyzer
                                INNER JOIN ObjectLink AS ObjectLink_Partner_Juridical
                                                      ON ObjectLink_Partner_Juridical.ObjectId = MIContainer.ObjectExtId_Analyzer
                                                     AND ObjectLink_Partner_Juridical.DescId   = zc_ObjectLink_Partner_Juridical()
                                                     -- !!!����������!!!
                                                     AND (ObjectLink_Partner_Juridical.ChildObjectId = inJuridicalId OR inJuridicalId = 0)
                           WHERE MIContainer.OperDate BETWEEN inStartDate AND inEndDate
                             AND MIContainer.WhereObjectId_Analyzer = inUnitId
                             AND MIContainer.MovementDescId         = zc_Movement_Income()
                             AND MIContainer.DescId                 = zc_MIContainer_Count()
                          )
  -- ������ ������� �� ����������� �� !!!���������!!! "��������"
, tmpGoodsListIncome AS (SELECT DISTINCT
                                tmpGoods.GoodsId
                              , ObjectLink_GoodsListIncome_Partner.ChildObjectId AS PartnerId
                         FROM _tmpGoods AS tmpGoods
                              INNER JOIN ObjectLink AS ObjectLink_GoodsListIncome_Goods
                                                    ON ObjectLink_GoodsListIncome_Goods.ChildObjectId = tmpGoods.GoodsId
                                                   AND ObjectLink_GoodsListIncome_Goods.DescId        = zc_ObjectLink_GoodsListIncome_Goods()
                              INNER JOIN ObjectBoolean AS ObjectBoolean_GoodsListIncome_Last
                                                       ON ObjectBoolean_GoodsListIncome_Last.ObjectId  = ObjectLink_GoodsListIncome_Goods.ObjectId
                                                      AND ObjectBoolean_GoodsListIncome_Last.DescId    = zc_ObjectBoolean_GoodsListIncome_Last()
                                                      AND ObjectBoolean_GoodsListIncome_Last.ValueData = TRUE -- �� ���������
                              LEFT JOIN ObjectLink AS ObjectLink_GoodsListIncome_Partner
                                                   ON ObjectLink_GoodsListIncome_Partner.ObjectId = ObjectLink_GoodsListIncome_Goods.ObjectId
                                                  AND ObjectLink_GoodsListIncome_Partner.DescId = zc_ObjectLink_GoodsListIncome_Partner()
                              INNER JOIN ObjectLink AS ObjectLink_Partner_Juridical
                                                    ON ObjectLink_Partner_Juridical.ObjectId = ObjectLink_GoodsListIncome_Partner.ChildObjectId
                                                   AND ObjectLink_Partner_Juridical.DescId = zc_ObjectLink_Partner_Juridical()
                                                   -- !!!����������!!!
                                                   AND (ObjectLink_Partner_Juridical.ChildObjectId = inJuridicalId OR inJuridicalId = 0)
                        )
      -- !!!���������!!! ������ ������� + �� �� ����������� - � GoodsId � ��� ������� ����������
    , tmpGoodsList AS (SELECT tmp.GoodsId
                            , STRING_AGG (Object.ValueData :: TVarChar, '; ') AS PartnerName -- �� ����� ���� ��� �� ����, �� ��� ����� ������������ ���� ����� ������ ���� �� ��������
                       FROM (-- ��������� � 1
                             SELECT tmpContainerIncome.GoodsId
                                  , tmpContainerIncome.PartnerId
                             FROM tmpContainerIncome
                            UNION
                             -- ��� ������� �� ������ - ���� ��� � �������
                             SELECT tmpGoodsListIncome.GoodsId
                                  , tmpGoodsListIncome.PartnerId
                             FROM tmpGoodsListIncome
                                  LEFT JOIN tmpContainerIncome ON tmpContainerIncome.GoodsId = tmpGoodsListIncome.GoodsId
                             WHERE tmpContainerIncome.GoodsId IS NULL
                            ) AS tmp
                            LEFT JOIN Object ON Object.Id = tmp.PartnerId
                       GROUP BY tmp.GoodsId
                      UNION
                       -- ��������� � 2 - ��� ������� �� ������ - ���� ��� � ����������
                       SELECT tmpOrderIncome.GoodsId, tmpOrderIncome.PartnerName
                       FROM tmpOrderIncome
                            LEFT JOIN tmpContainerIncome ON tmpContainerIncome.GoodsId = tmpOrderIncome.GoodsId
                            LEFT JOIN tmpGoodsListIncome ON tmpGoodsListIncome.GoodsId = tmpOrderIncome.GoodsId
                       WHERE tmpContainerIncome.GoodsId IS NULL
                         AND tmpGoodsListIncome.GoodsId IS NULL
                      UNION
                       -- ��������� � 3 - ��� ��������� - �� ���� ��� inJuridicalId
                       SELECT _tmpGoods.GoodsId, '' AS PartnerName
                       FROM _tmpGoods
                            LEFT JOIN tmpContainerIncome ON tmpContainerIncome.GoodsId = _tmpGoods.GoodsId
                            LEFT JOIN tmpGoodsListIncome ON tmpGoodsListIncome.GoodsId = _tmpGoods.GoodsId
                            LEFT JOIN tmpOrderIncome     ON tmpOrderIncome.GoodsId     = _tmpGoods.GoodsId
                       WHERE inJuridicalId = 0
                         AND tmpContainerIncome.GoodsId IS NULL
                         AND tmpGoodsListIncome.GoodsId IS NULL
                         AND tmpOrderIncome.GoodsId     IS NULL
                      )

   -- ���������� ��� �������� - �� !!!����������!!! ������
 , tmpContainerAll AS (SELECT Container.Id         AS ContainerId
                            , CLO_Unit.ObjectId    AS UnitId
                            , Container.ObjectId   AS GoodsId
                            , Container.Amount
                       FROM ContainerLinkObject AS CLO_Unit
                            -- INNER JOIN tmpUnit ON tmpUnit.UnitId = CLO_Unit.ObjectId
                            INNER JOIN Container ON Container.Id = CLO_Unit.ContainerId AND Container.DescId = zc_Container_Count()
                            INNER JOIN tmpGoodsList ON tmpGoodsList.GoodsId = Container.ObjectId
                       WHERE CLO_Unit.ObjectId = inUnitId
                         AND CLO_Unit.DescId   = zc_ContainerLinkObject_Unit()
                      )
     -- �������
   , tmpMIContainerAll AS (SELECT CASE WHEN MIContainer.MovementDescId in (zc_Movement_Income(), zc_Movement_ReturnOut()) THEN MIContainer.ObjectExtId_Analyzer ELSE 0 END AS ObjectExtId_Analyzer
                                , tmpContainerAll.ContainerId
                                , tmpContainerAll.GoodsId
                                , tmpContainerAll.Amount
                                , SUM (COALESCE (MIContainer.Amount, 0))  AS StartAmountSum
                                , SUM (CASE WHEN MIContainer.OperDate > inEndDate THEN COALESCE (MIContainer.Amount, 0) ELSE 0 END) AS EndAmountSum

                                , SUM (CASE WHEN MIContainer.OperDate BETWEEN inStartDate AND inEndDate
                                             AND MIContainer.MovementDescId in (zc_Movement_Income(), zc_Movement_ReturnOut())
                                            THEN COALESCE (MIContainer.Amount, 0)
                                            ELSE 0
                                       END) AS CountIncome
                                , SUM (CASE WHEN MIContainer.OperDate BETWEEN inStartDate AND inEndDate
                                             AND MIContainer.MovementDescId = zc_Movement_Send()
                                             -- AND MIContainer.isActive = FALSE
                                            THEN -1 * COALESCE (MIContainer.Amount, 0)
                                            ELSE 0
                                       END) AS CountSendOut

                                , SUM (CASE WHEN MIContainer.OperDate BETWEEN inStartDate AND inEndDate
                                             AND MIContainer.MovementDescId IN (zc_Movement_Sale())
                                            THEN -1 * COALESCE (MIContainer.Amount, 0)
                                            ELSE 0
                                       END
                                     + CASE WHEN MIContainer.OperDate BETWEEN inStartDate AND inEndDate
                                             AND MIContainer.MovementDescId IN (zc_Movement_ProductionUnion(), zc_Movement_ProductionSeparate(), zc_Movement_Loss())
                                             AND MIContainer.isActive = FALSE
                                            THEN -1 * COALESCE (MIContainer.Amount, 0)
                                            ELSE 0
                                       END
                                     + CASE WHEN MIContainer.OperDate BETWEEN inStartDate AND inEndDate
                                             AND MIContainer.MovementDescId IN (zc_Movement_Inventory())
                                             AND MIContainer.Amount < 0
                                            THEN -1 * COALESCE (MIContainer.Amount, 0)
                                            ELSE 0
                                       END) AS CountOut_oth

                                , SUM (CASE WHEN MIContainer.OperDate BETWEEN inStartDate AND inEndDate
                                             AND MIContainer.MovementDescId IN (zc_Movement_ReturnIn())
                                            THEN 1 * COALESCE (MIContainer.Amount, 0)
                                            ELSE 0
                                       END
                                     + CASE WHEN MIContainer.OperDate BETWEEN inStartDate AND inEndDate
                                             AND MIContainer.MovementDescId IN (zc_Movement_ProductionUnion(), zc_Movement_ProductionSeparate(), zc_Movement_Loss())
                                             AND MIContainer.isActive = TRUE
                                            THEN 1 * COALESCE (MIContainer.Amount, 0)
                                            ELSE 0
                                       END
                                     + CASE WHEN MIContainer.OperDate BETWEEN inStartDate AND inEndDate
                                             AND MIContainer.MovementDescId = zc_Movement_Inventory()
                                             AND MIContainer.Amount > 0
                                            THEN 1 * COALESCE (MIContainer.Amount, 0)
                                            ELSE 0
                                       END) AS CountIn_oth

                           FROM tmpContainerAll
                                LEFT JOIN MovementItemContainer AS MIContainer
                                                                ON MIContainer.Containerid = tmpContainerAll.ContainerId
                                                               AND MIContainer.OperDate >= inStartDate
                           GROUP BY CASE WHEN MIContainer.MovementDescId in (zc_Movement_Income(), zc_Movement_ReturnOut()) THEN MIContainer.ObjectExtId_Analyzer ELSE 0 END
                                  , tmpContainerAll.ContainerId, tmpContainerAll.GoodsId, tmpContainerAll.Amount
                          )
    -- �������� + �������
  , tmpContainer AS (SELECT tmp.GoodsId
                          , (tmp.StartAmount)        AS RemainsStart
                          , (tmp.EndAmount)          AS RemainsEnd
                          , (tmpIncome.CountIncome)  AS CountIncome
                          , (tmp.CountSendOut)       AS CountProductionOut
                          , (tmp.CountIn_oth   + COALESCE (tmpIncome.CountIn_oth, 0))  AS CountIn_oth
                          , (tmp.CountOut_oth  + COALESCE (tmpIncome.CountOut_oth, 0)) AS CountOut_oth

                     FROM (SELECT tmp.GoodsId
                                , SUM (tmp.StartAmount)  AS StartAmount
                                , SUM (tmp.EndAmount)    AS EndAmount

                                , SUM (tmp.CountSendOut) AS CountSendOut

                                , SUM (tmp.CountOut_oth) AS CountOut_oth

                                , SUM (tmp.CountIn_oth) AS CountIn_oth
                           FROM
                          (SELECT tmpMIContainerAll.GoodsId
                                , tmpMIContainerAll.Amount - SUM (tmpMIContainerAll.StartAmountSum)  AS StartAmount
                                , tmpMIContainerAll.Amount - SUM (tmpMIContainerAll.EndAmountSum)    AS EndAmount

                                , SUM (tmpMIContainerAll.CountSendOut) AS CountSendOut

                                , SUM (tmpMIContainerAll.CountOut_oth) AS CountOut_oth

                                , SUM (tmpMIContainerAll.CountIn_oth) AS CountIn_oth

                           FROM tmpMIContainerAll
                           GROUP BY tmpMIContainerAll.ContainerId, tmpMIContainerAll.GoodsId, tmpMIContainerAll.Amount
                          ) AS tmp
                           GROUP BY tmp.GoodsId
                          ) AS tmp
                          LEFT JOIN (SELECT tmpMIContainerAll.GoodsId
                                          , SUM (CASE -- ���� ���� �� ���� ����������� - ����� ���� ������
                                                      WHEN inJuridicalId = 0
                                                           THEN tmpMIContainerAll.CountIncome
                                                      -- ���� ���� ������ �� ������ ����������
                                                      WHEN ObjectLink_Partner_Juridical.ChildObjectId = inJuridicalId AND inJuridicalId > 0
                                                           THEN tmpMIContainerAll.CountIncome
                                                      -- ����� ��� "������" ������/������
                                                      ELSE 0
                                                END) AS CountIncome

                                          , SUM (CASE -- ����� ��� "������" ������
                                                      WHEN ObjectLink_Partner_Juridical.ChildObjectId <> inJuridicalId AND inJuridicalId > 0
                                                           AND tmpMIContainerAll.CountIncome > 0
                                                           THEN tmpMIContainerAll.CountIncome
                                                      ELSE 0
                                                END) AS CountIn_oth
                                          , SUM (CASE -- ����� ��� "������" ������
                                                      WHEN ObjectLink_Partner_Juridical.ChildObjectId <> inJuridicalId AND inJuridicalId > 0
                                                           AND tmpMIContainerAll.CountIncome < 0
                                                           THEN -1 * tmpMIContainerAll.CountIncome
                                                      ELSE 0
                                                END) AS CountOut_oth

                                     FROM tmpMIContainerAll
                                          LEFT JOIN ObjectLink AS ObjectLink_Partner_Juridical
                                                               ON ObjectLink_Partner_Juridical.ObjectId = tmpMIContainerAll.ObjectExtId_Analyzer
                                                              AND ObjectLink_Partner_Juridical.DescId   = zc_ObjectLink_Partner_Juridical()
                                     GROUP BY tmpMIContainerAll.GoodsId
                                    ) AS tmpIncome ON tmpIncome.GoodsId = tmp.GoodsId
                     )
   -- ���������� - ��� "������� � ������������"
 , tmpContainer_Oth AS (SELECT Container.Id       AS ContainerId
                             , Container.ObjectId AS GoodsId
                             , Container.Amount
                        FROM tmpUnit
                             INNER JOIN ContainerLinkObject AS CLO_Unit
                                                            ON CLO_Unit.ObjectId = tmpUnit.UnitId
                                                           AND CLO_Unit.DescId   = zc_ContainerLinkObject_Unit()
                             INNER JOIN Container ON Container.Id     = CLO_Unit.ContainerId
                                                 AND Container.DescId = zc_Container_Count()
                             INNER JOIN tmpGoodsList ON tmpGoodsList.GoodsId = Container.ObjectId
                       )
    --"������� � ������������"
  , tmpRemains_Oth AS (SELECT tmp.GoodsId
                            , SUM (tmp.StartAmount) AS RemainsStart
                            , SUM (tmp.EndAmount)   AS RemainsEnd

                       FROM (SELECT tmpContainer_Oth.ContainerId
                                  , tmpContainer_Oth.GoodsId
                                  , tmpContainer_Oth.Amount - SUM (COALESCE (MIContainer.Amount, 0))  AS StartAmount
                                  , tmpContainer_Oth.Amount - SUM (CASE WHEN MIContainer.OperDate > inEndDate THEN COALESCE (MIContainer.Amount, 0) ELSE 0 END) AS EndAmount
                             FROM tmpContainer_Oth
                                  LEFT JOIN MovementItemContainer AS MIContainer
                                                                  ON MIContainer.Containerid = tmpContainer_Oth.ContainerId
                                                                 AND MIContainer.OperDate    >= inStartDate
                             GROUP BY tmpContainer_Oth.ContainerId, tmpContainer_Oth.GoodsId, tmpContainer_Oth.Amount
                             HAVING tmpContainer_Oth.Amount - SUM (COALESCE (MIContainer.Amount, 0))  <> 0
                                 OR tmpContainer_Oth.Amount - SUM (CASE WHEN MIContainer.OperDate > inEndDate THEN COALESCE (MIContainer.Amount, 0) ELSE 0 END) <> 0
                            ) AS tmp
                       GROUP BY tmp.GoodsId
                      )
       -- ���������
       SELECT
             Object_Goods.Id                            AS GoodsId
           , Object_Goods.ObjectCode                    AS GoodsCode
           , Object_Goods.ValueData                     AS GoodsName
           , Object_Measure.ValueData                   AS MeasureName
           , ObjectString_Goods_GroupNameFull.ValueData AS GoodsGroupNameFull
           , Object_GoodsGroup.ValueData                AS GoodsGroupName

           , tmpGoodsList.PartnerName       :: TVarChar AS PartnerName

           , tmpOrderIncome.Comment         :: TVarChar AS Comment
           , tmpOrderIncome.MovementId_List :: TVarChar AS MovementId_List

           , vbCountDays                        AS CountDays

           , tmpContainer.RemainsStart        :: TFloat AS RemainsStart
           , tmpContainer.RemainsEnd          :: TFloat AS RemainsEnd
           , tmpRemains_Oth.RemainsStart      :: TFloat AS RemainsStart_Oth
           , tmpRemains_Oth.RemainsEnd        :: TFloat AS RemainsEnd_Oth
           , tmpContainer.CountIncome         :: TFloat AS CountIncome
           , tmpContainer.CountProductionOut  :: TFloat AS CountProductionOut
           , tmpContainer.CountIn_oth         :: TFloat AS CountIn_oth
           , tmpContainer.CountOut_oth        :: TFloat AS CountOut_oth

           , (CASE WHEN vbCountDays <> 0 THEN tmpContainer.CountProductionOut/vbCountDays ELSE 0 END)  :: TFloat AS CountOnDay
           , CASE WHEN tmpContainer.CountProductionOut <=0 AND  tmpContainer.RemainsEnd <> 0 THEN 365
                  WHEN tmpContainer.RemainsEnd <> 0 AND (tmpContainer.CountProductionOut/vbCountDays) <> 0
                  THEN tmpContainer.RemainsEnd / (tmpContainer.CountProductionOut/vbCountDays)
                  ELSE 0
             END :: TFloat AS RemainsDays

           , 30 :: TFloat AS ReserveDays
           , CASE WHEN tmpContainer.CountProductionOut > 0 AND tmpContainer.RemainsEnd <> 0 AND tmpContainer.RemainsEnd <> 0  AND tmpContainer.RemainsEnd < (tmpContainer.CountProductionOut/vbCountDays) * 30 THEN (tmpContainer.CountProductionOut/vbCountDays) * 30 - tmpContainer.RemainsEnd ELSE 0 END :: TFloat AS PlanOrder
           , tmpOrderIncome.Amount  :: TFloat AS CountOrder

           , CASE WHEN tmpContainer.CountProductionOut <= 0 AND tmpContainer.RemainsEnd <> 0
                  THEN 365
                  WHEN (tmpContainer.CountProductionOut / vbCountDays) <> 0
                  THEN (COALESCE (tmpContainer.RemainsEnd, 0) + COALESCE (tmpOrderIncome.Amount, 0)) / (tmpContainer.CountProductionOut / vbCountDays)
                  ELSE 0
             END  :: TFloat AS RemainsDaysWithOrder

           , CASE WHEN COALESCE (tmpOrderIncome.Amount, 0) > 0 THEN 25088  -- �������
                  ELSE
                    CASE WHEN tmpContainer.CountProductionOut <= 0 AND tmpContainer.RemainsEnd <> 0
                              THEN zc_Color_Black()

                         WHEN COALESCE (tmpContainer.CountProductionOut, 0) <= 0 AND COALESCE (tmpContainer.RemainsEnd, 0) = 0
                              THEN zc_Color_Black()

                         WHEN 29.9 < CASE WHEN tmpContainer.RemainsEnd <> 0 AND (tmpContainer.CountProductionOut / vbCountDays) <> 0
                                               THEN COALESCE (tmpContainer.RemainsEnd, 0) / (tmpContainer.CountProductionOut / vbCountDays)
                                           ELSE 0
                                     END
                              THEN zc_Color_Black()

                         ELSE zc_Color_Red()
                    END
              END :: Integer AS Color_RemainsDays

       FROM tmpGoodsList
          LEFT JOIN tmpContainer ON tmpContainer.GoodsId = tmpGoodsList.GoodsId
          LEFT JOIN tmpOrderIncome ON tmpOrderIncome.GoodsId = tmpGoodsList.GoodsId
          LEFT JOIN tmpRemains_Oth ON tmpRemains_Oth.GoodsId = tmpGoodsList.GoodsId
          LEFT JOIN Object AS Object_Goods ON Object_Goods.Id = tmpGoodsList.GoodsId

          LEFT JOIN ObjectLink AS ObjectLink_Goods_Measure ON ObjectLink_Goods_Measure.ObjectId = Object_Goods.Id
                                                          AND ObjectLink_Goods_Measure.DescId   = zc_ObjectLink_Goods_Measure()
          LEFT JOIN Object AS Object_Measure ON Object_Measure.Id = ObjectLink_Goods_Measure.ChildObjectId

          LEFT JOIN ObjectString AS ObjectString_Goods_GroupNameFull
                                 ON ObjectString_Goods_GroupNameFull.ObjectId = Object_Goods.Id
                                AND ObjectString_Goods_GroupNameFull.DescId   = zc_ObjectString_Goods_GroupNameFull()

          LEFT JOIN ObjectLink AS ObjectLink_Goods_GoodsGroup
                               ON ObjectLink_Goods_GoodsGroup.ObjectId = Object_Goods.Id
                              AND ObjectLink_Goods_GoodsGroup.DescId   = zc_ObjectLink_Goods_GoodsGroup()
          LEFT JOIN Object AS Object_GoodsGroup ON Object_GoodsGroup.Id = ObjectLink_Goods_GoodsGroup.ChildObjectId

       WHERE tmpContainer.RemainsStart   <> 0 OR tmpContainer.RemainsEnd         <> 0 OR tmpOrderIncome.Amount  <> 0
          OR tmpContainer.CountIncome    <> 0 OR tmpContainer.CountProductionOut <> 0
          OR tmpContainer.CountIn_oth    <> 0 OR tmpContainer.CountOut_oth       <> 0
          OR tmpRemains_Oth.RemainsStart <> 0
          OR tmpRemains_Oth.RemainsEnd   <> 0
      ;

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 16.05.17         *
 30.03.17         *
*/

-- ����
-- SELECT * FROM gpReport_SupplyBalance (inStartDate:= '01.05.2017', inEndDate:= '30.05.2017', inUnitId:= 8455, inGoodsGroupId:= 1941, inJuridicalId:= 0, inSession := '5'); -- ����� ������
