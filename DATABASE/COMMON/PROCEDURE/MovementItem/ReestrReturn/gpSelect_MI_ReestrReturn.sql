-- Function: gpSelect_MI_ReestrReturn()

DROP FUNCTION IF EXISTS gpSelect_MI_ReestrReturn(Integer, Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_MI_ReestrReturn(
    IN inMovementId         Integer   ,
    IN inIsErased           Boolean   , --
    IN inSession            TVarChar    -- ������ ������������
)
RETURNS TABLE  (Id Integer, LineNum Integer
              , MemberId Integer, MemberCode Integer, MemberName TVarChar
              , InsertDate TDateTime
              , isErased Boolean
              , MovementId_ReturnIn Integer, BarCode_ReturnIn TVarChar
              , InvNumber_ReturnIn TVarChar, OperDate_ReturnIn TDateTime
              , StatusCode_ReturnIn Integer, StatusName_ReturnIn TVarChar
              , Checked Boolean
              , OperDatePartner TDateTime, InvNumberPartner TVarChar
              , TotalCountKg TFloat, TotalSumm TFloat
              , FromName TVarChar, ToName TVarChar
              , PaidKindName TVarChar
              , ContractCode Integer, ContractName TVarChar, ContractTagName TVarChar
              , JuridicalName_To TVarChar, OKPO_To TVarChar 
              , ReestrKindName TVarChar
              )
AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     vbUserId:= lpGetUserBySession (inSession);

      -- ���������
     RETURN QUERY
       WITH -- �������� ����� �������
            tmpMI AS (SELECT MovementItem.Id            AS MovementItemId
                           , MovementItem.ObjectId      AS MemberId
                           , MIDate_Insert.ValueData    AS InsertDate
                           , MovementFloat_MovementItemId.MovementId AS MovementId_ReturnIn
                           , MovementItem.isErased      AS isErased
                      FROM (SELECT FALSE AS isErased UNION ALL SELECT inIsErased AS isErased WHERE inIsErased = TRUE) AS tmpIsErased
                           INNER JOIN MovementItem ON MovementItem.MovementId = inMovementId
                                                  AND MovementItem.DescId     = zc_MI_Master()
                                                  AND MovementItem.isErased   = tmpIsErased.isErased
                           LEFT JOIN MovementItemDate AS MIDate_Insert
                                                      ON MIDate_Insert.MovementItemId = MovementItem.Id
                                                     AND MIDate_Insert.DescId = zc_MIDate_Insert()
                           LEFT JOIN MovementFloat AS MovementFloat_MovementItemId
                                                   ON MovementFloat_MovementItemId.ValueData = MovementItem.Id
                                                  AND MovementFloat_MovementItemId.DescId = zc_MovementFloat_MovementItemId()
                      )
       -- ���������
     SELECT  tmp.MovementItemId                           AS Id
           , CAST (ROW_NUMBER() OVER (ORDER BY tmp.MovementItemId) AS Integer) AS LineNum
           , tmp.MemberId                                 AS MemberId
           , Object_Member.ObjectCode                     AS MemberCode
           , Object_Member.ValueData                      AS MemberName
           , tmp.InsertDate                               AS InsertDate
           , tmp.isErased                                 AS isErased
           , Movement_ReturnIn.Id                             AS MovementId_ReturnIn
           , zfFormat_BarCode (zc_BarCodePref_Movement(), Movement_ReturnIn.Id) AS BarCode_ReturnIn
           , Movement_ReturnIn.InvNumber                      AS InvNumber_ReturnIn
           , Movement_ReturnIn.OperDate                       AS OperDate_ReturnIn
           , Object_Status.ObjectCode                     AS StatusCode_ReturnIn
           , Object_Status.ValueData                      AS StatusName_ReturnIn

           , COALESCE (MovementBoolean_Checked.ValueData, FALSE) AS Checked

           , MovementDate_OperDatePartner.ValueData        AS OperDatePartner
           , MovementString_InvNumberPartner.ValueData     AS InvNumberPartner

           , MovementFloat_TotalCountKg.ValueData          AS TotalCountKg
           , MovementFloat_TotalSumm.ValueData             AS TotalSumm

           , Object_From.ValueData                     AS FromName
           , Object_To.ValueData                       AS ToName
           , Object_PaidKind.ValueData                 AS PaidKindName
           , View_Contract_InvNumber.ContractCode      AS ContractCode
           , View_Contract_InvNumber.InvNumber         AS ContractName
           , View_Contract_InvNumber.ContractTagName
           , Object_JuridicalTo.ValueData              AS JuridicalName_To
           , ObjectHistory_JuridicalDetails_View.OKPO  AS OKPO_To

           , Object_ReestrKind.ValueData       	       AS ReestrKindName

       FROM tmpMI AS tmp
            LEFT JOIN Object AS Object_Member ON Object_Member.Id = tmp.MemberId

            LEFT JOIN Movement AS Movement_ReturnIn  ON Movement_ReturnIn.Id = tmp.MovementId_ReturnIn
            LEFT JOIN Object AS Object_Status ON Object_Status.Id = Movement_ReturnIn.StatusId

            LEFT JOIN MovementBoolean AS MovementBoolean_Checked
                                      ON MovementBoolean_Checked.MovementId = Movement_ReturnIn.Id
                                     AND MovementBoolean_Checked.DescId = zc_MovementBoolean_Checked()
            LEFT JOIN MovementDate AS MovementDate_OperDatePartner
                                   ON MovementDate_OperDatePartner.MovementId = Movement_ReturnIn.Id
                                  AND MovementDate_OperDatePartner.DescId = zc_MovementDate_OperDatePartner()
            LEFT JOIN MovementString AS MovementString_InvNumberPartner
                                     ON MovementString_InvNumberPartner.MovementId = Movement_ReturnIn.Id
                                    AND MovementString_InvNumberPartner.DescId = zc_MovementString_InvNumberPartner()

            LEFT JOIN MovementFloat AS MovementFloat_TotalSumm
                                    ON MovementFloat_TotalSumm.MovementId = Movement_ReturnIn.Id
                                   AND MovementFloat_TotalSumm.DescId = zc_MovementFloat_TotalSumm()
            LEFT JOIN MovementFloat AS MovementFloat_TotalCountKg
                                    ON MovementFloat_TotalCountKg.MovementId = Movement_ReturnIn.Id
                                   AND MovementFloat_TotalCountKg.DescId = zc_MovementFloat_TotalCountKg()

            LEFT JOIN MovementLinkObject AS MovementLinkObject_From
                                         ON MovementLinkObject_From.MovementId = Movement_ReturnIn.Id
                                        AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
            LEFT JOIN Object AS Object_From ON Object_From.Id = MovementLinkObject_From.ObjectId
            
            LEFT JOIN MovementLinkObject AS MovementLinkObject_To
                                         ON MovementLinkObject_To.MovementId = Movement_ReturnIn.Id
                                        AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
            LEFT JOIN Object AS Object_To ON Object_To.Id = MovementLinkObject_To.ObjectId

            LEFT JOIN ObjectLink AS ObjectLink_Partner_Juridical
                                 ON ObjectLink_Partner_Juridical.ObjectId = Object_From.Id
                                AND ObjectLink_Partner_Juridical.DescId = zc_ObjectLink_Partner_Juridical()
            LEFT JOIN Object AS Object_JuridicalTo ON Object_JuridicalTo.Id = ObjectLink_Partner_Juridical.ChildObjectId
            LEFT JOIN ObjectHistory_JuridicalDetails_View ON ObjectHistory_JuridicalDetails_View.JuridicalId = Object_JuridicalTo.Id
           
            LEFT JOIN MovementLinkObject AS MovementLinkObject_PaidKind
                                         ON MovementLinkObject_PaidKind.MovementId = Movement_ReturnIn.Id
                                        AND MovementLinkObject_PaidKind.DescId = zc_MovementLinkObject_PaidKind()
            LEFT JOIN Object AS Object_PaidKind ON Object_PaidKind.Id = MovementLinkObject_PaidKind.ObjectId

            LEFT JOIN MovementLinkObject AS MovementLinkObject_Contract
                                         ON MovementLinkObject_Contract.MovementId = Movement_ReturnIn.Id
                                        AND MovementLinkObject_Contract.DescId = zc_MovementLinkObject_Contract()
            LEFT JOIN Object_Contract_InvNumber_View AS View_Contract_InvNumber ON View_Contract_InvNumber.ContractId = MovementLinkObject_Contract.ObjectId

            LEFT JOIN MovementLinkObject AS MovementLinkObject_ReestrKind
                                         ON MovementLinkObject_ReestrKind.MovementId = Movement_ReturnIn.Id
                                        AND MovementLinkObject_ReestrKind.DescId = zc_MovementLinkObject_ReestrKind()
            LEFT JOIN Object AS Object_ReestrKind ON Object_ReestrKind.Id = MovementLinkObject_ReestrKind.ObjectId
           ;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 12.03.17         *
*/

-- ����
-- SELECT * FROM gpSelect_MI_ReestrReturn (inMovementId:= 4353346, inIsErased:= True, inSession:= zfCalc_UserAdmin())