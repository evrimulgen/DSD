-- Function: gpGet_Movement_ReturnOut()

DROP FUNCTION IF EXISTS gpGet_Movement_ReturnOut (Integer, TVarChar);


CREATE OR REPLACE FUNCTION gpGet_Movement_ReturnOut(
    IN inMovementId        Integer  , -- ���� ���������
    IN inSession           TVarChar   -- ������ ������������
)
RETURNS TABLE (Id Integer
             , InvNumber TVarChar
             , InvNumberPartner TVarChar
             , OperDate TDateTime
             , OperDatePartner TDateTime
             , StatusCode Integer, StatusName TVarChar
             , PriceWithVAT Boolean
             , FromId Integer, FromName TVarChar
             , ToId Integer, ToName TVarChar
             , NDSKindId Integer, NDSKindName TVarChar
             , IncomeOperDate TDateTime, IncomeInvNumber TVarChar
              )
AS
$BODY$
  DECLARE vbUserId Integer;
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId := PERFORM lpCheckRight (inSession, zc_Enum_Process_Get_Movement_ReturnOut());
     vbUserId := inSession;

     IF COALESCE (inMovementId, 0) = 0
     THEN
     RETURN QUERY
         SELECT
               0                                                AS Id
             , CAST (NEXTVAL ('movement_ReturnOut_seq') AS TVarChar) AS InvNumber
             , ''::TVarChar                                     AS InvNumberPartner
             , CURRENT_DATE::TDateTime                          AS OperDate
             , CURRENT_DATE::TDateTime                          AS OperDatePartner
             , Object_Status.Code                               AS StatusCode
             , Object_Status.Name                               AS StatusName
             , CAST (False as Boolean)                          AS PriceWithVAT
             , 0                     				AS FromId
             , CAST ('' AS TVarChar) 			        AS FromName
             , 0                     				AS ToId
             , CAST ('' AS TVarChar) 				AS ToName
             , 0                     			        AS NDSKindId
             , CAST ('' AS TVarChar) 				AS NDSKindName
             , CURRENT_DATE::TDateTime                          AS IncomeOperDate
             , ''::TVarChar                                     AS IncomeInvNumber
          FROM lfGet_Object_Status(zc_Enum_Status_UnComplete()) AS Object_Status;

     ELSE

     RETURN QUERY
       SELECT
             Movement_ReturnOut_View.Id
           , Movement_ReturnOut_View.InvNumber
           , Movement_ReturnOut_View.InvNumberPartner
           , Movement_ReturnOut_View.OperDate
           , Movement_ReturnOut_View.OperDatePartner
           , Movement_ReturnOut_View.StatusCode
           , Movement_ReturnOut_View.StatusName
           , Movement_ReturnOut_View.PriceWithVAT
           , Movement_ReturnOut_View.FromId
           , Movement_ReturnOut_View.FromName
           , Movement_ReturnOut_View.ToId
           , Movement_ReturnOut_View.ToName
           , Movement_ReturnOut_View.NDSKindId
           , Movement_ReturnOut_View.NDSKindName
           , Movement_ReturnOut_View.IncomeOperDate
           , Movement_ReturnOut_View.IncomeInvNumber

       FROM Movement_ReturnOut_View       
      WHERE Movement_ReturnOut_View.Id = inMovementId;

       END IF;

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION gpGet_Movement_ReturnOut (Integer, TVarChar) OWNER TO postgres;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 03.07.14                                                        *
*/

-- ����
-- SELECT * FROM gpGet_Movement_ReturnOut (inMovementId:= 1, inSession:= '9818')