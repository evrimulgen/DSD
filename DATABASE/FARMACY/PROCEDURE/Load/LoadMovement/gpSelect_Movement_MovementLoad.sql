-- Function: gpSelect_Movement_PriceList()

DROP FUNCTION IF EXISTS gpSelect_Movement_MovementLoad (TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Movement_MovementLoad(
    IN inSession       TVarChar    -- ������ ������������
)
RETURNS TABLE (Id Integer, OperDate TDateTime, InvNumber TVarChar
             , JuridicalId Integer, JuridicalName TVarChar
             , ContractId Integer, ContractName TVarChar
             , UnitId Integer, UnitName TVarChar
             , isAllGoodsConcat Boolean, NDSinPrice Boolean)

AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Select_Movement_PriceList());
--     vbUserId:= lpGetUserBySession (inSession);

     RETURN QUERY
       SELECT
             LoadMovement.Id
           , LoadMovement.OperDate	 -- ���� ���������
           , LoadMovement.InvNumber	 -- ����� ���������
           , Object_Juridical.Id         AS JuridicalId
           , Object_Juridical.ValueData  AS JuridicalName
           , Object_Contract.Id          AS ContractId
           , Object_Contract.ValueData   AS ContractName
           , Object_Unit.Id              AS UnitId
           , Object_Unit.ValueData       AS UnitName
           , LoadMovement.TotalCount           
           , LoadMovement.TotalSumm
           , LoadMovement.isAllGoodsConcat           
           , LoadMovement.NDSinPrice           
       FROM LoadPriceList
            LEFT JOIN Object AS Object_Unit ON Object_Unit.Id = LoadPriceList.UnitId
            LEFT JOIN Object AS Object_Juridical ON Object_Juridical.Id = LoadPriceList.JuridicalId
            LEFT JOIN Object AS Object_Contract ON Object_Contract.Id = LoadPriceList.ContractId;

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION gpSelect_Movement_MovementLoad (TVarChar) OWNER TO postgres;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 07.11.14                        *

*/

-- ����
-- SELECT * FROM gpSelect_Movement_PriceList (inStartDate:= '30.01.2014', inEndDate:= '01.02.2014', inIsErased := FALSE, inSession:= '2')