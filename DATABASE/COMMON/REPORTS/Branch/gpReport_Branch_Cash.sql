-- Function: gpReport_Branch_Cash()

DROP FUNCTION IF EXISTS gpReport_Branch_Cash (TDateTime, TDateTime,  Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpReport_Branch_Cash(
    IN inStartDate          TDateTime , --
    IN inEndDate            TDateTime , --
    IN inBranchId           Integer,    -- ������
    IN inSession            TVarChar    -- ������ ������������
)
RETURNS TABLE (BranchCode Integer, BranchName TVarChar
             , GroupId Integer, GroupName TVarChar
             --, InfoMoneyCode Integer, InfoMoneyName TVarChar
             , InfoMoneyName_all TVarChar
             , Amount TFloat
             --, StartAmount TFloat, StartAmountD TFloat, StartAmountK TFloat
             --, DebetSumm TFloat, KreditSumm TFloat
             --, EndAmount TFloat, EndAmountD TFloat, EndAmountK TFloat         
              )
AS
$BODY$
   DECLARE vbUserId Integer;

BEGIN
          vbUserId:= lpGetUserBySession (inSession);

    CREATE TEMP TABLE _tmpBranch (BranchId Integer) ON COMMIT DROP; 
    
    -- ������
    IF COALESCE(inBranchId,0) = 0
    THEN
     --RAISE EXCEPTION '������. �� ������ ������.';
       INSERT INTO _tmpBranch (BranchId)
           SELECT Object.Id AS BranchId FROM Object WHERE Object.DescId = zc_Object_Branch() and Object.Id <> zc_Branch_Basis();
    ELSE
       INSERT INTO _tmpBranch (BranchId)
           SELECT inBranchId;
    END IF;


    -- ���������
     RETURN QUERY
   WITH tmpCashList AS (SELECT Cash_Branch.ObjectId AS CashId 
                             , _tmpBranch.BranchId
                       FROM _tmpBranch
                            INNER JOIN ObjectLink AS Cash_Branch
                                                  ON Cash_Branch.ChildObjectId = _tmpBranch.BranchId
                                                 AND Cash_Branch.DescId = zc_ObjectLink_Cash_Branch()
                       ) 


      , tmpUnit_byProfitLoss AS (SELECT * FROM lfSelect_Object_Unit_byProfitLossDirection ())

, tmpAll AS (SELECT 
        CASE WHEN Operation.ContainerId > 0 AND Operation.isSaldo = TRUE THEN 1  
             WHEN Operation.ContainerId > 0 AND Operation.isSaldo = FALSE THEN 4  
             WHEN Operation.DebetSumm > 0 THEN 2
             WHEN Operation.KreditSumm > 0 THEN 3
             ELSE -1 END :: Integer AS GroupId,
             
        CASE WHEN Operation.ContainerId > 0 AND Operation.isSaldo = TRUE THEN '1.������ ���������' 
             WHEN Operation.ContainerId > 0 AND Operation.isSaldo = FALSE THEN '1.������ ��������'
             WHEN Operation.DebetSumm > 0 THEN '2.�����������' 
             WHEN Operation.KreditSumm > 0 THEN '3.�������' 
             ELSE '' END :: TVarChar AS GroupName,
        Object_Branch.ObjectCode                                                                    AS BranchCode,
        Object_Branch.ValueData                                                                     AS BranchName,
        
        Object_InfoMoney_View.InfoMoneyCode                                                         AS InfoMoneyCode,
        Object_InfoMoney_View.InfoMoneyName                                                         AS InfoMoneyName,
        Object_InfoMoney_View.InfoMoneyName_all                                                     AS InfoMoneyName_all,
  
        Operation.StartAmount ::TFloat                                                              AS StartAmount,
        CASE WHEN Operation.StartAmount > 0 THEN Operation.StartAmount ELSE 0 END ::TFloat          AS StartAmountD,
        CASE WHEN Operation.StartAmount < 0 THEN -1 * Operation.StartAmount ELSE 0 END :: TFloat    AS StartAmountK,
        Operation.DebetSumm::TFloat                                                                 AS DebetSumm,
        Operation.KreditSumm::TFloat                                                                AS KreditSumm,
        Operation.EndAmount ::TFloat                                                                AS EndAmount,
        CASE WHEN Operation.EndAmount > 0 THEN Operation.EndAmount ELSE 0 END :: TFloat             AS EndAmountD,
        CASE WHEN Operation.EndAmount < 0 THEN -1 * Operation.EndAmount ELSE 0 END :: TFloat        AS EndAmountK
     FROM
         (SELECT Operation_all.ContainerId, Operation_all.ObjectId, Operation_all.BranchId, Operation_all.InfoMoneyId, Operation_all.isSaldo,
                     SUM (Operation_all.StartAmount) AS StartAmount,
                     SUM (Operation_all.DebetSumm)   AS DebetSumm,
                     SUM (Operation_all.KreditSumm)  AS KreditSumm,
                     SUM (Operation_all.EndAmount)   AS EndAmount
          FROM
           -- �������
          (SELECT CLO_Cash.ContainerId      AS ContainerId,
                  Container.ObjectId        AS ObjectId,
                  tmpCashList.BranchId,
                  0                         AS InfoMoneyId,
                  Container.Amount - COALESCE(SUM (MIContainer.Amount), 0)  AS StartAmount,
                  0                         AS DebetSumm,
                  0                         AS KreditSumm,
                  0 AS EndAmount,
                  NULL :: Boolean           AS isActive,
                  True :: Boolean           AS isSaldo         --- true  ��������� , False ��������
          FROM tmpCashList
                  INNER JOIN ContainerLinkObject AS CLO_Cash
                                                 ON CLO_Cash.ObjectId = tmpCashList.CashId
                                                AND CLO_Cash.DescId = zc_ContainerLinkObject_Cash()
                  INNER JOIN Container ON Container.Id = CLO_Cash.ContainerId AND Container.DescId = zc_Container_Summ()
                  LEFT JOIN MovementItemContainer AS MIContainer ON MIContainer.Containerid = Container.Id
                                                                AND MIContainer.OperDate >= inStartDate
           GROUP BY CLO_Cash.ContainerId , Container.ObjectId, tmpCashList.BranchId, Container.Amount

           UNION ALL
           SELECT CLO_Cash.ContainerId      AS ContainerId,
                  Container.ObjectId        AS ObjectId,
                  tmpCashList.BranchId,
                  0                         AS InfoMoneyId,
                  0                         AS StartAmount,
                  0                         AS DebetSumm,
                  0                         AS KreditSumm,
                  Container.Amount - COALESCE(SUM (CASE WHEN MIContainer.OperDate > inEndDate THEN MIContainer.Amount ELSE 0 END), 0)  AS EndAmount,
                  NULL :: Boolean           AS isActive,
                  False :: Boolean          AS isSaldo         --- true  ��������� , False ��������
          FROM tmpCashList
                  INNER JOIN ContainerLinkObject AS CLO_Cash
                                                 ON CLO_Cash.ObjectId = tmpCashList.CashId
                                                AND CLO_Cash.DescId = zc_ContainerLinkObject_Cash()
                  INNER JOIN Container ON Container.Id = CLO_Cash.ContainerId AND Container.DescId = zc_Container_Summ()
                  LEFT JOIN MovementItemContainer AS MIContainer ON MIContainer.Containerid = Container.Id
                                                                AND MIContainer.OperDate >= inStartDate
           GROUP BY CLO_Cash.ContainerId , Container.ObjectId, tmpCashList.BranchId, Container.Amount

           UNION ALL
           -- ��������
           SELECT 0                                 AS ContainerId,
                  Container.ObjectId                AS ObjectId,
                  tmpCashList.BranchId,
                  MILO_InfoMoney.ObjectId           AS InfoMoneyId,
                  0                                 AS StartAmount,
                  SUM (CASE WHEN MIContainer.OperDate <= inEndDate THEN CASE WHEN MIContainer.Amount > 0 THEN MIContainer.Amount ELSE 0 END ELSE 0 END)         AS DebetSumm,
                  SUM (CASE WHEN MIContainer.OperDate <= inEndDate THEN CASE WHEN MIContainer.Amount < 0 THEN -1 * MIContainer.Amount ELSE 0 END ELSE 0 END)    AS KreditSumm,
                  0                                 AS EndAmount,
                  MIContainer.isActive,
                  NULL :: Boolean                  AS isSaldo     
           FROM tmpCashList
                  INNER JOIN ContainerLinkObject AS CLO_Cash
                                                 ON CLO_Cash.ObjectId = tmpCashList.CashId
                                                AND CLO_Cash.DescId = zc_ContainerLinkObject_Cash()
                  INNER JOIN Container ON Container.Id = CLO_Cash.ContainerId AND Container.DescId = zc_Container_Summ()
                  LEFT JOIN MovementItemContainer AS MIContainer ON MIContainer.Containerid = Container.Id
                                                                AND MIContainer.OperDate >= inStartDate
                  LEFT JOIN MovementItemLinkObject AS MILO_InfoMoney
                                                   ON MILO_InfoMoney.MovementItemId = MIContainer.MovementItemId
                                                  AND MILO_InfoMoney.DescId = zc_MILinkObject_InfoMoney()
                  LEFT JOIN Object_InfoMoney_View ON Object_InfoMoney_View.InfoMoneyId = MILO_InfoMoney.ObjectId
           GROUP BY CLO_Cash.ContainerId , Container.ObjectId, tmpCashList.BranchId, MILO_InfoMoney.ObjectId,
                    MIContainer.isActive
           ) AS Operation_all
          GROUP BY Operation_all.ContainerId, Operation_all.ObjectId, Operation_all.BranchId, Operation_all.InfoMoneyId,Operation_all.isActive, Operation_all.isSaldo
         ) AS Operation

     LEFT JOIN Object AS Object_Branch ON Object_Branch.Id = Operation.BranchId
     LEFT JOIN Object_InfoMoney_View ON Object_InfoMoney_View.InfoMoneyId = Operation.InfoMoneyId
     WHERE (Operation.StartAmount <> 0 OR Operation.EndAmount <> 0 OR Operation.DebetSumm <> 0 OR Operation.KreditSumm <> 0)
     )
     
     SELECT tmpAll.BranchCode,tmpAll.BranchName,
            tmpAll.GroupId, tmpAll.GroupName,
            tmpAll.InfoMoneyName_all,
            CASE WHEN tmpAll.GroupId = 1 THEN tmpAll.StartAmount 
                 WHEN tmpAll.GroupId = 4 THEN tmpAll.EndAmount
                 Else  tmpAll.DebetSumm + tmpAll.KreditSumm 
            END ::TFloat  AS Amount 

     FROM tmpAll
     ORDER BY tmpAll.BranchCode, tmpAll.Groupid
     ;


END;
$BODY$
  LANGUAGE plpgsql VOLATILE;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 10.11.15         * 

*/

-- ����
--SELECT * FROM gpReport_Branch_Cash (inStartDate:= '01.08.2015'::TDateTime, inEndDate:= '03.08.2015'::TDateTime, inBranchId:= 0, inSession:= zfCalc_UserAdmin())  --8374
--