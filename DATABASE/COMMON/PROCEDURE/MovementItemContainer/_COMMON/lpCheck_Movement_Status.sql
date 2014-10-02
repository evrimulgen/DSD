-- Function: lpCheck_Movement_Status (Integer)

DROP FUNCTION IF EXISTS lpCheck_Movement_Status (Integer, Integer);

CREATE OR REPLACE FUNCTION lpCheck_Movement_Status(
    IN inMovementId        Integer  , -- ���� ������� <��������>
    IN inUserId            Integer    -- ������������
)                              
  RETURNS VOID
AS
$BODY$
   DECLARE vbDescId Integer;
   DECLARE vbOperDate TDateTime;
   DECLARE vbCloseDate TDateTime;
   DECLARE vbRoleId Integer;

   DECLARE vbDocumentTaxKindId Integer;
   DECLARE vbStatusId_Tax Integer;
   DECLARE vbInvNumber TVarChar;
   DECLARE vbDescName TVarChar;
   DECLARE vbPartnerId Integer;
   DECLARE vbJuridicalId Integer;
   DECLARE vbContractId Integer;
   DECLARE vbStartDate  TDateTime;
   DECLARE vbEndDate  TDateTime;
BEGIN

  -- 1. �������� <���������������>
  IF EXISTS (SELECT MovementId FROM MovementBoolean WHERE MovementId = inMovementId AND DescId = zc_MovementBoolean_Registered() AND ValueData = TRUE)
  THEN
      RAISE EXCEPTION '������.�������� ���������������.<�������������> ����������.';
  END IF;
  -- END 1. �������� <���������������>


     -- 2.1. �������� ��� ���������
     -- ������������ ��� �����.
     SELECT MovementLinkObject_DocumentTaxKind_Master.ObjectId AS DocumentTaxKindId
          , Movement_DocumentMaster.StatusId
          , MS_InvNumberPartner.ValueData AS vbInvNumber
          , Movement_DocumentMaster.OperDate
          , MovementDesc.ItemName
            INTO vbDocumentTaxKindId, vbStatusId_Tax, vbInvNumber, vbOperDate, vbDescName
     FROM MovementLinkMovement AS MovementLinkMovement_Master
          INNER JOIN Movement AS Movement_DocumentMaster ON Movement_DocumentMaster.Id = MovementLinkMovement_Master.MovementChildId
                                                        AND Movement_DocumentMaster.StatusId <> zc_Enum_Status_Erased()
          LEFT JOIN MovementDesc ON MovementDesc.Id = Movement_DocumentMaster.DescId
          LEFT JOIN MovementString AS MS_InvNumberPartner
                                   ON MS_InvNumberPartner.MovementId = Movement_DocumentMaster.Id
                                  AND MS_InvNumberPartner.DescId = zc_MovementString_InvNumberPartner()
          LEFT JOIN MovementLinkObject AS MovementLinkObject_DocumentTaxKind_Master
                                       ON MovementLinkObject_DocumentTaxKind_Master.MovementId = Movement_DocumentMaster.Id
                                      AND MovementLinkObject_DocumentTaxKind_Master.DescId = zc_MovementLinkObject_DocumentTaxKind()
     WHERE MovementLinkMovement_Master.MovementId = inMovementId
       AND MovementLinkMovement_Master.DescId = zc_MovementLinkMovement_Master();
     -- �������� - ���� ������ � �������, �� ��� ������ ���� ������������
     IF vbDocumentTaxKindId <> zc_Enum_DocumentTaxKind_Tax() AND vbStatusId_Tax <> zc_Enum_Status_UnComplete()
     THEN
         RAISE EXCEPTION '������.��������� ����������.������ �������� <%> � <%> �� <%> � ������� <%>.', vbDescName, vbInvNumber, DATE (vbOperDate), lfGet_Object_ValueData (vbStatusId_Tax);
     END IF;
     -- END 2.1. �������� ��� ���������


     -- 2.2. �������� ��� �������������
     -- �������� - ���� ������ � �������, �� ��� ������ ���� ������������
     IF EXISTS (SELECT ObjectId FROM MovementLinkObject WHERE MovementId = inMovementId AND DescId = zc_MovementLinkObject_DocumentTaxKind() AND ObjectId <> zc_Enum_DocumentTaxKind_Corrective())
     THEN
         -- 2.2.1. ������������ ���������
         SELECT MovementLinkObject_DocumentTaxKind.ObjectId AS DocumentTaxKindId
              , CASE WHEN Movement.DescId = zc_Movement_ReturnIn() THEN MovementLinkObject_From.ObjectId ELSE MovementLinkObject_Partner.ObjectId END AS PartnerId
              , CASE WHEN Movement.DescId = zc_Movement_ReturnIn() THEN ObjectLink_Partner_Juridical.ChildObjectId ELSE MovementLinkObject_From.ObjectId END AS JuridicalId
              , CASE WHEN Movement.DescId = zc_Movement_ReturnIn() THEN MovementLinkObject_Contract.ObjectId ELSE MovementLinkObject_ContractFrom.ObjectId END AS ContractId
              , DATE_TRUNC ('MONTH', CASE WHEN Movement.DescId = zc_Movement_ReturnIn() THEN MovementDate_OperDatePartner.ValueData ELSE Movement.OperDate END) AS StartDate
              , DATE_TRUNC ('MONTH', CASE WHEN Movement.DescId = zc_Movement_ReturnIn() THEN MovementDate_OperDatePartner.ValueData ELSE Movement.OperDate END) + INTERVAL '1 MONTH' - INTERVAL '1 DAY' AS EndDate
                INTO vbDocumentTaxKindId, vbPartnerId, vbJuridicalId, vbContractId, vbStartDate, vbEndDate
         FROM MovementLinkObject AS MovementLinkObject_DocumentTaxKind
              LEFT JOIN MovementDate AS MovementDate_OperDatePartner
                                     ON MovementDate_OperDatePartner.MovementId =  MovementLinkObject_DocumentTaxKind.MovementId
                                    AND MovementDate_OperDatePartner.DescId = zc_MovementDate_OperDatePartner()
              LEFT JOIN MovementLinkObject AS MovementLinkObject_Partner
                                           ON MovementLinkObject_Partner.MovementId = MovementLinkObject_DocumentTaxKind.MovementId
                                          AND MovementLinkObject_Partner.DescId = zc_MovementLinkObject_Partner()
              LEFT JOIN MovementLinkObject AS MovementLinkObject_From
                                           ON MovementLinkObject_From.MovementId = MovementLinkObject_DocumentTaxKind.MovementId
                                          AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
              LEFT JOIN ObjectLink AS ObjectLink_Partner_Juridical
                                   ON ObjectLink_Partner_Juridical.ObjectId = MovementLinkObject_From.ObjectId
                                  AND ObjectLink_Partner_Juridical.DescId = zc_ObjectLink_Partner_Juridical()
              LEFT JOIN MovementLinkObject AS MovementLinkObject_Contract
                                           ON MovementLinkObject_Contract.MovementId = MovementLinkObject_DocumentTaxKind.MovementId
                                          AND MovementLinkObject_Contract.DescId = zc_MovementLinkObject_Contract()
              LEFT JOIN MovementLinkObject AS MovementLinkObject_ContractFrom
                                           ON MovementLinkObject_ContractFrom.MovementId = MovementLinkObject_DocumentTaxKind.MovementId
                                          AND MovementLinkObject_ContractFrom.DescId = zc_MovementLinkObject_ContractFrom()
              LEFT JOIN Movement ON Movement.Id = MovementLinkObject_DocumentTaxKind.MovementId
         WHERE MovementLinkObject_DocumentTaxKind.MovementId = inMovementId
           AND MovementLinkObject_DocumentTaxKind.DescId = zc_MovementLinkObject_DocumentTaxKind();

         -- 2.2.2. ��� �������� ������� �� ��.����
         IF vbDocumentTaxKindId IN (zc_Enum_DocumentTaxKind_CorrectiveSummaryJuridicalSR(), zc_Enum_DocumentTaxKind_CorrectiveSummaryJuridicalR())
         THEN
            vbInvNumber:= NULL; vbOperDate:= NULL;
            SELECT tmp.InvNumber, tmp.OperDate, MovementDesc.ItemName
                   INTO vbInvNumber, vbOperDate, vbDescName
            FROM
           (SELECT MS_InvNumberPartner.ValueData AS InvNumber, Movement.OperDate, Movement.DescId
            FROM Movement
                 INNER JOIN MovementLinkObject AS MovementLinkObject_Contract
                                               ON MovementLinkObject_Contract.MovementId = Movement.Id
                                              AND MovementLinkObject_Contract.DescId = zc_MovementLinkObject_Contract()
                                              AND MovementLinkObject_Contract.ObjectId = vbContractId
                 INNER JOIN MovementLinkObject AS MovementLinkObject_To
                                               ON MovementLinkObject_To.MovementId = Movement.Id
                                              AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
                                              AND MovementLinkObject_To.ObjectId = vbJuridicalId
                 INNER JOIN MovementLinkObject AS MovementLinkObject_DocumentTaxKind
                                               ON MovementLinkObject_DocumentTaxKind.MovementId = Movement.Id
                                              AND MovementLinkObject_DocumentTaxKind.DescId = zc_MovementLinkObject_DocumentTaxKind()
                                              AND MovementLinkObject_DocumentTaxKind.ObjectId IN (zc_Enum_DocumentTaxKind_TaxSummaryJuridicalSR(), zc_Enum_DocumentTaxKind_TaxSummaryJuridicalS())
                 LEFT JOIN MovementString AS MS_InvNumberPartner
                                          ON MS_InvNumberPartner.MovementId = Movement.Id
                                         AND MS_InvNumberPartner.DescId = zc_MovementString_InvNumberPartner()
            WHERE Movement.OperDate BETWEEN vbStartDate AND vbEndDate
              AND Movement.DescId = zc_Movement_Tax()
              AND Movement.StatusId = zc_Enum_Status_Complete()
              AND vbDocumentTaxKindId = zc_Enum_DocumentTaxKind_CorrectiveSummaryJuridicalSR()
           UNION
            SELECT MS_InvNumberPartner.ValueData AS InvNumber, Movement.OperDate, Movement.DescId
            FROM Movement
                 INNER JOIN MovementLinkObject AS MovementLinkObject_Contract
                                               ON MovementLinkObject_Contract.MovementId = Movement.Id
                                              AND MovementLinkObject_Contract.DescId = zc_MovementLinkObject_Contract()
                                              AND MovementLinkObject_Contract.ObjectId = vbContractId
                 INNER JOIN MovementLinkObject AS MovementLinkObject_From
                                               ON MovementLinkObject_From.MovementId = Movement.Id
                                              AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
                                              AND MovementLinkObject_From.ObjectId = vbJuridicalId
                 INNER JOIN MovementLinkObject AS MovementLinkObject_DocumentTaxKind
                                               ON MovementLinkObject_DocumentTaxKind.MovementId = Movement.Id
                                              AND MovementLinkObject_DocumentTaxKind.DescId = zc_MovementLinkObject_DocumentTaxKind()
                                              AND MovementLinkObject_DocumentTaxKind.ObjectId IN (zc_Enum_DocumentTaxKind_CorrectiveSummaryJuridicalSR(), zc_Enum_DocumentTaxKind_CorrectiveSummaryJuridicalR())
                 LEFT JOIN MovementString AS MS_InvNumberPartner
                                          ON MS_InvNumberPartner.MovementId = Movement.Id
                                         AND MS_InvNumberPartner.DescId = zc_MovementString_InvNumberPartner()
            WHERE Movement.OperDate BETWEEN vbStartDate AND vbEndDate
              AND Movement.DescId = zc_Movement_TaxCorrective()
              AND Movement.StatusId = zc_Enum_Status_Complete()
           ) AS tmp
           LEFT JOIN MovementDesc ON MovementDesc.Id = tmp.DescId;

           IF vbInvNumber IS NOT NULL OR vbOperDate IS NOT NULL
           THEN
               RAISE EXCEPTION '������.��������� ����������.������ �������� <%> � <%> �� <%> � ������� <%>.', vbDescName, vbInvNumber, DATE (vbOperDate), lfGet_Object_ValueData (zc_Enum_Status_Complete());
           END IF;
         END IF;


         -- 2.2.3. ��� �������� ������� �� �����������
         IF vbDocumentTaxKindId IN (zc_Enum_DocumentTaxKind_CorrectiveSummaryPartnerSR(), zc_Enum_DocumentTaxKind_CorrectiveSummaryPartnerR())
         THEN
            vbInvNumber:= NULL; vbOperDate:= NULL;
            SELECT tmp.InvNumber, tmp.OperDate, MovementDesc.ItemName
                   INTO vbInvNumber, vbOperDate, vbDescName
            FROM
           (SELECT MS_InvNumberPartner.ValueData AS InvNumber, Movement.OperDate, Movement.DescId
            FROM Movement
                 INNER JOIN MovementLinkObject AS MovementLinkObject_Contract
                                               ON MovementLinkObject_Contract.MovementId = Movement.Id
                                              AND MovementLinkObject_Contract.DescId = zc_MovementLinkObject_Contract()
                                              AND MovementLinkObject_Contract.ObjectId = vbContractId
                 INNER JOIN MovementLinkObject AS MovementLinkObject_Partner
                                               ON MovementLinkObject_Partner.MovementId = Movement.Id
                                              AND MovementLinkObject_Partner.DescId = zc_MovementLinkObject_Partner()
                                              AND MovementLinkObject_Partner.ObjectId = vbPartnerId
                 INNER JOIN MovementLinkObject AS MovementLinkObject_DocumentTaxKind
                                               ON MovementLinkObject_DocumentTaxKind.MovementId = Movement.Id
                                              AND MovementLinkObject_DocumentTaxKind.DescId = zc_MovementLinkObject_DocumentTaxKind()
                                              AND MovementLinkObject_DocumentTaxKind.ObjectId IN (zc_Enum_DocumentTaxKind_TaxSummaryPartnerSR(), zc_Enum_DocumentTaxKind_TaxSummaryPartnerS())
                 LEFT JOIN MovementString AS MS_InvNumberPartner
                                          ON MS_InvNumberPartner.MovementId = Movement.Id
                                         AND MS_InvNumberPartner.DescId = zc_MovementString_InvNumberPartner()
            WHERE Movement.OperDate BETWEEN vbStartDate AND vbEndDate
              AND Movement.DescId = zc_Movement_Tax()
              AND Movement.StatusId = zc_Enum_Status_Complete()
              AND vbDocumentTaxKindId = zc_Enum_DocumentTaxKind_CorrectiveSummaryPartnerSR()
           UNION
            SELECT MS_InvNumberPartner.ValueData AS InvNumber, Movement.OperDate, Movement.DescId
            FROM Movement
                 INNER JOIN MovementLinkObject AS MovementLinkObject_Contract
                                               ON MovementLinkObject_Contract.MovementId = Movement.Id
                                              AND MovementLinkObject_Contract.DescId = zc_MovementLinkObject_Contract()
                                              AND MovementLinkObject_Contract.ObjectId = vbContractId
                 INNER JOIN MovementLinkObject AS MovementLinkObject_Partner
                                               ON MovementLinkObject_Partner.MovementId = Movement.Id
                                              AND MovementLinkObject_Partner.DescId = zc_MovementLinkObject_Partner()
                                              AND MovementLinkObject_Partner.ObjectId = vbPartnerId
                 INNER JOIN MovementLinkObject AS MovementLinkObject_DocumentTaxKind
                                               ON MovementLinkObject_DocumentTaxKind.MovementId = Movement.Id
                                              AND MovementLinkObject_DocumentTaxKind.DescId = zc_MovementLinkObject_DocumentTaxKind()
                                              AND MovementLinkObject_DocumentTaxKind.ObjectId IN (zc_Enum_DocumentTaxKind_CorrectiveSummaryPartnerSR(), zc_Enum_DocumentTaxKind_CorrectiveSummaryPartnerR())
                 LEFT JOIN MovementString AS MS_InvNumberPartner
                                          ON MS_InvNumberPartner.MovementId = Movement.Id
                                         AND MS_InvNumberPartner.DescId = zc_MovementString_InvNumberPartner()
            WHERE Movement.OperDate BETWEEN vbStartDate AND vbEndDate
              AND Movement.DescId = zc_Movement_TaxCorrective()
              AND Movement.StatusId = zc_Enum_Status_Complete()
           ) AS tmp
           LEFT JOIN MovementDesc ON MovementDesc.Id = tmp.DescId;

           IF vbInvNumber IS NOT NULL OR vbOperDate IS NOT NULL
           THEN
               RAISE EXCEPTION '������.��������� ����������.������ �������� <%> � <%> �� <%> � ������� <%>.', vbDescName, vbInvNumber, DATE (vbOperDate), lfGet_Object_ValueData (zc_Enum_Status_Complete());
           END IF;
         END IF;

     END IF;
     -- END 2.2. �������� ��� �������������

  -- 3.1. ������������ ����
  vbOperDate:= (SELECT OperDate FROM Movement WHERE Id = inMovementId);
  -- 3.2. ������������ 
  vbDescId:= (SELECT DescId FROM Movement WHERE Id = inMovementId);

  -- 3.1. ������������ ���� ��� <�������� �������>
  SELECT CASE WHEN tmp.CloseDate > tmp.ClosePeriod THEN tmp.CloseDate ELSE tmp.ClosePeriod END
       , tmp.RoleId
         INTO vbCloseDate, vbRoleId
  FROM (SELECT MAX (CASE WHEN PeriodClose.Period = INTERVAL '0 DAY' THEN DATE_TRUNC ('DAY', PeriodClose.CloseDate) ELSE zc_DateStart() END) AS CloseDate
             , MAX (CASE WHEN PeriodClose.Period <> INTERVAL '0 DAY' THEN DATE_TRUNC ('DAY', CURRENT_TIMESTAMP) - INTERVAL '1 day' ELSE zc_DateStart() END) AS ClosePeriod
             , MAX (PeriodClose.RoleId) AS RoleId
        FROM PeriodClose
             LEFT JOIN ObjectLink_UserRole_View AS View_UserRole
                                                ON View_UserRole.RoleId = PeriodClose.RoleId
                                               AND View_UserRole.UserId = inUserId
                                               -- AND vbDescId NOT IN (zc_Movement_PersonalService(), zc_Movement_Service(), zc_Movement_SendDebt())
        WHERE View_UserRole.UserId = inUserId -- OR PeriodClose.RoleId IS NULL
          AND PeriodClose.RoleId IN (SELECT RoleId FROM Object_Role_MovementDesc_View WHERE MovementDescId = vbDescId)
       ) AS tmp;
            
  -- 3.2. �������� ���� ��� <�������� �������>
  IF vbOperDate < vbCloseDate
  THEN 
       RAISE EXCEPTION '������.��������� �� <%> �� ��������.��� ���� <%> ������ ������ �� <%>.', TO_CHAR (vbOperDate, 'DD.MM.YYYY'), lfGet_Object_ValueData (vbRoleId), TO_CHAR (vbCloseDate, 'DD.MM.YYYY');
  END IF;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION lpCheck_Movement_Status (Integer, Integer) OWNER TO postgres;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 23.09.14                                        * add Object_Role_MovementDesc_View
 05.09.14                                        * add �������� - ���� ������ � �������, �� ��� ������ ���� ������������
*/

-- ����
-- SELECT * FROM lpCheck_Movement_Status (inMovementId:= 55, inUserId:= 2)