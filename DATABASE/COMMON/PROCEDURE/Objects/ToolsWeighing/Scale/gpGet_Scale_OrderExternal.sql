-- Function: gpGet_Scale_OrderExternal()

DROP FUNCTION IF EXISTS gpSelect_Scale_OrderExternal (TDateTime, TVarChar, TVarChar);
DROP FUNCTION IF EXISTS gpGet_Scale_OrderExternal (TDateTime, TVarChar, TVarChar);

CREATE OR REPLACE FUNCTION gpGet_Scale_OrderExternal(
    IN inOperDate    TDateTime   ,
    IN inBarCode     TVarChar    ,
    IN inSession     TVarChar      -- ������ ������������
)
RETURNS TABLE (MovementId       Integer
             , BarCode          TVarChar
             , InvNumber        TVarChar
             , InvNumberPartner TVarChar

             , MovementDescId Integer
             , FromId         Integer, FromCode         Integer, FromName       TVarChar
             , ToId           Integer, ToCode           Integer, ToName         TVarChar
             , PaidKindId     Integer, PaidKindName   TVarChar

             , PriceListId    Integer, PriceListCode  Integer, PriceListName TVarChar
             , ContractId     Integer, ContractCode   Integer, ContractNumber TVarChar, ContractTagName TVarChar

             , PartnerId_calc   Integer
             , PartnerCode_calc Integer
             , PartnerName_calc TVarChar
             , ChangePercent    TFloat
             , ChangePercentAmount TFloat
             , isEdiOrdspr      Boolean
             , isEdiInvoice     Boolean
             , isEdiDesadv      Boolean

             , OrderExternalName_master TVarChar
              )
AS
$BODY$
   DECLARE vbUserId     Integer;
BEGIN
   -- �������� ���� ������������ �� ����� ���������
   -- vbUserId:= lpGetUserBySession (inSession);


    -- ���������
    RETURN QUERY
       SELECT Movement.Id                                    AS MovementId
            , inBarCode                                      AS BarCode
            , Movement.InvNumber                             AS InvNumber
            , MovementString_InvNumberPartner.ValueData      AS InvNumberPartner

            , zc_Movement_Sale()                             AS MovementDescId
            , Object_From.Id                                 AS FromId
            , Object_From.ObjectCode                         AS FromCode
            , Object_From.ValueData                          AS FromName
            , Object_To.Id                                   AS ToId
            , Object_To.ObjectCode                           AS ToCode
            , Object_To.ValueData                            AS ToName
            , Object_PaidKind.Id                             AS PaidKindId
            , Object_PaidKind.ValueData                      AS PaidKindName

            , Object_PriceList.Id                            AS PriceListId
            , Object_PriceList.ObjectCode                    AS PriceListCode
            , Object_PriceList.ValueData                     AS PriceListName
            , View_Contract_InvNumber.ContractId             AS ContractId
            , View_Contract_InvNumber.ContractCode           AS ContractCode
            , View_Contract_InvNumber.InvNumber              AS ContractNumber
            , View_Contract_InvNumber.ContractTagName        AS ContractTagName

            , Object_From.Id         AS PartnerId_calc
            , Object_From.ObjectCode AS PartnerCode_calc
            , Object_From.ValueData  AS PartnerName_calc
            , MovementFloat_ChangePercent.ValueData AS ChangePercent
            , (SELECT tmp.ChangePercentAmount FROM gpGet_Scale_Partner (inOperDate, -1 * Object_From.Id, inSession) AS tmp WHERE tmp.ContractId = View_Contract_InvNumber.ContractId) AS ChangePercentAmount

            , COALESCE (ObjectBoolean_Partner_EdiOrdspr.ValueData, FALSE)  :: Boolean AS isEdiOrdspr
            , COALESCE (ObjectBoolean_Partner_EdiInvoice.ValueData, FALSE) :: Boolean AS isEdiInvoice
            , COALESCE (ObjectBoolean_Partner_EdiDesadv.ValueData, FALSE)  :: Boolean AS isEdiDesadv

            , ('� <' || Movement.InvNumber || '>' || ' �� <' || DATE (Movement.OperDate) :: TVarChar || '>') :: TVarChar AS OrderExternalName_master

       FROM (SELECT Movement.Id, Movement.InvNumber, Movement.DescId, Movement.OperDate FROM (SELECT zfConvert_StringToNumber (SUBSTR (inBarCode, 4, 13-4)) AS MovementId WHERE CHAR_LENGTH (inBarCode) >= 13) AS tmp INNER JOIN Movement ON Movement.Id = tmp.MovementId AND Movement.DescId = zc_Movement_OrderExternal() AND Movement.OperDate BETWEEN inOperDate - INTERVAL '1000 DAY' AND inOperDate + INTERVAL '1 DAY'
           UNION
             SELECT Movement.Id, Movement.InvNumber, Movement.DescId, Movement.OperDate FROM (SELECT inBarCode AS BarCode WHERE CHAR_LENGTH (inBarCode) > 0 AND CHAR_LENGTH (inBarCode) < 13) AS tmp INNER JOIN Movement ON Movement.InvNumber = tmp.BarCode AND Movement.DescId = zc_Movement_OrderExternal() AND Movement.OperDate BETWEEN inOperDate - INTERVAL '1000 DAY' AND inOperDate + INTERVAL '1 DAY'
            ) AS Movement
            LEFT JOIN MovementLinkObject AS MovementLinkObject_From
                                         ON MovementLinkObject_From.MovementId = Movement.Id
                                        AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
            LEFT JOIN Object AS Object_From ON Object_From.Id = MovementLinkObject_From.ObjectId
            LEFT JOIN MovementLinkObject AS MovementLinkObject_To
                                         ON MovementLinkObject_To.MovementId = Movement.Id
                                        AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
            LEFT JOIN Object AS Object_To ON Object_To.Id = MovementLinkObject_To.ObjectId

            LEFT JOIN MovementLinkObject AS MovementLinkObject_Contract
                                         ON MovementLinkObject_Contract.MovementId = Movement.Id
                                        AND MovementLinkObject_Contract.DescId = zc_MovementLinkObject_Contract()
            LEFT JOIN Object_Contract_InvNumber_View AS View_Contract_InvNumber ON View_Contract_InvNumber.ContractId = MovementLinkObject_Contract.ObjectId

            LEFT JOIN MovementLinkObject AS MovementLinkObject_PaidKind
                                         ON MovementLinkObject_PaidKind.MovementId = Movement.Id
                                        AND MovementLinkObject_PaidKind.DescId = zc_MovementLinkObject_PaidKind()
            LEFT JOIN Object AS Object_PaidKind ON Object_PaidKind.Id = MovementLinkObject_PaidKind.ObjectId

            LEFT JOIN MovementLinkObject AS MovementLinkObject_PriceList
                                         ON MovementLinkObject_PriceList.MovementId = Movement.Id
                                        AND MovementLinkObject_PriceList.DescId = zc_MovementLinkObject_PriceList()
            LEFT JOIN Object AS Object_PriceList ON Object_PriceList.Id = MovementLinkObject_PriceList.ObjectId

            LEFT JOIN MovementFloat AS MovementFloat_ChangePercent
                                    ON MovementFloat_ChangePercent.MovementId =  Movement.Id
                                   AND MovementFloat_ChangePercent.DescId = zc_MovementFloat_ChangePercent()
            LEFT JOIN MovementString AS MovementString_InvNumberPartner
                                     ON MovementString_InvNumberPartner.MovementId =  Movement.Id
                                    AND MovementString_InvNumberPartner.DescId = zc_MovementString_InvNumberPartner()

            LEFT JOIN ObjectBoolean AS ObjectBoolean_Partner_EdiOrdspr
                                    ON ObjectBoolean_Partner_EdiOrdspr.ObjectId =  MovementLinkObject_From.ObjectId
                                   AND ObjectBoolean_Partner_EdiOrdspr.DescId = zc_ObjectBoolean_Partner_EdiOrdspr()
            LEFT JOIN ObjectBoolean AS ObjectBoolean_Partner_EdiInvoice
                                    ON ObjectBoolean_Partner_EdiInvoice.ObjectId =  MovementLinkObject_From.ObjectId
                                   AND ObjectBoolean_Partner_EdiInvoice.DescId = zc_ObjectBoolean_Partner_EdiInvoice()
            LEFT JOIN ObjectBoolean AS ObjectBoolean_Partner_EdiDesadv
                                    ON ObjectBoolean_Partner_EdiDesadv.ObjectId =  MovementLinkObject_From.ObjectId
                                   AND ObjectBoolean_Partner_EdiDesadv.DescId = zc_ObjectBoolean_Partner_EdiDesadv()
      ;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpGet_Scale_OrderExternal (TDateTime, TVarChar, TVarChar) OWNER TO postgres;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 18.01.15                                        *
*/

-- ����
-- SELECT * FROM gpGet_Scale_OrderExternal ('01.01.2015', '0000007448300', zfCalc_UserAdmin())
