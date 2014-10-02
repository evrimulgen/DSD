-- Function: gpReport_Personal

DROP FUNCTION IF EXISTS gpReport_Personal (TDateTime, TDateTime, TDateTime, Boolean, Integer, Integer, Integer, Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpReport_Personal(
    IN inStartDate        TDateTime , --
    IN inEndDate          TDateTime , --
    IN inServiceDate      TDateTime , --
    IN inIsServiceDate    Boolean , --
    IN inAccountId        Integer,    -- ����
    IN inBranchId         Integer,    -- ����
    IN inInfoMoneyId      Integer,    -- �������������� ������
    IN inInfoMoneyGroupId Integer,    -- ������ �������������� ������
    IN inInfoMoneyDestinationId   Integer,    --
    IN inSession          TVarChar    -- ������ ������������
)
RETURNS TABLE (PersonalCode Integer, PersonalName TVarChar
             , UnitCode Integer, UnitName TVarChar
             , PositionCode Integer, PositionName TVarChar
             , BranchName TVarChar
             , InfoMoneyGroupName TVarChar, InfoMoneyDestinationName TVarChar, InfoMoneyCode Integer, InfoMoneyName TVarChar, InfoMoneyName_all TVarChar
             , AccountName TVarChar
             , ServiceDate TDateTime
             , StartAmount TFloat, StartAmountD TFloat, StartAmountK TFloat
             , DebetSumm TFloat, KreditSumm TFloat
             , MoneySumm TFloat, ServiceSumm TFloat
             , EndAmount TFloat, EndAmountD TFloat, EndAmountK TFloat
              )
AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId:= lpCheckRight (inSession, zc_Enum_Process_Select_...());
     inServiceDate:= DATE_TRUNC ('MONTH', inServiceDate);

     -- ���������
  RETURN QUERY
     SELECT
        Object_Personal.ObjectCode                                                                  AS PersonalCode,
        Object_Personal.ValueData                                                                   AS PersonalName,
        Object_Unit.ObjectCode                                                                      AS UnitCode,
        Object_Unit.ValueData                                                                       AS UnitName,
        Object_Position.ObjectCode                                                                  AS PositionCode,
        Object_Position.ValueData                                                                   AS PositionName,
        Object_Branch.ValueData                                                                     AS BranchName,
        Object_InfoMoney_View.InfoMoneyGroupName                                                    AS InfoMoneyGroupName,
        Object_InfoMoney_View.InfoMoneyDestinationName                                              AS InfoMoneyDestinationName,
        Object_InfoMoney_View.InfoMoneyCode                                                         AS InfoMoneyCode,
        Object_InfoMoney_View.InfoMoneyName                                                         AS InfoMoneyName,
        Object_InfoMoney_View.InfoMoneyName_all                                                     AS InfoMoneyName_all,
        Object_Account_View.AccountName_all                                                         AS AccountName,
        Operation.ServiceDate                                                                       AS ServiceDate,
        (-1 * Operation.StartAmount) :: TFloat                                                      AS StartAmount,
        CASE WHEN Operation.StartAmount > 0 THEN Operation.StartAmount ELSE 0 END ::TFloat          AS StartAmountD,
        CASE WHEN Operation.StartAmount < 0 THEN -1 * Operation.StartAmount ELSE 0 END :: TFloat    AS StartAmountK,
        Operation.DebetSumm :: TFloat                                                               AS DebetSumm,
        Operation.KreditSumm :: TFloat                                                              AS KreditSumm,
        Operation.MoneySumm :: TFloat                                                               AS MoneySumm,
        Operation.ServiceSumm :: TFloat                                                             AS ServiceSumm,
        (- 1 * Operation.EndAmount) :: TFloat                                                       AS EndAmount,
        CASE WHEN Operation.EndAmount > 0 THEN Operation.EndAmount ELSE 0 END :: TFloat             AS EndAmountD,
        CASE WHEN Operation.EndAmount < 0 THEN -1 * Operation.EndAmount ELSE 0 END :: TFloat        AS EndAmountK

     FROM
         (SELECT Operation_all.ContainerId, Operation_all.AccountId, Operation_all.PersonalId, Operation_all.InfoMoneyId, Operation_all.UnitId, Operation_all.PositionId
               , Operation_all.BranchId, Operation_all.ServiceDate
               , SUM (Operation_all.StartAmount) AS StartAmount
               , SUM (Operation_all.DebetSumm)   AS DebetSumm
               , SUM (Operation_all.KreditSumm)  AS KreditSumm
               , SUM (Operation_all.MoneySumm)   AS MoneySumm
               , SUM (Operation_all.ServiceSumm) AS ServiceSumm
               , SUM (Operation_all.EndAmount)   AS EndAmount
          FROM
          (SELECT tmpContainer.ContainerId
                , tmpContainer.AccountId
                , tmpContainer.PersonalId
                , tmpContainer.InfoMoneyId
                , tmpContainer.UnitId
                , tmpContainer.PositionId
                , tmpContainer.BranchId
                , tmpContainer.ServiceDate
                , tmpContainer.Amount - COALESCE (SUM (MIContainer.Amount), 0)                                                                                   AS StartAmount
                , SUM (CASE WHEN MIContainer.OperDate <= inEndDate THEN CASE WHEN MIContainer.Amount > 0 THEN MIContainer.Amount ELSE 0 END ELSE 0 END)          AS DebetSumm
                , SUM (CASE WHEN MIContainer.OperDate <= inEndDate THEN CASE WHEN MIContainer.Amount < 0 THEN -1 * MIContainer.Amount ELSE 0 END ELSE 0 END)     AS KreditSumm
                , SUM (CASE WHEN MIContainer.OperDate <= inEndDate THEN CASE WHEN Movement.DescId IN (zc_Movement_Cash(), zc_Movement_BankAccount()) THEN MIContainer.Amount ELSE 0 END ELSE 0 END) AS MoneySumm
                , SUM (CASE WHEN MIContainer.OperDate <= inEndDate THEN CASE WHEN Movement.DescId IN (zc_Movement_PersonalService()) THEN -1 * MIContainer.Amount ELSE 0 END ELSE 0 END)     AS ServiceSumm
                , tmpContainer.Amount - COALESCE (SUM (CASE WHEN MIContainer.OperDate > inEndDate THEN MIContainer.Amount ELSE 0 END), 0)                        AS EndAmount
            FROM (SELECT CLO_Personal.ContainerId AS ContainerId
                       , Container.ObjectId       AS AccountId
                       , Container.Amount
                       , CLO_Personal.ObjectId    AS PersonalId
                       , CLO_InfoMoney.ObjectId   AS InfoMoneyId
                       , CLO_Unit.ObjectId        AS UnitId
                       , CLO_Position.ObjectId    AS PositionId
                       , CLO_Branch.ObjectId      AS BranchId
                       , ObjectDate_Service.ValueData AS ServiceDate
                  FROM ContainerLinkObject AS CLO_Personal
                       INNER JOIN Container ON Container.Id = CLO_Personal.ContainerId AND Container.DescId = zc_Container_Summ()
                       INNER JOIN ContainerLinkObject AS CLO_InfoMoney
                                                      ON CLO_InfoMoney.ContainerId = Container.Id AND CLO_InfoMoney.DescId = zc_ContainerLinkObject_InfoMoney()
                       LEFT JOIN ContainerLinkObject AS CLO_Unit
                                                     ON CLO_Unit.ContainerId = Container.Id AND CLO_Unit.DescId = zc_ContainerLinkObject_Unit()
                       LEFT JOIN ContainerLinkObject AS CLO_Position
                                                     ON CLO_Position.ContainerId = Container.Id AND CLO_Position.DescId = zc_ContainerLinkObject_Position()
                       LEFT JOIN ContainerLinkObject AS CLO_Branch
                                                     ON CLO_Branch.ContainerId = Container.Id AND CLO_Branch.DescId = zc_ContainerLinkObject_Branch()
                       LEFT JOIN ContainerLinkObject AS CLO_ServiceDate
                                                     ON CLO_ServiceDate.ContainerId = CLO_Personal.ContainerId
                                                    AND CLO_ServiceDate.DescId = zc_ContainerLinkObject_ServiceDate()
                       LEFT JOIN Object_InfoMoney_View ON Object_InfoMoney_View.InfoMoneyId = CLO_InfoMoney.ObjectId
                       LEFT JOIN ObjectDate AS ObjectDate_Service
                                            ON ObjectDate_Service.ObjectId = CLO_ServiceDate.ObjectId
                                           AND ObjectDate_Service.DescId = zc_ObjectDate_ServiceDate_Value()
                  WHERE CLO_Personal.DescId = zc_ContainerLinkObject_Personal()
                    AND (Object_InfoMoney_View.InfoMoneyDestinationId = inInfoMoneyDestinationId OR inInfoMoneyDestinationId = 0)
                    AND (Object_InfoMoney_View.InfoMoneyId = inInfoMoneyId OR inInfoMoneyId = 0)
                    AND (Object_InfoMoney_View.InfoMoneyGroupId = inInfoMoneyGroupId OR inInfoMoneyGroupId = 0)
                    AND (Container.ObjectId = inAccountId OR inAccountId = 0)
                    AND (CLO_Branch.ObjectId = inBranchId OR inBranchId = 0)
                    AND (ObjectDate_Service.ValueData = inServiceDate OR inIsServiceDate = FALSE)
                  ) AS tmpContainer
                  LEFT JOIN MovementItemContainer AS MIContainer
                                                  ON MIContainer.Containerid = tmpContainer.ContainerId
                                                 AND MIContainer.OperDate >= inStartDate
                  LEFT JOIN Movement ON Movement.Id = MIContainer.MovementId
            GROUP BY tmpContainer.ContainerId, tmpContainer.AccountId, tmpContainer.PersonalId, tmpContainer.InfoMoneyId, tmpContainer.UnitId, tmpContainer.PositionId, tmpContainer.BranchId, tmpContainer.ServiceDate, tmpContainer.Amount

           ) AS Operation_all

          GROUP BY Operation_all.ContainerId, Operation_all.AccountId, Operation_all.PersonalId, Operation_all.InfoMoneyId, Operation_all.UnitId, Operation_all.PositionId, Operation_all.BranchId, Operation_all.ServiceDate
         ) AS Operation


     LEFT JOIN Object_Account_View ON Object_Account_View.AccountId = Operation.AccountId
     LEFT JOIN Object AS Object_Personal ON Object_Personal.Id = Operation.PersonalId
     LEFT JOIN Object AS Object_Unit ON Object_Unit.Id = Operation.UnitId
     LEFT JOIN Object AS Object_Position ON Object_Position.Id = Operation.PositionId
     LEFT JOIN Object AS Object_Branch ON Object_Branch.Id = Operation.BranchId

     LEFT JOIN Object_InfoMoney_View ON Object_InfoMoney_View.InfoMoneyId = Operation.InfoMoneyId

     WHERE (Operation.StartAmount <> 0 OR Operation.EndAmount <> 0 OR Operation.DebetSumm <> 0 OR Operation.KreditSumm <> 0);


END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpReport_Personal (TDateTime, TDateTime, TDateTime, Boolean, Integer, Integer, Integer, Integer, Integer, TVarChar) OWNER TO postgres;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 04.09.14                                                        *


*/

-- ����
-- SELECT * FROM gpReport_Personal (inStartDate:= '01.08.2014', inEndDate:= '05.08.2014', inServiceDate:= '05.08.2014', inIsServiceDate:= false, inAccountId:= 0, inBranchId:=0, inInfoMoneyId:= 0, inInfoMoneyGroupId:= 0, inInfoMoneyDestinationId:= 0, inSession:= '2');