-- Function: gpSelect_Movement_1C_Load()

DROP FUNCTION IF EXISTS gpSelect_Movement_1C_Load (TDateTime, TDateTime, Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Movement_1C_Load(
    IN inStartDate      TDateTime , --
    IN inEndDate        TDateTime , --
    IN inInfoMoneyId    Integer   ,
    IN inPaidKindId     Integer   ,
    IN inSession        TVarChar    -- ������ ������������
)
RETURNS TABLE (UnitId TVarChar,  VidDoc TVarChar, InvNumber TVarChar, OperDate TVarChar, ClientCode TVarChar, ClientName TVarChar,
               GoodsCode  TVarChar, GoodsName TVarChar, OperCount TVarChar, OperPrice TVarChar,
               Tax TVarChar, Suma TVarChar, PDV TVarChar, SumaPDV TVarChar,
               ClientINN TVarChar, ClientOKPO TVarChar, CLIENTKIND TVarChar,
               InvNalog TVarChar, BillId TVarChar, EKSPCODE TVarChar, EXPName TVarChar,
               GoodsId TVarChar, PackId TVarChar, PackName TVarChar,
               Doc1Date TVarChar, Doc1Number TVarChar, Doc2Date TVarChar, Doc2Number TVarChar)
AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId:= lpCheckRight (inSession, zc_Enum_Process_Select_Movement_1C_Load());
     vbUserId:= inSession;

     --
     RETURN QUERY
     WITH tmpInfoMoney AS (SELECT Object_InfoMoney_View.InfoMoneyId FROM Object_InfoMoney_View WHERE Object_InfoMoney_View.InfoMoneyId = inInfoMoneyId AND Object_InfoMoney_View.InfoMoneyGroupId <> zc_Enum_InfoMoneyGroup_10000() -- �������� �����
                          UNION
                           SELECT Object_InfoMoney_View_find.InfoMoneyId
                           FROM Object_InfoMoney_View
                                LEFT JOIN Object_InfoMoney_View AS Object_InfoMoney_View_find ON Object_InfoMoney_View_find.InfoMoneyDestinationId = Object_InfoMoney_View.InfoMoneyDestinationId
                           WHERE Object_InfoMoney_View.InfoMoneyId = inInfoMoneyId
                             AND Object_InfoMoney_View.InfoMoneyGroupId = zc_Enum_InfoMoneyGroup_10000() -- �������� �����
                          /*UNION
                           SELECT Object_InfoMoney_View.InfoMoneyId
                           FROM (SELECT 1 FROM Object_InfoMoney_View WHERE Object_InfoMoney_View.InfoMoneyId = inInfoMoneyId
                                                                       AND Object_InfoMoney_View.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10200() -- �������� ����� + ������ �����
                                 LIMIT 1
                                ) AS tmp
                                INNER JOIN Object_InfoMoney_View ON Object_InfoMoney_View.InfoMoneyDestinationId IN (zc_Enum_InfoMoneyDestination_20100() -- ������������� + �������� � �������
                                                                                                                   , zc_Enum_InfoMoneyDestination_20200() -- ������������� + ������ ���
                                                                                                                   , zc_Enum_InfoMoneyDestination_20300() -- ������������� + ����
                                                                                                                   -- , zc_Enum_InfoMoneyDestination_20400() -- ������������� + ���
                                                                                                                   , zc_Enum_InfoMoneyDestination_20500() -- ������������� + ��������� ����
                                                                                                                   , zc_Enum_InfoMoneyDestination_20600() -- ������������� + ������ ���������
                                                                                                                    )
                                                                 OR Object_InfoMoney_View.InfoMoneyGroupId = zc_Enum_InfoMoneyGroup_70000() -- ����������
*/
                          )

  , tmpContract AS (SELECT ObjectLink_Contract_InfoMoney.ChildObjectId AS InfoMoneyId
                         , ObjectLink_Contract_InfoMoney.ObjectId      AS ContractId
                    FROM ObjectLink AS ObjectLink_Contract_InfoMoney
                         INNER JOIN tmpInfoMoney ON tmpInfoMoney.InfoMoneyId = ObjectLink_Contract_InfoMoney.ChildObjectId
                    WHERE ObjectLink_Contract_InfoMoney.DescId = zc_ObjectLink_Contract_InfoMoney()
                    )

  , tmpMovement AS (SELECT Movement.*, Movement.OperDate AS OperDatePartner
                    FROM Movement
                    WHERE Movement.OperDate BETWEEN inStartDate AND inEndDate
                      AND Movement.DescId IN (zc_Movement_PriceCorrective(), zc_Movement_TransferDebtOut(), zc_Movement_TransferDebtIn())
                      AND Movement.StatusId = zc_Enum_Status_Complete()
                   UNION
                    SELECT Movement.*, MovementDate_OperDatePartner.ValueData AS OperDatePartner
                    FROM MovementDate AS MovementDate_OperDatePartner
                         INNER JOIN Movement ON Movement.Id = MovementDate_OperDatePartner.MovementId
                                AND Movement.DescId IN (zc_Movement_Sale(), zc_Movement_ReturnIn(), zc_Movement_Income(), zc_Movement_ReturnOut())
                                AND Movement.StatusId = zc_Enum_Status_Complete()
                    WHERE MovementDate_OperDatePartner.ValueData BETWEEN inStartDate AND inEndDate
                      AND MovementDate_OperDatePartner.DescId = zc_MovementDate_OperDatePartner()
                    )

  , tmpLinkDesc AS (SELECT zc_Movement_Sale() AS MovementDescId, zc_MovementLinkObject_Contract() AS ContractDescId, zc_MovementLinkObject_PaidKind() AS PaidKindDescId
                  UNION
                    SELECT zc_Movement_ReturnIn() AS MovementDescId, zc_MovementLinkObject_Contract() AS ContractDescId, zc_MovementLinkObject_PaidKind() AS PaidKindDescId
                  UNION
                    SELECT zc_Movement_PriceCorrective() AS MovementDescId, zc_MovementLinkObject_Contract() AS ContractDescId, zc_MovementLinkObject_PaidKind() AS PaidKindDescId
                  UNION
                    SELECT zc_Movement_Income() AS MovementDescId, zc_MovementLinkObject_Contract() AS ContractDescId, zc_MovementLinkObject_PaidKind() AS PaidKindDescId
                  UNION
                    SELECT zc_Movement_ReturnOut() AS MovementDescId, zc_MovementLinkObject_Contract() AS ContractDescId, zc_MovementLinkObject_PaidKind() AS PaidKindDescId
                  UNION
                    SELECT zc_Movement_TransferDebtOut() AS MovementDescId, zc_MovementLinkObject_ContractTo() AS ContractDescId, zc_MovementLinkObject_PaidKindTo() AS PaidKindDescId
                  UNION
                    SELECT zc_Movement_TransferDebtIn() AS MovementDescId, zc_MovementLinkObject_ContractFrom() AS ContractDescId, zc_MovementLinkObject_PaidKindFrom() AS PaidKindDescId
                   )
 , tmpMov AS (SELECT Movement.*
                   , tmpContract.InfoMoneyId
                   , Object_Partner.Id                 AS PartnerId
                   , Object_Partner.ValueData         AS PartnerName
                   , MovementFloat_TotalSumm.ValueData AS TotalSumm
                   , movementfloat_changepercent.ValueData  AS ChangePercent
                   , MovementBoolean_PriceWithVAT.ValueData AS PriceWithVAT
                   , MovementFloat_VATPercent.ValueData     AS VATPercent

                    , ObjectHistory_JuridicalDetails_ViewByDate.INN             AS ClientINN
                    , ObjectHistory_JuridicalDetails_ViewByDate.OKPO            AS ClientOKPO
                    , MS_InvNumberPartner_Master.ValueData                      AS InvNalog

              FROM tmpMovement AS Movement
                   LEFT JOIN tmpLinkDesc ON tmpLinkDesc.MovementDescId = Movement.DescId
                   LEFT JOIN MovementLinkObject AS MovementLinkObject_Contract
                                                ON MovementLinkObject_Contract.MovementId = Movement.Id
                                               AND MovementLinkObject_Contract.DescId = tmpLinkDesc.ContractDescId
                                               AND Movement.DescId = tmpLinkDesc.MovementDescId

                   INNER JOIN tmpContract ON tmpContract.ContractId = MovementLinkObject_Contract.ObjectId

                   INNER JOIN MovementLinkObject AS MovementLinkObject_PaidKind
                                                 ON MovementLinkObject_PaidKind.MovementId = Movement.Id
                                                AND MovementLinkObject_PaidKind.DescId = tmpLinkDesc.PaidKindDescId
                                                AND Movement.DescId = tmpLinkDesc.MovementDescId
                                                AND MovementLinkObject_PaidKind.ObjectId = inPaidKindId

                   LEFT JOIN MovementBoolean AS MovementBoolean_PriceWithVAT
                                             ON MovementBoolean_PriceWithVAT.MovementId = Movement.Id
                                            AND MovementBoolean_PriceWithVAT.DescId = zc_MovementBoolean_PriceWithVAT()
                   LEFT JOIN MovementFloat AS MovementFloat_VATPercent
                                           ON MovementFloat_VATPercent.MovementId = Movement.Id
                                          AND MovementFloat_VATPercent.DescId = zc_MovementFloat_VATPercent()
                   LEFT JOIN MovementFloat AS MovementFloat_ChangePercent
                                           ON MovementFloat_ChangePercent.MovementId = Movement.Id
                                          AND MovementFloat_ChangePercent.DescId = zc_MovementFloat_ChangePercent()
                                          AND Movement.DescId <> zc_Movement_Sale()
                   LEFT JOIN MovementFloat AS MovementFloat_TotalSumm
                                           ON MovementFloat_TotalSumm.MovementId = Movement.Id
                                          AND MovementFloat_TotalSumm.DescId = zc_MovementFloat_TotalSumm()

                   LEFT JOIN MovementLinkMovement AS MovementLinkMovement_Master
                                                  ON MovementLinkMovement_Master.MovementId = Movement.Id
                                                 AND MovementLinkMovement_Master.DescId = zc_MovementLinkMovement_Master()
                   LEFT JOIN Movement AS Movement_DocumentMaster
                                      ON Movement_DocumentMaster.Id = MovementLinkMovement_Master.MovementChildId
                                     AND Movement_DocumentMaster.StatusId <> zc_Enum_Status_Erased()
                   LEFT JOIN MovementString AS MS_InvNumberPartner_Master
                                            ON MS_InvNumberPartner_Master.MovementId = Movement_DocumentMaster.Id
                                           AND MS_InvNumberPartner_Master.DescId = zc_MovementString_InvNumberPartner()

                   LEFT JOIN MovementLinkObject AS MovementLinkObject_Partner
                                                ON MovementLinkObject_Partner.MovementId = Movement.Id
                                               AND MovementLinkObject_Partner.DescId = zc_MovementLinkObject_Partner()
                   LEFT JOIN MovementLinkObject AS MovementLinkObject_To
                                                ON MovementLinkObject_To.MovementId = Movement.Id
                                               AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
                   LEFT JOIN MovementLinkObject AS MovementLinkObject_From
                                                ON MovementLinkObject_From.MovementId = Movement.Id
                                               AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()

                   LEFT JOIN Object AS Object_Partner ON Object_Partner.Id = CASE WHEN Movement.DescId IN (zc_Movement_Sale(), zc_Movement_ReturnOut())
                                                                                       THEN MovementLinkObject_To.ObjectId
                                                                                  WHEN Movement.DescId IN (zc_Movement_ReturnIn(), zc_Movement_Income())
                                                                                       THEN MovementLinkObject_From.ObjectId
                                                                                  ELSE MovementLinkObject_Partner.ObjectId
                                                                             END
                   LEFT JOIN ObjectLink AS ObjectLink_Partner_Juridical
                                        ON ObjectLink_Partner_Juridical.ObjectId = Object_Partner.Id
                                       AND ObjectLink_Partner_Juridical.DescId = zc_ObjectLink_Partner_Juridical()
                   LEFT JOIN ObjectHistory_JuridicalDetails_ViewByDate
                          ON ObjectHistory_JuridicalDetails_ViewByDate.JuridicalId = CASE WHEN Movement.DescId = zc_Movement_PriceCorrective()
                                                                                               THEN MovementLinkObject_From.ObjectId
                                                                                                 WHEN Movement.DescId = zc_Movement_TransferDebtOut()
                                                                                               THEN MovementLinkObject_To.ObjectId
                                                                                          WHEN Movement.DescId = zc_Movement_TransferDebtIn()
                                                                                               THEN MovementLinkObject_From.ObjectId
                                                                                          ELSE ObjectLink_Partner_Juridical.ChildObjectId
                                                                                     END
                         AND Movement.OperDate >= ObjectHistory_JuridicalDetails_ViewByDate.StartDate AND Movement.OperDate < ObjectHistory_JuridicalDetails_ViewByDate.EndDate
                  )

  , tmpGoodsByGoodsKind AS (SELECT Object_GoodsByGoodsKind_View.Id
                                 , Object_GoodsByGoodsKind_View.GoodsId
                                 , Object_GoodsByGoodsKind_View.GoodsKindId
                            FROM Object_GoodsByGoodsKind_View
                            )

                , tmpMI AS (SELECT MIMaster.*
                            FROM tmpMov AS Movement
                                 LEFT JOIN MovementItem AS MIMaster ON MIMaster.MovementId = Movement.Id
                                                                   AND MIMaster.DescId = zc_MI_Master()
                                                                   AND MIMaster.isErased = FALSE
                           )
 , tmpMIF_ChangePercent AS (SELECT MIFloat_ChangePercent.*
                            FROM tmpMI
                                 LEFT JOIN MovementItemFloat AS MIFloat_ChangePercent
                                                             ON MIFloat_ChangePercent.MovementItemId = tmpMI.Id
                                                            AND MIFloat_ChangePercent.DescId = zc_MIFloat_ChangePercent()
                           )
 , tmpMIF_AmountPartner AS (SELECT MIFloat_AmountPartner.*
                            FROM tmpMI
                                 LEFT JOIN MovementItemFloat AS MIFloat_AmountPartner
                                                             ON MIFloat_AmountPartner.MovementItemId = tmpMI.Id
                                                            AND MIFloat_AmountPartner.DescId = zc_MIFloat_AmountPartner()
                           )
         , tmpMIF_Price AS (SELECT MIFloat_Price.*
                            FROM tmpMI
                                 LEFT JOIN MovementItemFloat AS MIFloat_Price
                                                             ON MIFloat_Price.MovementItemId = tmpMI.Id
                                                            AND MIFloat_Price.DescId = zc_MIFloat_Price()
                           )
 , tmpMIF_CountForPrice AS (SELECT MIFloat_CountForPrice.*
                            FROM tmpMI
                                 LEFT JOIN MovementItemFloat AS MIFloat_CountForPrice
                                                             ON MIFloat_CountForPrice.MovementItemId = tmpMI.Id
                                                            AND MIFloat_CountForPrice.DescId = zc_MIFloat_CountForPrice()
                           )
    , tmpMILO_GoodsKind AS (SELECT MILinkObject_GoodsKind.*
                            FROM tmpMI
                                 LEFT JOIN tmpMov ON tmpMov.Id = tmpMI.MovementId
                                 LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                                                  ON MILinkObject_GoodsKind.MovementItemId = tmpMI.Id
                                                                 AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
                                                                 AND tmpMov.InfoMoneyId = zc_Enum_InfoMoney_30101() -- ������� ���������
                           )
     -- ���������
     SELECT '0' :: TVarChar                                           AS UnitId
           , CASE WHEN Movement.DescId IN (zc_Movement_PriceCorrective())
                       THEN 123
                  WHEN Movement.TotalSumm < 0
                       THEN 123

                  WHEN Movement.DescId IN (zc_Movement_Sale())
                       THEN 2
                  WHEN Movement.DescId IN (zc_Movement_PriceCorrective()) AND MIFloat_Price.ValueData < 0
                       THEN 2
                  WHEN Movement.DescId IN (zc_Movement_TransferDebtOut()) AND Movement.InfoMoneyId <> zc_Enum_InfoMoney_20901() -- ����
                       THEN 2
                  WHEN Movement.DescId IN (zc_Movement_TransferDebtOut()) AND Movement.InfoMoneyId = zc_Enum_InfoMoney_20901() -- ����
                       THEN 8

                  WHEN Movement.DescId IN (zc_Movement_ReturnIn())
                       THEN 4
                  WHEN Movement.DescId IN (zc_Movement_PriceCorrective()) AND MIFloat_Price.ValueData >= 0
                       THEN 4
                  WHEN Movement.DescId IN (zc_Movement_TransferDebtIn()) AND Movement.InfoMoneyId <> zc_Enum_InfoMoney_20901() -- ����
                       THEN 4
                  WHEN Movement.DescId IN (zc_Movement_TransferDebtIn()) AND Movement.InfoMoneyId = zc_Enum_InfoMoney_20901() -- ����
                       THEN 6

                  WHEN Movement.DescId IN (zc_Movement_Income())
                       THEN 6
                  WHEN Movement.DescId IN (zc_Movement_ReturnOut())
                       THEN 8

             END :: TVarChar                                           AS VidDoc
           , Movement.InvNumber				               AS InvNumber
           , TO_CHAR (Movement.OperDatePartner, 'DD.MM.YYYY') :: TVarChar AS OperDate

           , COALESCE (Movement.PartnerId, 0) :: TVarChar               AS ClientCode
           , Movement.PartnerName :: TVarChar                           AS ClientName

           , COALESCE (Object_GoodsByGoodsKind_View.Id, MIMaster.ObjectId) :: TVarChar AS GoodsCode
           , Object_Goods.ValueData                                    AS GoodsName

           , CASE WHEN Movement.DescId IN (zc_Movement_Sale(), zc_Movement_ReturnIn(), zc_Movement_Income(), zc_Movement_ReturnOut())
                       THEN COALESCE (MIFloat_AmountPartner.ValueData, 0)
                  ELSE MIMaster.Amount
             END :: TVarChar                                           AS OperCount
           , (CASE WHEN MIFloat_ChangePercent.ValueData       <> 0 AND Movement.DescId IN (zc_Movement_Sale(), zc_Movement_ReturnIn())
                        THEN CAST ( (1 + MIFloat_ChangePercent.ValueData       / 100) * COALESCE (MIFloat_Price.ValueData, 0) AS NUMERIC (16, 2))
                   WHEN Movement.ChangePercent <> 0 AND Movement.DescId NOT IN (zc_Movement_Sale(), zc_Movement_ReturnIn())
                        THEN CAST ( (1 + Movement.ChangePercent / 100) * COALESCE (MIFloat_Price.ValueData, 0) AS NUMERIC (16, 2))
                   ELSE COALESCE (MIFloat_Price.ValueData, 0)
              END / CASE WHEN MIFloat_CountForPrice.ValueData <> 0 THEN MIFloat_CountForPrice.ValueData ELSE 1 END
            * CASE WHEN Movement.DescId = zc_Movement_PriceCorrective() THEN -1 ELSE 1 END
             ) :: TVarChar                                             AS OperPrice

           , '0' :: TVarChar                                           AS Tax

             -- ����� ��� ���
           , (
             CAST (
             CASE WHEN Movement.PriceWithVAT = FALSE OR COALESCE (Movement.VATPercent, 0) = 0
                       -- ���� ���� ��� ��� ��� %���=0
                       THEN 1
                  WHEN Movement.PriceWithVAT = TRUE
                       -- ���� ���� c ���
                       THEN 1 / (1 + Movement.VATPercent / 100)
             END
           * CASE WHEN MIFloat_ChangePercent.ValueData       <> 0 AND Movement.DescId IN (zc_Movement_Sale(), zc_Movement_ReturnIn())
                       THEN CAST ( (1 + MIFloat_ChangePercent.ValueData       / 100) * COALESCE (MIFloat_Price.ValueData, 0) AS NUMERIC (16, 2))
                  WHEN Movement.ChangePercent <> 0 AND Movement.DescId NOT IN (zc_Movement_Sale(), zc_Movement_ReturnIn())
                       THEN CAST ( (1 + Movement.ChangePercent / 100) * COALESCE (MIFloat_Price.ValueData, 0) AS NUMERIC (16, 2))
                  ELSE COALESCE (MIFloat_Price.ValueData, 0)
             END / CASE WHEN MIFloat_CountForPrice.ValueData <> 0 THEN MIFloat_CountForPrice.ValueData ELSE 1 END
           * CASE WHEN Movement.DescId IN (zc_Movement_Sale(), zc_Movement_ReturnIn(), zc_Movement_Income(), zc_Movement_ReturnOut())
                       THEN COALESCE (MIFloat_AmountPartner.ValueData, 0)
                  ELSE MIMaster.Amount
             END AS NUMERIC (16, 2)
             )
           * CASE WHEN Movement.DescId = zc_Movement_PriceCorrective() THEN -1 ELSE 1 END
             ) :: TVarChar                       AS Summa

             -- ����� ���
           , (
             -- ***����� � ���
             CAST ((
             CAST (
             CASE WHEN MIFloat_ChangePercent.ValueData       <> 0 AND Movement.DescId IN (zc_Movement_Sale(), zc_Movement_ReturnIn())
                       THEN CAST ( (1 + MIFloat_ChangePercent.ValueData       / 100) * COALESCE (MIFloat_Price.ValueData, 0) AS NUMERIC (16, 2))
                  WHEN Movement.ChangePercent <> 0 AND Movement.DescId NOT IN (zc_Movement_Sale(), zc_Movement_ReturnIn())
                       THEN CAST ( (1 + Movement.ChangePercent / 100) * COALESCE (MIFloat_Price.ValueData, 0) AS NUMERIC (16, 2))
                  ELSE COALESCE (MIFloat_Price.ValueData, 0)
             END / CASE WHEN MIFloat_CountForPrice.ValueData <> 0 THEN MIFloat_CountForPrice.ValueData ELSE 1 END
           * CASE WHEN Movement.DescId IN (zc_Movement_Sale(), zc_Movement_ReturnIn(), zc_Movement_Income(), zc_Movement_ReturnOut())
                       THEN COALESCE (MIFloat_AmountPartner.ValueData, 0)
                  ELSE MIMaster.Amount
             END AS NUMERIC (16, 2))
           * CASE WHEN Movement.PriceWithVAT = TRUE OR COALESCE (Movement.VATPercent, 0) = 0
                       -- ���� ���� � ��� ��� %���=0
                       THEN 1
                  WHEN Movement.PriceWithVAT = FALSE
                       -- ���� ���� c ���
                       THEN (1 + Movement.VATPercent / 100)
             END
             )
           * CASE WHEN Movement.DescId = zc_Movement_PriceCorrective() THEN -1 ELSE 1 END
             AS NUMERIC (16, 4))

             -- ***�����
           -
             -- ***����� ��� ���
             (
             CAST (
             CASE WHEN Movement.PriceWithVAT = FALSE OR COALESCE (Movement.VATPercent, 0) = 0
                       -- ���� ���� ��� ��� ��� %���=0
                       THEN 1
                  WHEN Movement.PriceWithVAT = TRUE
                       -- ���� ���� c ���
                       THEN 1 / (1 + Movement.VATPercent / 100)
             END
           * CASE WHEN MIFloat_ChangePercent.ValueData       <> 0 AND Movement.DescId IN (zc_Movement_Sale(), zc_Movement_ReturnIn())
                       THEN CAST ( (1 + MIFloat_ChangePercent.ValueData       / 100) * COALESCE (MIFloat_Price.ValueData, 0) AS NUMERIC (16, 2))
                  WHEN Movement.ChangePercent <> 0 AND Movement.DescId NOT IN (zc_Movement_Sale(), zc_Movement_ReturnIn())
                       THEN CAST ( (1 + Movement.ChangePercent / 100) * COALESCE (MIFloat_Price.ValueData, 0) AS NUMERIC (16, 2))
                  ELSE COALESCE (MIFloat_Price.ValueData, 0)
             END / CASE WHEN MIFloat_CountForPrice.ValueData <> 0 THEN MIFloat_CountForPrice.ValueData ELSE 1 END
           * CASE WHEN Movement.DescId IN (zc_Movement_Sale(), zc_Movement_ReturnIn(), zc_Movement_Income(), zc_Movement_ReturnOut())
                       THEN COALESCE (MIFloat_AmountPartner.ValueData, 0)
                  ELSE MIMaster.Amount
             END AS NUMERIC (16, 2)
             )
           * CASE WHEN Movement.DescId = zc_Movement_PriceCorrective() THEN -1 ELSE 1 END
             )
             ) :: TVarChar                                             AS PDV

             -- ����� � ���
           , CAST ((
             CAST (
             CASE WHEN MIFloat_ChangePercent.ValueData       <> 0 AND Movement.DescId IN (zc_Movement_Sale(), zc_Movement_ReturnIn())
                       THEN CAST ( (1 + MIFloat_ChangePercent.ValueData       / 100) * COALESCE (MIFloat_Price.ValueData, 0) AS NUMERIC (16, 2))
                  WHEN Movement.ChangePercent <> 0 AND Movement.DescId NOT IN (zc_Movement_Sale(), zc_Movement_ReturnIn())
                       THEN CAST ( (1 + Movement.ChangePercent / 100) * COALESCE (MIFloat_Price.ValueData, 0) AS NUMERIC (16, 2))
                  ELSE COALESCE (MIFloat_Price.ValueData, 0)
             END / CASE WHEN MIFloat_CountForPrice.ValueData <> 0 THEN MIFloat_CountForPrice.ValueData ELSE 1 END
           * CASE WHEN Movement.DescId IN (zc_Movement_Sale(), zc_Movement_ReturnIn(), zc_Movement_Income(), zc_Movement_ReturnOut())
                       THEN COALESCE (MIFloat_AmountPartner.ValueData, 0)
                  ELSE MIMaster.Amount
             END AS NUMERIC (16, 2))
           * CASE WHEN Movement.PriceWithVAT = TRUE OR COALESCE (Movement.VATPercent, 0) = 0
                       -- ���� ���� � ��� ��� %���=0
                       THEN 1
                  WHEN Movement.PriceWithVAT = FALSE
                       -- ���� ���� c ���
                       THEN (1 + Movement.VATPercent / 100)
             END
             )
           * CASE WHEN Movement.DescId = zc_Movement_PriceCorrective() THEN -1 ELSE 1 END
             AS NUMERIC (16, 4)) :: TVarChar                           AS SummaPDV

           , Movement.ClientINN
           , Movement.ClientOKPO
           , CASE WHEN Movement.InfoMoneyId = zc_Enum_InfoMoney_30101() -- ������� ���������
                       THEN 1
                  WHEN Movement.InfoMoneyId = zc_Enum_InfoMoney_30103() -- ����
                       THEN 3

                  WHEN Movement.DescId IN (zc_Movement_Income(), zc_Movement_ReturnOut())
                       THEN 4
                  ELSE NULL
             END :: TVarChar                                           AS CLIENTKIND

           , Movement.InvNalog
           , Movement.Id :: TVarChar                                   AS BillId
           , '' :: TVarChar                                            AS EKSPCODE
           , '' :: TVarChar                                            AS EKSPName
           , Object_Goods.Id :: TVarChar                               AS GoodsId
           , Object_GoodsKind.Id :: TVarChar                           AS PackId
           , Object_GoodsKind.ValueData                                AS PackName
           , '' :: TVarChar                                            AS Doc1Date
           , '' :: TVarChar                                            AS Doc1Number
           , '' :: TVarChar                                            AS Doc2Date
           , '' :: TVarChar                                            AS Doc2Number

     FROM tmpMov AS Movement
            LEFT JOIN tmpMI AS MIMaster ON MIMaster.MovementId = Movement.Id
            LEFT JOIN Object AS Object_Goods ON Object_Goods.Id = MIMaster.ObjectId

            LEFT JOIN tmpMILO_GoodsKind AS MILinkObject_GoodsKind ON MILinkObject_GoodsKind.MovementItemId = MIMaster.Id
            LEFT JOIN Object AS Object_GoodsKind ON Object_GoodsKind.Id = MILinkObject_GoodsKind.ObjectId

            LEFT JOIN ObjectLink AS ObjectLink_Goods_InfoMoney
                                 ON ObjectLink_Goods_InfoMoney.ObjectId = MIMaster.ObjectId
                                AND ObjectLink_Goods_InfoMoney.DescId = zc_ObjectLink_Goods_InfoMoney()
            LEFT JOIN tmpGoodsByGoodsKind AS Object_GoodsByGoodsKind_View ON Object_GoodsByGoodsKind_View.GoodsId = MIMaster.ObjectId
                                                  AND Object_GoodsByGoodsKind_View.GoodsKindId = Object_GoodsKind.Id --MILinkObject_GoodsKind.ObjectId
                                                  -- AND ObjectLink_Goods_InfoMoney.ChildObjectId IN (zc_Enum_InfoMoney_20901(), zc_Enum_InfoMoney_30101(), zc_Enum_InfoMoney_30201()) -- ���� AND ������ + ��������� + ������� ��������� AND ������ + ������ ����� + ������ �����

            LEFT JOIN tmpMIF_ChangePercent AS MIFloat_ChangePercent ON MIFloat_ChangePercent.MovementItemId = MIMaster.Id
            LEFT JOIN tmpMIF_AmountPartner AS MIFloat_AmountPartner ON MIFloat_AmountPartner.MovementItemId = MIMaster.Id
            LEFT JOIN tmpMIF_Price         AS MIFloat_Price         ON MIFloat_Price.MovementItemId = MIMaster.Id
            LEFT JOIN tmpMIF_CountForPrice AS MIFloat_CountForPrice ON MIFloat_CountForPrice.MovementItemId = MIMaster.Id

      WHERE 0 <> CASE WHEN Movement.DescId IN (zc_Movement_Sale(), zc_Movement_ReturnIn(), zc_Movement_Income(), zc_Movement_ReturnOut())
                           THEN COALESCE (MIFloat_AmountPartner.ValueData, 0)
                      ELSE MIMaster.Amount
                 END
      ORDER BY Movement.Id
     ;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpSelect_Movement_1C_Load (TDateTime, TDateTime, Integer, Integer, TVarChar) OWNER TO postgres;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 05.04.17         *
 20.07.14                                        * add zc_Movement_PriceCorrective
 02.06.14                                        * add isErased = FALSE
 30.05.14                                        * add 0 <>
 19.05.14                                        * all
 14.05.14                         *
*/

-- ����
-- SELECT * FROM gpSelect_Movement_1C_Load (inStartDate:= '01.11.2016', inEndDate:= '11.11.2016', inInfoMoneyId:= 8911, inPaidKindId:= zc_Enum_PaidKind_FirstForm(), inSession:= zfCalc_UserAdmin())
--SELECT * FROM gpSelect_Movement_1C_Load (inStartDate:= '31.03.2017', inEndDate:= '31.03.2017', inInfoMoneyId:= zc_Enum_InfoMoney_30101(), inPaidKindId:= zc_Enum_PaidKind_FirstForm(), inSession:= zfCalc_UserAdmin()) AS a WHERE InvNumber = '400883'
