-- Function: gpSelect_MI_Reestr()

DROP FUNCTION IF EXISTS gpSelect_MI_Reestr(Integer, TVarChar);
DROP FUNCTION IF EXISTS gpSelect_MI_Reestr(Integer, Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_MI_Reestr(
    IN inMovementId         Integer   ,
    IN inIsErased           Boolean   , --
    IN inSession            TVarChar    -- ������ ������������
)
RETURNS TABLE ( Id Integer, MemberId Integer, OperDate TDateTime, isErased Boolean
             , MovementId_Sale Integer, InvNumber_Sale TVarChar, OperDate_Sale TDateTime--, StatusCode Integer, StatusName TVarChar
             , Checked Boolean
             --, PriceWithVAT Boolean

             , OperDatePartner TDateTime, InvNumberPartner TVarChar
             , TotalSumm TFloat
             , InvNumberOrder TVarChar
             , FromId Integer, FromName TVarChar, ToId Integer, ToName TVarChar
             , PaidKindId Integer, PaidKindName TVarChar
             , ContractId Integer, ContractCode Integer, ContractName TVarChar, ContractTagName TVarChar
             , JuridicalName_To TVarChar, OKPO_To TVarChar
           --  , PersonalName TVarChar
             --
             , InvNumber_Transport TVarChar, OperDate_Transport TDateTime, InvNumber_Transport_Full TVarChar
             , CarName TVarChar, CarModelName TVarChar, PersonalDriverName TVarChar
             
             , InsertDate TDateTime
             , Comment TVarChar
             , ReestrKindId Integer, ReestrKindName TVarChar
             
             , InvNumber_ReestrFull TVarChar
              )
AS
$BODY$
   DECLARE vbUserId Integer;
   
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     vbUserId:= lpGetUserBySession (inSession);

     -- ���������
     RETURN QUERY
       WITH tmpMI AS (SELECT MovementItem.Id            AS MovementItemId
                           , MovementItem.ObjectId      AS MemberId
                           , MIDate_Insert.ValueData    AS OperDate
                           , MovementItem.isErased      AS isErased
                      FROM (SELECT FALSE AS isErased UNION ALL SELECT inIsErased AS isErased WHERE inIsErased = TRUE) AS tmpIsErased
                           INNER JOIN MovementItem ON MovementItem.MovementId = inMovementId
                                                  AND MovementItem.DescId     = zc_MI_Master()
                                                  AND MovementItem.isErased   = tmpIsErased.isErased
                           LEFT JOIN MovementItemDate AS MIDate_Insert
                                                      ON MIDate_Insert.MovementItemId = MovementItem.Id
                                                     AND MIDate_Insert.DescId = zc_MIDate_Insert()
                      )
     SELECT  tmp.MovementItemId                           AS Id
           , tmp.MemberId                                 AS MemberId
           , tmp.OperDate                                 AS OperDate
           , tmp.isErased                                 AS isErased
           , Movement_Sale.Id                                    AS MovementId_Sale
           , Movement_Sale.InvNumber                             AS InvNumber_Sale
--           , zfConvert_StringToNumber (Movement.InvNumber)  AS InvNumber
           , Movement_Sale.OperDate                              AS OperDate_Sale
       --    , Object_Status.ObjectCode                       AS StatusCode
         --  , Object_Status.ValueData                        AS StatusName
           , COALESCE (MovementBoolean_Checked.ValueData, FALSE) AS Checked
        --   , MovementBoolean_PriceWithVAT.ValueData         AS PriceWithVAT

           , MovementDate_OperDatePartner.ValueData         AS OperDatePartner
           , MovementString_InvNumberPartner.ValueData      AS InvNumberPartner

           , MovementFloat_TotalSumm.ValueData              AS TotalSumm

           , MovementString_InvNumberOrder.ValueData        AS InvNumberOrder
           , Object_From.Id                                 AS FromId
           , Object_From.ValueData                          AS FromName
           , Object_To.Id                                   AS ToId
           , Object_To.ValueData                            AS ToName
           , Object_PaidKind.Id                             AS PaidKindId
           , Object_PaidKind.ValueData                      AS PaidKindName
           , View_Contract_InvNumber.ContractId             AS ContractId
           , View_Contract_InvNumber.ContractCode           AS ContractCode
           , View_Contract_InvNumber.InvNumber              AS ContractName
           , View_Contract_InvNumber.ContractTagName
           , Object_JuridicalTo.ValueData                   AS JuridicalName_To
           , ObjectHistory_JuridicalDetails_View.OKPO       AS OKPO_To

          -- , Object_Personal.ValueData                      AS PersonalName

           , Movement_Transport.InvNumber              AS InvNumber_Transport
           , Movement_Transport.OperDate               AS OperDate_Transport
           , ('� ' || Movement_Transport.InvNumber || ' �� ' || Movement_Transport.OperDate  :: Date :: TVarChar ) :: TVarChar  AS InvNumber_Transport_Full 
           , Object_Car.ValueData                      AS CarName
           , Object_CarModel.ValueData                 AS CarModelName
           , View_PersonalDriver.PersonalName          AS PersonalDriverName
 
           , MovementDate_Insert.ValueData          AS InsertDate
           , MovementString_Comment.ValueData       AS Comment

           , Object_ReestrKind.Id             	    AS ReestrKindId
           , Object_ReestrKind.ValueData       	    AS ReestrKindName

           , zfCalc_PartionMovementName (Movement_Reestr.DescId, MovementDesc_Reestr.ItemName, Movement_Reestr.InvNumber, Movement_Reestr.OperDate) :: TVarChar AS InvNumber_ReestrFull


       FROM (SELECT tmpMI.MovementItemId
                 , tmpMI.MemberId
                 , tmpMI.OperDate
                 , tmpMI.isErased
                 , MovementFloat_MovementItemId.MovementId AS MovementId_Sale
             FROM tmpMI
                 INNER JOIN MovementFloat AS MovementFloat_MovementItemId
                                          ON MovementFloat_MovementItemId.ValueData ::integer = tmpMI.MovementItemId
                                         AND MovementFloat_MovementItemId.DescId = zc_MovementFloat_MovementItemId()
            ) AS tmp
            INNER JOIN Movement AS Movement_Sale  ON Movement_Sale.id = tmp.MovementId_Sale  -- ���. �������
--            LEFT JOIN Object AS Object_Status ON Object_Status.Id = Movement.StatusId


            LEFT JOIN MovementBoolean AS MovementBoolean_Checked
                                      ON MovementBoolean_Checked.MovementId =  Movement_Sale.Id
                                     AND MovementBoolean_Checked.DescId = zc_MovementBoolean_Checked()

            LEFT JOIN MovementDate AS MovementDate_Insert
                                   ON MovementDate_Insert.MovementId = Movement_Sale.Id
                                  AND MovementDate_Insert.DescId = zc_MovementDate_Insert()

            LEFT JOIN MovementDate AS MovementDate_OperDatePartner
                                   ON MovementDate_OperDatePartner.MovementId = Movement_Sale.Id
                                  AND MovementDate_OperDatePartner.DescId = zc_MovementDate_OperDatePartner()
            LEFT JOIN MovementString AS MovementString_InvNumberPartner
                                     ON MovementString_InvNumberPartner.MovementId = Movement_Sale.Id
                                    AND MovementString_InvNumberPartner.DescId = zc_MovementString_InvNumberPartner()

            LEFT JOIN MovementString AS MovementString_Comment 
                                     ON MovementString_Comment.MovementId = Movement_Sale.Id
                                    AND MovementString_Comment.DescId = zc_MovementString_Comment()

            LEFT JOIN MovementFloat AS MovementFloat_TotalSumm
                                    ON MovementFloat_TotalSumm.MovementId = Movement_Sale.Id
                                   AND MovementFloat_TotalSumm.DescId = zc_MovementFloat_TotalSumm()

            LEFT JOIN MovementString AS MovementString_InvNumberOrder
                                     ON MovementString_InvNumberOrder.MovementId = Movement_Sale.Id
                                    AND MovementString_InvNumberOrder.DescId = zc_MovementString_InvNumberOrder()

            LEFT JOIN MovementLinkObject AS MovementLinkObject_From
                                         ON MovementLinkObject_From.MovementId = Movement_Sale.Id
                                        AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
            LEFT JOIN Object AS Object_From ON Object_From.Id = MovementLinkObject_From.ObjectId
            
            LEFT JOIN MovementLinkObject AS MovementLinkObject_To
                                         ON MovementLinkObject_To.MovementId = Movement_Sale.Id
                                        AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
            LEFT JOIN Object AS Object_To ON Object_To.Id = MovementLinkObject_To.ObjectId

            LEFT JOIN ObjectLink AS ObjectLink_Partner_Juridical
                                 ON ObjectLink_Partner_Juridical.ObjectId = Object_To.Id
                                AND ObjectLink_Partner_Juridical.DescId = zc_ObjectLink_Partner_Juridical()
            LEFT JOIN Object AS Object_JuridicalTo ON Object_JuridicalTo.Id = ObjectLink_Partner_Juridical.ChildObjectId
            LEFT JOIN ObjectHistory_JuridicalDetails_View ON ObjectHistory_JuridicalDetails_View.JuridicalId = Object_JuridicalTo.Id
           
            LEFT JOIN MovementLinkObject AS MovementLinkObject_PaidKind
                                         ON MovementLinkObject_PaidKind.MovementId = Movement_Sale.Id
                                        AND MovementLinkObject_PaidKind.DescId = zc_MovementLinkObject_PaidKind()
            LEFT JOIN Object AS Object_PaidKind ON Object_PaidKind.Id = MovementLinkObject_PaidKind.ObjectId

            LEFT JOIN MovementLinkObject AS MovementLinkObject_Contract
                                         ON MovementLinkObject_Contract.MovementId = Movement_Sale.Id
                                        AND MovementLinkObject_Contract.DescId = zc_MovementLinkObject_Contract()
            LEFT JOIN Object_Contract_InvNumber_View AS View_Contract_InvNumber ON View_Contract_InvNumber.ContractId = MovementLinkObject_Contract.ObjectId
            LEFT JOIN Object_InfoMoney_View AS View_InfoMoney ON View_InfoMoney.InfoMoneyId = View_Contract_InvNumber.InfoMoneyId

            LEFT JOIN MovementLinkMovement AS MovementLinkMovement_Transport
                                           ON MovementLinkMovement_Transport.MovementId = Movement_Sale.Id
                                          AND MovementLinkMovement_Transport.DescId = zc_MovementLinkMovement_Transport()
            LEFT JOIN Movement AS Movement_Transport ON Movement_Transport.Id = MovementLinkMovement_Transport.MovementChildId

            LEFT JOIN MovementLinkObject AS MovementLinkObject_ReestrKind
                                         ON MovementLinkObject_ReestrKind.MovementId = Movement_Sale.Id
                                        AND MovementLinkObject_ReestrKind.DescId = zc_MovementLinkObject_ReestrKind()
            LEFT JOIN Object AS Object_ReestrKind ON Object_ReestrKind.Id = MovementLinkObject_ReestrKind.ObjectId

            LEFT JOIN MovementLinkObject AS MovementLinkObject_Car
                                         ON MovementLinkObject_Car.MovementId = Movement_Transport.Id
                                        AND MovementLinkObject_Car.DescId = zc_MovementLinkObject_Car()
            LEFT JOIN Object AS Object_Car ON Object_Car.Id = MovementLinkObject_Car.ObjectId

            LEFT JOIN ObjectLink AS ObjectLink_Car_CarModel ON ObjectLink_Car_CarModel.ObjectId = Object_Car.Id
                                                           AND ObjectLink_Car_CarModel.DescId = zc_ObjectLink_Car_CarModel()
            LEFT JOIN Object AS Object_CarModel ON Object_CarModel.Id = ObjectLink_Car_CarModel.ChildObjectId
            
            LEFT JOIN MovementLinkObject AS MovementLinkObject_PersonalDriver
                                         ON MovementLinkObject_PersonalDriver.MovementId = Movement_Transport.Id
                                        AND MovementLinkObject_PersonalDriver.DescId = zc_MovementLinkObject_PersonalDriver()
            LEFT JOIN Object_Personal_View AS View_PersonalDriver ON View_PersonalDriver.PersonalId = MovementLinkObject_PersonalDriver.ObjectId
--
          
            LEFT JOIN Movement AS Movement_Reestr ON Movement_Reestr.Id = inMovementId
            LEFT JOIN MovementDesc AS MovementDesc_Reestr ON MovementDesc_Reestr.Id = Movement_Reestr.DescId

    ;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 21.10.16         * 
*/

-- ����
-- SELECT * FROM gpSelect_MI_Reestr (inMovementId:= 4353346, inIsErased:= True, inSession:= zfCalc_UserAdmin())