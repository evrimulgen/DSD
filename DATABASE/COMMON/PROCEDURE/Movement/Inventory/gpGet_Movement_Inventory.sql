-- Function: gpGet_Movement_Inventory()

DROP FUNCTION IF EXISTS gpGet_Movement_Inventory (Integer, TVarChar);
DROP FUNCTION IF EXISTS gpGet_Movement_Inventory (Integer, TDateTime, TVarChar);

CREATE OR REPLACE FUNCTION gpGet_Movement_Inventory(
    IN inMovementId        Integer  , -- ���� ���������
    IN inOperDate          TDateTime , --
    IN inSession           TVarChar   -- ������ ������������
)
RETURNS TABLE (Id Integer, InvNumber TVarChar, OperDate TDateTime, StatusCode Integer, StatusName TVarChar
             , TotalCount TFloat, TotalSumm TFloat
             , FromId Integer, FromName TVarChar, ToId Integer, ToName TVarChar
             , GoodsGroupId Integer, GoodsGroupName TVarChar, isGoodsGroupIn Boolean, isGoodsGroupExc Boolean
             )
AS
$BODY$
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Get_Movement_Inventory());

     IF COALESCE (inMovementId, 0) = 0
     THEN
         RETURN QUERY
         SELECT
               0 AS Id
             , CAST (NEXTVAL ('Movement_Inventory_seq') AS TVarChar) AS InvNumber
--             , CAST (CURRENT_DATE as TDateTime) AS OperDate
             , inOperDate                       AS OperDate
             , Object_Status.Code               AS StatusCode
             , Object_Status.Name               AS StatusName
             , 0 :: TFloat                      AS TotalCount
             , 0 :: TFloat                      AS TotalSumm
             , 0                                AS FromId
             , CAST ('' as TVarChar)            AS FromName
             , 0                                AS ToId
             , CAST ('' as TVarChar)            AS ToName
             
             , 0                                AS GoodsGroupId
             , CAST ('' as TVarChar)            AS GoodsGroupName
  
             , CAST (FALSE as Boolean)          AS isGoodsGroupIn
             , CAST (FALSE as Boolean)          AS isGoodsGroupExc
             
          FROM lfGet_Object_Status(zc_Enum_Status_UnComplete()) AS Object_Status;

     ELSE
       RETURN QUERY
       SELECT
             Movement.Id                         AS Id
           , Movement.InvNumber                  AS InvNumber
           , Movement.OperDate                   AS OperDate
           , Object_Status.ObjectCode            AS StatusCode
           , Object_Status.ValueData             AS StatusName

           , MovementFloat_TotalCount.ValueData  AS TotalCount

           , MovementFloat_TotalSumm.ValueData   AS TotalSumm

           , Object_From.Id                      AS FromId
           , Object_From.ValueData               AS FromName
           , Object_To.Id                        AS ToId
           , Object_To.ValueData                 AS ToName

           , Object_GoodsGroup.Id                AS GoodsGroupId
           , Object_GoodsGroup.ValueData         AS GoodsGroupName
 
           , COALESCE (MovementBoolean_GoodsGroupIn.ValueData, FALSE)  :: Boolean AS isGoodsGroupIn
           , COALESCE (MovementBoolean_GoodsGroupExc.ValueData, FALSE) :: Boolean AS isGoodsGroupExc                        
       FROM Movement
            LEFT JOIN Object AS Object_Status ON Object_Status.Id = Movement.StatusId

            LEFT JOIN MovementFloat AS MovementFloat_TotalCount
                                    ON MovementFloat_TotalCount.MovementId =  Movement.Id
                                   AND MovementFloat_TotalCount.DescId = zc_MovementFloat_TotalCount()

            LEFT JOIN MovementFloat AS MovementFloat_TotalSumm
                                    ON MovementFloat_TotalSumm.MovementId =  Movement.Id
                                   AND MovementFloat_TotalSumm.DescId = zc_MovementFloat_TotalSumm()

            LEFT JOIN MovementBoolean AS MovementBoolean_GoodsGroupIn
                                      ON MovementBoolean_GoodsGroupIn.MovementId =  Movement.Id
                                     AND MovementBoolean_GoodsGroupIn.DescId = zc_MovementBoolean_GoodsGroupIn()

            LEFT JOIN MovementBoolean AS MovementBoolean_GoodsGroupExc
                                      ON MovementBoolean_GoodsGroupExc.MovementId =  Movement.Id
                                     AND MovementBoolean_GoodsGroupExc.DescId = zc_MovementBoolean_GoodsGroupExc()

            LEFT JOIN MovementLinkObject AS MovementLinkObject_From
                                         ON MovementLinkObject_From.MovementId = Movement.Id
                                        AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
            LEFT JOIN Object AS Object_From ON Object_From.Id = MovementLinkObject_From.ObjectId

            LEFT JOIN MovementLinkObject AS MovementLinkObject_To
                                         ON MovementLinkObject_To.MovementId = Movement.Id
                                        AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
            LEFT JOIN Object AS Object_To ON Object_To.Id = MovementLinkObject_To.ObjectId

            LEFT JOIN MovementLinkObject AS MovementLinkObject_GoodsGroup
                                         ON MovementLinkObject_GoodsGroup.MovementId = Movement.Id
                                        AND MovementLinkObject_GoodsGroup.DescId = zc_MovementLinkObject_GoodsGroup()
            LEFT JOIN Object AS Object_GoodsGroup ON Object_GoodsGroup.Id = MovementLinkObject_GoodsGroup.ObjectId

         WHERE Movement.Id = inMovementId
         AND Movement.DescId = zc_Movement_Inventory();

   END IF;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpGet_Movement_Inventory (Integer, TDateTime, TVarChar) OWNER TO postgres;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.
 27.01.14                                        * all
 18.07.13         *
*/

-- ����
-- SELECT * FROM gpGet_Movement_Inventory (inMovementId:= 1, inOperDate:= NULL, inSession:= '2')
