-- Function: gpGet_Movement_Sale()

DROP FUNCTION IF EXISTS gpGet_Movement_Sale (Integer, TDateTime, TVarChar);

CREATE OR REPLACE FUNCTION gpGet_Movement_Sale(
    IN inMovementId        Integer  , -- ���� ���������
    IN inOperDate          TDateTime, -- ���� ���������
    IN inSession           TVarChar   -- ������ ������������
)
RETURNS TABLE (Id Integer
             , InvNumber TVarChar
             , OperDate TDateTime
             , StatusCode Integer
             , StatusName TVarChar
             , TotalCount TFloat
             , TotalSumm TFloat
             , TotalSummPrimeCost TFloat
             , UnitId Integer
             , UnitName TVarChar
             , JuridicalId Integer
             , JuridicalName TVarChar
             , PaidKindId Integer
             , PaidKindName TVarChar
             , Comment TVarChar

             , OperDateSP TDateTime
             , PartnerMedicalId Integer
             , PartnerMedicalName TVarChar
             , InvNumberSP TVarChar
             , MedicSPId   Integer
             , MedicSPName TVarChar
             , MemberSPId   Integer
             , MemberSPName TVarChar
             , GroupMemberSPId Integer
             , GroupMemberSPName TVarChar
             , SPKindId   Integer
             , SPKindName TVarChar
             )
AS
$BODY$
BEGIN

    -- �������� ���� ������������ �� ����� ���������
    -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Get_Movement_Sale());

    IF COALESCE (inMovementId, 0) = 0
    THEN
        RETURN QUERY
        SELECT
            0                                                AS Id
          , CAST (NEXTVAL ('movement_sale_seq') AS TVarChar) AS InvNumber
          , CURRENT_DATE::TDateTime                          AS OperDate
          , Object_Status.Code               	             AS StatusCode
          , Object_Status.Name              	             AS StatusName
          , 0::TFloat                                        AS TotalCount
          , 0::TFloat                                        AS TotalSumm
          , 0::TFloat                                        AS TotalSummPrimeCost
          , NULL::Integer                                    AS UnitId
          , NULL::TVarChar                                   AS UnitName
          , NULL::Integer                                    AS JuridicalId
          , NULL::TVarChar                                   AS JuridicalName
          , NULL::Integer                                    AS PaidKindId
          , NULL::TVarChar                                   AS PaidKindName
          , NULL::TVarChar                                   AS Comment

          , CURRENT_DATE::TDateTime                          AS OperDateSP
          , NULL::Integer                                    AS PartnerMedicalId
          , NULL::TVarChar                                   AS PartnerMedicalName
          , NULL::TVarChar                                   AS InvNumberSP
          , NULL::Integer                                    AS MedicSPId
          , NULL::TVarChar                                   AS MedicSPName
          , NULL::Integer                                    AS MemberSPId
          , NULL::TVarChar                                   AS MemberSPName

          , NULL::Integer                                    AS GroupMemberSPId
          , NULL::TVarChar                                   AS GroupMemberSPName

          , NULL::Integer                                    AS SPKindId
          , NULL::TVarChar                                   AS SPKindName 

        FROM lfGet_Object_Status(zc_Enum_Status_UnComplete()) AS Object_Status;
    ELSE
        RETURN QUERY
        SELECT
            Movement_Sale.Id
          , Movement_Sale.InvNumber
          , Movement_Sale.OperDate
          , Movement_Sale.StatusCode
          , Movement_Sale.StatusName
          , Movement_Sale.TotalCount
          , Movement_Sale.TotalSumm
          , Movement_Sale.TotalSummPrimeCost
          , Movement_Sale.UnitId
          , Movement_Sale.UnitName
          , Movement_Sale.JuridicalId
          , Movement_Sale.JuridicalName
          , Movement_Sale.PaidKindId
          , Movement_Sale.PaidKindName
          , Movement_Sale.Comment

          , COALESCE(Movement_Sale.OperDateSP, Movement_Sale.OperDate) :: TDateTime AS OperDateSP
          , Movement_Sale.PartnerMedicalId
          , Movement_Sale.PartnerMedicalName
          , Movement_Sale.InvNumberSP
          , Movement_Sale.MedicSPid
          , Movement_Sale.MedicSPName
          , Movement_Sale.MemberSPId
          , Movement_Sale.MemberSPName

          , Movement_Sale.GroupMemberSPId
          , Movement_Sale.GroupMemberSPName

          , Movement_Sale.SPKindId
          , Movement_Sale.SPKindName 
        FROM
            Movement_Sale_View AS Movement_Sale
        WHERE Movement_Sale.Id =  inMovementId;
    END IF;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpGet_Movement_Sale (Integer, TDateTime, TVarChar) OWNER TO postgres;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.  ��������� �.�.
 08.02.17         * add SP
 15.09.16         *
 13.10.15                                                                        *
*/
