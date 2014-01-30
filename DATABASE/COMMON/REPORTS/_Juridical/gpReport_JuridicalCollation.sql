-- Function: gpReport_JuridicalCollation()

DROP FUNCTION IF EXISTS gpReport_JuridicalCollation (TDateTime, TDateTime, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpReport_JuridicalCollation(
    IN inStartDate        TDateTime , -- 
    IN inEndDate          TDateTime , --
    IN inJuridicalId      Integer,    -- ����������� ����  
    IN inSession          TVarChar    -- ������ ������������
)
RETURNS TABLE (MovementSumm TFloat, 
               Debet TFloat, 
               Kredit TFloat, 
               OperDate TDateTime, 
               InvNumber TVarChar, 
               AccountCode Integer,
               AccountName TVarChar,
               ContractName TVarChar,
               InfoMoneyGroupCode Integer,
               InfoMoneyGroupName TVarChar,
               InfoMoneyDestinationCode Integer,
               InfoMoneyDestinationName TVarChar,
               InfoMoneyCode Integer,
               InfoMoneyName TVarChar,
               MovementId Integer, 
               ItemName TVarChar)
AS
$BODY$
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Report_Fuel());

     -- ���� ������, ������� ������� ������� � ��������. 
     -- ������� ������ - ����� ����������. �������� ���������� �� ������ ������ 20400 ��� ������� � 30500 ��� �������� �������
  RETURN QUERY  
  SELECT 
          Operation.MovementSumm::TFloat,
          (CASE WHEN Operation.MovementSumm > 0 THEN Operation.MovementSumm ELSE 0 END)::TFloat AS Debet,
          (CASE WHEN Operation.MovementSumm > 0 THEN 0 ELSE - Operation.MovementSumm END)::TFloat AS Kredit,
          Movement.OperDate,
          Movement.InvNumber, 
          Account.ObjectCode        AS AccountCode,
          Account.ValueData         AS AccountName,
          Contract.ValueData        AS ContractName,
          Object_InfoMoney_View.InfoMoneyGroupCode,
          Object_InfoMoney_View.InfoMoneyGroupName,
          Object_InfoMoney_View.InfoMoneyDestinationCode,
          Object_InfoMoney_View.InfoMoneyDestinationName,
          Object_InfoMoney_View.InfoMoneyCode,
          Object_InfoMoney_View.InfoMoneyName,
          Movement.Id               AS MovementId, 
          MovementDesc.ItemName
    FROM (SELECT 
           CLO_Contract.ObjectId AS ContractId, 
           CLO_InfoMoney.ObjectId AS InfoMoneyId, 
           MIContainer.MovementId, 
           Container.ObjectId AS AccountId, 
           SUM(MIContainer.Amount) AS MovementSumm
      FROM ContainerLinkObject AS CLO_Juridical 
      JOIN Container ON Container.Id = CLO_Juridical.ContainerId
      JOIN MovementItemContainer AS MIContainer 
        ON MIContainer.Containerid = Container.Id
 LEFT JOIN ContainerLinkObject AS CLO_InfoMoney
        ON CLO_InfoMoney.ContainerId = Container.Id
       AND CLO_InfoMoney.DescId = zc_ContainerLinkObject_InfoMoney()  
 LEFT JOIN ContainerLinkObject AS CLO_Contract
        ON CLO_Contract.ContainerId = Container.Id
       AND CLO_Contract.DescId = zc_ContainerLinkObject_Contract()  
       AND MIContainer.OperDate BETWEEN inStartDate AND inEndDate
    WHERE CLO_Juridical.ObjectId = inJuridicalId AND inJuridicalId <> 0 
  -- WHERE CLO_Juridical.DescId = zc_ContainerLinkObject_Juridical() 
  GROUP BY ContractId, AccountId, MIContainer.MovementId, InfoMoneyId
    HAVING SUM(MIContainer.Amount) <> 0) AS Operation
      JOIN Object AS Account ON Account.Id = Operation.AccountId
      JOIN Object_InfoMoney_View ON Object_InfoMoney_View.InfoMoneyId = Operation.InfoMoneyId
      JOIN Object AS Contract ON Contract.Id = Operation.ContractId
      JOIN Movement ON Movement.Id = Operation.MovementId
      JOIN MovementDesc ON Movement.DescId = MovementDesc.Id;
                                  
    -- �����. �������� ��������� ������. 
    -- ����� �������

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpReport_JuridicalCollation (TDateTime, TDateTime, Integer, TVarChar) OWNER TO postgres;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 25.01.14                        * 
 15.01.14                        * 
*/

-- ����
-- SELECT * FROM gpReport_Fuel (inStartDate:= '01.01.2013', inEndDate:= '01.02.2013', inFuelId:= null, inCarId:= null, inBranchId:= null,inSession:= '2'); 
                                                                
