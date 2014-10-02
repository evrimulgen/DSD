-- Function: gpReport_Founder

DROP FUNCTION IF EXISTS gpReport_Founder (TDateTime, TDateTime, Integer, Integer, Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpReport_Founder(
    IN inStartDate        TDateTime , --
    IN inEndDate          TDateTime , --
    IN inAccountId        Integer,    -- ����
    IN inInfoMoneyId      Integer,    -- �������������� ������
    IN inInfoMoneyGroupId Integer,    -- ������ �������������� ������
    IN inInfoMoneyDestinationId   Integer,    --
    IN inSession          TVarChar    -- ������ ������������
)
RETURNS TABLE (ContainerId Integer, FounderCode Integer, FounderName TVarChar
             , InfoMoneyGroupName TVarChar, InfoMoneyDestinationName TVarChar, InfoMoneyCode Integer, InfoMoneyName TVarChar
             , AccountName TVarChar
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

     -- ���������
  RETURN QUERY
     SELECT
        Operation.ContainerId,
        Object_Founder.ObjectCode                                                                   AS FounderCode,
        Object_Founder.ValueData                                                                    AS FounderName,
        Object_InfoMoney_View.InfoMoneyGroupName                                                    AS InfoMoneyGroupName,
        Object_InfoMoney_View.InfoMoneyDestinationName                                              AS InfoMoneyDestinationName,
        Object_InfoMoney_View.InfoMoneyCode                                                         AS InfoMoneyCode,
        Object_InfoMoney_View.InfoMoneyName                                                         AS InfoMoneyName,
        Object_Account_View.AccountName_all                                                         AS AccountName,

        Operation.StartAmount ::TFloat                                                              AS StartAmount,
        CASE WHEN Operation.StartAmount > 0 THEN Operation.StartAmount ELSE 0 END ::TFloat          AS StartAmountD,
        CASE WHEN Operation.StartAmount < 0 THEN -1 * Operation.StartAmount ELSE 0 END :: TFloat    AS StartAmountK,

        Operation.DebetSumm::TFloat                                                                 AS DebetSumm,
        Operation.KreditSumm::TFloat                                                                AS KreditSumm,
        Operation.MoneySumm :: TFloat                                                               AS MoneySumm,
        Operation.ServiceSumm :: TFloat                                                             AS ServiceSumm,

        Operation.EndAmount ::TFloat                                                                AS EndAmount,
        CASE WHEN Operation.EndAmount > 0 THEN Operation.EndAmount ELSE 0 END :: TFloat             AS EndAmountD,
        CASE WHEN Operation.EndAmount < 0 THEN -1 * Operation.EndAmount ELSE 0 END :: TFloat        AS EndAmountK


     FROM
         (SELECT Operation_all.ContainerId, Operation_all.ObjectId,  Operation_all.FounderId, Operation_all.InfoMoneyId,
                     SUM (Operation_all.StartAmount) AS StartAmount,
                     SUM (Operation_all.DebetSumm)   AS DebetSumm,
                     SUM (Operation_all.KreditSumm)  AS KreditSumm,
                     SUM (Operation_all.MoneySumm)   AS MoneySumm,
                     SUM (Operation_all.ServiceSumm) AS ServiceSumm,
                     SUM (Operation_all.EndAmount)   AS EndAmount
          FROM
          (SELECT tmpContainer.Id AS ContainerId, tmpContainer.ObjectId, tmpContainer.FounderId, tmpContainer.InfoMoneyId,
                     tmpContainer.Amount - COALESCE(SUM (MIContainer.Amount), 0)                                                                                AS StartAmount,
                     SUM (CASE WHEN MIContainer.OperDate <= inEndDate THEN CASE WHEN MIContainer.Amount > 0 THEN MIContainer.Amount ELSE 0 END ELSE 0 END)      AS DebetSumm,
                     SUM (CASE WHEN MIContainer.OperDate <= inEndDate THEN CASE WHEN MIContainer.Amount < 0 THEN -1 * MIContainer.Amount ELSE 0 END ELSE 0 END) AS KreditSumm,
                     SUM (CASE WHEN MIContainer.OperDate <= inEndDate THEN CASE WHEN Movement.DescId IN (zc_Movement_Cash(), zc_Movement_BankAccount()) THEN MIContainer.Amount ELSE 0 END ELSE 0 END) AS MoneySumm,
                     SUM (CASE WHEN MIContainer.OperDate <= inEndDate THEN CASE WHEN Movement.DescId IN (zc_Movement_FounderService()) THEN -1 * MIContainer.Amount ELSE 0 END ELSE 0 END)     AS ServiceSumm,
                     tmpContainer.Amount - COALESCE(SUM (CASE WHEN MIContainer.OperDate > inEndDate THEN MIContainer.Amount ELSE 0 END), 0)                     AS EndAmount
            FROM (SELECT CLO_Founder.ContainerId AS Id, Container.Amount, Container.ObjectId, CLO_Founder.ObjectId AS FounderId, CLO_InfoMoney.ObjectId AS InfoMoneyId
                  FROM ContainerLinkObject AS CLO_Founder
                  INNER JOIN Container ON Container.Id = CLO_Founder.ContainerId AND Container.DescId = zc_Container_Summ()
                  LEFT JOIN ContainerLinkObject AS CLO_InfoMoney
                                                ON CLO_InfoMoney.ContainerId = Container.Id AND CLO_InfoMoney.DescId = zc_ContainerLinkObject_InfoMoney()
                  LEFT JOIN Object_InfoMoney_View ON Object_InfoMoney_View.InfoMoneyId = CLO_InfoMoney.ObjectId
                  WHERE CLO_Founder.DescId = zc_ContainerLinkObject_Founder()
                    AND (Object_InfoMoney_View.InfoMoneyDestinationId = inInfoMoneyDestinationId OR inInfoMoneyDestinationId = 0)
                    AND (Object_InfoMoney_View.InfoMoneyId = inInfoMoneyId OR inInfoMoneyId = 0)
                    AND (Object_InfoMoney_View.InfoMoneyGroupId = inInfoMoneyGroupId OR inInfoMoneyGroupId = 0)
                    AND (Container.ObjectId = inAccountId OR inAccountId = 0)
                  ) AS tmpContainer
            LEFT JOIN MovementItemContainer AS MIContainer
                                            ON MIContainer.Containerid = tmpContainer.Id
                                           AND MIContainer.OperDate >= inStartDate
            LEFT JOIN Movement ON Movement.Id = MIContainer.MovementId
            GROUP BY tmpContainer.Id , tmpContainer.ObjectId, tmpContainer.FounderId, tmpContainer.InfoMoneyId, tmpContainer.Amount

           ) AS Operation_all

          GROUP BY Operation_all.ContainerId, Operation_all.ObjectId, Operation_all.FounderId, Operation_all.InfoMoneyId
         ) AS Operation


     LEFT JOIN Object_Account_View ON Object_Account_View.AccountId = Operation.ObjectId
     LEFT JOIN Object AS Object_Founder ON Object_Founder.Id = Operation.FounderId
     LEFT JOIN Object_InfoMoney_View ON Object_InfoMoney_View.InfoMoneyId = Operation.InfoMoneyId

     WHERE (Operation.StartAmount <> 0 OR Operation.EndAmount <> 0 OR Operation.DebetSumm <> 0 OR Operation.KreditSumm <> 0);


END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpReport_Founder (TDateTime, TDateTime, Integer, Integer, Integer, Integer, TVarChar) OWNER TO postgres;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 27.09.14                                        *
 10.09.14                                                        *
*/

-- ����
-- SELECT * FROM gpReport_Founder (inStartDate:= '01.08.2014', inEndDate:= '05.08.2014', inAccountId:= 0, inInfoMoneyId:= 0, inInfoMoneyGroupId:= 0, inInfoMoneyDestinationId:= 0, inSession:= '2');