-- Function: gpGet_Movement_Email_Send()

-- DROP FUNCTION IF EXISTS gpGet_Movement_XML_Email (Integer, TVarChar);
DROP FUNCTION IF EXISTS gpGet_Movement_Email_Send (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpGet_Movement_Email_Send(
    IN inMovementId           Integer   ,
    IN inSession              TVarChar    -- ������ ������������
)
RETURNS TABLE (Subject TVarChar, Body TBlob, AddressFrom TVarChar, AddressTo TVarChar
             , Host TVarChar, Port TVarChar, UserName TVarChar, Password TVarChar
              )
AS
$BODY$
   DECLARE vbUserId   Integer;

   DECLARE vbPartnerId Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId:= lpCheckRight (inSession, zc_Enum_Process_Select_Movement_XML_Mida());
     vbUserId:= lpGetUserBySession (inSession);


     -- ������������ <����������>
     vbPartnerId:= (SELECT CASE WHEN Movement.DescId = zc_Movement_Sale() THEN MovementLinkObject_To.ObjectId ELSE MovementLinkObject_From.ObjectId END
                    FROM Movement
                         LEFT JOIN MovementLinkObject AS MovementLinkObject_From
                                                      ON MovementLinkObject_From.MovementId = Movement.Id
                                                     AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
                         LEFT JOIN MovementLinkObject AS MovementLinkObject_To
                                                      ON MovementLinkObject_To.MovementId = Movement.Id
                                                     AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
                    WHERE Movement.Id = inMovementId
                   );

     -- ��������
     IF 0 = COALESCE((WITH tmpExportJuridical AS (SELECT DISTINCT tmp.PartnerId FROM lpSelect_Object_ExportJuridical_list() AS tmp)
                      SELECT 1
                      FROM tmpExportJuridical
                      WHERE tmpExportJuridical.PartnerId = vbPartnerId)
                   , 0)
     THEN
         RAISE EXCEPTION '������.������ ������� ��� ���������� <%> �� �������������.'
                       , lfGet_Object_ValueData ();
     END IF;

     -- ���������
     RETURN QUERY
     WITH -- ���� ����������
          tmpPartnerTo AS (SELECT vbPartnerId AS PartnerId)
          -- ���, ���� ���� ��������� Email
        , tmpExportJuridical AS (SELECT tmp.PartnerId, tmp.EmailKindId, STRING_AGG (tmp.ContactPersonMail, ';') AS ContactPersonMail FROM lpSelect_Object_ExportJuridical_list() AS tmp GROUP BY tmp.PartnerId, tmp.EmailKindId)
          -- ��� ��������� - ������ ����������, ��� ������ ����������
        , tmpEmail_from AS (SELECT * FROM gpSelect_Object_EmailSettings (inEmailKindId:= (SELECT tmp.EmailKindId
                                                                                          FROM tmpPartnerTo
                                                                                               INNER JOIN (SELECT DISTINCT tmpExportJuridical.PartnerId, tmpExportJuridical.EmailKindId FROM tmpExportJuridical) AS tmp ON tmp.PartnerId = tmpPartnerTo.PartnerId
                                                                                          )
                                                                       , inSession    := inSession)
                                                                        )
     SELECT tmp.outFileName          :: TVarChar AS Subject
          , ''                       :: TBlob    AS Body
          , gpGet_Mail.Value                     AS AddressFrom
          -- , tmpExportJuridical.ContactPersonMail :: TVarChar AS AddressTo
          , CASE WHEN inSession = '5' THEN 'ashtu777@ua.fm' ELSE tmpExportJuridical.ContactPersonMail END :: TVarChar AS AddressTo
          , gpGet_Host.Value                     AS Host
          , gpGet_Port.Value                     AS Port
          , gpGet_User.Value                     AS UserName
          , gpGet_Password.Value                 AS Password

     FROM gpGet_Movement_Email_FileName (inMovementId, inSession) AS tmp
          LEFT JOIN tmpPartnerTo ON tmpPartnerTo.PartnerId > 0
          LEFT JOIN tmpExportJuridical ON tmpExportJuridical.PartnerId = tmpPartnerTo.PartnerId
          LEFT JOIN tmpEmail_from AS gpGet_Host      ON gpGet_Host.EmailToolsId      = zc_Enum_EmailTools_Host()
          LEFT JOIN tmpEmail_from AS gpGet_Port      ON gpGet_Port.EmailToolsId      = zc_Enum_EmailTools_Port()
          LEFT JOIN tmpEmail_from AS gpGet_Mail      ON gpGet_Mail.EmailToolsId      = zc_Enum_EmailTools_Mail()
          LEFT JOIN tmpEmail_from AS gpGet_User      ON gpGet_User.EmailToolsId      = zc_Enum_EmailTools_User()
          LEFT JOIN tmpEmail_from AS gpGet_Password  ON gpGet_Password.EmailToolsId  = zc_Enum_EmailTools_Password()
    ;
/*     SELECT tmp.outFileName                      :: TVarChar AS Subject
          , ''                                   :: TBlob    AS Body
          , 'nikolaev.filial.alan@gmail.com'     :: TVarChar AS AddressFrom
          , 'MIDA@KIVIT.COM.UA'                  :: TVarChar AS AddressTo
          , 'smtp.gmail.com'                     :: TVarChar AS Host
          , 465                                  :: Integer  AS Port
          , 'nikolaev.filial.alan@gmail.com'     :: TVarChar AS UserName
          , 'nikolaevfilialalan'                 :: TVarChar AS Password -- '24447183'

     FROM gpGet_Movement_XML_FileName (inMovementId, inSession) AS tmp;
     SELECT tmp.outFileName          :: TVarChar AS Subject
          , ''                       :: TBlob    AS Body
          , '24447183@ukr.net'       :: TVarChar AS AddressFrom
          , 'ashtu777@ua.fm'         :: TVarChar AS AddressTo
          , 'smtp.ukr.net'           :: TVarChar AS Host
          , 465                      :: Integer  AS Port
          , '24447183@ukr.net'       :: TVarChar AS UserName
          , 'vas6ok'                 :: TVarChar AS Password -- '24447183'

     FROM gpGet_Movement_XML_FileName (inMovementId, inSession) AS tmp;*/
/*
     SELECT tmp.outFileName          :: TVarChar AS Subject
          , ''                       :: TBlob    AS Body
          , 'mail_out_in@alan.dp.ua' :: TVarChar AS AddressFrom
          , 'ashtu@ua.fm' :: TVarChar AS AddressTo
          , 'smtp.alan.dp.ua'        :: TVarChar AS Host
          , 25                       :: Integer  AS Port
          , 'mail_out_in'            :: TVarChar AS UserName
          , 'vas6ok'                 :: TVarChar AS Password
     FROM gpGet_Movement_XML_FileName (inMovementId, inSession) AS tmp;
*/


END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 25.02.16                                        *
*/

-- ����
-- SELECT * FROM gpGet_Movement_Email_Send (inMovementId:= 3376510, inSession:= zfCalc_UserAdmin()) -- zc_Enum_ExportKind_Mida35273055()
-- SELECT * FROM gpGet_Movement_Email_Send (inMovementId:= 3252496, inSession:= zfCalc_UserAdmin()) -- zc_Enum_ExportKind_Vez37171990()
