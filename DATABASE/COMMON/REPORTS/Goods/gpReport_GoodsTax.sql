-- Function: gpReport_GoodsTax ()

DROP FUNCTION IF EXISTS gpReport_GoodsTax (TDateTime, TDateTime, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpReport_GoodsTax (
    IN inStartDate    TDateTime ,  
    IN inEndDate      TDateTime ,
    IN inGoodsId      Integer   ,
    IN inSession      TVarChar    -- ������ ������������
)
RETURNS TABLE  (InvNumber TVarChar, OperDate TDateTime, MovementDescName TVarChar, StatusName TVarChar
              , PartnerCode Integer, PartnerName TVarChar, JuridicalCode Integer, JuridicalName TVarChar, OKPO TVarChar
              , ContractCode Integer, ContractNumber TVarChar
              , InfoMoneyGroupName TVarChar, InfoMoneyDestinationName TVarChar, InfoMoneyCode Integer, InfoMoneyName TVarChar
              , InvNumberPartner TVarChar, DocumentTaxKindName TVarChar
              , GoodsCode Integer, GoodsName TVarChar, GoodsKindName TVarChar
              , Amount TFloat, OperPrice TFloat
              )  
AS
$BODY$
BEGIN

   RETURN QUERY
   SELECT Movement.InvNumber
        , Movement.OperDate       AS OperDate
        , MovementDesc.ItemName   AS MovementDescName
        , Object_Status.ValueData AS StatusName

        , Object_Partner.ObjectCode AS PartnerCode
        , Object_Partner.ValueData  AS PartnerName
        , Object_Juridical.ObjectCode AS JuridicalCode
        , Object_Juridical.ValueData  AS JuridicalName
        , ObjectHistory_JuridicalDetails_View.OKPO
                
        , View_Contract_InvNumber.ContractCode
        , View_Contract_InvNumber.InvNumber AS ContractNumber

        , View_InfoMoney.InfoMoneyGroupName
        , View_InfoMoney.InfoMoneyDestinationName
        , View_InfoMoney.InfoMoneyCode
        , View_InfoMoney.InfoMoneyName

        , MS_InvNumberPartner.ValueData AS InvNumberPartner
        , Object_TaxKind.ValueData      AS DocumentTaxKindName

        , Object_Goods.ObjectCode    AS GoodsCode
        , Object_Goods.ValueData     AS GoodsName
        , Object_GoodsKind.ValueData AS GoodsKindName

        , CAST (tmp_All.Amount AS TFloat)    AS Amount
        , CAST (tmp_All.OperPrice AS TFloat) AS OperPrice

  FROM (SELECT tmpMI.MovementId
             , tmpMI.GoodsId
             , tmpMI.GoodsKindId
             , tmpMI.Amount
             , tmpMI.OperPrice
        FROM (SELECT MovementItem.MovementId
                   , MovementItem.ObjectId AS GoodsId
                   , MILinkObject_GoodsKind.ObjectId AS GoodsKindId
                   , MovementItem.Amount
                   , COALESCE (MIFloat_Price.ValueData, 0) AS OperPrice
              FROM MovementItem
                   INNER JOIN Movement ON Movement.Id = MovementItem.MovementId
                                      AND Movement.OperDate BETWEEN inStartDate and inEndDate
                                      AND Movement.StatusId IN (zc_Enum_Status_Complete(), zc_Enum_Status_UnComplete())
                                      AND Movement.DescId IN (zc_Movement_Tax(), zc_Movement_TaxCorrective())
                   LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                                    ON MILinkObject_GoodsKind.MovementItemId = MovementItem.Id
                                                   AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
                   LEFT JOIN MovementItemFloat AS MIFloat_Price
                                               ON MIFloat_Price.MovementItemId = MovementItem.Id
                                              AND MIFloat_Price.DescId = zc_MIFloat_Price()
              WHERE MovementItem.ObjectId = inGoodsId
                AND MovementItem.isErased   = FALSE
             ) AS tmpMI
       ) AS tmp_All

            LEFT JOIN Object AS Object_Goods ON Object_Goods.Id = tmp_All.GoodsId
            LEFT JOIN Object AS Object_GoodsKind ON Object_GoodsKind.Id = tmp_All.GoodsKindId

            LEFT JOIN Movement ON Movement.Id = tmp_All.MovementId 
            LEFT JOIN MovementDesc ON MovementDesc.Id = Movement.DescId
            LEFT JOIN Object AS Object_Status ON Object_Status.Id = Movement.StatusId


            LEFT JOIN MovementLinkObject AS MovementLinkObject_Partner
                                         ON MovementLinkObject_Partner.MovementId = tmp_All.MovementId 
                                        AND MovementLinkObject_Partner.DescId = zc_MovementLinkObject_Partner()
            LEFT JOIN Object AS Object_Partner ON Object_Partner.Id = MovementLinkObject_Partner.ObjectId

            LEFT JOIN MovementLinkObject AS MovementLinkObject_Juridical
                                         ON MovementLinkObject_Juridical.MovementId = tmp_All.MovementId 
                                        AND MovementLinkObject_Juridical.DescId = CASE WHEN Movement.DescId = zc_Movement_Tax() THEN zc_MovementLinkObject_To()
                                                                                       WHEN MovementDesc.Id = zc_Movement_ReturnIn() THEN zc_MovementLinkObject_From()
                                                                                  END

            LEFT JOIN Object AS Object_Juridical ON Object_Juridical.Id = MovementLinkObject_Juridical.ObjectId
            LEFT JOIN ObjectHistory_JuridicalDetails_View ON ObjectHistory_JuridicalDetails_View.JuridicalId = Object_Juridical.Id

            LEFT JOIN MovementLinkObject AS MovementLinkObject_Contract
                                         ON MovementLinkObject_Contract.MovementId = tmp_All.MovementId
                                        AND MovementLinkObject_Contract.DescId = zc_MovementLinkObject_Contract()
            LEFT JOIN Object_Contract_InvNumber_View AS View_Contract_InvNumber ON View_Contract_InvNumber.ContractId = MovementLinkObject_Contract.ObjectId
            LEFT JOIN Object_InfoMoney_View AS View_InfoMoney ON View_InfoMoney.InfoMoneyId = View_Contract_InvNumber.InfoMoneyId

            LEFT JOIN MovementString AS MS_InvNumberPartner ON MS_InvNumberPartner.MovementId = tmp_All.MovementId
                                                           AND MS_InvNumberPartner.DescId = zc_MovementString_InvNumberPartner()
            LEFT JOIN MovementLinkObject AS MovementLinkObject_DocumentTaxKind
                                         ON MovementLinkObject_DocumentTaxKind.MovementId = tmp_All.MovementId
                                        AND MovementLinkObject_DocumentTaxKind.DescId = zc_MovementLinkObject_DocumentTaxKind()
            LEFT JOIN Object AS Object_TaxKind ON Object_TaxKind.Id = MovementLinkObject_DocumentTaxKind.ObjectId
 ;
    
        
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpReport_GoodsTax (TDateTime, TDateTime, Integer, TVarChar) OWNER TO postgres;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 29.05.14                                        * ALL
 20.05.14         * rename gpReport_GoodsTax
 10.04.14                                        * ALL
 09.02.14         *  GROUP BY tmp_All
                   , add GoodsKind
 21.12.13                                        * Personal -> Member
 05.11.13         *  
*/

-- ����
-- SELECT * FROM gpReport_GoodsTax (inStartDate:= '01.12.2013', inEndDate:= '01.12.2013', inGoodsId:= 1826, inSession:= zfCalc_UserAdmin());