-- Function: gpUpdate_HistoryCost_diff()

DROP FUNCTION IF EXISTS gpUpdate_HistoryCost_diff (TDateTime, TDateTime, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpUpdate_HistoryCost_diff(
    IN inStartDate       TDateTime , --
    IN inEndDate         TDateTime , --
    IN inIsUpdate        Boolean   , --
    IN inSession         TVarChar    -- ������ ������������
)                              
--  RETURNS VOID
  RETURNS TABLE (OperDate TDateTime, ContainerId Integer, MovementItemId Integer, Amount TFloat, Amount_diff TFloat)
AS
$BODY$
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_InsertUpdate_HistoryCost());

     IF inIsUpdate = TRUE THEN RETURN; END IF;

     -- ������� - ������
     CREATE TEMP TABLE _tmpDiff (OperDate TDateTime, ContainerId Integer, MovementItemId Integer, Amount TFloat, Amount_diff TFloat) ON COMMIT DROP;

     -- ��������� �������
        WITH tmpContainerSumm AS (-- ������� �� �����
                                  SELECT Container_Summ.Id AS ContainerId, Container_Summ.ParentId, Container_Summ.ObjectId
                                       , Container_Summ.Amount - COALESCE (SUM (MIContainer.Amount), 0) AS Amount_end
                                  FROM Container AS Container_Summ
                                       LEFT JOIN MovementItemContainer AS MIContainer
                                                                       ON MIContainer.ContainerId = Container_Summ.Id
                                                                      AND MIContainer.OperDate > inEndDate
                                  WHERE Container_Summ.DescId = zc_Container_Summ()
                                    AND Container_Summ.ParentId > 0
                                    AND Container_Summ.ObjectId <> zc_Enum_Account_110101() -- ������� + ����� � ����
                                  GROUP BY Container_Summ.Id, Container_Summ.ParentId, Container_Summ.Amount, Container_Summ.ObjectId
                                  HAVING Container_Summ.Amount - COALESCE (SUM (MIContainer.Amount), 0) <> 0
                                 )
          , tmpContainerCount AS (-- ������� �� ���-�� = 0
                                  SELECT Container.Id AS ContainerId
                                  FROM (SELECT tmpContainerSumm.ParentId AS ContainerId FROM tmpContainerSumm GROUP BY tmpContainerSumm.ParentId) AS tmp
                                       INNER JOIN Container ON Container.Id = tmp.ContainerId
                                       LEFT JOIN MovementItemContainer AS MIContainer
                                                                       ON MIContainer.ContainerId = tmp.ContainerId
                                                                      AND MIContainer.OperDate > inEndDate
                                  GROUP BY Container.Id, Container.Amount
                                  HAVING Container.Amount - COALESCE (SUM (MIContainer.Amount), 0) = 0
                                 )
           , tmpContainer AS (-- ������� �� ����� <> 0 AND ���-�� = 0, �.�. "��������" �������
                              SELECT tmpContainerSumm.ContainerId, tmpContainerSumm.Amount_end AS Amount_diff
                              FROM tmpContainerCount
                                   INNER JOIN tmpContainerSumm ON tmpContainerSumm.ParentId = tmpContainerCount.ContainerId
                             )
             , tmpListAll AS (-- 
                              SELECT tmpContainer.ContainerId, MIContainer.Id, MIContainer.MovementDescId, MIContainer.Amount, tmpContainer.Amount_diff
                              FROM tmpContainer
                                   INNER JOIN MovementItemContainer AS MIContainer
                                                                    ON MIContainer.ContainerId = tmpContainer.ContainerId
                                                                   AND MIContainer.OperDate BETWEEN inStartDate AND inEndDate
                                                                   AND (MIContainer.isActive = FALSE OR MIContainer.MovementDescId = zc_Movement_Inventory())
                                                                   AND ABS (MIContainer.Amount) >= tmpContainer.Amount_diff
                             )
      , tmpList_Summ_sale AS (-- 
                              SELECT tmpListAll.ContainerId
                                   , MAX (ABS (tmpListAll.Amount)) AS Amount
                              FROM tmpListAll
                              WHERE tmpListAll.MovementDescId IN (zc_Movement_Sale(), zc_Movement_Loss(), zc_Movement_Inventory(), zc_Movement_ReturnOut())
                              GROUP BY tmpListAll.ContainerId
                             )
         , tmpListMI_sale AS (-- 
                              SELECT tmpListAll.ContainerId, MAX (tmpListAll.Id) AS Id
                              FROM tmpList_Summ_sale
                                   INNER JOIN tmpListAll ON tmpListAll.ContainerId  = tmpList_Summ_sale.ContainerId
                                                        AND ABS (tmpListAll.Amount) = ABS (tmpList_Summ_sale.Amount)
                                                        AND tmpListAll.MovementDescId IN (zc_Movement_Sale(), zc_Movement_Loss(), zc_Movement_Inventory(), zc_Movement_ReturnOut())
                              GROUP BY tmpListAll.ContainerId
                             )
       , tmpList_Summ_all AS (-- 
                              SELECT tmpListAll.ContainerId
                                   , MAX (ABS (tmpListAll.Amount)) AS Amount
                              FROM tmpListAll
                              WHERE tmpListAll.MovementDescId NOT IN (zc_Movement_Sale(), zc_Movement_Loss(), zc_Movement_Inventory(), zc_Movement_ReturnOut())
                              GROUP BY tmpListAll.ContainerId
                             )
          , tmpListMI_all AS (-- 
                              SELECT tmpListAll.ContainerId, MAX (tmpListAll.Id) AS Id
                              FROM tmpList_Summ_sale
                                   INNER JOIN tmpListAll ON tmpListAll.ContainerId  = tmpList_Summ_sale.ContainerId
                                                        AND ABS (tmpListAll.Amount) = ABS (tmpList_Summ_sale.Amount)
                                                        AND tmpListAll.MovementDescId NOT IN (zc_Movement_Sale(), zc_Movement_Loss(), zc_Movement_Inventory(), zc_Movement_ReturnOut())
                              GROUP BY tmpListAll.ContainerId
                             )

     -- ���������
     INSERT INTO _tmpDiff (OperDate, ContainerId, MovementItemId, Amount, Amount_diff)
        SELECT MIContainer.OperDate, tmpContainer.ContainerId, MIContainer.MovementItemId, MIContainer.Amount, tmpContainer.Amount_diff
        FROM tmpContainer
             LEFT JOIN tmpListMI_sale ON tmpListMI_sale.ContainerId = tmpContainer.ContainerId
             LEFT JOIN tmpListMI_all ON tmpListMI_all.ContainerId = tmpContainer.ContainerId
             LEFT JOIN MovementItemContainer AS MIContainer ON MIContainer.Id = COALESCE (tmpListMI_sale.Id, tmpListMI_all.Id)
       ;

     IF inIsUpdate = TRUE
     THEN
          -- ��������
          UPDATE HistoryCost SET MovementItemId_diff = NULL
                               , Summ_diff           = NULL
          WHERE inStartDate >= HistoryCost.StartDate AND inEndDate <= HistoryCost.EndDate
            AND Summ_diff <> 0
            ;
          -- ���������
          UPDATE HistoryCost SET MovementItemId_diff = _tmpDiff.MovementItemId
                               , Summ_diff           = _tmpDiff.Amount_diff
          FROM _tmpDiff
          WHERE HistoryCost.ContainerId = _tmpDiff.ContainerId
           AND _tmpDiff.OperDate BETWEEN HistoryCost.StartDate AND HistoryCost.EndDate
            ;
          -- ���������
          RETURN QUERY
             SELECT * FROM _tmpDiff
            ;
     ELSE
          -- ���������
          RETURN QUERY
             SELECT * FROM _tmpDiff
            ;
     END IF;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 08.08.15                                        *
*/

-- SELECT * FROM gpUpdate_HistoryCost_diff (inStartDate:= '01.07.2015', inEndDate:= '31.07.2015', inIsUpdate:= FALSE, inSession:= zfCalc_UserAdmin())