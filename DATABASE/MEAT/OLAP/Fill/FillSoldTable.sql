-- Function: gpSelect_Object_GoodsByGoodsKind1CLink (TVarChar)

DROP FUNCTION IF EXISTS FillSoldTable (TVarChar);

CREATE OR REPLACE FUNCTION FillSoldTable(
    IN inSession     TVarChar       -- ������ ������������
)
RETURNS VOId
-- RETURNS SETOF refcursor
AS
$BODY$
BEGIN
  --
  DELETE FROM SoldTable;


  --
  INSERT INTO SoldTable (OperDate, InvNumber
                       , JuridicalId, PartnerId, InfoMoneyId, PaidKindId, BranchId, RetailId, AreaId, PartnerTagId, ContractId, ContractTagId , ContractTagGroupId
                       , PersonalId, PersonalTradeId, BranchId_Personal
                       , TradeMarkId, GoodsGroupAnalystId, GoodsTagId, GoodsGroupId, GoodsId, GoodsKindId, MeasureId
                       , RegionId, ProvinceId, CityKindId, CityId, ProvinceCityId, StreetKindId, StreetId
                       , Sale_Summ, Sale_Summ_10300, Sale_SummCost, Sale_SummCost_10500, Sale_SummCost_40200, Sale_Amount_Weight, Sale_Amount_Sh, Sale_AmountPartner_Weight, Sale_AmountPartner_Sh, Sale_Amount_10500_Weight, Sale_Amount_40200_Weight
                       , Actions_Summ, Actions_Weight
                       , Return_Summ, Return_Summ_10300, Return_SummCost, Return_SummCost_40200, Return_Amount_Weight, Return_Amount_Sh, Return_AmountPartner_Weight, Return_AmountPartner_Sh, Return_Amount_40200_Weight
                       , SaleReturn_Summ, SaleReturn_SummCost, SaleReturn_Amount_Weight, SaleReturn_Amount_Sh
                       , Bonus, Plan_Weight, Plan_Summ
                       , Money_Summ, SendDebt_Summ, Money_SendDebt_Summ)

   WITH tmpAnalyzer AS (SELECT Constant_ProfitLoss_AnalyzerId_View.*
                             , CASE WHEN isSale = TRUE THEN zc_MovementLinkObject_To() ELSE zc_MovementLinkObject_From() END AS MLO_DescId
                        FROM Constant_ProfitLoss_AnalyzerId_View
                       ) 
      , tmpOperation AS (SELECT MIContainer.OperDate
                              , '' :: TVarChar AS InvNumber
                              , CLO_Juridical.ObjectId                AS JuridicalId
                              , CASE WHEN MIContainer.MovementDescId = zc_Movement_Service() THEN MIContainer.ObjectId_Analyzer ELSE MovementLinkObject_Partner.ObjectId END AS PartnerId
                              , CLO_InfoMoney.ObjectId                AS InfoMoneyId
                              , CLO_PaidKind.ObjectId                 AS PaidKindId
                              , MILinkObject_Branch.ObjectId          AS BranchId
                              , CLO_Contract.ObjectId                 AS ContractId

                              , MIContainer.ObjectId_Analyzer                 AS GoodsId
                              , COALESCE (MILinkObject_GoodsKind.ObjectId, 0) AS GoodsKindId

                              , SUM (CASE WHEN tmpAnalyzer.isSale = TRUE  AND tmpAnalyzer.isSumm = TRUE AND tmpAnalyzer.isCost = FALSE THEN  1 * MIContainer.Amount ELSE 0 END) AS Sale_Summ
                              , SUM (CASE WHEN tmpAnalyzer.isSale = FALSE AND tmpAnalyzer.isSumm = TRUE AND tmpAnalyzer.isCost = FALSE THEN -1 * MIContainer.Amount ELSE 0 END) AS Return_Summ

                              , SUM (CASE WHEN tmpAnalyzer.AnalyzerId = zc_Enum_AnalyzerId_SaleSumm_10200() THEN -1 * MIContainer.Amount ELSE 0 END) AS Sale_Summ_10200
                              , SUM (CASE WHEN tmpAnalyzer.AnalyzerId = zc_Enum_AnalyzerId_SaleSumm_10300() THEN -1 * MIContainer.Amount ELSE 0 END) AS Sale_Summ_10300
                              , SUM (CASE WHEN tmpAnalyzer.AnalyzerId = zc_Enum_AnalyzerId_ReturnInSumm_10300() THEN 1 * MIContainer.Amount ELSE 0 END) AS Return_Summ_10300

                              , SUM (CASE WHEN tmpAnalyzer.isSale = TRUE  AND tmpAnalyzer.isSumm = FALSE THEN -1 * MIContainer.Amount ELSE 0 END) AS Sale_Amount
                              , SUM (CASE WHEN tmpAnalyzer.isSale = FALSE AND tmpAnalyzer.isSumm = FALSE THEN  1 * MIContainer.Amount ELSE 0 END) AS Return_Amount

                              , SUM (CASE WHEN tmpAnalyzer.AnalyzerId = zc_Enum_AnalyzerId_SaleCount_10400()     THEN -1 * MIContainer.Amount ELSE 0 END) AS Sale_AmountPartner
                              , SUM (CASE WHEN tmpAnalyzer.AnalyzerId = zc_Enum_AnalyzerId_ReturnInCount_10800() THEN  1 * MIContainer.Amount ELSE 0 END) AS Return_AmountPartner

                              , SUM (CASE WHEN tmpAnalyzer.AnalyzerId = zc_Enum_AnalyzerId_SaleCount_10500()     THEN -1 * MIContainer.Amount ELSE 0 END) AS Sale_Amount_10500
                              , SUM (CASE WHEN tmpAnalyzer.AnalyzerId = zc_Enum_AnalyzerId_SaleCount_40200()     THEN  1 * MIContainer.Amount ELSE 0 END) AS Sale_Amount_40200
                              , SUM (CASE WHEN tmpAnalyzer.AnalyzerId = zc_Enum_AnalyzerId_ReturnInCount_40200() THEN  1 * MIContainer.Amount ELSE 0 END) AS Return_Amount_40200

                              , SUM (CASE WHEN tmpAnalyzer.AnalyzerId = zc_Enum_AnalyzerId_SaleSumm_10400() THEN -1 * COALESCE (MIContainer.Amount, 0) ELSE 0 END) AS Sale_SummCost
                              , SUM (CASE WHEN tmpAnalyzer.AnalyzerId = zc_Enum_AnalyzerId_SaleSumm_10500() THEN -1 * COALESCE (MIContainer.Amount, 0) ELSE 0 END) AS Sale_SummCost_10500
                              , SUM (CASE WHEN tmpAnalyzer.AnalyzerId = zc_Enum_AnalyzerId_SaleSumm_40200() THEN      COALESCE (MIContainer.Amount, 0) ELSE 0 END) AS Sale_SummCost_40200

                              , SUM (CASE WHEN tmpAnalyzer.AnalyzerId = zc_Enum_AnalyzerId_ReturnInSumm_10800() THEN COALESCE (MIContainer.Amount, 0) ELSE 0 END) AS Return_SummCost
                              , SUM (CASE WHEN tmpAnalyzer.AnalyzerId = zc_Enum_AnalyzerId_ReturnInSumm_40200() THEN COALESCE (MIContainer.Amount, 0) ELSE 0 END) AS Return_SummCost_40200

                         FROM tmpAnalyzer
                              INNER JOIN MovementItemContainer AS MIContainer
                                                               ON MIContainer.AnalyzerId = tmpAnalyzer.AnalyzerId
                                                              AND MIContainer.OperDate >= '01.12.2015'
                              INNER JOIN ContainerLinkObject AS CLO_Juridical
                                                             ON CLO_Juridical.ContainerId = MIContainer.ContainerId_Analyzer
                                                            AND CLO_Juridical.DescId = zc_ContainerLinkObject_Juridical()
                              INNER JOIN ContainerLinkObject AS CLO_InfoMoney
                                                             ON CLO_InfoMoney.ContainerId = MIContainer.ContainerId_Analyzer
                                                            AND CLO_InfoMoney.DescId = zc_ContainerLinkObject_InfoMoney()
                                                            AND CLO_InfoMoney.ObjectId = zc_Enum_InfoMoney_30101() -- !!������� ���������!!!
                              INNER JOIN ContainerLinkObject AS CLO_PaidKind
                                                             ON CLO_PaidKind.ContainerId = MIContainer.ContainerId_Analyzer
                                                            AND CLO_PaidKind.DescId = zc_ContainerLinkObject_PaidKind()
                              LEFT JOIN ContainerLinkObject AS CLO_Contract
                                                            ON CLO_Contract.ContainerId = MIContainer.ContainerId_Analyzer
                                                           AND CLO_Contract.DescId = zc_ContainerLinkObject_Contract()

                              LEFT JOIN MovementLinkObject AS MovementLinkObject_Partner
                                                           ON MovementLinkObject_Partner.MovementId = MIContainer.MovementId
                                                          AND MovementLinkObject_Partner.DescId = CASE WHEN MIContainer.MovementDescId = zc_Movement_PriceCorrective() THEN zc_MovementLinkObject_Partner() ELSE tmpAnalyzer.MLO_DescId END

                              LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                                               ON MILinkObject_GoodsKind.MovementItemId = MIContainer.MovementItemId
                                                              AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
                              LEFT JOIN MovementItemLinkObject AS MILinkObject_Branch
                                                               ON MILinkObject_Branch.MovementItemId = MIContainer.MovementItemId
                                                              AND MILinkObject_Branch.DescId = zc_MILinkObject_Branch()
                         GROUP BY MIContainer.OperDate
                                , CLO_Juridical.ObjectId
                                , MIContainer.MovementDescId, MovementLinkObject_Partner.ObjectId
                                , CLO_InfoMoney.ObjectId
                                , CLO_PaidKind.ObjectId
                                , MILinkObject_Branch.ObjectId
                                , CLO_Contract.ObjectId
                                , MIContainer.ObjectId_Analyzer
                                , MILinkObject_GoodsKind.ObjectId
                        )
       
      SELECT tmpResult.OperDate
           , tmpResult.InvNumber

           , tmpResult.JuridicalId
           , tmpResult.PartnerId
           , tmpResult.InfoMoneyId
           , tmpResult.PaidKindId
           , tmpResult.BranchId
           , ObjectLink_Juridical_Retail.ChildObjectId             AS RetailId
           , View_Partner_Address.AreaId                
           , View_Partner_Address.PartnerTagId          
           , tmpResult.ContractId 
           , ObjectLink_Contract_ContractTag.ChildObjectId         AS ContractTagId
           , ObjectLink_ContractTag_ContractTagGroup.ChildObjectId AS ContractTagGroupId

           , ObjectLink_Partner_Personal.ChildObjectId             AS PersonalId
           , ObjectLink_Partner_PersonalTrade.ChildObjectId        AS PersonalTradeId
           , ObjectLink_Unit_Branch.ChildObjectId                  AS BranchId_Personal

           , ObjectLink_Goods_TradeMark.ChildObjectId              AS TradeMarkId
           , ObjectLink_Goods_GoodsGroupAnalyst.ChildObjectId      AS GoodsGroupAnalystId
           , ObjectLink_Goods_GoodsTag.ChildObjectId               AS GoodsTagId
           , ObjectLink_Goods_GoodsGroup.ChildObjectId             AS GoodsGroupId
           , tmpResult.GoodsId
           , tmpResult.GoodsKindId
           , ObjectLink_Goods_Measure.ChildObjectId                AS MeasureId

           , View_Partner_Address.RegionId              
           , View_Partner_Address.ProvinceId            
           , View_Partner_Address.CityKindId            
           , View_Partner_Address.CityId                
           , View_Partner_Address.ProvinceCityId        
           , View_Partner_Address.StreetKindId          
           , View_Partner_Address.StreetId              

           , tmpResult.Sale_Summ
           , tmpResult.Sale_Summ_10300
           , tmpResult.Sale_SummCost
           , tmpResult.Sale_SummCost_10500
           , tmpResult.Sale_SummCost_40200
           , tmpResult.Sale_Amount_Weight
           , tmpResult.Sale_Amount_Sh
           , tmpResult.Sale_AmountPartner_Weight
           , tmpResult.Sale_AmountPartner_Sh
           , tmpResult.Sale_Amount_10500_Weight
           , tmpResult.Sale_Amount_40200_Weight

           , tmpResult.Sale_Summ_10200 AS Actions_Summ
           , 0                         AS Actions_Weight

           , tmpResult.Return_Summ
           , tmpResult.Return_Summ_10300
           , tmpResult.Return_SummCost
           , tmpResult.Return_SummCost_40200
           , tmpResult.Return_Amount_Weight
           , tmpResult.Return_Amount_Sh
           , tmpResult.Return_AmountPartner_Weight
           , tmpResult.Return_AmountPartner_Sh
           , tmpResult.Return_Amount_40200_Weight

           , (tmpResult.Sale_Summ - tmpResult.Return_Summ)                   AS SaleReturn_Summ
           , (tmpResult.Sale_SummCost - tmpResult.Return_SummCost)           AS SaleReturn_SummCost
           , (tmpResult.Sale_Amount_Weight - tmpResult.Return_Amount_Weight) AS SaleReturn_Amount_Weight
           , (tmpResult.Sale_Amount_Sh - tmpResult.Return_Amount_Sh)         AS SaleReturn_Amount_Sh
      
           , 0, 0, 0
           , 0, 0, 0

      FROM (SELECT tmpOperation.OperDate
                 , tmpOperation.InvNumber

                 , tmpOperation.JuridicalId
                 , tmpOperation.PartnerId
                 , tmpOperation.InfoMoneyId
                 , tmpOperation.PaidKindId
                 , tmpOperation.BranchId
                 , tmpOperation.ContractId

                 , tmpOperation.GoodsId
                 , tmpOperation.GoodsKindId

                 , SUM (tmpOperation.Sale_Summ)   AS Sale_Summ
                 , SUM (tmpOperation.Return_Summ) AS Return_Summ

                 , SUM (tmpOperation.Sale_Summ_10200)   AS Sale_Summ_10200
                 , SUM (tmpOperation.Sale_Summ_10300)   AS Sale_Summ_10300
                 , SUM (tmpOperation.Return_Summ_10300) AS Return_Summ_10300

                 , SUM (tmpOperation.Sale_Amount * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN ObjectFloat_Weight.ValueData ELSE 1 END) AS Sale_Amount_Weight
                 , SUM (CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN tmpOperation.Sale_Amount ELSE 0 END) AS Sale_Amount_Sh
                 , SUM (tmpOperation.Return_Amount * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN ObjectFloat_Weight.ValueData ELSE 1 END) AS Return_Amount_Weight
                 , SUM (CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN tmpOperation.Return_Amount ELSE 0 END) AS Return_Amount_Sh

                 , SUM (tmpOperation.Sale_AmountPartner * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN ObjectFloat_Weight.ValueData ELSE 1 END) AS Sale_AmountPartner_Weight
                 , SUM (CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN tmpOperation.Sale_AmountPartner ELSE 0 END) AS Sale_AmountPartner_Sh
                 , SUM (tmpOperation.Return_AmountPartner * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN ObjectFloat_Weight.ValueData ELSE 1 END) AS Return_AmountPartner_Weight
                 , SUM (CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN tmpOperation.Return_AmountPartner ELSE 0 END) AS Return_AmountPartner_Sh

                 , SUM (tmpOperation.Sale_Amount_10500 * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN ObjectFloat_Weight.ValueData ELSE 1 END) AS Sale_Amount_10500_Weight
                 , SUM (tmpOperation.Sale_Amount_40200 * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN ObjectFloat_Weight.ValueData ELSE 1 END) AS Sale_Amount_40200_Weight
                 , SUM (tmpOperation.Return_Amount_40200 * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN ObjectFloat_Weight.ValueData ELSE 1 END) AS Return_Amount_40200_Weight

                 , SUM (tmpOperation.Sale_SummCost)       AS Sale_SummCost
                 , SUM (tmpOperation.Sale_SummCost_10500) AS Sale_SummCost_10500
                 , SUM (tmpOperation.Sale_SummCost_40200) AS Sale_SummCost_40200

                 , SUM (tmpOperation.Return_SummCost)       AS Return_SummCost
                 , SUM (tmpOperation.Return_SummCost_40200) AS Return_SummCost_40200
            FROM tmpOperation
                 LEFT JOIN ObjectLink AS ObjectLink_Goods_Measure
                                      ON ObjectLink_Goods_Measure.ObjectId = tmpOperation.GoodsId
                                     AND ObjectLink_Goods_Measure.DescId = zc_ObjectLink_Goods_Measure()
                 LEFT JOIN ObjectFloat AS ObjectFloat_Weight
                                       ON ObjectFloat_Weight.ObjectId = tmpOperation.GoodsId
                                      AND ObjectFloat_Weight.DescId = zc_ObjectFloat_Goods_Weight()

            GROUP BY tmpOperation.OperDate
                   , tmpOperation.InvNumber

                   , tmpOperation.JuridicalId
                   , tmpOperation.PartnerId
                   , tmpOperation.InfoMoneyId
                   , tmpOperation.PaidKindId
                   , tmpOperation.BranchId
                   , tmpOperation.ContractId

                   , tmpOperation.GoodsId
                   , tmpOperation.GoodsKindId
           ) AS tmpResult

           LEFT JOIN Object_Partner_Address_View AS View_Partner_Address ON View_Partner_Address.PartnerId = tmpResult.PartnerId

           LEFT JOIN ObjectLink AS ObjectLink_Goods_TradeMark
                                ON ObjectLink_Goods_TradeMark.ObjectId = tmpResult.GoodsId
                               AND ObjectLink_Goods_TradeMark.DescId = zc_ObjectLink_Goods_TradeMark()
           LEFT JOIN ObjectLink AS ObjectLink_Goods_GoodsGroupAnalyst
                                ON ObjectLink_Goods_GoodsGroupAnalyst.ObjectId = tmpResult.GoodsId
                               AND ObjectLink_Goods_GoodsGroupAnalyst.DescId = zc_ObjectLink_Goods_GoodsGroupAnalyst()
           LEFT JOIN ObjectLink AS ObjectLink_Goods_GoodsTag
                                ON ObjectLink_Goods_GoodsTag.ObjectId = tmpResult.GoodsId
                               AND ObjectLink_Goods_GoodsTag.DescId = zc_ObjectLink_Goods_GoodsTag()
           LEFT JOIN ObjectLink AS ObjectLink_Goods_GoodsGroup
                                ON ObjectLink_Goods_GoodsGroup.ObjectId = tmpResult.GoodsId
                               AND ObjectLink_Goods_GoodsGroup.DescId = zc_ObjectLink_Goods_GoodsGroup()
           LEFT JOIN ObjectLink AS ObjectLink_Goods_Measure
                                ON ObjectLink_Goods_Measure.ObjectId = tmpResult.GoodsId
                               AND ObjectLink_Goods_Measure.DescId = zc_ObjectLink_Goods_Measure()

           LEFT JOIN ObjectLink AS ObjectLink_Contract_ContractTag
                                ON ObjectLink_Contract_ContractTag.ObjectId = tmpResult.ContractId
                               AND ObjectLink_Contract_ContractTag.DescId = zc_ObjectLink_Contract_ContractTag()
           LEFT JOIN ObjectLink AS ObjectLink_ContractTag_ContractTagGroup
                                ON ObjectLink_ContractTag_ContractTagGroup.ObjectId = ObjectLink_Contract_ContractTag.ChildObjectId
                               AND ObjectLink_ContractTag_ContractTagGroup.DescId = zc_ObjectLink_ContractTag_ContractTagGroup()

           LEFT JOIN ObjectLink AS ObjectLink_Juridical_Retail
                                ON ObjectLink_Juridical_Retail.ObjectId = tmpResult.JuridicalId
                               AND ObjectLink_Juridical_Retail.DescId = zc_ObjectLink_Juridical_Retail()

           LEFT JOIN ObjectLink AS ObjectLink_Partner_Personal
                                ON ObjectLink_Partner_Personal.ObjectId = tmpResult.PartnerId
                               AND ObjectLink_Partner_Personal.DescId = zc_ObjectLink_Partner_Personal()
           LEFT JOIN ObjectLink AS ObjectLink_Personal_Unit
                                ON ObjectLink_Personal_Unit.ObjectId = ObjectLink_Partner_Personal.ChildObjectId
                               AND ObjectLink_Personal_Unit.DescId = zc_ObjectLink_Personal_Unit()
           LEFT JOIN ObjectLink AS ObjectLink_Unit_Branch
                                ON ObjectLink_Unit_Branch.ObjectId = ObjectLink_Personal_Unit.ChildObjectId
                               AND ObjectLink_Unit_Branch.DescId = zc_ObjectLink_Unit_Branch()

           LEFT JOIN ObjectLink AS ObjectLink_Partner_PersonalTrade
                                ON ObjectLink_Partner_PersonalTrade.ObjectId = tmpResult.PartnerId
                               AND ObjectLink_Partner_PersonalTrade.DescId = zc_ObjectLink_Partner_PersonalTrade()

     UNION ALL
      SELECT MovementItemContainer.OperDate, '' :: TVarChar AS InvNumber
           , CLO_Juridical.ObjectId                                AS JuridicalId
           , 0 AS PartnerId
           , CLO_InfoMoney.ObjectId                                AS InfoMoneyId
           , CLO_PaidKind.ObjectId                                 AS PaidKindId
           , 0 AS BranchId
           , ObjectLink_Juridical_Retail.ChildObjectId             AS RetailId
           , 0 AS AreaId
           , 0 AS PartnerTagId
           , CLO_Contract.ObjectId                                 AS ContractId
           , ObjectLink_Contract_ContractTag.ChildObjectId         AS ContractTagId
           , ObjectLink_ContractTag_ContractTagGroup.ChildObjectId AS ContractTagGroupId

           , 0 AS PersonalId, 0 AS PersonalTradeId, 0 AS BranchId_Personal
           , 0 AS TradeMarkId, 0 AS GoodsGroupAnalystId, 0 AS GoodsTagId, 0 AS GoodsGroupId, 0 AS GoodsId, 0 AS GoodsKindId, 0 AS MeasureId
           , 0 AS RegionId, 0 AS ProvinceId, 0 AS CityKindId, 0 AS CityId, 0 AS ProvinceCityId, 0 AS StreetKindId, 0 AS StreetId

           , 0 AS Sale_Summ, 0 AS Sale_Summ_10300, 0 AS Sale_SummCost, 0 AS Sale_SummCost_10500, 0 AS Sale_SummCost_40200, 0 AS Sale_Amount_Weight, 0 AS Sale_Amount_Sh, 0 AS Sale_AmountPartner_Weight, 0 AS Sale_AmountPartner_Sh, 0 AS Sale_Amount_10500_Weight, 0 AS Sale_Amount_40200_Weight
           , 0 AS Actions_Summ, 0 AS Actions_Weight
           , 0 AS Return_Summ, 0 AS Return_Summ_10300, 0 AS Return_SummCost, 0 AS Return_SummCost_40200, 0 AS Return_Amount_Weight, 0 AS Return_Amount_Sh, 0 AS Return_AmountPartner_Weight, 0 AS Return_AmountPartner_Sh, 0 AS Return_Amount_40200_Weight
           , 0 AS SaleReturn_Summ, 0 AS SaleReturn_SummCost, 0 AS SaleReturn_Amount_Weight, 0 AS SaleReturn_Amount_Sh
           , -1 * SUM (MovementItemContainer.Amount) AS Bonus
           , 0 AS Plan_Weight, 0 AS Plan_Summ
           , 0 AS Money_Summ, 0 AS SendDebt_Summ, 0 AS Money_SendDebt_Summ
   FROM Movement 
        JOIN MovementItemContainer ON MovementItemContainer.MovementId = Movement.Id
                                  AND MovementItemContainer.DescId = zc_MIContainer_Summ()
                                  AND MovementItemContainer.OperDate >= '01.12.2015'
        JOIN Container ON Container.Id = MovementItemContainer.ContainerId
                      AND Container.ObjectId = zc_Enum_Account_50401() -- !!!������� ������� �������� + ������ �� ����������!!!

        LEFT JOIN ContainerLinkObject AS CLO_Juridical ON CLO_Juridical.ContainerId = Container.Id AND CLO_Juridical.DescId = zc_ContainerLinkObject_Juridical()
        LEFT JOIN ContainerLinkObject AS CLO_PaidKind ON CLO_PaidKind.ContainerId = Container.Id AND CLO_PaidKind.DescId = zc_ContainerLinkObject_PaidKind()
        LEFT JOIN ContainerLinkObject AS CLO_Contract ON CLO_Contract.ContainerId = Container.Id AND CLO_Contract.DescId = zc_ContainerLinkObject_Contract()
        LEFT JOIN ContainerLinkObject AS CLO_InfoMoney ON CLO_InfoMoney.ContainerId = Container.Id AND CLO_InfoMoney.DescId = zc_ContainerLinkObject_InfoMoney()
   
           LEFT JOIN ObjectLink AS ObjectLink_Juridical_Retail
                                ON ObjectLink_Juridical_Retail.ObjectId = CLO_Juridical.ObjectId
                               AND ObjectLink_Juridical_Retail.DescId = zc_ObjectLink_Juridical_Retail()
           LEFT JOIN ObjectLink AS ObjectLink_Contract_ContractTag
                                ON ObjectLink_Contract_ContractTag.ObjectId = CLO_Contract.ObjectId
                               AND ObjectLink_Contract_ContractTag.DescId = zc_ObjectLink_Contract_ContractTag()
           LEFT JOIN ObjectLink AS ObjectLink_ContractTag_ContractTagGroup
                                ON ObjectLink_ContractTag_ContractTagGroup.ObjectId = CLO_Contract.ObjectId
                               AND ObjectLink_ContractTag_ContractTagGroup.DescId = zc_ObjectLink_ContractTag_ContractTagGroup()
    WHERE Movement.DescId = zc_Movement_ProfitLossService()
    GROUP BY MovementItemContainer.OperDate
           , CLO_PaidKind.ObjectId 
           , CLO_Juridical.ObjectId
           , CLO_Contract.ObjectId
           , CLO_InfoMoney.ObjectId
           , ObjectLink_Juridical_Retail.ChildObjectId
           , ObjectLink_Contract_ContractTag.ChildObjectId
           , ObjectLink_ContractTag_ContractTagGroup.ChildObjectId
     UNION ALL
      SELECT MovementItemContainer.OperDate, '' :: TVarChar AS InvNumber
           , CLO_Juridical.ObjectId                                AS JuridicalId
           , 0 AS PartnerId
           , CLO_InfoMoney.ObjectId                                AS InfoMoneyId
           , CLO_PaidKind.ObjectId                                 AS PaidKindId
           , 0 AS BranchId
           , ObjectLink_Juridical_Retail.ChildObjectId             AS RetailId
           , 0 AS AreaId
           , 0 AS PartnerTagId
           , CLO_Contract.ObjectId                                 AS ContractId
           , ObjectLink_Contract_ContractTag.ChildObjectId         AS ContractTagId
           , ObjectLink_ContractTag_ContractTagGroup.ChildObjectId AS ContractTagGroupId

           , 0 AS PersonalId, 0 AS PersonalTradeId, 0 AS BranchId_Personal
           , 0 AS TradeMarkId, 0 AS GoodsGroupAnalystId, 0 AS GoodsTagId, 0 AS GoodsGroupId, 0 AS GoodsId, 0 AS GoodsKindId, 0 AS MeasureId
           , 0 AS RegionId, 0 AS ProvinceId, 0 AS CityKindId, 0 AS CityId, 0 AS ProvinceCityId, 0 AS StreetKindId, 0 AS StreetId

           , 0 AS Sale_Summ, 0 AS Sale_Summ_10300, 0 AS Sale_SummCost, 0 AS Sale_SummCost_10500, 0 AS Sale_SummCost_40200, 0 AS Sale_Amount_Weight, 0 AS Sale_Amount_Sh, 0 AS Sale_AmountPartner_Weight, 0 AS Sale_AmountPartner_Sh, 0 AS Sale_Amount_10500_Weight, 0 AS Sale_Amount_40200_Weight
           , 0 AS Actions_Summ, 0 AS Actions_Weight
           , 0 AS Return_Summ, 0 AS Return_Summ_10300, 0 AS Return_SummCost, 0 AS Return_SummCost_40200, 0 AS Return_Amount_Weight, 0 AS Return_Amount_Sh, 0 AS Return_AmountPartner_Weight, 0 AS Return_AmountPartner_Sh, 0 AS Return_Amount_40200_Weight
           , 0 AS SaleReturn_Summ, 0 AS SaleReturn_SummCost, 0 AS SaleReturn_Amount_Weight, 0 AS SaleReturn_Amount_Sh
           , 0 AS Bonus
           , 0 AS Plan_Weight, 0 AS Plan_Summ
           , SUM (CASE WHEN Movement.DescId IN (zc_Movement_Cash(), zc_Movement_BankAccount()) THEN -1 * MovementItemContainer.Amount ELSE 0 END) AS Money_Summ
           , SUM (CASE WHEN Movement.DescId = zc_Movement_SendDebt() THEN -1 * MovementItemContainer.Amount ELSE 0 END) AS SendDebt_Summ
           , SUM (MovementItemContainer.Amount) AS Money_SendDebt_Summ
   FROM Movement 
        JOIN MovementItemContainer ON MovementItemContainer.MovementId = Movement.Id
                                  AND MovementItemContainer.DescId = zc_MIContainer_Summ()
                                  AND MovementItemContainer.OperDate >= '01.12.2015'
        JOIN Container ON Container.Id = MovementItemContainer.ContainerId
                      AND Container.DescId = zc_Container_Summ()
        INNER JOIN ContainerLinkObject AS CLO_InfoMoney ON CLO_InfoMoney.ContainerId = Container.Id AND CLO_InfoMoney.DescId = zc_ContainerLinkObject_InfoMoney()
                                                       AND CLO_InfoMoney.ObjectId = zc_Enum_InfoMoney_30101() -- !!������� ���������!!!

        LEFT JOIN ContainerLinkObject AS CLO_Juridical ON CLO_Juridical.ContainerId = Container.Id AND CLO_Juridical.DescId = zc_ContainerLinkObject_Juridical()
        LEFT JOIN ContainerLinkObject AS CLO_PaidKind ON CLO_PaidKind.ContainerId = Container.Id AND CLO_PaidKind.DescId = zc_ContainerLinkObject_PaidKind()
        LEFT JOIN ContainerLinkObject AS CLO_Contract ON CLO_Contract.ContainerId = Container.Id AND CLO_Contract.DescId = zc_ContainerLinkObject_Contract()

           LEFT JOIN ObjectLink AS ObjectLink_Juridical_Retail
                                ON ObjectLink_Juridical_Retail.ObjectId = CLO_Juridical.ObjectId
                               AND ObjectLink_Juridical_Retail.DescId = zc_ObjectLink_Juridical_Retail()
           LEFT JOIN ObjectLink AS ObjectLink_Contract_ContractTag
                                ON ObjectLink_Contract_ContractTag.ObjectId = CLO_Contract.ObjectId
                               AND ObjectLink_Contract_ContractTag.DescId = zc_ObjectLink_Contract_ContractTag()
           LEFT JOIN ObjectLink AS ObjectLink_ContractTag_ContractTagGroup
                                ON ObjectLink_ContractTag_ContractTagGroup.ObjectId = CLO_Contract.ObjectId
                               AND ObjectLink_ContractTag_ContractTagGroup.DescId = zc_ObjectLink_ContractTag_ContractTagGroup()
    WHERE Movement.DescId IN (zc_Movement_Cash(), zc_Movement_BankAccount(), zc_Movement_SendDebt())
    GROUP BY MovementItemContainer.OperDate
           , CLO_PaidKind.ObjectId 
           , CLO_Juridical.ObjectId
           , CLO_Contract.ObjectId
           , CLO_InfoMoney.ObjectId
           , ObjectLink_Juridical_Retail.ChildObjectId
           , ObjectLink_Contract_ContractTag.ChildObjectId
           , ObjectLink_ContractTag_ContractTagGroup.ChildObjectId
   ;


  --
  UPDATE SoldTable SET Sale_Profit = COALESCE(Sale_Summ, 0) - COALESCE(Sale_SummCost, 0)                       -- ������� (������ ������)
                , SaleBonus_Profit = COALESCE(Sale_Summ, 0) - COALESCE(Sale_SummCost, 0) - COALESCE(Bonus, 0)  -- ������� � ������ ������� (������ ������)
               , SaleReturn_Profit = COALESCE(Sale_Summ, 0) - COALESCE(Sale_SummCost, 0) - COALESCE(Return_Summ, 0)                      -- ������� � ������ !!!��������!!!
          , SaleReturnBonus_Profit = COALESCE(Sale_Summ, 0) - COALESCE(Sale_SummCost, 0) - COALESCE(Return_Summ, 0) - COALESCE(Bonus, 0) -- ������� � ������ !!!��������!!! � �������
  ;
  
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION FillSoldTable (TVarChar) OWNER TO postgres;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 12.01.15                                        * all
 26.11.14                         *  
 25.11.14                                        * add Sale_SummCost Return_SummCost 
 19.11.14                         * add 
*/
-- ����
-- SELECT * FROM SoldTable
-- SELECT * FROM FillSoldTable (zfCalc_UserAdmin()) 
