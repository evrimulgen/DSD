-- Function: gpSelect_Movement_PriceList()

DROP FUNCTION IF EXISTS gpReport_OrderGoodsSearch (Integer, TDateTime, TDateTime, TVarChar);

CREATE OR REPLACE FUNCTION gpReport_OrderGoodsSearch(
    IN inGoodsId       Integer     -- ����� �������
  , IN inStartDate     TDateTime 
  , IN inEndDate       TDateTime
  , IN inSession       TVarChar    -- ������ ������������
)
RETURNS TABLE (ItemName TVarChar, Amount TFloat, 
               Code Integer, Name TVarChar, 
               OperDate TDateTime, InvNumber TVarChar, 
               UnitName TVarChar, JuridicalName TVarChar, Price TFloat, StatusName TVarChar
             , OrderKindId Integer,  OrderKindName TVarChar)


AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Select_Movement_PriceList());
--     vbUserId:= lpGetUserBySession (inSession);

     RETURN QUERY
      SELECT MovementDesc.ItemName,  MovementItem.Amount, Object.ObjectCode, Object.ValueData, 
       Movement.OperDate, Movement.InvNumber, Object_Unit.ValueData, Object_From.ValueData, 
       MIFloat_Price.ValueData, Status.ValueData
           , Object_OrderKind.Id                                AS OrderKindId
           , Object_OrderKind.ValueData                         AS OrderKindName

 FROM Movement 
   JOIN Object AS Status ON Status.Id = Movement.StatusId AND Status.Id <> zc_Enum_Status_Erased()
   JOIN MovementItem ON MovementItem.MovementId = Movement.Id
   JOIN Object ON Object.Id = MovementItem.ObjectId
   JOIN MovementDesc ON MovementDesc.Id = Movement.DescId
                   LEFT JOIN MovementItemFloat AS MIFloat_Price
                                                   ON MIFloat_Price.MovementItemId = MovementItem.Id
                                                  AND MIFloat_Price.DescId = zc_MIFloat_Price()
                                                  AND Movement.DescId = zc_Movement_OrderExternal() 
   LEFT JOIN MovementLinkObject AS MovementLinkObject_Unit
                               ON MovementLinkObject_Unit.MovementId = Movement.Id
                              AND MovementLinkObject_Unit.DescId = zc_MovementLinkObject_Unit()
            LEFT JOIN MovementLinkObject AS MovementLinkObject_To
                                         ON MovementLinkObject_To.MovementId = Movement.Id
                                        AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()

            LEFT JOIN Object AS Object_Unit ON Object_Unit.Id = COALESCE(MovementLinkObject_Unit.ObjectId, MovementLinkObject_To.ObjectId)

            LEFT JOIN MovementLinkObject AS MovementLinkObject_From
                                         ON MovementLinkObject_From.MovementId = Movement.Id
                                        AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()

            LEFT JOIN Object AS Object_From ON Object_From.Id = MovementLinkObject_From.ObjectId

            LEFT JOIN MovementLinkObject AS MovementLinkObject_OrderKind
                                         ON MovementLinkObject_OrderKind.MovementId = Movement.Id
                                        AND MovementLinkObject_OrderKind.DescId = zc_MovementLinkObject_OrderKind()

            LEFT JOIN Object AS Object_OrderKind ON Object_OrderKind.Id = MovementLinkObject_OrderKind.ObjectId

   WHERE Movement.DescId in (zc_Movement_OrderInternal(), zc_Movement_OrderExternal())
     AND Movement.OperDate BETWEEN inStartDate AND inEndDate AND Object.Id = inGoodsId;

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION gpReport_OrderGoodsSearch (Integer, TDateTime, TDateTime, TVarChar) OWNER TO postgres;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 02.12.14                        *

*/

-- ����
-- SELECT * FROM gpSelect_Movement_PriceList (inStartDate:= '30.01.2014', inEndDate:= '01.02.2014', inIsErased := FALSE, inSession:= '2')