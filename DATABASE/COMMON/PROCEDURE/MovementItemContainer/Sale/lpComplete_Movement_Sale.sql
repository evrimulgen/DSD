-- Function: lpComplete_Movement_Sale (Integer, Integer, Boolean)

DROP FUNCTION IF EXISTS lpComplete_Movement_Sale (Integer, Integer, Boolean);

CREATE OR REPLACE FUNCTION lpComplete_Movement_Sale(
    IN inMovementId        Integer               , -- ���� ���������
    IN inUserId            Integer               , -- ������������
    IN inIsLastComplete    Boolean  DEFAULT False  -- ��� ��������� ���������� ����� ������� �/� (��� ������� �������� !!!�� ��������������!!!)
)                              
RETURNS VOID
AS
$BODY$
  DECLARE vbIsHistoryCost Boolean; -- ����� �������� �/� ��� ����� ������������

  DECLARE vbMovementDescId Integer;

  DECLARE vbOperSumm_PriceList_byItem TFloat;
  DECLARE vbOperSumm_PriceList TFloat;
  DECLARE vbOperSumm_Partner_byItem TFloat;
  DECLARE vbOperSumm_Currency_byItem TFloat;
  DECLARE vbOperSumm_Partner TFloat;
  DECLARE vbOperSumm_Partner_ChangePercent_byItem TFloat;
  DECLARE vbOperSumm_Partner_ChangePercent TFloat;
  DECLARE vbOperSumm_Currency TFloat;

  DECLARE vbPriceWithVAT_PriceList Boolean;
  DECLARE vbVATPercent_PriceList TFloat;

  DECLARE vbPriceWithVAT Boolean;
  DECLARE vbVATPercent TFloat;
  DECLARE vbDiscountPercent TFloat;
  DECLARE vbExtraChargesPercent TFloat;

  DECLARE vbOperDate TDateTime;
  DECLARE vbOperDatePartner TDateTime;

  DECLARE vbUnitId_From Integer;
  DECLARE vbMemberId_From Integer;
  DECLARE vbBranchId_From Integer;
  DECLARE vbAccountDirectionId_From Integer;
  DECLARE vbIsPartionDate_Unit Boolean;

  DECLARE vbJuridicalId_To Integer;
  DECLARE vbIsCorporate_To Boolean;
  DECLARE vbInfoMoneyId_CorporateTo Integer;
  DECLARE vbPartnerId_To Integer;
  DECLARE vbMemberId_To Integer;
  DECLARE vbInfoMoneyDestinationId_To Integer;
  DECLARE vbInfoMoneyId_To Integer;

  DECLARE vbPaidKindId Integer;
  DECLARE vbContractId Integer;
  DECLARE vbJuridicalId_Basis_From Integer;
  DECLARE vbBusinessId_From Integer;

  DECLARE vbCurrencyDocumentId Integer;
  DECLARE vbCurrencyPartnerId Integer;
  DECLARE vbCurrencyValue TFloat;
  DECLARE vbParValue TFloat;
  DECLARE vbCurrencyPartnerValue TFloat;
  DECLARE vbParPartnerValue TFloat;

BEGIN
     -- !!!��������!!!
     PERFORM lpInsertUpdate_MovementFloat_TotalSumm (inMovementId:= inMovementId);

     -- !!!�����������!!! �������� ������� ��������
     DELETE FROM _tmpMIContainer_insert;
     DELETE FROM _tmpMIReport_insert;
     -- !!!�����������!!! �������� ������� - �������� �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     DELETE FROM _tmpItemSumm;
     -- !!!�����������!!! �������� ������� - �������������� �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     DELETE FROM _tmpItem;


     -- !!! ������ ��� ������ ����� �������� �/� (������� ��� ��������� ����������)!!!
     IF (EXISTS (SELECT UserId FROM ObjectLink_UserRole_View WHERE UserId = inUserId AND RoleId = zc_Enum_Role_Admin())
         AND inIsLastComplete = FALSE
        )
     -- !!! ����� ��� ��� ���������, ������� ��� ��������!!!
     OR 301310 = (SELECT Object_RoleAccessKeyGuide_View.BranchId FROM Object_RoleAccessKeyGuide_View WHERE Object_RoleAccessKeyGuide_View.UserId = inUserId AND Object_RoleAccessKeyGuide_View.BranchId <> 0)
     THEN vbIsHistoryCost:= TRUE;
     ELSE vbIsHistoryCost:= FALSE;
     END IF;


     -- ��� ��������� ����� ��� 
     SELECT lfObject_PriceList.PriceWithVAT, lfObject_PriceList.VATPercent
       INTO vbPriceWithVAT_PriceList, vbVATPercent_PriceList
     FROM lfGet_Object_PriceList (zc_PriceList_Basis()) AS lfObject_PriceList;


     -- ��� ��������� ����� ��� ������� �������� ���� �� ����������� ��� ��������� � ��� ������������ �������� � ���������
     SELECT COALESCE (MovementBoolean_PriceWithVAT.ValueData, TRUE) AS PriceWithVAT
          , COALESCE (MovementFloat_VATPercent.ValueData, 0) AS VATPercent
          , CASE WHEN COALESCE (MovementFloat_ChangePercent.ValueData, 0) < 0 THEN -1 * MovementFloat_ChangePercent.ValueData ELSE 0 END AS DiscountPercent
          , CASE WHEN COALESCE (MovementFloat_ChangePercent.ValueData, 0) > 0 THEN MovementFloat_ChangePercent.ValueData ELSE 0 END AS ExtraChargesPercent

          , Movement.DescId                                                      AS MovementDescId
          , Movement.OperDate                                                    AS OperDate -- COALESCE (MovementDate_OperDatePartner.ValueData, Movement.OperDate) AS OperDate -- 
          , COALESCE (MovementDate_OperDatePartner.ValueData, Movement.OperDate) AS OperDatePartner

          , COALESCE (CASE WHEN Object_From.DescId = zc_Object_Unit() THEN Object_From.Id ELSE 0 END, 0) AS UnitId_From
          , 0 AS MemberId_From -- COALESCE (CASE WHEN Object_From.DescId = zc_Object_Member() THEN Object_From.Id WHEN Object_From.DescId = zc_Object_Personal() THEN ObjectLink_PersonalFrom_Member.ChildObjectId ELSE 0 END, 0) AS MemberId_From
          , COALESCE (CASE WHEN Object_From.DescId = zc_Object_Unit() THEN ObjectLink_UnitFrom_Branch.ChildObjectId WHEN Object_From.DescId = zc_Object_Personal() THEN ObjectLink_UnitPersonalFrom_Branch.ChildObjectId ELSE 0 END, 0) AS BranchId_From
          , COALESCE (ObjectLink_UnitFrom_AccountDirection.ChildObjectId, 0) AS AccountDirectionId_From -- ��������� ������ - ����������� !!!����� ������ ��� �������������!!!
          , COALESCE (ObjectBoolean_PartionDate.ValueData, FALSE) AS isPartionDate_Unit

          , COALESCE (CASE WHEN Object_To.DescId = zc_Object_Partner() THEN ObjectLink_Partner_Juridical.ChildObjectId ELSE 0 END, 0) AS JuridicalId_To
          , CASE WHEN Constant_InfoMoney_isCorporate_View.InfoMoneyId IS NOT NULL
                      THEN TRUE
                 ELSE COALESCE (ObjectBoolean_isCorporate.ValueData, FALSE)
            END AS isCorporate_To
          , CASE WHEN Constant_InfoMoney_isCorporate_View.InfoMoneyId IS NOT NULL
                      THEN ObjectLink_Juridical_InfoMoney.ChildObjectId
                 ELSE 0
            END AS InfoMoneyId_CorporateTo
          , COALESCE (CASE WHEN Object_To.DescId = zc_Object_Partner() THEN Object_To.Id ELSE 0 END, 0) AS PartnerId_To
          , 0 AS MemberId_To -- COALESCE (CASE WHEN Object_To.DescId = zc_Object_Member() THEN Object_To.Id WHEN Object_To.DescId = zc_Object_Personal() THEN ObjectLink_PersonalTo_Member.ChildObjectId ELSE 0 END, 0) AS MemberId_To

            -- �� ������ ���������� �����: ������ �� �������� -- � ������ ����: � ������ ������� - �� ��������, �� ������ - �� ������ !!!(���� ���� ��������)!!!, ����� ����� ���������� ��� ������� ������
          , COALESCE (ObjectLink_Contract_InfoMoney.ChildObjectId, 0) AS InfoMoneyId_To -- COALESCE (ObjectLink_Contract_InfoMoney.ChildObjectId, COALESCE (ObjectLink_Juridical_InfoMoney.ChildObjectId, 0)) AS InfoMoneyId_To

          , COALESCE (MovementLinkObject_PaidKind.ObjectId, 0) AS PaidKindId
          , COALESCE (MovementLinkObject_Contract.ObjectId, 0) AS ContractId

          , COALESCE (CASE WHEN Object_From.DescId = zc_Object_Unit() THEN ObjectLink_UnitFrom_Juridical.ChildObjectId WHEN Object_From.DescId = zc_Object_Personal() THEN ObjectLink_UnitPersonalFrom_Juridical.ChildObjectId ELSE 0 END, 0) AS JuridicalId_Basis_From
          , COALESCE (CASE WHEN Object_From.DescId = zc_Object_Unit() THEN ObjectLink_UnitFrom_Business.ChildObjectId WHEN Object_From.DescId = zc_Object_Personal() THEN ObjectLink_UnitPersonalFrom_Business.ChildObjectId ELSE 0 END, 0) AS BusinessId_From

          , COALESCE (MovementLinkObject_CurrencyDocument.ObjectId, zc_Enum_Currency_Basis()) AS CurrencyDocumentId
          , COALESCE (MovementLinkObject_CurrencyPartner.ObjectId, zc_Enum_Currency_Basis())  AS CurrencyPartnerId
          , COALESCE (MovementFloat_CurrencyValue.ValueData, 0)                               AS CurrencyPartnerValue
          , COALESCE (MovementFloat_ParValue.ValueData, 0)                                    AS ParPartnerValue
          , COALESCE (MovementFloat_CurrencyPartnerValue.ValueData, 0)                        AS CurrencyPartnerValue
          , COALESCE (MovementFloat_ParPartnerValue.ValueData, 0)                             AS ParPartnerValue

            INTO vbPriceWithVAT, vbVATPercent, vbDiscountPercent, vbExtraChargesPercent
               , vbMovementDescId, vbOperDate, vbOperDatePartner
               , vbUnitId_From, vbMemberId_From, vbBranchId_From, vbAccountDirectionId_From, vbIsPartionDate_Unit
               , vbJuridicalId_To, vbIsCorporate_To, vbInfoMoneyId_CorporateTo, vbPartnerId_To , vbMemberId_To, vbInfoMoneyId_To
               , vbPaidKindId, vbContractId
               , vbJuridicalId_Basis_From, vbBusinessId_From
               , vbCurrencyDocumentId, vbCurrencyPartnerId, vbCurrencyValue, vbParValue, vbCurrencyPartnerValue, vbParPartnerValue
     FROM Movement
          LEFT JOIN MovementDate AS MovementDate_OperDatePartner
                                 ON MovementDate_OperDatePartner.MovementId =  Movement.Id
                                AND MovementDate_OperDatePartner.DescId = zc_MovementDate_OperDatePartner()
          LEFT JOIN MovementBoolean AS MovementBoolean_PriceWithVAT
                   ON MovementBoolean_PriceWithVAT.MovementId = Movement.Id
                  AND MovementBoolean_PriceWithVAT.DescId = zc_MovementBoolean_PriceWithVAT()
          LEFT JOIN MovementFloat AS MovementFloat_VATPercent
                   ON MovementFloat_VATPercent.MovementId = Movement.Id
                  AND MovementFloat_VATPercent.DescId = zc_MovementFloat_VATPercent()
          LEFT JOIN MovementFloat AS MovementFloat_ChangePercent
                 ON MovementFloat_ChangePercent.MovementId = Movement.Id
                AND MovementFloat_ChangePercent.DescId = zc_MovementFloat_ChangePercent()

          LEFT JOIN MovementLinkObject AS MovementLinkObject_From
                                       ON MovementLinkObject_From.MovementId = Movement.Id
                                      AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
          LEFT JOIN Object AS Object_From ON Object_From.Id = MovementLinkObject_From.ObjectId

          LEFT JOIN MovementLinkObject AS MovementLinkObject_CurrencyDocument
                                       ON MovementLinkObject_CurrencyDocument.MovementId = Movement.Id
                                      AND MovementLinkObject_CurrencyDocument.DescId = zc_MovementLinkObject_CurrencyDocument()
          LEFT JOIN MovementLinkObject AS MovementLinkObject_CurrencyPartner
                                       ON MovementLinkObject_CurrencyPartner.MovementId = Movement.Id
                                      AND MovementLinkObject_CurrencyPartner.DescId = zc_MovementLinkObject_CurrencyPartner()
          LEFT JOIN MovementFloat AS MovementFloat_CurrencyValue
                                  ON MovementFloat_CurrencyValue.MovementId = Movement.Id
                                 AND MovementFloat_CurrencyValue.DescId = zc_MovementFloat_CurrencyValue()
          LEFT JOIN MovementFloat AS MovementFloat_ParValue
                                  ON MovementFloat_ParValue.MovementId = Movement.Id
                                 AND MovementFloat_ParValue.DescId = zc_MovementFloat_ParValue()
          LEFT JOIN MovementFloat AS MovementFloat_CurrencyPartnerValue
                                  ON MovementFloat_CurrencyPartnerValue.MovementId = Movement.Id
                                 AND MovementFloat_CurrencyPartnerValue.DescId = zc_MovementFloat_CurrencyPartnerValue()
          LEFT JOIN MovementFloat AS MovementFloat_ParPartnerValue
                                  ON MovementFloat_ParPartnerValue.MovementId = Movement.Id
                                 AND MovementFloat_ParPartnerValue.DescId = zc_MovementFloat_ParPartnerValue()

          LEFT JOIN ObjectLink AS ObjectLink_UnitFrom_Branch
                               ON ObjectLink_UnitFrom_Branch.ObjectId = MovementLinkObject_From.ObjectId
                              AND ObjectLink_UnitFrom_Branch.DescId = zc_ObjectLink_Unit_Branch()
                              AND Object_From.DescId = zc_Object_Unit()
          LEFT JOIN ObjectLink AS ObjectLink_UnitFrom_AccountDirection
                               ON ObjectLink_UnitFrom_AccountDirection.ObjectId = MovementLinkObject_From.ObjectId
                              AND ObjectLink_UnitFrom_AccountDirection.DescId = zc_ObjectLink_Unit_AccountDirection()
                              AND Object_From.DescId = zc_Object_Unit()
          LEFT JOIN ObjectBoolean AS ObjectBoolean_PartionDate
                                  ON ObjectBoolean_PartionDate.ObjectId = MovementLinkObject_From.ObjectId
                                 AND ObjectBoolean_PartionDate.DescId = zc_ObjectBoolean_Unit_PartionDate()
                                 AND Object_From.DescId = zc_Object_Unit()
          LEFT JOIN ObjectLink AS ObjectLink_UnitFrom_Juridical
                               ON ObjectLink_UnitFrom_Juridical.ObjectId = MovementLinkObject_From.ObjectId
                              AND ObjectLink_UnitFrom_Juridical.DescId = zc_ObjectLink_Unit_Juridical()
                              AND Object_From.DescId = zc_Object_Unit()
          LEFT JOIN ObjectLink AS ObjectLink_UnitFrom_Business
                               ON ObjectLink_UnitFrom_Business.ObjectId = MovementLinkObject_From.ObjectId
                              AND ObjectLink_UnitFrom_Business.DescId = zc_ObjectLink_Unit_Business()
                              AND Object_From.DescId = zc_Object_Unit()

          LEFT JOIN ObjectLink AS ObjectLink_PersonalFrom_Member
                               ON ObjectLink_PersonalFrom_Member.ObjectId = MovementLinkObject_From.ObjectId
                              AND ObjectLink_PersonalFrom_Member.DescId = zc_ObjectLink_Personal_Member()
                              AND Object_From.DescId = zc_Object_Personal()
          LEFT JOIN ObjectLink AS ObjectLink_PersonalFrom_Unit
                               ON ObjectLink_PersonalFrom_Unit.ObjectId = MovementLinkObject_From.ObjectId
                              AND ObjectLink_PersonalFrom_Unit.DescId = zc_ObjectLink_Personal_Unit()
                              AND Object_From.DescId = zc_Object_Personal()
          LEFT JOIN ObjectLink AS ObjectLink_UnitPersonalFrom_Branch
                               ON ObjectLink_UnitPersonalFrom_Branch.ObjectId = ObjectLink_PersonalFrom_Unit.ChildObjectId
                              AND ObjectLink_UnitPersonalFrom_Branch.DescId = zc_ObjectLink_Unit_Branch()
                              AND Object_From.DescId = zc_Object_Personal()
          LEFT JOIN ObjectLink AS ObjectLink_UnitPersonalFrom_Juridical
                               ON ObjectLink_UnitPersonalFrom_Juridical.ObjectId = ObjectLink_PersonalFrom_Unit.ChildObjectId
                              AND ObjectLink_UnitPersonalFrom_Juridical.DescId = zc_ObjectLink_Unit_Juridical()
                              AND Object_From.DescId = zc_Object_Personal()
          LEFT JOIN ObjectLink AS ObjectLink_UnitPersonalFrom_Business
                               ON ObjectLink_UnitPersonalFrom_Business.ObjectId = ObjectLink_PersonalFrom_Unit.ChildObjectId
                              AND ObjectLink_UnitPersonalFrom_Business.DescId = zc_ObjectLink_Unit_Business()
                              AND Object_From.DescId = zc_Object_Personal()

          LEFT JOIN MovementLinkObject AS MovementLinkObject_To
                                       ON MovementLinkObject_To.MovementId = Movement.Id
                                      AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
          LEFT JOIN Object AS Object_To ON Object_To.Id = MovementLinkObject_To.ObjectId

          LEFT JOIN ObjectLink AS ObjectLink_PersonalTo_Member
                               ON ObjectLink_PersonalTo_Member.ObjectId = MovementLinkObject_To.ObjectId
                              AND ObjectLink_PersonalTo_Member.DescId = zc_ObjectLink_Personal_Member()
                              AND Object_To.DescId = zc_Object_Personal()
          LEFT JOIN ObjectLink AS ObjectLink_Partner_Juridical
                               ON ObjectLink_Partner_Juridical.ObjectId = MovementLinkObject_To.ObjectId
                              AND ObjectLink_Partner_Juridical.DescId = zc_ObjectLink_Partner_Juridical()
                              AND Object_To.DescId = zc_Object_Partner()
          LEFT JOIN ObjectBoolean AS ObjectBoolean_isCorporate
                                  ON ObjectBoolean_isCorporate.ObjectId = ObjectLink_Partner_Juridical.ChildObjectId
                                 AND ObjectBoolean_isCorporate.DescId = zc_ObjectBoolean_Juridical_isCorporate()
          LEFT JOIN ObjectLink AS ObjectLink_Juridical_InfoMoney
                               ON ObjectLink_Juridical_InfoMoney.ObjectId = ObjectLink_Partner_Juridical.ChildObjectId
                              AND ObjectLink_Juridical_InfoMoney.DescId = zc_ObjectLink_Juridical_InfoMoney()
          LEFT JOIN Constant_InfoMoney_isCorporate_View ON Constant_InfoMoney_isCorporate_View.InfoMoneyId = ObjectLink_Juridical_InfoMoney.ChildObjectId

          LEFT JOIN MovementLinkObject AS MovementLinkObject_PaidKind
                                       ON MovementLinkObject_PaidKind.MovementId = Movement.Id
                                      AND MovementLinkObject_PaidKind.DescId = zc_MovementLinkObject_PaidKind()
          LEFT JOIN MovementLinkObject AS MovementLinkObject_Contract
                                       ON MovementLinkObject_Contract.MovementId = Movement.Id
                                      AND MovementLinkObject_Contract.DescId = zc_MovementLinkObject_Contract()
          LEFT JOIN ObjectLink AS ObjectLink_Contract_InfoMoney
                               ON ObjectLink_Contract_InfoMoney.ObjectId = MovementLinkObject_Contract.ObjectId
                              AND ObjectLink_Contract_InfoMoney.DescId = zc_ObjectLink_Contract_InfoMoney()

     WHERE Movement.Id = inMovementId
       AND Movement.DescId = zc_Movement_Sale()
       AND Movement.StatusId IN (zc_Enum_Status_UnComplete(), zc_Enum_Status_Erased());


     -- ������������ �������������� ����������, �������� ����� ��� ��� ������������ �������� � ��������� (��� ����������)
     SELECT View_InfoMoney.InfoMoneyDestinationId INTO vbInfoMoneyDestinationId_To FROM lfGet_Object_InfoMoney (vbInfoMoneyId_To) AS View_InfoMoney;

     -- !!!���� ��� ������� ��� "�������� ������������", ����� ��� "������� ������"
     IF vbInfoMoneyDestinationId_To IN (zc_Enum_InfoMoneyDestination_30100() -- ���������
                                      , zc_Enum_InfoMoneyDestination_30200() -- ������ �����
                                       )
        AND vbBranchId_From = 0
     THEN
         vbBranchId_From:= zc_Branch_Basis();
     END IF;


     -- ��������� ������� - �������������� �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     INSERT INTO _tmpItem (MovementItemId
                         , ContainerId_Goods, ContainerId_GoodsPartner, GoodsId, GoodsKindId, AssetId, PartionGoods, PartionGoodsDate
                         , OperCount, OperCount_ChangePercent, OperCount_Partner, tmpOperSumm_PriceList, OperSumm_PriceList, tmpOperSumm_Partner, tmpOperSumm_Partner_original, OperSumm_Partner, OperSumm_Partner_ChangePercent, OperSumm_Currency, OperSumm_80103
                         , ContainerId_ProfitLoss_10100, ContainerId_ProfitLoss_10200, ContainerId_ProfitLoss_10300, ContainerId_ProfitLoss_80103
                         , ContainerId_Partner, ContainerId_Currency, AccountId_Partner, ContainerId_Transit, AccountId_Transit, InfoMoneyDestinationId, InfoMoneyId
                         , BusinessId_From
                         , isPartionCount, isPartionSumm, isTareReturning, isLossMaterials
                         , PartionGoodsId
                         , PriceListPrice, Price, Price_original, CountForPrice)
        SELECT
              _tmp.MovementItemId
            , 0 AS ContainerId_Goods
            , 0 AS ContainerId_GoodsPartner
            , _tmp.GoodsId
            , _tmp.GoodsKindId
            , _tmp.AssetId
            , _tmp.PartionGoods
            , _tmp.PartionGoodsDate

            , _tmp.OperCount
            , _tmp.OperCount_ChangePercent
            , _tmp.OperCount_Partner
              -- ������������� (� ����� ���-��) ����� �����-����� �� ����������� !!!��� ������!!! - � ����������� �� 2-� ������
            , _tmp.tmpOperSumm_PriceList
              -- �������� ����� �����-����� �� ����������� !!! ��� ������ !!!
            , CASE WHEN vbPriceWithVAT_PriceList OR vbVATPercent_PriceList = 0
                      -- ���� ���� � ��� ��� %���=0, ����� ������ �� ������
                      THEN _tmp.tmpOperSumm_PriceList
                   WHEN vbVATPercent_PriceList > 0
                      -- ���� ���� ��� ���, ����� �������� ����� � ���
                      THEN CAST ( (1 + vbVATPercent_PriceList / 100) * _tmp.tmpOperSumm_PriceList AS NUMERIC (16, 2))
              END AS OperSumm_PriceList

              -- ������������� (� ����� ���-��) ����� �� ����������� !!!����� ��� ������(�.�. ������ ���� ����)!!! - � ����������� �� 2-� ������
            , _tmp.tmpOperSumm_Partner
              -- ������������� (� ����� ���-��) ����� �� ����������� !!!��� ������!!! - � ����������� �� 2-� ������
            , _tmp.tmpOperSumm_Partner_original

              -- �������� ����� �� ����������� !!!��� ������!!!
            , CAST
             (CASE WHEN vbPriceWithVAT = TRUE  OR vbVATPercent = 0
                      -- ���� ���� � ��� ��� %���=0, ����� ������ �� ������
                      THEN _tmp.tmpOperSumm_Partner_original
                   WHEN vbVATPercent > 0
                      -- ���� ���� ��� ���, ����� �������� ����� � ���
                      THEN CAST ( (1 + vbVATPercent / 100) * _tmp.tmpOperSumm_Partner_original AS NUMERIC (16, 2))
              END   -- ��� ����������� � ������ zc_Enum_Currency_Basis
                  * CASE WHEN vbCurrencyDocumentId <> zc_Enum_Currency_Basis() THEN CASE WHEN vbParValue = 0 THEN 0 ELSE vbCurrencyValue / vbParValue END ELSE 1 END
              AS NUMERIC (16, 2)) AS OperSumm_Partner -- !!!���������!!!


              -- �������� ����� �� �����������
            , CAST
             (CASE WHEN vbPriceWithVAT = TRUE OR vbVATPercent = 0
                      -- ���� ���� � ��� ��� %���=0, ����� ��������� ��� % ������ ��� % ������� !!!�� ��� �� ������/������� ������ � ����!!!
                      THEN CASE WHEN vbPaidKindId = zc_Enum_PaidKind_SecondForm() AND vbDiscountPercent > 0 THEN CAST ( (1 - vbDiscountPercent / 100) * _tmp.tmpOperSumm_Partner AS NUMERIC (16, 2))
                                WHEN vbPaidKindId = zc_Enum_PaidKind_SecondForm() AND vbExtraChargesPercent > 0 THEN CAST ( (1 + vbExtraChargesPercent / 100) * _tmp.tmpOperSumm_Partner AS NUMERIC (16, 2))
                                ELSE _tmp.tmpOperSumm_Partner
                           END
                   WHEN vbVATPercent > 0
                      -- ���� ���� ��� ���, ����� ��������� ��� % ������ ��� % ������� ��� ����� � ��� (���� ������� ����� � ��� ��� � ��� ��) !!!�� ��� �� ������/������� ������ � ����!!!
                      THEN CASE WHEN vbPaidKindId = zc_Enum_PaidKind_SecondForm() AND vbDiscountPercent > 0 THEN CAST ( (1 - vbDiscountPercent/100) * (CAST ( (1 + vbVATPercent / 100) * _tmp.tmpOperSumm_Partner AS NUMERIC (16, 2))) AS NUMERIC (16, 2))
                                WHEN vbPaidKindId = zc_Enum_PaidKind_SecondForm() AND vbExtraChargesPercent > 0 THEN CAST ( (1 + vbExtraChargesPercent/100) * (CAST ( (1 + vbVATPercent / 100) * _tmp.tmpOperSumm_Partner AS NUMERIC (16, 2))) AS NUMERIC (16, 2))
                                ELSE CAST ( (1 + vbVATPercent / 100) * _tmp.tmpOperSumm_Partner AS NUMERIC (16, 2))
                           END
                   WHEN vbVATPercent > 0
                      -- ���� ���� ��� ���, ����� ��������� ��� % ������ ��� % ������� ��� ����� ��� ���, ��������� �� 2-� ������, � ����� ��������� ��� (���� ������� ����� ������������ ��� ��) !!!�� ��� �� ������/������� ������ � ����!!!
                      THEN CASE WHEN 1=0 AND vbDiscountPercent > 0 THEN CAST ( (1 + vbVATPercent / 100) * CAST ( (1 - vbDiscountPercent/100) * _tmp.tmpOperSumm_Partner AS NUMERIC (16, 2)) AS NUMERIC (16, 2))
                                WHEN 1=0 AND vbExtraChargesPercent > 0 THEN CAST ( (1 + vbVATPercent / 100) * CAST ( (1 + vbExtraChargesPercent/100) * _tmp.tmpOperSumm_Partner AS NUMERIC (16, 2)) AS NUMERIC (16, 2))
                                ELSE CAST ( (1 + vbVATPercent / 100) * (_tmp.tmpOperSumm_Partner) AS NUMERIC (16, 2))
                           END
              END   -- ��� ����������� � ������ zc_Enum_Currency_Basis
                  * CASE WHEN vbCurrencyDocumentId <> zc_Enum_Currency_Basis() THEN CASE WHEN vbParValue = 0 THEN 0 ELSE vbCurrencyValue / vbParValue END ELSE 1 END
              AS NUMERIC (16, 2)) AS OperSumm_Partner_ChangePercent  -- !!!���������!!!

              -- �������� ����� � ������ �� �����������
            , CAST
             (CASE WHEN vbPriceWithVAT = TRUE OR vbVATPercent = 0
                      -- ���� ���� � ��� ��� %���=0, ����� ��������� ��� % ������ ��� % ������� !!!�� ��� �� ������/������� ������ � ����!!!
                      THEN CASE WHEN vbPaidKindId = zc_Enum_PaidKind_SecondForm() AND vbDiscountPercent > 0 THEN CAST ( (1 - vbDiscountPercent / 100) * _tmp.tmpOperSumm_Partner AS NUMERIC (16, 2))
                                WHEN vbPaidKindId = zc_Enum_PaidKind_SecondForm() AND vbExtraChargesPercent > 0 THEN CAST ( (1 + vbExtraChargesPercent / 100) * _tmp.tmpOperSumm_Partner AS NUMERIC (16, 2))
                                ELSE _tmp.tmpOperSumm_Partner
                           END
                   WHEN vbVATPercent > 0
                      -- ���� ���� ��� ���, ����� ��������� ��� % ������ ��� % ������� ��� ����� � ��� (���� ������� ����� � ��� ��� � ��� ��) !!!�� ��� �� ������/������� ������ � ����!!!
                      THEN CASE WHEN vbPaidKindId = zc_Enum_PaidKind_SecondForm() AND vbDiscountPercent > 0 THEN CAST ( (1 - vbDiscountPercent/100) * (CAST ( (1 + vbVATPercent / 100) * _tmp.tmpOperSumm_Partner AS NUMERIC (16, 2))) AS NUMERIC (16, 2))
                                WHEN vbPaidKindId = zc_Enum_PaidKind_SecondForm() AND vbExtraChargesPercent > 0 THEN CAST ( (1 + vbExtraChargesPercent/100) * (CAST ( (1 + vbVATPercent / 100) * _tmp.tmpOperSumm_Partner AS NUMERIC (16, 2))) AS NUMERIC (16, 2))
                                ELSE CAST ( (1 + vbVATPercent / 100) * _tmp.tmpOperSumm_Partner AS NUMERIC (16, 2))
                           END
                   WHEN vbVATPercent > 0
                      -- ���� ���� ��� ���, ����� ��������� ��� % ������ ��� % ������� ��� ����� ��� ���, ��������� �� 2-� ������, � ����� ��������� ��� (���� ������� ����� ������������ ��� ��) !!!�� ��� �� ������/������� ������ � ����!!!
                      THEN CASE WHEN 1=0 AND vbDiscountPercent > 0 THEN CAST ( (1 + vbVATPercent / 100) * CAST ( (1 - vbDiscountPercent/100) * _tmp.tmpOperSumm_Partner AS NUMERIC (16, 2)) AS NUMERIC (16, 2))
                                WHEN 1=0 AND vbExtraChargesPercent > 0 THEN CAST ( (1 + vbVATPercent / 100) * CAST ( (1 + vbExtraChargesPercent/100) * _tmp.tmpOperSumm_Partner AS NUMERIC (16, 2)) AS NUMERIC (16, 2))
                                ELSE CAST ( (1 + vbVATPercent / 100) * (_tmp.tmpOperSumm_Partner) AS NUMERIC (16, 2))
                           END
              END   -- ��� ����������� � ������ CurrencyPartnerId
                  * CASE WHEN vbCurrencyPartnerId <> vbCurrencyDocumentId THEN CASE WHEN vbParPartnerValue = 0 THEN 0 ELSE vbCurrencyPartnerValue /  vbParPartnerValue END ELSE CASE WHEN vbCurrencyPartnerId = zc_Enum_Currency_Basis() THEN 0 ELSE 1 END END
              AS NUMERIC (16, 2)) AS OperSumm_Currency -- !!!���������!!!

            , 0 AS OperSumm_80103

              -- ���� - ������� (���� - ����� ����������)
            , 0 AS ContainerId_ProfitLoss_10100
              -- ���� - ������� (���� - ������ �� ������)
            , 0 AS ContainerId_ProfitLoss_10200
              -- ���� - ������� (���� - ������ ��������������)
            , 0 AS ContainerId_ProfitLoss_10300
              -- ���� - ������� (���� - �������� �������)
            , 0 AS ContainerId_ProfitLoss_80103

              -- ���� - ���� �����������
            , 0 AS ContainerId_Partner
              -- ���� - ���� ����������� � ������
            , 0 AS ContainerId_Currency
              -- ����(�����������) �����������
            , 0 AS AccountId_Partner 
              -- ���� - ���� �������
            , 0 AS ContainerId_Transit
              -- ����(�����������) �������
            , 0 AS AccountId_Transit
              -- �������������� ����������
            , _tmp.InfoMoneyDestinationId
              -- ������ ����������
            , _tmp.InfoMoneyId

              -- �������� ������ !!!����������!!! �� ������ ��� ������������/����������
            , CASE WHEN _tmp.BusinessId_From = 0 THEN vbBusinessId_From ELSE _tmp.BusinessId_From END AS BusinessId_From

            , _tmp.isPartionCount
            , _tmp.isPartionSumm 

              -- ���������� �� ��� ���� (���� ��, ������������� �������� �� �������)
            , CASE WHEN _tmp.Price = 0
                    AND _tmp.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20500() -- 20500; "��������� ����"
                        THEN TRUE
                   ELSE FALSE
              END AS isTareReturning

              -- �������� ������ ����� �� ��� (���� ��, ������ �� ������ ��� �������� �� ������, ����� ��� ����� �������� ��������)
            , CASE WHEN _tmp.Price = 0
                    AND _tmp.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20600() -- 10200; "������ �����"
                        THEN TRUE
                   ELSE FALSE
              END AS isLossMaterials

              -- ������ ������, ���������� �����
            , 0 AS PartionGoodsId


            , _tmp.PriceListPrice
            , _tmp.Price
            , _tmp.Price_original
            , _tmp.CountForPrice

        FROM 
             (SELECT
                    tmpMI.MovementItemId
                  , tmpMI.GoodsId
                  , CASE WHEN View_InfoMoney.InfoMoneyId IN (zc_Enum_InfoMoney_20901(), zc_Enum_InfoMoney_30101(), zc_Enum_InfoMoney_30201()) THEN tmpMI.GoodsKindId ELSE 0 END AS GoodsKindId -- ���� + ������� ��������� + ������ ������ �����
                  , COALESCE (MILinkObject_Asset.ObjectId, 0) AS AssetId
                  , COALESCE (MIString_PartionGoods.ValueData, '') AS PartionGoods
                  , COALESCE (MIDate_PartionGoods.ValueData, zc_DateEnd()) AS PartionGoodsDate
 
                  , lfObjectHistory_PriceListItem.ValuePrice AS PriceListPrice
                  , tmpMI.Price
                  , tmpMI.Price_original
                  , tmpMI.CountForPrice
                    -- ���������� ��� ������
                  , tmpMI.OperCount
                    -- ���������� � ������ % ������
                  , tmpMI.OperCount_ChangePercent
                    -- ���������� � �����������
                  , tmpMI.OperCount_Partner

                    -- ������������� ����� �����-����� �� ����������� - � ����������� �� 2-� ������
                  , COALESCE (CAST (tmpMI.OperCount_Partner * lfObjectHistory_PriceListItem.ValuePrice AS NUMERIC (16, 2)), 0) AS tmpOperSumm_PriceList
                    -- ������������� ����� �� ����������� - � ����������� �� 2-� ������ + ������ ������ � ���� (!!!���� ����!!!)
                  , CASE WHEN tmpMI.CountForPrice <> 0 THEN CAST (tmpMI.OperCount_Partner * tmpMI.Price / tmpMI.CountForPrice AS NUMERIC (16, 2))
                                                       ELSE CAST (tmpMI.OperCount_Partner * tmpMI.Price AS NUMERIC (16, 2))
                    END AS tmpOperSumm_Partner
                    -- ������������� ����� �� ����������� - � ����������� �� 2-� ������ + !!!��!!! ������ ������ � ����
                  , CASE WHEN tmpMI.CountForPrice <> 0 THEN CAST (tmpMI.OperCount_Partner * tmpMI.Price_original / tmpMI.CountForPrice AS NUMERIC (16, 2))
                                                       ELSE CAST (tmpMI.OperCount_Partner * tmpMI.Price_original AS NUMERIC (16, 2))
                    END AS tmpOperSumm_Partner_original

                    -- �������������� ����������
                  , COALESCE (View_InfoMoney.InfoMoneyDestinationId, 0) AS InfoMoneyDestinationId
                    -- ������ ����������
                  , COALESCE (View_InfoMoney.InfoMoneyId, 0) AS InfoMoneyId

                    -- ������ �� ������
                  , COALESCE (ObjectLink_Goods_Business.ChildObjectId, 0) AS BusinessId_From

                  , COALESCE (ObjectBoolean_PartionCount.ValueData, FALSE)      AS isPartionCount
                  , COALESCE (ObjectBoolean_PartionSumm.ValueData, FALSE)       AS isPartionSumm

              FROM
             (SELECT (MovementItem.Id) AS MovementItemId
                   , MovementItem.ObjectId AS GoodsId
                   , COALESCE (MILinkObject_GoodsKind.ObjectId, 0) AS GoodsKindId

                   , SUM (MovementItem.Amount) AS OperCount
                   , SUM (COALESCE (MIFloat_AmountChangePercent.ValueData, 0)) AS OperCount_ChangePercent
                   , SUM (COALESCE (MIFloat_AmountPartner.ValueData, 0)) AS OperCount_Partner
                   , CASE WHEN vbDiscountPercent <> 0 AND vbPaidKindId <> zc_Enum_PaidKind_SecondForm() -- !!!��� ��� �� ���������!!!
                               THEN CAST ( (1 - vbDiscountPercent / 100) * COALESCE (MIFloat_Price.ValueData, 0) AS NUMERIC (16, 2))
                          WHEN vbExtraChargesPercent <> 0 AND vbPaidKindId <> zc_Enum_PaidKind_SecondForm() -- !!!��� ��� �� ���������!!!
                               THEN CAST ( (1 + vbExtraChargesPercent / 100) * COALESCE (MIFloat_Price.ValueData, 0) AS NUMERIC (16, 2))
                          ELSE COALESCE (MIFloat_Price.ValueData, 0)
                     END AS Price
                   , COALESCE (MIFloat_Price.ValueData, 0) AS Price_original
                   , COALESCE (MIFloat_CountForPrice.ValueData, 0) AS CountForPrice

              FROM Movement
                   JOIN MovementItem ON MovementItem.MovementId = Movement.Id AND MovementItem.DescId = zc_MI_Master() AND MovementItem.isErased = FALSE

                   LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                                    ON MILinkObject_GoodsKind.MovementItemId = MovementItem.Id
                                                   AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()

                   LEFT JOIN MovementItemFloat AS MIFloat_AmountChangePercent
                                               ON MIFloat_AmountChangePercent.MovementItemId = MovementItem.Id
                                              AND MIFloat_AmountChangePercent.DescId = zc_MIFloat_AmountChangePercent()
                   LEFT JOIN MovementItemFloat AS MIFloat_AmountPartner
                                               ON MIFloat_AmountPartner.MovementItemId = MovementItem.Id
                                              AND MIFloat_AmountPartner.DescId = zc_MIFloat_AmountPartner()

                   LEFT JOIN MovementItemFloat AS MIFloat_Price
                                               ON MIFloat_Price.MovementItemId = MovementItem.Id
                                              AND MIFloat_Price.DescId = zc_MIFloat_Price()
                   LEFT JOIN MovementItemFloat AS MIFloat_CountForPrice
                                               ON MIFloat_CountForPrice.MovementItemId = MovementItem.Id
                                              AND MIFloat_CountForPrice.DescId = zc_MIFloat_CountForPrice()
              WHERE Movement.Id = inMovementId
                AND Movement.DescId = zc_Movement_Sale()
                AND Movement.StatusId IN (zc_Enum_Status_UnComplete(), zc_Enum_Status_Erased())
              GROUP BY MovementItem.Id
                     , MovementItem.ObjectId
                     , MILinkObject_GoodsKind.ObjectId
                     , MIFloat_Price.ValueData
                     , MIFloat_CountForPrice.ValueData
             ) AS tmpMI

                   LEFT JOIN MovementItemLinkObject AS MILinkObject_Asset
                                                    ON MILinkObject_Asset.MovementItemId = tmpMI.MovementItemId
                                                   AND MILinkObject_Asset.DescId = zc_MILinkObject_Asset()

                   LEFT JOIN MovementItemString AS MIString_PartionGoods
                                                ON MIString_PartionGoods.MovementItemId = tmpMI.MovementItemId
                                               AND MIString_PartionGoods.DescId = zc_MIString_PartionGoods()
                   LEFT JOIN MovementItemDate AS MIDate_PartionGoods
                                              ON MIDate_PartionGoods.MovementItemId = tmpMI.MovementItemId
                                             AND MIDate_PartionGoods.DescId = zc_MIDate_PartionGoods()

                   LEFT JOIN ObjectBoolean AS ObjectBoolean_PartionCount
                                           ON ObjectBoolean_PartionCount.ObjectId = tmpMI.GoodsId
                                          AND ObjectBoolean_PartionCount.DescId = zc_ObjectBoolean_Goods_PartionCount()
                   LEFT JOIN ObjectBoolean AS ObjectBoolean_PartionSumm
                                           ON ObjectBoolean_PartionSumm.ObjectId = tmpMI.GoodsId
                                          AND ObjectBoolean_PartionSumm.DescId = zc_ObjectBoolean_Goods_PartionSumm()

                   LEFT JOIN ObjectLink AS ObjectLink_Goods_Business
                                        ON ObjectLink_Goods_Business.ObjectId = tmpMI.GoodsId
                                       AND ObjectLink_Goods_Business.DescId = zc_ObjectLink_Goods_Business()
                   LEFT JOIN ObjectLink AS ObjectLink_Goods_InfoMoney
                                        ON ObjectLink_Goods_InfoMoney.ObjectId = tmpMI.GoodsId
                                       AND ObjectLink_Goods_InfoMoney.DescId = zc_ObjectLink_Goods_InfoMoney()
                   LEFT JOIN Object_InfoMoney_View AS View_InfoMoney ON View_InfoMoney.InfoMoneyId = ObjectLink_Goods_InfoMoney.ChildObjectId

                   LEFT JOIN lfSelect_ObjectHistory_PriceListItem (inPriceListId:= zc_PriceList_Basis(), inOperDate:= vbOperDatePartner)
                          AS lfObjectHistory_PriceListItem ON lfObjectHistory_PriceListItem.GoodsId = tmpMI.GoodsId
             ) AS _tmp;


     -- ��������
     IF COALESCE (vbContractId, 0) = 0 AND (EXISTS (SELECT _tmpItem.isTareReturning FROM _tmpItem WHERE _tmpItem.isTareReturning = FALSE))
     THEN
         RAISE EXCEPTION '������.� ��������� �� ��������� <�������>.���������� ����������.';
     END IF;


     -- !!!
     -- IF NOT EXISTS (SELECT MovementItemId FROM _tmpItem) THEN RETURN; END IF;


     -- ������� ����
     SELECT -- ������ �������� ����� �����-����� �� �����������
            CASE WHEN vbPriceWithVAT_PriceList OR vbVATPercent_PriceList = 0
                    -- ���� ���� � ��� ��� %���=0, ����� ������ �� ������
                    THEN _tmpItem.tmpOperSumm_PriceList
                 WHEN vbVATPercent_PriceList > 0
                    -- ���� ���� ��� ���, ����� �������� ����� � ���
                    THEN CAST ( (1 + vbVATPercent_PriceList / 100) * _tmpItem.tmpOperSumm_PriceList AS NUMERIC (16, 2))
            END AS OperSumm_PriceList

            -- ������ �������� ����� �� ����������� !!!��� ������!!!
          , CAST
           (CASE WHEN vbPriceWithVAT OR vbVATPercent = 0
                    -- ���� ���� � ��� ��� %���=0, ����� ������ �� ������
                    THEN _tmpItem.tmpOperSumm_Partner_original
                 WHEN vbVATPercent > 0
                    -- ���� ���� ��� ���, ����� �������� ����� � ���
                    THEN CAST ( (1 + vbVATPercent / 100) * _tmpItem.tmpOperSumm_Partner_original AS NUMERIC (16, 2))
            END   -- ��� ����������� � ������ zc_Enum_Currency_Basis
                * CASE WHEN vbCurrencyDocumentId <> zc_Enum_Currency_Basis() THEN CASE WHEN vbParValue = 0 THEN 0 ELSE vbCurrencyValue / vbParValue END ELSE 1 END
            AS NUMERIC (16, 2)) AS OperSumm_Partner  -- !!!���������!!!

            -- ������ �������� ����� �� �����������
          , CAST
           (CASE WHEN vbPriceWithVAT OR vbVATPercent = 0
                    -- ���� ���� � ��� ��� %���=0, ����� ��������� ��� % ������ ��� % ������� !!!�� ��� �� ������/������� ������ � ����!!!
                    THEN CASE WHEN vbPaidKindId = zc_Enum_PaidKind_SecondForm() AND vbDiscountPercent > 0 THEN CAST ( (1 - vbDiscountPercent / 100) * _tmpItem.tmpOperSumm_Partner AS NUMERIC (16, 2))
                              WHEN vbPaidKindId = zc_Enum_PaidKind_SecondForm() AND vbExtraChargesPercent > 0 THEN CAST ( (1 + vbExtraChargesPercent / 100) * _tmpItem.tmpOperSumm_Partner AS NUMERIC (16, 2))
                              ELSE _tmpItem.tmpOperSumm_Partner
                         END
                 WHEN vbVATPercent > 0
                    -- ���� ���� ��� ���, ����� ��������� ��� % ������ ��� % ������� ��� ����� � ��� (���� ������� ����� � ��� ��� � ��� ��) !!!�� ��� �� ������/������� ������ � ����!!!
                    THEN CASE WHEN vbPaidKindId = zc_Enum_PaidKind_SecondForm() AND vbDiscountPercent > 0 THEN CAST ( (1 - vbDiscountPercent/100) * (CAST ( (1 + vbVATPercent / 100) * _tmpItem.tmpOperSumm_Partner AS NUMERIC (16, 2))) AS NUMERIC (16, 2))
                              WHEN vbPaidKindId = zc_Enum_PaidKind_SecondForm() AND vbExtraChargesPercent > 0 THEN CAST ( (1 + vbExtraChargesPercent/100) * (CAST ( (1 + vbVATPercent / 100) * _tmpItem.tmpOperSumm_Partner AS NUMERIC (16, 2))) AS NUMERIC (16, 2))
                              ELSE CAST ( (1 + vbVATPercent / 100) * _tmpItem.tmpOperSumm_Partner AS NUMERIC (16, 2))
                         END
                 WHEN vbVATPercent > 0
                    -- ���� ���� ��� ���, ����� ��������� ��� % ������ ��� % ������� ��� ����� ��� ���, ��������� �� 2-� ������, � ����� ��������� ��� (���� ������� ����� ������������ ��� ��) !!!�� ��� �� ������/������� ������ � ����!!!
                    THEN CASE WHEN 1=0 AND vbDiscountPercent > 0 THEN CAST ( (1 + vbVATPercent / 100) * CAST ( (1 - vbDiscountPercent/100) * _tmpItem.tmpOperSumm_Partner AS NUMERIC (16, 2)) AS NUMERIC (16, 2))
                              WHEN 1=0 AND vbExtraChargesPercent > 0 THEN CAST ( (1 + vbVATPercent / 100) * CAST ( (1 + vbExtraChargesPercent/100) * _tmpItem.tmpOperSumm_Partner AS NUMERIC (16, 2)) AS NUMERIC (16, 2))
                              ELSE CAST ( (1 + vbVATPercent / 100) * _tmpItem.tmpOperSumm_Partner AS NUMERIC (16, 2))
                         END
            END   -- ��� ����������� � ������ zc_Enum_Currency_Basis
                * CASE WHEN vbCurrencyDocumentId <> zc_Enum_Currency_Basis() THEN CASE WHEN vbParValue = 0 THEN 0 ELSE vbCurrencyValue / vbParValue END ELSE 1 END
            AS NUMERIC (16, 2)) AS OperSumm_Partner_ChangePercent  -- !!!���������!!!

            -- ������ �������� ����� � ������ �� �����������
          , CAST
           (CASE WHEN vbPriceWithVAT OR vbVATPercent = 0
                    -- ���� ���� � ��� ��� %���=0, ����� ��������� ��� % ������ ��� % ������� !!!�� ��� �� ������/������� ������ � ����!!!
                    THEN CASE WHEN vbPaidKindId = zc_Enum_PaidKind_SecondForm() AND vbDiscountPercent > 0 THEN CAST ( (1 - vbDiscountPercent / 100) * _tmpItem.tmpOperSumm_Partner AS NUMERIC (16, 2))
                              WHEN vbPaidKindId = zc_Enum_PaidKind_SecondForm() AND vbExtraChargesPercent > 0 THEN CAST ( (1 + vbExtraChargesPercent / 100) * _tmpItem.tmpOperSumm_Partner AS NUMERIC (16, 2))
                              ELSE _tmpItem.tmpOperSumm_Partner
                         END
                 WHEN vbVATPercent > 0
                    -- ���� ���� ��� ���, ����� ��������� ��� % ������ ��� % ������� ��� ����� � ��� (���� ������� ����� � ��� ��� � ��� ��) !!!�� ��� �� ������/������� ������ � ����!!!
                    THEN CASE WHEN vbPaidKindId = zc_Enum_PaidKind_SecondForm() AND vbDiscountPercent > 0 THEN CAST ( (1 - vbDiscountPercent/100) * (CAST ( (1 + vbVATPercent / 100) * _tmpItem.tmpOperSumm_Partner AS NUMERIC (16, 2))) AS NUMERIC (16, 2))
                              WHEN vbPaidKindId = zc_Enum_PaidKind_SecondForm() AND vbExtraChargesPercent > 0 THEN CAST ( (1 + vbExtraChargesPercent/100) * (CAST ( (1 + vbVATPercent / 100) * _tmpItem.tmpOperSumm_Partner AS NUMERIC (16, 2))) AS NUMERIC (16, 2))
                              ELSE CAST ( (1 + vbVATPercent / 100) * _tmpItem.tmpOperSumm_Partner AS NUMERIC (16, 2))
                         END
                 WHEN vbVATPercent > 0
                    -- ���� ���� ��� ���, ����� ��������� ��� % ������ ��� % ������� ��� ����� ��� ���, ��������� �� 2-� ������, � ����� ��������� ��� (���� ������� ����� ������������ ��� ��) !!!�� ��� �� ������/������� ������ � ����!!!
                    THEN CASE WHEN 1=0 AND vbDiscountPercent > 0 THEN CAST ( (1 + vbVATPercent / 100) * CAST ( (1 - vbDiscountPercent/100) * _tmpItem.tmpOperSumm_Partner AS NUMERIC (16, 2)) AS NUMERIC (16, 2))
                              WHEN 1=0 AND vbExtraChargesPercent > 0 THEN CAST ( (1 + vbVATPercent / 100) * CAST ( (1 + vbExtraChargesPercent/100) * _tmpItem.tmpOperSumm_Partner AS NUMERIC (16, 2)) AS NUMERIC (16, 2))
                              ELSE CAST ( (1 + vbVATPercent / 100) * _tmpItem.tmpOperSumm_Partner AS NUMERIC (16, 2))
                         END
            END   -- ��� ����������� � ������ CurrencyPartnerId
                * CASE WHEN vbCurrencyPartnerId <> vbCurrencyDocumentId THEN CASE WHEN vbParPartnerValue = 0 THEN 0 ELSE vbCurrencyPartnerValue /  vbParPartnerValue END ELSE CASE WHEN vbCurrencyPartnerId = zc_Enum_Currency_Basis() THEN 0 ELSE 1 END END
            AS NUMERIC (16, 2)) AS OperSumm_Currency  -- !!!���������!!!

            INTO vbOperSumm_PriceList, vbOperSumm_Partner, vbOperSumm_Partner_ChangePercent, vbOperSumm_Currency
     FROM
           -- �������� 1 ������
          (SELECT SUM (CASE WHEN vbOperDatePartner < '01.07.2014' THEN _tmpItem.tmpOperSumm_PriceList ELSE CAST (_tmpItem.OperCount_Partner * _tmpItem.PriceListPrice AS NUMERIC (16, 2)) END) AS tmpOperSumm_PriceList
                , SUM (CASE WHEN vbOperDatePartner < '01.07.2014' THEN _tmpItem.tmpOperSumm_Partner -- ��� �������� �� ������� ������ �������� (���� ���� �� �����������)
                            WHEN _tmpItem.CountForPrice <> 0 THEN CAST (_tmpItem.OperCount_Partner * _tmpItem.Price / _tmpItem.CountForPrice AS NUMERIC (16, 2))
                                                             ELSE CAST (_tmpItem.OperCount_Partner * _tmpItem.Price AS NUMERIC (16, 2))
                        END) AS tmpOperSumm_Partner
                , SUM (CASE WHEN vbOperDatePartner < '01.07.2014' THEN _tmpItem.tmpOperSumm_Partner_original -- ��� �������� �� ������� ������ �������� (���� ���� �� �����������)
                            WHEN _tmpItem.CountForPrice <> 0 THEN CAST (_tmpItem.OperCount_Partner * _tmpItem.Price_original / _tmpItem.CountForPrice AS NUMERIC (16, 2))
                                                             ELSE CAST (_tmpItem.OperCount_Partner * _tmpItem.Price_original AS NUMERIC (16, 2))
                        END) AS tmpOperSumm_Partner_original
           FROM (SELECT _tmpItem.PriceListPrice
                      , _tmpItem.Price
                      , _tmpItem.Price_original
                      , _tmpItem.CountForPrice
                      , SUM (_tmpItem.OperCount_Partner) AS OperCount_Partner
                      , SUM (_tmpItem.tmpOperSumm_PriceList) AS tmpOperSumm_PriceList
                      , SUM (_tmpItem.tmpOperSumm_Partner) AS tmpOperSumm_Partner
                      , SUM (_tmpItem.tmpOperSumm_Partner_original) AS tmpOperSumm_Partner_original
                 FROM _tmpItem
                 GROUP BY _tmpItem.PriceListPrice
                        , _tmpItem.Price
                        , _tmpItem.Price_original
                        , _tmpItem.CountForPrice
                        , _tmpItem.GoodsId
                        , _tmpItem.GoodsKindId
                ) AS _tmpItem
          ) AS _tmpItem
     ;

     -- ������ �������� ���� �� ����������� (�� ���������)
     SELECT SUM (_tmpItem.OperSumm_PriceList), SUM (_tmpItem.OperSumm_Partner), SUM (_tmpItem.OperSumm_Partner_ChangePercent), SUM (_tmpItem.OperSumm_Currency) INTO vbOperSumm_PriceList_byItem, vbOperSumm_Partner_byItem, vbOperSumm_Partner_ChangePercent_byItem, vbOperSumm_Currency_byItem FROM _tmpItem;

     -- ���� �� ����� ��� �������� ����� �����-����� �� �����������
     IF COALESCE (vbOperSumm_PriceList, 0) <> COALESCE (vbOperSumm_PriceList_byItem, 0)
     THEN
         -- �� ������� ������������ ����� ������� ����� (������������ ����� ���������� �������� < 0, �� ��� ������ �� ������������)
         UPDATE _tmpItem SET OperSumm_PriceList = _tmpItem.OperSumm_PriceList - (vbOperSumm_PriceList_byItem - vbOperSumm_PriceList)
         WHERE _tmpItem.MovementItemId IN (SELECT MAX (_tmpItem.MovementItemId) FROM _tmpItem WHERE _tmpItem.OperSumm_PriceList IN (SELECT MAX (_tmpItem.OperSumm_PriceList) FROM _tmpItem)
                                          );
     END IF;
     -- ���� �� ����� ��� �������� ����� �� ����������� !!!��� ������!!!
     IF COALESCE (vbOperSumm_Partner, 0) <> COALESCE (vbOperSumm_Partner_byItem, 0)
     THEN
         -- �� ������� ������������ ����� ������� ����� (������������ ����� ���������� �������� < 0, �� ��� ������ �� ������������)
         UPDATE _tmpItem SET OperSumm_Partner = _tmpItem.OperSumm_Partner - (vbOperSumm_Partner_byItem - vbOperSumm_Partner)
         WHERE _tmpItem.MovementItemId IN (SELECT MAX (_tmpItem.MovementItemId) FROM _tmpItem WHERE _tmpItem.OperSumm_Partner IN (SELECT MAX (_tmpItem.OperSumm_Partner) FROM _tmpItem)
                                          );
     END IF;
     -- ���� �� ����� ��� �������� ����� �� �����������
     IF COALESCE (vbOperSumm_Partner_ChangePercent, 0) <> COALESCE (vbOperSumm_Partner_ChangePercent_byItem, 0)
     THEN
         -- �� ������� ������������ ����� ������� ����� (������������ ����� ���������� �������� < 0, �� ��� ������ �� ������������)
         UPDATE _tmpItem SET OperSumm_Partner_ChangePercent = _tmpItem.OperSumm_Partner_ChangePercent - (vbOperSumm_Partner_ChangePercent_byItem - vbOperSumm_Partner_ChangePercent)
         WHERE _tmpItem.MovementItemId IN (SELECT MAX (_tmpItem.MovementItemId) FROM _tmpItem WHERE _tmpItem.OperSumm_Partner_ChangePercent IN (SELECT MAX (_tmpItem.OperSumm_Partner_ChangePercent) FROM _tmpItem)
                                          );
     END IF;
     -- ���� �� ����� ��� �������� ����� � ������ �� �����������
     IF COALESCE (vbOperSumm_Currency, 0) <> COALESCE (vbOperSumm_Currency_byItem, 0)
     THEN
         -- �� ������� ������������ ����� ������� ����� (������������ ����� ���������� �������� < 0, �� ��� ������ �� ������������)
         UPDATE _tmpItem SET OperSumm_Currency = _tmpItem.OperSumm_Currency - (vbOperSumm_Currency_byItem - vbOperSumm_Currency)
         WHERE _tmpItem.MovementItemId IN (SELECT MAX (_tmpItem.MovementItemId) FROM _tmpItem WHERE _tmpItem.OperSumm_Currency IN (SELECT MAX (_tmpItem.OperSumm_Currency) FROM _tmpItem)
                                          );
     END IF;


     -- ����������� ������ ������, ���� ���� ...
     UPDATE _tmpItem SET PartionGoodsId = CASE WHEN vbAccountDirectionId_From = zc_Enum_AccountDirection_20200() -- ������ + �� �������
                                                AND vbOperDate >= zc_DateStart_PartionGoods()
                                                AND (_tmpItem.isPartionCount OR _tmpItem.isPartionSumm)
                                                   THEN lpInsertFind_Object_PartionGoods (_tmpItem.PartionGoods)

                                               WHEN vbIsPartionDate_Unit = TRUE
                                                AND _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30100() -- ������ + ���������
                                                   THEN lpInsertFind_Object_PartionGoods (_tmpItem.PartionGoodsDate)
                                               WHEN _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30100() -- ������ + ���������
                                                   THEN 0

                                               WHEN _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20200() -- ������������� + ������ ���
                                                 OR _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20300() -- ������������� + ����
                                                 OR _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_70100() -- ����������� ����������
                                                   THEN lpInsertFind_Object_PartionGoods (inUnitId_Partion:= NULL
                                                                                        , inGoodsId       := NULL
                                                                                        , inStorageId     := NULL
                                                                                        , inInvNumber     := NULL
                                                                                        , inOperDate      := NULL
                                                                                        , inPrice         := NULL
                                                                                         )
                                               ELSE lpInsertFind_Object_PartionGoods ('')
                                          END
     WHERE _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100() -- �������� ����� + ������ �����
        OR _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20200() -- ������������� + ������ ���
        OR _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20300() -- ������������� + ����
        OR _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30100() -- ������ + ���������
        OR _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_70100() -- ����������� ����������
     ;


     -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
     -- !!! �� � ������ - �������� !!!
     -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


     -- 1.1.1. ������������ ContainerId_GoodsPartner ��� �������� �� ��������������� ����� - ����� ���������� ��� ���.����
     UPDATE _tmpItem SET ContainerId_GoodsPartner = -- 0)����� 1)����������
                                                    -- 0)����� 1)���.����
                                                    lpInsertFind_Container (inContainerDescId   := zc_Container_Count()
                                                                          , inParentId          := NULL
                                                                          , inObjectId          := _tmpItem.GoodsId
                                                                          , inJuridicalId_basis := NULL
                                                                          , inBusinessId        := NULL
                                                                          , inObjectCostDescId  := NULL
                                                                          , inObjectCostId      := NULL
                                                                          , inDescId_1          := CASE WHEN vbMemberId_To <> 0 THEN zc_ContainerLinkObject_Member() ELSE zc_ContainerLinkObject_Partner() END
                                                                          , inObjectId_1        := CASE WHEN vbMemberId_To <> 0 THEN vbMemberId_To ELSE vbPartnerId_To END
                                                                          , inDescId_2          := zc_ContainerLinkObject_Branch()
                                                                          , inObjectId_2        := vbBranchId_From
                                                                           )
     WHERE _tmpItem.isTareReturning = TRUE AND _tmpItem.OperCount <> 0;

     -- 1.1.2. ����������� �������� ��� ��������������� ����� - ����� ���������� ��� ���.����
     INSERT INTO _tmpMIContainer_insert (Id, DescId, MovementDescId, MovementId, MovementItemId, ContainerId, ParentId, Amount, OperDate, IsActive)
       SELECT 0, zc_MIContainer_CountSupplier() AS DescId, vbMovementDescId, inMovementId, MovementItemId, ContainerId_GoodsPartner, 0 AS ParentId, OperCount, vbOperDate, TRUE
       FROM _tmpItem
       WHERE _tmpItem.isTareReturning = TRUE AND _tmpItem.OperCount <> 0;


     -- 1.2.1. ������������ ContainerId_Goods ��� ��������������� �����
     UPDATE _tmpItem SET ContainerId_Goods = lpInsertUpdate_ContainerCount_Goods (inOperDate               := vbOperDate
                                                                                , inUnitId                 := vbUnitId_From
                                                                                , inCarId                  := NULL
                                                                                , inMemberId               := vbMemberId_From
                                                                                , inInfoMoneyDestinationId := _tmpItem.InfoMoneyDestinationId
                                                                                , inGoodsId                := _tmpItem.GoodsId
                                                                                , inGoodsKindId            := _tmpItem.GoodsKindId
                                                                                , inIsPartionCount         := _tmpItem.isPartionCount
                                                                                , inPartionGoodsId         := _tmpItem.PartionGoodsId
                                                                                , inAssetId                := _tmpItem.AssetId
                                                                                , inBranchId               := vbBranchId_From -- ��� ��������� ����� ��� �������
                                                                                 );
     -- 1.2.2. ����������� �������� ��� ��������������� ����� (�������)
     INSERT INTO _tmpMIContainer_insert (Id, DescId, MovementDescId, MovementId, MovementItemId, ContainerId, AnalyzerId, ParentId, Amount, OperDate, IsActive)
       SELECT 0, zc_MIContainer_Count() AS DescId, vbMovementDescId, inMovementId, MovementItemId
            , ContainerId_Goods
            , zc_Enum_ProfitLossDirection_10400() AS AnalyzerId -- ������������� ����������
            , 0 AS ParentId
            , -1 * OperCount_Partner
            , vbOperDate
            , FALSE
       FROM _tmpItem
       -- ����� �.�. ���� ���� �������� ������ ����?
       -- WHERE OperCount_Partner <> 0
      UNION ALL
       SELECT 0, zc_MIContainer_Count() AS DescId, vbMovementDescId, inMovementId, MovementItemId
            , ContainerId_Goods
            , zc_Enum_ProfitLossDirection_10500() AS AnalyzerId -- ������ �� ���
            , 0 AS ParentId
            , -1 * (OperCount - OperCount_ChangePercent)
            , vbOperDate
            , FALSE
       FROM _tmpItem
       WHERE (OperCount - OperCount_ChangePercent) <> 0
      UNION ALL
       SELECT 0, zc_MIContainer_Count() AS DescId, vbMovementDescId, inMovementId, MovementItemId
            , ContainerId_Goods
            , zc_Enum_ProfitLossDirection_40200() AS AnalyzerId -- ���������� ��������
            , 0 AS ParentId
            , -1 * (OperCount_ChangePercent - OperCount_Partner)
            , vbOperDate
            , FALSE
       FROM _tmpItem
       WHERE (OperCount_ChangePercent - OperCount_Partner) <> 0
      ;


     -- 1.2.3. ������ !!!���������� ���� �� ����������!!!, ������� �������
     DELETE FROM _tmpItem WHERE _tmpItem.isTareReturning = TRUE;

     -- 1.2.4. ������ !!!������ ����� � �����=0 �� ����������!!!, ������� ������� (����� ��� ����� �������� ��������))
     DELETE FROM _tmpItem WHERE _tmpItem.isLossMaterials = TRUE;


     -- 1.3.1. ����� ����������: ��������� ������� - �������� �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     INSERT INTO _tmpItemSumm (MovementItemId, ContainerId_ProfitLoss_40208, ContainerId_ProfitLoss_10500, ContainerId_ProfitLoss_10400, ContainerId, AccountId, OperSumm, OperSumm_ChangePercent, OperSumm_Partner)
        SELECT
              _tmpItem.MovementItemId
            , 0 AS ContainerId_ProfitLoss_40208 -- ���� - ������� (���� - ������� � ���� : �/�2 - �/�3)
            , 0 AS ContainerId_ProfitLoss_10500 -- ���� - ������� (���� - ������ � ���� : �/�1 - �/�2)
            , 0 AS ContainerId_ProfitLoss_10400 -- ���� - ������� (���� - ������������� ���������� : �/�3)
            , COALESCE (lfContainerSumm_20901.ContainerId, COALESCE (Container_Summ.Id, 0)) AS ContainerId
            , COALESCE (lfContainerSumm_20901.AccountId, COALESCE (Container_Summ.ObjectId, 0)) AS AccountId
              -- �/�1 - ��� ����������: ������ � �������
            , SUM ((_tmpItem.OperCount * COALESCE (HistoryCost.Price, 0))) AS OperSumm
              -- �/�2 - ��� ����������: � ������ % ������
            , SUM ((_tmpItem.OperCount_ChangePercent * COALESCE (HistoryCost.Price, 0))) AS OperSumm_ChangePercent
              -- �/�3 - ��� ����������: �����������
            , SUM ((_tmpItem.OperCount_Partner * COALESCE (HistoryCost.Price, 0))) AS OperSumm_Partner
        FROM _tmpItem
             -- ��� ������� ��� ����
             LEFT JOIN lfSelect_ContainerSumm_byAccount (zc_Enum_Account_20901()) AS lfContainerSumm_20901
                                                                                  ON lfContainerSumm_20901.GoodsId           = _tmpItem.GoodsId
                                                                                 AND lfContainerSumm_20901.JuridicalId_basis = vbJuridicalId_Basis_From
                                                                                 -- AND lfContainerSumm_20901.BusinessId        = _tmpItem.BusinessId_From -- !!!���� �� ������� � ���������� �� �������!!!
                                                                                 AND _tmpItem.InfoMoneyDestinationId         = zc_Enum_InfoMoneyDestination_20500() -- 20500; "��������� ����"
                                                                                 AND _tmpItem.isTareReturning                = FALSE
             -- ��� ������� ��� ���������
             LEFT JOIN Container AS Container_Summ ON Container_Summ.ParentId = _tmpItem.ContainerId_Goods
                                                  AND Container_Summ.DescId = zc_Container_Summ()
             /*JOIN ContainerObjectCost AS ContainerObjectCost_Basis
                                      ON ContainerObjectCost_Basis.ContainerId = COALESCE (lfContainerSumm_20901.ContainerId, Container_Summ.Id)
                                     AND ContainerObjectCost_Basis.ObjectCostDescId = zc_ObjectCost_Basis()*/
             LEFT JOIN HistoryCost ON HistoryCost.ContainerId = COALESCE (lfContainerSumm_20901.ContainerId, Container_Summ.Id) -- HistoryCost.ObjectCostId = ContainerObjectCost_Basis.ObjectCostId
                                  AND vbOperDate BETWEEN HistoryCost.StartDate AND HistoryCost.EndDate
        WHERE zc_isHistoryCost() = TRUE -- !!!���� ����� ��������!!!
          AND vbIsHistoryCost = TRUE -- !!! ������ ��� ������ ����� �������� �/� (������� ��� ��������� ����������)!!!
          AND (_tmpItem.OperCount * COALESCE (HistoryCost.Price, 0) <> 0                 -- !!!
             OR _tmpItem.OperCount_ChangePercent * COALESCE (HistoryCost.Price, 0) <> 0  -- ����� ���� !!!�� �����!!! 
             OR _tmpItem.OperCount_Partner * COALESCE (HistoryCost.Price, 0) <> 0)       -- !!!
        GROUP BY _tmpItem.MovementItemId
               , Container_Summ.Id
               , Container_Summ.ObjectId
               , lfContainerSumm_20901.ContainerId
               , lfContainerSumm_20901.AccountId;

     -- 1.3.2. ����������� �������� ��� ��������� ����� (�������)
     INSERT INTO _tmpMIContainer_insert (Id, DescId, MovementDescId, MovementId, MovementItemId, ContainerId, AnalyzerId, ParentId, Amount, OperDate, IsActive)
       SELECT 0, zc_MIContainer_Summ() AS DescId, vbMovementDescId, inMovementId, _tmpItemSumm.MovementItemId
            , _tmpItemSumm.ContainerId
            , zc_Enum_ProfitLossDirection_10400() AS AnalyzerId -- ������������� ����������
            , 0 AS ParentId
            , -1 * _tmpItemSumm.OperSumm_Partner
            , vbOperDate
            , FALSE
       FROM _tmpItemSumm
       WHERE _tmpItemSumm.OperSumm_Partner <> 0
      UNION ALL
       SELECT 0, zc_MIContainer_Summ() AS DescId, vbMovementDescId, inMovementId, _tmpItemSumm.MovementItemId
            , _tmpItemSumm.ContainerId
            , zc_Enum_ProfitLossDirection_10500() AS AnalyzerId -- ������ �� ���
            , 0 AS ParentId
            , -1 * (_tmpItemSumm.OperSumm - _tmpItemSumm.OperSumm_ChangePercent)
            , vbOperDate
            , FALSE
       FROM _tmpItemSumm
       WHERE (_tmpItemSumm.OperSumm - _tmpItemSumm.OperSumm_ChangePercent) <> 0
      UNION ALL
       SELECT 0, zc_MIContainer_Summ() AS DescId, vbMovementDescId, inMovementId, _tmpItemSumm.MovementItemId
            , _tmpItemSumm.ContainerId
            , zc_Enum_ProfitLossDirection_40200() AS AnalyzerId -- ���������� ��������
            , 0 AS ParentId
            , -1 * (_tmpItemSumm.OperSumm_ChangePercent - _tmpItemSumm.OperSumm_Partner)
            , vbOperDate
            , FALSE
       FROM _tmpItemSumm
       WHERE (_tmpItemSumm.OperSumm_ChangePercent - _tmpItemSumm.OperSumm_Partner) <> 0
      ;


     -- 2.1. ������� ���������� ��� �������� - �������
     UPDATE _tmpItemSumm SET ContainerId_ProfitLoss_40208 = _tmpItem_byDestination.ContainerId_ProfitLoss_40208 -- ���� - ������� (���� - ������� � ���� : �/�2 - �/�3)
                           , ContainerId_ProfitLoss_10500 = _tmpItem_byDestination.ContainerId_ProfitLoss_10500 -- ���� - ������� (���� - ������ � ���� : �/�1 - �/�2)
                           , ContainerId_ProfitLoss_10400 = _tmpItem_byDestination.ContainerId_ProfitLoss_10400 -- ���� - ������� (���� - ������������� ���������� : �/�3)
     FROM _tmpItem
          JOIN
          (SELECT -- ��� ����� ������� � ���� : �/�2 - �/�3
                  lpInsertFind_Container (inContainerDescId   := zc_Container_Summ()
                                        , inParentId          := NULL
                                        , inObjectId          := zc_Enum_Account_100301 () -- 100301; "������� �������� �������"
                                        , inJuridicalId_basis := vbJuridicalId_Basis_From
                                        , inBusinessId        := _tmpItem_byProfitLoss.BusinessId_From
                                        , inObjectCostDescId  := NULL
                                        , inObjectCostId      := NULL
                                        , inDescId_1          := zc_ContainerLinkObject_ProfitLoss()
                                        , inObjectId_1        := _tmpItem_byProfitLoss.ProfitLossId_CountChange
                                         ) AS ContainerId_ProfitLoss_40208
                  -- ��� ����� ������ � ���� : �/�1 - �/�2
                , lpInsertFind_Container (inContainerDescId   := zc_Container_Summ()
                                        , inParentId          := NULL
                                        , inObjectId          := zc_Enum_Account_100301 () -- 100301; "������� �������� �������"
                                        , inJuridicalId_basis := vbJuridicalId_Basis_From
                                        , inBusinessId        := _tmpItem_byProfitLoss.BusinessId_From
                                        , inObjectCostDescId  := NULL
                                        , inObjectCostId      := NULL
                                        , inDescId_1          := zc_ContainerLinkObject_ProfitLoss()
                                        , inObjectId_1        := _tmpItem_byProfitLoss.ProfitLossId_ChangePercent
                                         ) AS ContainerId_ProfitLoss_10500
                  -- ��� ����� ������������� ���������� : �/�3
                , lpInsertFind_Container (inContainerDescId   := zc_Container_Summ()
                                        , inParentId          := NULL
                                        , inObjectId          := zc_Enum_Account_100301 () -- 100301; "������� �������� �������"
                                        , inJuridicalId_basis := vbJuridicalId_Basis_From
                                        , inBusinessId        := _tmpItem_byProfitLoss.BusinessId_From
                                        , inObjectCostDescId  := NULL
                                        , inObjectCostId      := NULL
                                        , inDescId_1          := zc_ContainerLinkObject_ProfitLoss()
                                        , inObjectId_1        := _tmpItem_byProfitLoss.ProfitLossId_Partner
                                         ) AS ContainerId_ProfitLoss_10400
                , _tmpItem_byProfitLoss.InfoMoneyDestinationId
                , _tmpItem_byProfitLoss.BusinessId_From
           FROM (SELECT -- ���������� ProfitLossId - ��� ����� ������� � ���� : �/�2 - �/�3
                        CASE WHEN vbIsCorporate_To = TRUE
                              AND _tmpItem_group.ProfitLossGroupId <> zc_Enum_ProfitLossGroup_10000() -- 10000; "��������� �������� ������������"
                              AND _tmpItem_group.ProfitLossId > 0
                                  THEN _tmpItem_group.ProfitLossId
                             WHEN _tmpItem_group.ProfitLossGroupId = zc_Enum_ProfitLossGroup_10000() -- 10000; "��������� �������� ������������"
                              AND _tmpItem_group.InfoMoneyDestinationId_calc = zc_Enum_InfoMoneyDestination_20900()  -- ����      -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20900()
                                  THEN zc_Enum_ProfitLoss_40208() -- ���������� �������� 40208; "������� � ����"
                             WHEN _tmpItem_group.ProfitLossGroupId = zc_Enum_ProfitLossGroup_10000() -- 10000; "��������� �������� ������������"
                                  THEN zc_Enum_ProfitLoss_40208() -- ���������� �������� 40208; "������� � ����"
                             ELSE lpInsertFind_Object_ProfitLoss (inProfitLossGroupId      := _tmpItem_group.ProfitLossGroupId
                                                                , inProfitLossDirectionId  := _tmpItem_group.ProfitLossDirectionId
                                                                , inInfoMoneyDestinationId := _tmpItem_group.InfoMoneyDestinationId_calc
                                                                , inInfoMoneyId            := NULL
                                                                , inUserId                 := inUserId
                                                                 )
                        END AS ProfitLossId_CountChange

                        -- ���������� ProfitLossId - ��� ����� ������ � ���� : �/�1 - �/�2
                      , CASE WHEN vbIsCorporate_To = TRUE
                              AND _tmpItem_group.ProfitLossGroupId <> zc_Enum_ProfitLossGroup_10000() -- 10000; "��������� �������� ������������"
                              AND _tmpItem_group.ProfitLossId > 0
                                  THEN _tmpItem_group.ProfitLossId
                             WHEN _tmpItem_group.ProfitLossGroupId = zc_Enum_ProfitLossGroup_10000() -- 10000; "��������� �������� ������������"
                              AND _tmpItem_group.InfoMoneyDestinationId_calc = zc_Enum_InfoMoneyDestination_20900()  -- ����      -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20900()
                                  THEN zc_Enum_ProfitLoss_10502() -- ������ �� ��� 10502; "����"
                             WHEN _tmpItem_group.ProfitLossGroupId = zc_Enum_ProfitLossGroup_10000() -- 10000; "��������� �������� ������������"
                                  THEN zc_Enum_ProfitLoss_10501() -- ������ �� ��� 10501; "���������"
                             ELSE lpInsertFind_Object_ProfitLoss (inProfitLossGroupId      := _tmpItem_group.ProfitLossGroupId
                                                                , inProfitLossDirectionId  := _tmpItem_group.ProfitLossDirectionId
                                                                , inInfoMoneyDestinationId := _tmpItem_group.InfoMoneyDestinationId_calc
                                                                , inInfoMoneyId            := NULL
                                                                , inUserId                 := inUserId
                                                                 )
                        END AS ProfitLossId_ChangePercent

                        -- ���������� ProfitLossId - ��� ����� ������������� ���������� : �/�3
                      , CASE WHEN vbIsCorporate_To = TRUE
                              AND _tmpItem_group.ProfitLossGroupId <> zc_Enum_ProfitLossGroup_10000() -- 10000; "��������� �������� ������������"
                              AND _tmpItem_group.ProfitLossId > 0
                                  THEN _tmpItem_group.ProfitLossId
                             WHEN _tmpItem_group.ProfitLossGroupId = zc_Enum_ProfitLossGroup_10000() -- 10000; "��������� �������� ������������"
                              AND _tmpItem_group.InfoMoneyDestinationId_calc = zc_Enum_InfoMoneyDestination_20900()  -- ����      -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20900()
                                  THEN zc_Enum_ProfitLoss_10402() -- ������������� ���������� 10402; "����"
                             WHEN _tmpItem_group.ProfitLossGroupId = zc_Enum_ProfitLossGroup_10000() -- 10000; "��������� �������� ������������"
                                  THEN zc_Enum_ProfitLoss_10401() -- ������������� ���������� 10401; "���������"
                             ELSE lpInsertFind_Object_ProfitLoss (inProfitLossGroupId      := _tmpItem_group.ProfitLossGroupId
                                                                , inProfitLossDirectionId  := _tmpItem_group.ProfitLossDirectionId
                                                                , inInfoMoneyDestinationId := _tmpItem_group.InfoMoneyDestinationId_calc
                                                                , inInfoMoneyId            := NULL
                                                                , inUserId                 := inUserId
                                                                 )
                        END AS ProfitLossId_Partner

                      , _tmpItem_group.InfoMoneyDestinationId
                      , _tmpItem_group.BusinessId_From
                 FROM (SELECT CASE WHEN vbMemberId_To = 0
                                    AND _tmpItem.InfoMoneyDestinationId IN (zc_Enum_InfoMoneyDestination_20900()  -- ����      -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20900()
                                                                          , zc_Enum_InfoMoneyDestination_30100()) -- ��������� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30100()
                                        THEN zc_Enum_ProfitLossGroup_10000() -- 10000; "��������� �������� ������������"
                                   WHEN vbIsCorporate_To = TRUE
                                        THEN zc_Enum_ProfitLossGroup_70000() -- 70000; "�������������� �������"
                                   WHEN vbMemberId_To = 0
                                    AND _tmpItem.InfoMoneyDestinationId IN (zc_Enum_InfoMoneyDestination_10100()  -- ������ ����� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100()
                                                                          , zc_Enum_InfoMoneyDestination_30200()) -- ������ ����� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30200()
                                        THEN zc_Enum_ProfitLossGroup_10000() -- 10000; "��������� �������� ������������"
                                   ELSE zc_Enum_ProfitLossGroup_70000() -- 70000; "�������������� �������"
                              END AS ProfitLossGroupId

                            , CASE WHEN vbMemberId_To = 0
                                    AND _tmpItem.InfoMoneyDestinationId IN (zc_Enum_InfoMoneyDestination_20900()  -- ����      -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20900()
                                                                          , zc_Enum_InfoMoneyDestination_30100()) -- ��������� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30100()
                                        THEN zc_Enum_ProfitLossDirection_10400() -- 10400; "������������� ����������"
                                   WHEN vbIsCorporate_To = TRUE
                                        THEN zc_Enum_ProfitLossDirection_70100() -- 70300; "���������� ����� ���������"
                                   WHEN vbMemberId_To = 0
                                    AND _tmpItem.InfoMoneyDestinationId IN (zc_Enum_InfoMoneyDestination_10100()  -- ������ ����� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100()
                                                                          , zc_Enum_InfoMoneyDestination_30200()) -- ������ ����� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30200()
                                        THEN zc_Enum_ProfitLossDirection_10400() -- 10400; "������������� ����������"
                                   WHEN vbMemberId_To <> 0
                                        THEN zc_Enum_ProfitLossDirection_70300() -- 70300; "���.���� (���������� ������)"
                                   ELSE zc_Enum_ProfitLossDirection_70200() -- 70200; "������"
                              END AS ProfitLossDirectionId

                            , _tmpItem.InfoMoneyDestinationId_calc
                            , _tmpItem.InfoMoneyDestinationId
                            , _tmpItem.BusinessId_From
                            , _tmpItem.ProfitLossId
                       FROM (SELECT  _tmpItem.InfoMoneyDestinationId
                                   , _tmpItem.BusinessId_From
                                   , _tmpItem.GoodsKindId
                                   , CASE WHEN (_tmpItem.GoodsKindId = zc_GoodsKind_WorkProgress() AND _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30100()) -- ������ + ���������
                                            OR (vbAccountDirectionId_From = zc_Enum_AccountDirection_20400() AND _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30100()) -- ������ + �� ������������ AND ������ + ���������
                                               THEN zc_Enum_InfoMoneyDestination_21300() -- ������������� + ������������� ������������
                                          WHEN _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30200() -- ������ + ������ �����
                                               THEN zc_Enum_InfoMoneyDestination_30100() -- ������ + ���������
                                          ELSE _tmpItem.InfoMoneyDestinationId
                                     END AS InfoMoneyDestinationId_calc
                                   , CASE WHEN zc_Enum_InfoMoney_20801() = vbInfoMoneyId_CorporateTo
                                               THEN NULL -- ����
                                          WHEN zc_Enum_InfoMoney_20901() = vbInfoMoneyId_CorporateTo
                                               THEN zc_Enum_ProfitLoss_70101() -- ����
                                          WHEN zc_Enum_InfoMoney_21001() = vbInfoMoneyId_CorporateTo
                                               THEN zc_Enum_ProfitLoss_70102() -- �����
                                          WHEN zc_Enum_InfoMoney_21101() = vbInfoMoneyId_CorporateTo
                                               THEN zc_Enum_ProfitLoss_70103() -- �������
                                          WHEN zc_Enum_InfoMoney_21151() = vbInfoMoneyId_CorporateTo
                                               THEN zc_Enum_ProfitLoss_70104() -- �������-���������
                                     END AS ProfitLossId
                             FROM _tmpItemSumm
                                  JOIN _tmpItem ON _tmpItem.MovementItemId = _tmpItemSumm.MovementItemId
                             GROUP BY _tmpItem.InfoMoneyDestinationId
                                    , _tmpItem.BusinessId_From
                                    , _tmpItem.GoodsKindId
                            ) AS _tmpItem
                       GROUP BY _tmpItem.InfoMoneyDestinationId_calc
                              , _tmpItem.InfoMoneyDestinationId
                              , _tmpItem.BusinessId_From
                              , _tmpItem.ProfitLossId
                      ) AS _tmpItem_group
                ) AS _tmpItem_byProfitLoss
          ) AS _tmpItem_byDestination ON _tmpItem_byDestination.InfoMoneyDestinationId = _tmpItem.InfoMoneyDestinationId
                                     AND _tmpItem_byDestination.BusinessId_From = _tmpItem.BusinessId_From
     WHERE _tmpItemSumm.MovementItemId = _tmpItem.MovementItemId;

     -- 2.2. ����������� �������� - ������� (�������������)
     INSERT INTO _tmpMIContainer_insert (Id, DescId, MovementDescId, MovementId, MovementItemId, ContainerId, ParentId, Amount, OperDate, IsActive)
       -- �������� �� ������� � ���� : �/�2 - �/�3
       SELECT 0, zc_MIContainer_Summ() AS DescId, vbMovementDescId, inMovementId, 0 AS MovementItemId, _tmpItem_group.ContainerId_ProfitLoss, 0 AS ParentId, _tmpItem_group.OperSumm, vbOperDate, FALSE
       FROM (SELECT _tmpItemSumm.ContainerId_ProfitLoss_40208 AS ContainerId_ProfitLoss
                  , SUM (_tmpItemSumm.OperSumm_ChangePercent - _tmpItemSumm.OperSumm_Partner) AS OperSumm
             FROM _tmpItemSumm
             GROUP BY _tmpItemSumm.ContainerId_ProfitLoss_40208
            ) AS _tmpItem_group
       WHERE _tmpItem_group.OperSumm <> 0
      UNION ALL
       -- �������� �� ������� � ���� : �/�1 - �/�2
       SELECT 0, zc_MIContainer_Summ() AS DescId, vbMovementDescId, inMovementId, 0 AS MovementItemId, _tmpItem_group.ContainerId_ProfitLoss, 0 AS ParentId, _tmpItem_group.OperSumm, vbOperDate, FALSE
       FROM (SELECT _tmpItemSumm.ContainerId_ProfitLoss_10500 AS ContainerId_ProfitLoss
                  , SUM (_tmpItemSumm.OperSumm - _tmpItemSumm.OperSumm_ChangePercent) AS OperSumm
             FROM _tmpItemSumm
             GROUP BY _tmpItemSumm.ContainerId_ProfitLoss_10500
            ) AS _tmpItem_group
       WHERE _tmpItem_group.OperSumm <> 0
      UNION ALL
       -- �������� �� ������������� ���������� : �/�3
       SELECT 0, zc_MIContainer_Summ() AS DescId, vbMovementDescId, inMovementId, 0 AS MovementItemId, _tmpItem_group.ContainerId_ProfitLoss, 0 AS ParentId, _tmpItem_group.OperSumm, vbOperDate, FALSE
       FROM (SELECT _tmpItemSumm.ContainerId_ProfitLoss_10400 AS ContainerId_ProfitLoss
                  , SUM (_tmpItemSumm.OperSumm_Partner) AS OperSumm
             FROM _tmpItemSumm
             GROUP BY _tmpItemSumm.ContainerId_ProfitLoss_10400
            ) AS _tmpItem_group
       WHERE _tmpItem_group.OperSumm <> 0
       ;


     -- 3.1. ������������ ����(�����������) ��� �������� �� ���� ���������� ��� ���.���� (����������� ����)
     UPDATE _tmpItem SET AccountId_Partner = _tmpItem_byAccount.AccountId
                       , AccountId_Transit = CASE WHEN vbOperDate <> vbOperDatePartner AND vbMemberId_From = 0 AND vbMemberId_To = 0 THEN zc_Enum_Account_110101() ELSE 0 END -- �������
     FROM (SELECT CASE WHEN vbIsCorporate_To = TRUE
                            THEN _tmpItem_group.AccountId
                       ELSE lpInsertFind_Object_Account (inAccountGroupId         := zc_Enum_AccountGroup_30000() -- �������� -- select * from gpSelect_Object_AccountGroup ('2') where Id in (zc_Enum_AccountGroup_30000())
                                                       , inAccountDirectionId     := _tmpItem_group.AccountDirectionId
                                                       , inInfoMoneyDestinationId := _tmpItem_group.InfoMoneyDestinationId_calc
                                                       , inInfoMoneyId            := NULL
                                                       , inUserId                 := inUserId
                                                        )
                   END AS AccountId
                , _tmpItem_group.InfoMoneyDestinationId
           FROM (SELECT CASE WHEN vbMemberId_To <> 0
                                  THEN zc_Enum_AccountDirection_30500() -- ���.���� (����������� ����)  -- select * from gpSelect_Object_AccountDirection ('2') where Id in (zc_Enum_AccountDirection_30500())
                             WHEN vbIsCorporate_To = TRUE
                                  THEN zc_Enum_AccountDirection_30200() -- ���� �������� -- select * from gpSelect_Object_AccountDirection ('2') where Id in (zc_Enum_AccountDirection_30200())
                             WHEN vbInfoMoneyDestinationId_To IN (zc_Enum_InfoMoneyDestination_10100()  -- ������ ����� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100()
                                                                , zc_Enum_InfoMoneyDestination_20700()  -- ������       -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20700()
                                                                , zc_Enum_InfoMoneyDestination_20900()  -- ����         -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20900()
                                                                , zc_Enum_InfoMoneyDestination_30100()  -- ���������    -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30100()
                                                                , zc_Enum_InfoMoneyDestination_30200()) -- ������ ����� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30200()
                                  THEN CASE WHEN vbCurrencyPartnerId <> zc_Enum_Currency_Basis() THEN zc_Enum_AccountDirection_30150() ELSE zc_Enum_AccountDirection_30100() END -- ���������� ��� OR ����������
                             WHEN _tmpItem.InfoMoneyDestinationId IN (zc_Enum_InfoMoneyDestination_10100()  -- ������ ����� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100()
                                                                    , zc_Enum_InfoMoneyDestination_20700()  -- ������       -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20700()
                                                                    , zc_Enum_InfoMoneyDestination_20900()  -- ����         -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20900()
                                                                    , zc_Enum_InfoMoneyDestination_30100()  -- ���������    -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30100()
                                                                    , zc_Enum_InfoMoneyDestination_30200()) -- ������ ����� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30200()
                                  THEN CASE WHEN vbCurrencyPartnerId <> zc_Enum_Currency_Basis() THEN zc_Enum_AccountDirection_30150() ELSE zc_Enum_AccountDirection_30100() END -- ���������� ��� OR ����������
                          -- ELSE zc_Enum_AccountDirection_30400() -- ������ �������� select * from gpSelect_Object_AccountDirection ('2') where Id in (zc_Enum_AccountDirection_30400())
                             ELSE CASE WHEN vbCurrencyPartnerId <> zc_Enum_Currency_Basis() THEN zc_Enum_AccountDirection_30150() ELSE zc_Enum_AccountDirection_30100() END -- ���������� ��� OR ����������
                        END AS AccountDirectionId

                      , CASE WHEN vbIsCorporate_To = TRUE
                                  THEN vbInfoMoneyDestinationId_To -- zc_Enum_InfoMoneyDestination_30100() -- ���������
                             WHEN vbInfoMoneyDestinationId_To <> 0
                                  THEN vbInfoMoneyDestinationId_To -- ��: ������ �� �������� -- � ������ ����: � ������ ������� - �� ��������, �� ������ - �� ������ !!!(���� ���� ��������)!!!, ����� ����� ���������� ��� ������� ������
                             ELSE _tmpItem.InfoMoneyDestinationId -- ����� ����� �� ������
                        END AS InfoMoneyDestinationId_calc

                      , _tmpItem.InfoMoneyDestinationId
                      , CASE WHEN zc_Enum_InfoMoney_20801() = vbInfoMoneyId_CorporateTo
                                  THEN zc_Enum_Account_30201() -- ����
                             WHEN zc_Enum_InfoMoney_20901() = vbInfoMoneyId_CorporateTo
                                  THEN zc_Enum_Account_30202() -- ����
                             WHEN zc_Enum_InfoMoney_21001() = vbInfoMoneyId_CorporateTo
                                  THEN zc_Enum_Account_30203() -- �����
                             WHEN zc_Enum_InfoMoney_21101() = vbInfoMoneyId_CorporateTo
                                  THEN zc_Enum_Account_30204() -- �������
                             WHEN zc_Enum_InfoMoney_21151() = vbInfoMoneyId_CorporateTo
                                  THEN zc_Enum_Account_30205() -- �������-���������
                        END AS AccountId
                 FROM _tmpItem
                 -- WHERE _tmpItem.OperSumm_Partner_ChangePercent <> 0 !!!������ ������������, �.�. ���� AccountId � ��������� ��� ������!!!
                 GROUP BY _tmpItem.InfoMoneyDestinationId
                ) AS _tmpItem_group
          ) AS _tmpItem_byAccount
      WHERE _tmpItem.InfoMoneyDestinationId = _tmpItem_byAccount.InfoMoneyDestinationId;


     -- 3.2.1. ������������ ContainerId ��� �������� �� ���� ���������� ��� ���.���� (����������� ����)
     UPDATE _tmpItem SET ContainerId_Partner = _tmpItem_byInfoMoney.ContainerId
                       , ContainerId_Transit = _tmpItem_byInfoMoney.ContainerId_Transit
     FROM (SELECT CASE WHEN vbMemberId_To <> 0
                                 -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)���.���� (����������� ����) 2)NULL 3)NULL 4)������ ����������
                            THEN lpInsertFind_Container (inContainerDescId   := zc_Container_Summ()
                                                       , inParentId          := NULL
                                                       , inObjectId          := _tmpItem_group.AccountId_Partner
                                                       , inJuridicalId_basis := vbJuridicalId_Basis_From
                                                       , inBusinessId        := _tmpItem_group.BusinessId_From
                                                       , inObjectCostDescId  := NULL
                                                       , inObjectCostId      := NULL
                                                       , inDescId_1          := zc_ContainerLinkObject_Member()
                                                       , inObjectId_1        := vbMemberId_To
                                                       , inDescId_2          := zc_ContainerLinkObject_InfoMoney()
                                                       , inObjectId_2        := _tmpItem_group.InfoMoneyId_calc
                                                       , inDescId_3          := zc_ContainerLinkObject_Branch()
                                                       , inObjectId_3        := vbBranchId_From -- ���� ��������� ������ �� ������� ������
                                                       , inDescId_4          := zc_ContainerLinkObject_Car()
                                                       , inObjectId_4        := 0 -- ��� ���.���� (����������� ����) !!!������ ����� ��������� ��������� ������ �������� = 0!!!
                                                        )
                            -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)����������� ���� 2)���� ���� ������ 3)�������� 4)������ ����������
                       WHEN vbIsCorporate_To = TRUE
                                 -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)����������� ���� 2)���� ���� ������ 3)�������� 4)������ ����������
                            THEN lpInsertFind_Container (inContainerDescId   := zc_Container_Summ()
                                                       , inParentId          := NULL
                                                       , inObjectId          := _tmpItem_group.AccountId_Partner
                                                       , inJuridicalId_basis := vbJuridicalId_Basis_From
                                                       , inBusinessId        := _tmpItem_group.BusinessId_From
                                                       , inObjectCostDescId  := NULL
                                                       , inObjectCostId      := NULL
                                                       , inDescId_1          := zc_ContainerLinkObject_Juridical()
                                                       , inObjectId_1        := vbJuridicalId_To
                                                       , inDescId_2          := zc_ContainerLinkObject_InfoMoney()
                                                       , inObjectId_2        := _tmpItem_group.InfoMoneyId_calc
                                                       , inDescId_3          := zc_ContainerLinkObject_Contract()
                                                       , inObjectId_3        := vbContractId
                                                       , inDescId_4          := zc_ContainerLinkObject_PaidKind()
                                                       , inObjectId_4        := vbPaidKindId
                                                        )
                            -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)����������� ���� 2)���� ���� ������ 3)�������� 4)������ ����������
                       ELSE lpInsertFind_Container (inContainerDescId   := zc_Container_Summ()
                                                  , inParentId          := NULL
                                                  , inObjectId          := _tmpItem_group.AccountId_Partner
                                                  , inJuridicalId_basis := vbJuridicalId_Basis_From
                                                  , inBusinessId        := _tmpItem_group.BusinessId_From
                                                  , inObjectCostDescId  := NULL
                                                  , inObjectCostId      := NULL
                                                  , inDescId_1          := zc_ContainerLinkObject_Juridical()
                                                  , inObjectId_1        := vbJuridicalId_To
                                                  , inDescId_2          := zc_ContainerLinkObject_PaidKind()
                                                  , inObjectId_2        := vbPaidKindId
                                                  , inDescId_3          := zc_ContainerLinkObject_Contract()
                                                  , inObjectId_3        := vbContractId
                                                  , inDescId_4          := zc_ContainerLinkObject_InfoMoney()
                                                  , inObjectId_4        := _tmpItem_group.InfoMoneyId_calc
                                                  , inDescId_5          := CASE WHEN vbPaidKindId = zc_Enum_PaidKind_SecondForm() THEN zc_ContainerLinkObject_Partner() ELSE NULL END
                                                  , inObjectId_5        := CASE WHEN vbPaidKindId = zc_Enum_PaidKind_SecondForm() THEN vbPartnerId_To ELSE NULL END
                                                  , inDescId_6          := CASE WHEN vbPaidKindId = zc_Enum_PaidKind_SecondForm() THEN zc_ContainerLinkObject_Branch() ELSE NULL END
                                                  , inObjectId_6        := CASE WHEN vbPaidKindId = zc_Enum_PaidKind_SecondForm() THEN vbBranchId_From ELSE NULL END
                                                  , inDescId_7          := CASE WHEN vbCurrencyPartnerId = zc_Enum_Currency_Basis() THEN NULL ELSE zc_ContainerLinkObject_Currency() END
                                                  , inObjectId_7        := CASE WHEN vbCurrencyPartnerId = zc_Enum_Currency_Basis() THEN NULL ELSE vbCurrencyPartnerId END
                                                   )
                  END AS ContainerId
                , CASE WHEN _tmpItem_group.AccountId_Transit = 0 OR vbMemberId_To <> 0
                            THEN 0
                            -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)����������� ���� 2)���� ���� ������ 3)�������� 4)������ ����������
                       ELSE lpInsertFind_Container (inContainerDescId   := zc_Container_Summ()
                                                  , inParentId          := NULL
                                                  , inObjectId          := _tmpItem_group.AccountId_Transit
                                                  , inJuridicalId_basis := vbJuridicalId_Basis_From
                                                  , inBusinessId        := _tmpItem_group.BusinessId_From
                                                  , inObjectCostDescId  := NULL
                                                  , inObjectCostId      := NULL
                                                  , inDescId_1          := zc_ContainerLinkObject_Juridical()
                                                  , inObjectId_1        := vbJuridicalId_To
                                                  , inDescId_2          := zc_ContainerLinkObject_PaidKind()
                                                  , inObjectId_2        := vbPaidKindId
                                                  , inDescId_3          := zc_ContainerLinkObject_Contract()
                                                  , inObjectId_3        := vbContractId
                                                  , inDescId_4          := zc_ContainerLinkObject_InfoMoney()
                                                  , inObjectId_4        := _tmpItem_group.InfoMoneyId_calc
                                                  , inDescId_5          := CASE WHEN vbPaidKindId = zc_Enum_PaidKind_SecondForm() AND vbIsCorporate_To = FALSE THEN zc_ContainerLinkObject_Partner() ELSE NULL END
                                                  , inObjectId_5        := CASE WHEN vbPaidKindId = zc_Enum_PaidKind_SecondForm() AND vbIsCorporate_To = FALSE THEN vbPartnerId_To ELSE NULL END
                                                  , inDescId_6          := CASE WHEN vbPaidKindId = zc_Enum_PaidKind_SecondForm() AND vbIsCorporate_To = FALSE THEN zc_ContainerLinkObject_Branch() ELSE NULL END
                                                  , inObjectId_6        := CASE WHEN vbPaidKindId = zc_Enum_PaidKind_SecondForm() AND vbIsCorporate_To = FALSE THEN vbBranchId_From ELSE NULL END
                                                   )
                  END AS ContainerId_Transit
                , _tmpItem_group.InfoMoneyId
           FROM (SELECT _tmpItem.AccountId_Partner
                      , _tmpItem.AccountId_Transit
                      , _tmpItem.InfoMoneyId
                      , _tmpItem.BusinessId_From
                      , CASE WHEN vbInfoMoneyId_To <> 0
                                  THEN vbInfoMoneyId_To -- ��: ������ �� �������� -- � ������ ����: � ������ ������� - �� ��������, �� ������ - �� ������ !!!(���� ���� ��������)!!!, ����� ����� ���������� ��� ������� ������
                             WHEN _tmpItem.InfoMoneyId = zc_Enum_InfoMoney_20901 () -- -- 20901; "����"
                                  THEN zc_Enum_InfoMoney_30101 () -- 30101; "������� ���������"
                             ELSE _tmpItem.InfoMoneyId -- ����� ����� �� ������
                        END AS InfoMoneyId_calc
                 FROM _tmpItem
                 -- WHERE _tmpItem.OperSumm_Partner_ChangePercent <> 0 !!!������ ������������, �.�. ���� ContainerId � ��������� ��� ������!!!
                 GROUP BY _tmpItem.AccountId_Partner
                        , _tmpItem.AccountId_Transit
                        , _tmpItem.InfoMoneyId
                        , _tmpItem.BusinessId_From
                ) AS _tmpItem_group
          ) AS _tmpItem_byInfoMoney
     WHERE _tmpItem.InfoMoneyId = _tmpItem_byInfoMoney.InfoMoneyId
     ;
     -- 3.2.2. ������������ ContainerId_Currency ��� �������� �� ���� ���������� ��� ���.���� (����������� ����)
     UPDATE _tmpItem SET ContainerId_Currency = _tmpItem_byInfoMoney.ContainerId_Currency
     FROM (SELECT lpInsertFind_Container (inContainerDescId   := zc_Container_SummCurrency()
                                        , inParentId          := _tmpItem_group.ContainerId_Partner
                                        , inObjectId          := _tmpItem_group.AccountId_Partner
                                        , inJuridicalId_basis := vbJuridicalId_Basis_From
                                        , inBusinessId        := _tmpItem_group.BusinessId_From
                                        , inObjectCostDescId  := NULL
                                        , inObjectCostId      := NULL
                                        , inDescId_1          := zc_ContainerLinkObject_Juridical()
                                        , inObjectId_1        := vbJuridicalId_To
                                        , inDescId_2          := zc_ContainerLinkObject_PaidKind()
                                        , inObjectId_2        := vbPaidKindId
                                        , inDescId_3          := zc_ContainerLinkObject_Contract()
                                        , inObjectId_3        := vbContractId
                                        , inDescId_4          := zc_ContainerLinkObject_InfoMoney()
                                        , inObjectId_4        := _tmpItem_group.InfoMoneyId_calc
                                        , inDescId_5          := CASE WHEN vbPaidKindId = zc_Enum_PaidKind_SecondForm() THEN zc_ContainerLinkObject_Partner() ELSE NULL END
                                        , inObjectId_5        := CASE WHEN vbPaidKindId = zc_Enum_PaidKind_SecondForm() THEN vbPartnerId_To ELSE NULL END
                                        , inDescId_6          := CASE WHEN vbPaidKindId = zc_Enum_PaidKind_SecondForm() THEN zc_ContainerLinkObject_Branch() ELSE NULL END
                                        , inObjectId_6        := CASE WHEN vbPaidKindId = zc_Enum_PaidKind_SecondForm() THEN vbBranchId_From ELSE NULL END
                                        , inDescId_7          := zc_ContainerLinkObject_Currency()
                                        , inObjectId_7        := vbCurrencyPartnerId
                                         ) AS ContainerId_Currency
                , _tmpItem_group.InfoMoneyId
           FROM (SELECT _tmpItem.ContainerId_Partner
                      , _tmpItem.AccountId_Partner
                      , _tmpItem.InfoMoneyId
                      , _tmpItem.BusinessId_From
                      , CASE WHEN vbInfoMoneyId_To <> 0
                                  THEN vbInfoMoneyId_To -- ��: ������ �� �������� -- � ������ ����: � ������ ������� - �� ��������, �� ������ - �� ������ !!!(���� ���� ��������)!!!, ����� ����� ���������� ��� ������� ������
                             WHEN _tmpItem.InfoMoneyId = zc_Enum_InfoMoney_20901 () -- -- 20901; "����"
                                  THEN zc_Enum_InfoMoney_30101 () -- 30101; "������� ���������"
                             ELSE _tmpItem.InfoMoneyId -- ����� ����� �� ������
                        END AS InfoMoneyId_calc
                 FROM _tmpItem
                 WHERE vbCurrencyPartnerId <> zc_Enum_Currency_Basis()
                   AND vbMemberId_To = 0
                   AND vbIsCorporate_To = FALSE
                 GROUP BY _tmpItem.ContainerId_Partner
                        , _tmpItem.AccountId_Partner
                        , _tmpItem.InfoMoneyId
                        , _tmpItem.BusinessId_From
                ) AS _tmpItem_group
          ) AS _tmpItem_byInfoMoney
     WHERE _tmpItem.InfoMoneyId = _tmpItem_byInfoMoney.InfoMoneyId
     ;

     -- 3.3. ����������� �������� - ���� ���������� ��� ���.���� (����������� ����)
     INSERT INTO _tmpMIContainer_insert (Id, DescId, MovementDescId, MovementId, MovementItemId, ContainerId, AnalyzerId, ParentId, Amount, OperDate, IsActive)
       -- ��� ������� ��������
       SELECT 0, zc_MIContainer_Summ() AS DescId, vbMovementDescId, inMovementId, 0 AS MovementItemId
            , _tmpItem_group.ContainerId_Partner
            , _tmpItem_group.AnalyzerId
            , 0 AS ParentId
            , _tmpItem_group.OperSumm
            , CASE WHEN _tmpItem_group.AccountId_Transit <> 0 THEN vbOperDatePartner ELSE vbOperDate END AS OperDate
            , TRUE AS IsActive
       FROM (SELECT _tmpItem.ContainerId_Partner, _tmpItem.AccountId_Transit, zc_Enum_ProfitLossDirection_10100() AS AnalyzerId, SUM (_tmpItem.OperSumm_PriceList) AS OperSumm FROM _tmpItem GROUP BY _tmpItem.ContainerId_Partner, _tmpItem.AccountId_Transit
           UNION ALL
             SELECT _tmpItem.ContainerId_Partner, _tmpItem.AccountId_Transit, zc_Enum_ProfitLossDirection_10200() AS AnalyzerId, SUM (_tmpItem.OperSumm_Partner - _tmpItem.OperSumm_PriceList) AS OperSumm FROM _tmpItem GROUP BY _tmpItem.ContainerId_Partner, _tmpItem.AccountId_Transit
           UNION ALL
             SELECT _tmpItem.ContainerId_Partner, _tmpItem.AccountId_Transit, zc_Enum_ProfitLossDirection_10300() AS AnalyzerId, SUM (_tmpItem.OperSumm_Partner_ChangePercent - _tmpItem.OperSumm_Partner) AS OperSumm FROM _tmpItem GROUP BY _tmpItem.ContainerId_Partner, _tmpItem.AccountId_Transit
            ) AS _tmpItem_group
       WHERE _tmpItem_group.OperSumm <> 0
     UNION ALL
       -- ��� ��� �������� ��� ����� �������
       SELECT 0, zc_MIContainer_Summ() AS DescId, vbMovementDescId, inMovementId, 0 AS MovementItemId
            , _tmpItem_group.ContainerId_Transit
            , 0 AS AnalyzerId
            , 0 AS ParentId
            , CASE WHEN tmpOperDate.OperDate = vbOperDate THEN 1 ELSE -1 END * _tmpItem_group.OperSumm
            , tmpOperDate.OperDate
            , CASE WHEN tmpOperDate.OperDate = vbOperDate THEN TRUE ELSE FALSE END AS IsActive
       FROM (SELECT vbOperDate AS OperDate UNION SELECT vbOperDatePartner AS OperDate) AS tmpOperDate
            JOIN (SELECT _tmpItem.ContainerId_Transit, SUM (_tmpItem.OperSumm_Partner_ChangePercent) AS OperSumm FROM _tmpItem WHERE _tmpItem.AccountId_Transit <> 0 GROUP BY _tmpItem.ContainerId_Transit
                 ) AS _tmpItem_group ON _tmpItem_group.OperSumm <> 0
     UNION ALL
       -- ��� !!!����!!! �������� ��� "�������������" ��������� ����� 
       SELECT 0, zc_MIContainer_SummCurrency() AS DescId, vbMovementDescId, inMovementId, 0 AS MovementItemId
            , _tmpItem_group.ContainerId_Currency
            , 0 AS AnalyzerId
            , 0 AS ParentId
            , _tmpItem_group.OperSumm
            , vbOperDatePartner AS OperDate
            , TRUE AS IsActive
       FROM (SELECT _tmpItem.ContainerId_Currency, SUM (_tmpItem.OperSumm_Currency) AS OperSumm FROM _tmpItem WHERE _tmpItem.ContainerId_Currency <> 0 GROUP BY _tmpItem.ContainerId_Currency
            ) AS _tmpItem_group
       WHERE _tmpItem_group.OperSumm <> 0
     ;


     -- 4.1.1. ������� ���������� ��� �������� - ������� (����� ���������� � ������ �� ������ � ������ �������������� � �������� �������)
     UPDATE _tmpItem SET ContainerId_ProfitLoss_10100 = _tmpItem_byDestination.ContainerId_ProfitLoss_10100
                       , ContainerId_ProfitLoss_10200 = _tmpItem_byDestination.ContainerId_ProfitLoss_10200
                       , ContainerId_ProfitLoss_10300 = _tmpItem_byDestination.ContainerId_ProfitLoss_10300
                       , ContainerId_ProfitLoss_80103 = _tmpItem_byDestination.ContainerId_ProfitLoss_80103
     FROM (SELECT -- ��� ����� ����������
                  lpInsertFind_Container (inContainerDescId   := zc_Container_Summ()
                                        , inParentId          := NULL
                                        , inObjectId          := zc_Enum_Account_100301 () -- 100301; "������� �������� �������"
                                        , inJuridicalId_basis := vbJuridicalId_Basis_From
                                        , inBusinessId        := _tmpItem_byProfitLoss.BusinessId_From
                                        , inObjectCostDescId  := NULL
                                        , inObjectCostId      := NULL
                                        , inDescId_1          := zc_ContainerLinkObject_ProfitLoss()
                                        , inObjectId_1        := _tmpItem_byProfitLoss.ProfitLossId_PriceList
                                         ) AS ContainerId_ProfitLoss_10100
                  -- ��� ������ �� ������
                , lpInsertFind_Container (inContainerDescId   := zc_Container_Summ()
                                        , inParentId          := NULL
                                        , inObjectId          := zc_Enum_Account_100301 () -- 100301; "������� �������� �������"
                                        , inJuridicalId_basis := vbJuridicalId_Basis_From
                                        , inBusinessId        := _tmpItem_byProfitLoss.BusinessId_From
                                        , inObjectCostDescId  := NULL
                                        , inObjectCostId      := NULL
                                        , inDescId_1          := zc_ContainerLinkObject_ProfitLoss()
                                        , inObjectId_1        := _tmpItem_byProfitLoss.ProfitLossId_Partner
                                         ) AS ContainerId_ProfitLoss_10200
                  -- ��� ������ ��������������
                , lpInsertFind_Container (inContainerDescId   := zc_Container_Summ()
                                        , inParentId          := NULL
                                        , inObjectId          := zc_Enum_Account_100301 () -- 100301; "������� �������� �������"
                                        , inJuridicalId_basis := vbJuridicalId_Basis_From
                                        , inBusinessId        := _tmpItem_byProfitLoss.BusinessId_From
                                        , inObjectCostDescId  := NULL
                                        , inObjectCostId      := NULL
                                        , inDescId_1          := zc_ContainerLinkObject_ProfitLoss()
                                        , inObjectId_1        := _tmpItem_byProfitLoss.ProfitLossId_ChangePercent
                                         ) AS ContainerId_ProfitLoss_10300
                  -- ��� �������� �������
                , CASE WHEN vbCurrencyPartnerId <> zc_Enum_Currency_Basis()
                            THEN lpInsertFind_Container (inContainerDescId   := zc_Container_Summ()
                                                       , inParentId          := NULL
                                                       , inObjectId          := zc_Enum_Account_100301 () -- 100301; "������� �������� �������"
                                                       , inJuridicalId_basis := vbJuridicalId_Basis_From
                                                       , inBusinessId        := _tmpItem_byProfitLoss.BusinessId_From
                                                       , inObjectCostDescId  := NULL
                                                       , inObjectCostId      := NULL
                                                       , inDescId_1          := zc_ContainerLinkObject_ProfitLoss()
                                                       , inObjectId_1        := zc_Enum_ProfitLoss_80103()
                                                        )
                       ELSE 0
                  END AS ContainerId_ProfitLoss_80103
                , _tmpItem_byProfitLoss.InfoMoneyDestinationId
                , _tmpItem_byProfitLoss.BusinessId_From
           FROM (SELECT -- ���������� ProfitLossId - ��� ����� ����������
                        CASE WHEN vbIsCorporate_To = TRUE
                              AND _tmpItem_group.ProfitLossGroupId <> zc_Enum_ProfitLossGroup_10000() -- 10000; "��������� �������� ������������"
                              AND _tmpItem_group.ProfitLossId > 0
                                  THEN _tmpItem_group.ProfitLossId
                             WHEN _tmpItem_group.ProfitLossGroupId = zc_Enum_ProfitLossGroup_10000() -- 10000; "��������� �������� ������������"
                              AND _tmpItem_group.InfoMoneyDestinationId_calc = zc_Enum_InfoMoneyDestination_20900() -- ����      -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20900()
                                  THEN zc_Enum_ProfitLoss_10102() -- ����� ���������� 10102; "����"
                             WHEN _tmpItem_group.ProfitLossGroupId = zc_Enum_ProfitLossGroup_10000() -- 10000; "��������� �������� ������������"
                                  THEN zc_Enum_ProfitLoss_10101() -- ����� ���������� 10101; "���������"
                             ELSE lpInsertFind_Object_ProfitLoss (inProfitLossGroupId      := _tmpItem_group.ProfitLossGroupId
                                                                , inProfitLossDirectionId  := _tmpItem_group.ProfitLossDirectionId
                                                                , inInfoMoneyDestinationId := _tmpItem_group.InfoMoneyDestinationId_calc
                                                                , inInfoMoneyId            := NULL
                                                                , inUserId                 := inUserId
                                                                 )
                        END AS ProfitLossId_PriceList
                        -- ���������� ProfitLossId - ��� ������ �� ������
                      , CASE WHEN vbIsCorporate_To = TRUE
                              AND _tmpItem_group.ProfitLossGroupId <> zc_Enum_ProfitLossGroup_10000() -- 10000; "��������� �������� ������������"
                              AND _tmpItem_group.ProfitLossId > 0
                                  THEN _tmpItem_group.ProfitLossId
                             WHEN _tmpItem_group.ProfitLossGroupId = zc_Enum_ProfitLossGroup_10000() -- 10000; "��������� �������� ������������"
                              AND _tmpItem_group.InfoMoneyDestinationId_calc = zc_Enum_InfoMoneyDestination_20900() -- ����      -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20900()
                                  THEN zc_Enum_ProfitLoss_10202() -- ������ �� ������ 10202; "����"
                             WHEN _tmpItem_group.ProfitLossGroupId = zc_Enum_ProfitLossGroup_10000() -- 10000; "��������� �������� ������������"
                                  THEN zc_Enum_ProfitLoss_10201() -- ������ �� ������ 10201; "���������"
                             ELSE lpInsertFind_Object_ProfitLoss (inProfitLossGroupId      := _tmpItem_group.ProfitLossGroupId
                                                                , inProfitLossDirectionId  := _tmpItem_group.ProfitLossDirectionId
                                                                , inInfoMoneyDestinationId := _tmpItem_group.InfoMoneyDestinationId_calc
                                                                , inInfoMoneyId            := NULL
                                                                , inUserId                 := inUserId
                                                                 )
                        END AS ProfitLossId_Partner
                        -- ���������� ProfitLossId - ��� ������ ��������������
                      , CASE WHEN vbIsCorporate_To = TRUE
                              AND _tmpItem_group.ProfitLossGroupId <> zc_Enum_ProfitLossGroup_10000() -- 10000; "��������� �������� ������������"
                              AND _tmpItem_group.ProfitLossId > 0
                                  THEN _tmpItem_group.ProfitLossId
                             WHEN _tmpItem_group.ProfitLossGroupId = zc_Enum_ProfitLossGroup_10000() -- 10000; "��������� �������� ������������"
                              AND _tmpItem_group.InfoMoneyDestinationId_calc = zc_Enum_InfoMoneyDestination_20900() -- ����      -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20900()
                                  THEN zc_Enum_ProfitLoss_10302() -- ������ �������������� 10302; "����"
                             WHEN _tmpItem_group.ProfitLossGroupId = zc_Enum_ProfitLossGroup_10000() -- 10000; "��������� �������� ������������"
                                  THEN zc_Enum_ProfitLoss_10301() -- ������ �������������� 10301; "���������"
                             ELSE lpInsertFind_Object_ProfitLoss (inProfitLossGroupId      := _tmpItem_group.ProfitLossGroupId
                                                                , inProfitLossDirectionId  := _tmpItem_group.ProfitLossDirectionId
                                                                , inInfoMoneyDestinationId := _tmpItem_group.InfoMoneyDestinationId_calc
                                                                , inInfoMoneyId            := NULL
                                                                , inUserId                 := inUserId
                                                                 )
                        END AS ProfitLossId_ChangePercent
                      , _tmpItem_group.InfoMoneyDestinationId
                      , _tmpItem_group.BusinessId_From
                 FROM (SELECT -- ����� !!!����!!! ��� � ��� �/� (�� �� �/� ������ ����� �.�. ����� ���� ��� �/�=0)
                              CASE WHEN vbMemberId_To = 0
                                    AND _tmpItem.InfoMoneyDestinationId IN (zc_Enum_InfoMoneyDestination_20900()  -- ����      -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20900()
                                                                          , zc_Enum_InfoMoneyDestination_30100()) -- ��������� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30100()
                                        THEN zc_Enum_ProfitLossGroup_10000() -- 10000; "��������� �������� ������������"
                                   WHEN vbIsCorporate_To = TRUE
                                        THEN zc_Enum_ProfitLossGroup_70000() -- 70000; "�������������� �������"
                                   WHEN vbMemberId_To = 0
                                    AND _tmpItem.InfoMoneyDestinationId IN (zc_Enum_InfoMoneyDestination_10100()  -- ������ ����� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100()
                                                                          , zc_Enum_InfoMoneyDestination_30200()) -- ������ ����� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30200()
                                        THEN zc_Enum_ProfitLossGroup_10000() -- 10000; "��������� �������� ������������"
                                   ELSE zc_Enum_ProfitLossGroup_70000() -- 70000; "�������������� �������"
                              END AS ProfitLossGroupId

                              -- ����� !!!������!!! (� THEN) ��� ��� �/�
                            , CASE WHEN vbMemberId_To = 0
                                    AND _tmpItem.InfoMoneyDestinationId IN (zc_Enum_InfoMoneyDestination_20900()  -- ����      -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20900()
                                                                          , zc_Enum_InfoMoneyDestination_30100()) -- ��������� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30100()
                                        THEN zc_Enum_ProfitLossDirection_10100() -- 10100; "����� ����������"
                                   WHEN vbIsCorporate_To = TRUE
                                        THEN zc_Enum_ProfitLossDirection_70100() -- 70300; "���������� ����� ���������"
                                   WHEN vbMemberId_To = 0
                                    AND _tmpItem.InfoMoneyDestinationId IN (zc_Enum_InfoMoneyDestination_10100()  -- ������ ����� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100()
                                                                          , zc_Enum_InfoMoneyDestination_30200()) -- ������ ����� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30200()
                                        THEN zc_Enum_ProfitLossDirection_10100() -- 10100; "����� ����������"
                                   WHEN vbMemberId_To <> 0
                                        THEN zc_Enum_ProfitLossDirection_70300() -- 70300; "���.���� (���������� ������)"
                                   ELSE zc_Enum_ProfitLossDirection_70200() -- 70200; "������"
                              END AS ProfitLossDirectionId

                            , _tmpItem.InfoMoneyDestinationId_calc
                            , _tmpItem.InfoMoneyDestinationId
                            , _tmpItem.BusinessId_From
                            , _tmpItem.ProfitLossId
                       FROM (SELECT  _tmpItem.InfoMoneyDestinationId
                                   , _tmpItem.BusinessId_From
                                   , _tmpItem.GoodsKindId
                                   , CASE WHEN (_tmpItem.GoodsKindId = zc_GoodsKind_WorkProgress() AND _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30100()) -- ������ + ���������
                                            OR (vbAccountDirectionId_From = zc_Enum_AccountDirection_20400() AND _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30100()) -- ������ + �� ������������ AND ������ + ���������
                                               THEN zc_Enum_InfoMoneyDestination_21300() -- ������������� + ������������� ������������
                                          WHEN _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30200() -- ������ + ������ �����
                                               THEN zc_Enum_InfoMoneyDestination_30100() -- ������ + ���������
                                          ELSE _tmpItem.InfoMoneyDestinationId
                                     END AS InfoMoneyDestinationId_calc
                                   , CASE WHEN zc_Enum_InfoMoney_20801() = vbInfoMoneyId_CorporateTo
                                               THEN NULL -- ����
                                          WHEN zc_Enum_InfoMoney_20901() = vbInfoMoneyId_CorporateTo
                                               THEN zc_Enum_ProfitLoss_70101() -- ����
                                          WHEN zc_Enum_InfoMoney_21001() = vbInfoMoneyId_CorporateTo
                                               THEN zc_Enum_ProfitLoss_70102() -- �����
                                          WHEN zc_Enum_InfoMoney_21101() = vbInfoMoneyId_CorporateTo
                                               THEN zc_Enum_ProfitLoss_70103() -- �������
                                          WHEN zc_Enum_InfoMoney_21151() = vbInfoMoneyId_CorporateTo
                                               THEN zc_Enum_ProfitLoss_70104() -- �������-���������
                                     END AS ProfitLossId
                             FROM _tmpItem
                             -- !!!������ ������������, �.�. �������� ��� ������ ����� ������ ������!!!
                             -- WHERE _tmpItem.OperSumm_PriceList <> 0 OR _tmpItem.OperSumm_Partner <> 0 OR _tmpItem.OperSumm_Partner_ChangePercent <> 0
                             GROUP BY _tmpItem.InfoMoneyDestinationId
                                    , _tmpItem.BusinessId_From
                                    , _tmpItem.GoodsKindId
                            ) AS _tmpItem
                       GROUP BY _tmpItem.InfoMoneyDestinationId_calc
                              , _tmpItem.InfoMoneyDestinationId
                              , _tmpItem.BusinessId_From
                              , _tmpItem.ProfitLossId
                      ) AS _tmpItem_group
                ) AS _tmpItem_byProfitLoss
          ) AS _tmpItem_byDestination
     WHERE _tmpItem.InfoMoneyDestinationId = _tmpItem_byDestination.InfoMoneyDestinationId
       AND _tmpItem.BusinessId_From = _tmpItem_byDestination.BusinessId_From;

     -- 4.1.2. ����������� �������� - ������� (����� ���������� � ������ �� ������ � ������ ��������������)
     INSERT INTO _tmpMIContainer_insert (Id, DescId, MovementDescId, MovementId, MovementItemId, ContainerId, ParentId, Amount, OperDate, IsActive)
       -- ����� ����������
       SELECT 0, zc_MIContainer_Summ() AS DescId, vbMovementDescId, inMovementId, 0 AS MovementItemId, _tmpItem_group.ContainerId_ProfitLoss, 0 AS ParentId, _tmpItem_group.OperSumm, vbOperDate, FALSE
       FROM (SELECT _tmpItem.ContainerId_ProfitLoss_10100 AS ContainerId_ProfitLoss
                  , -1 * SUM (_tmpItem.OperSumm_PriceList) AS OperSumm
             FROM _tmpItem
             GROUP BY _tmpItem.ContainerId_ProfitLoss_10100
            ) AS _tmpItem_group
       WHERE _tmpItem_group.OperSumm <> 0
      UNION ALL
       -- ������ �� ������
       SELECT 0, zc_MIContainer_Summ() AS DescId, vbMovementDescId, inMovementId, 0 AS MovementItemId, _tmpItem_group.ContainerId_ProfitLoss, 0 AS ParentId, _tmpItem_group.OperSumm, vbOperDate, FALSE
       FROM (SELECT _tmpItem.ContainerId_ProfitLoss_10200 AS ContainerId_ProfitLoss
                  , 1 * SUM (_tmpItem.OperSumm_PriceList - _tmpItem.OperSumm_Partner) AS OperSumm
             FROM _tmpItem
             GROUP BY _tmpItem.ContainerId_ProfitLoss_10200
            ) AS _tmpItem_group
       WHERE _tmpItem_group.OperSumm <> 0
      UNION ALL
       -- ������ ��������������
       SELECT 0, zc_MIContainer_Summ() AS DescId, vbMovementDescId, inMovementId, 0 AS MovementItemId, _tmpItem_group.ContainerId_ProfitLoss, 0 AS ParentId, _tmpItem_group.OperSumm, vbOperDate, FALSE
       FROM (SELECT _tmpItem.ContainerId_ProfitLoss_10300 AS ContainerId_ProfitLoss
                  , 1 * SUM (_tmpItem.OperSumm_Partner - _tmpItem.OperSumm_Partner_ChangePercent) AS OperSumm
             FROM _tmpItem
             GROUP BY _tmpItem.ContainerId_ProfitLoss_10300
            ) AS _tmpItem_group
       WHERE _tmpItem_group.OperSumm <> 0
       ;

     -- 5.1.1. ����������� �������� ��� ������ (�����: �����(�/�) <-> ����(������� � ����))
     PERFORM lpInsertUpdate_MovementItemReport (inMovementDescId     := vbMovementDescId
                                              , inMovementId         := inMovementId
                                              , inMovementItemId     := _tmpItem_byProfitLoss.MovementItemId
                                              , inActiveContainerId  := _tmpItem_byProfitLoss.ActiveContainerId
                                              , inPassiveContainerId := _tmpItem_byProfitLoss.PassiveContainerId
                                              , inActiveAccountId    := _tmpItem_byProfitLoss.ActiveAccountId
                                              , inPassiveAccountId   := _tmpItem_byProfitLoss.PassiveAccountId
                                              , inReportContainerId  := lpInsertFind_ReportContainer (inActiveContainerId  := _tmpItem_byProfitLoss.ActiveContainerId
                                                                                                    , inPassiveContainerId := _tmpItem_byProfitLoss.PassiveContainerId
                                                                                                    , inActiveAccountId    := _tmpItem_byProfitLoss.ActiveAccountId
                                                                                                    , inPassiveAccountId   := _tmpItem_byProfitLoss.PassiveAccountId
                                                                                                     )
                                              , inChildReportContainerId := lpInsertFind_ChildReportContainer (inActiveContainerId  := _tmpItem_byProfitLoss.ActiveContainerId
                                                                                                             , inPassiveContainerId := _tmpItem_byProfitLoss.PassiveContainerId
                                                                                                             , inActiveAccountId    := _tmpItem_byProfitLoss.ActiveAccountId
                                                                                                             , inPassiveAccountId   := _tmpItem_byProfitLoss.PassiveAccountId
                                                                                                             , inAccountKindId_1    := zc_Enum_AccountKind_All()
                                                                                                             , inContainerId_1      := _tmpItem.ContainerId_Partner
                                                                                                             , inAccountId_1        := _tmpItem.AccountId_Partner
                                                                                                     )
                                              , inAmount   := _tmpItem_byProfitLoss.OperSumm
                                              , inOperDate := vbOperDate
                                               )
     FROM (SELECT ABS (_tmpCalc.OperSumm) AS OperSumm
                , CASE WHEN _tmpCalc.OperSumm > 0 THEN _tmpCalc.ContainerId_ProfitLoss ELSE _tmpCalc.ContainerId            END AS ActiveContainerId
                , CASE WHEN _tmpCalc.OperSumm > 0 THEN _tmpCalc.ContainerId            ELSE _tmpCalc.ContainerId_ProfitLoss END AS PassiveContainerId
                , CASE WHEN _tmpCalc.OperSumm > 0 THEN _tmpCalc.AccountId_ProfitLoss   ELSE _tmpCalc.AccountId              END AS ActiveAccountId
                , CASE WHEN _tmpCalc.OperSumm > 0 THEN _tmpCalc.AccountId              ELSE _tmpCalc.AccountId_ProfitLoss   END AS PassiveAccountId
                , _tmpCalc.MovementItemId
           FROM (SELECT _tmpItemSumm.MovementItemId
                      , _tmpItemSumm.ContainerId
                      , _tmpItemSumm.AccountId
                      , _tmpItemSumm.ContainerId_ProfitLoss_40208 AS ContainerId_ProfitLoss
                      , zc_Enum_Account_100301 () AS AccountId_ProfitLoss   -- 100301; "������� �������� �������"
                      , (_tmpItemSumm.OperSumm_ChangePercent - _tmpItemSumm.OperSumm_Partner) AS OperSumm -- !!!����>0, ������ "������", �.�. ���������� ������ ������ ��� ���� �� ������!!!
                                                                                                          -- �.�. ������: Active=ContainerId_ProfitLoss � �����: Passive=ContainerId_ProfitLoss
                 FROM _tmpItemSumm
                ) AS _tmpCalc
           WHERE _tmpCalc.OperSumm <> 0
          ) AS _tmpItem_byProfitLoss
          LEFT JOIN _tmpItem ON _tmpItem.MovementItemId = _tmpItem_byProfitLoss.MovementItemId
     ;
     -- 5.1.2. ����������� �������� ��� ������ (�����: �����(�/�) <-> ����(������ � ����))
     PERFORM lpInsertUpdate_MovementItemReport (inMovementDescId     := vbMovementDescId
                                              , inMovementId         := inMovementId
                                              , inMovementItemId     := _tmpItem_byProfitLoss.MovementItemId
                                              , inActiveContainerId  := _tmpItem_byProfitLoss.ActiveContainerId
                                              , inPassiveContainerId := _tmpItem_byProfitLoss.PassiveContainerId
                                              , inActiveAccountId    := _tmpItem_byProfitLoss.ActiveAccountId
                                              , inPassiveAccountId   := _tmpItem_byProfitLoss.PassiveAccountId
                                              , inReportContainerId  := lpInsertFind_ReportContainer (inActiveContainerId  := _tmpItem_byProfitLoss.ActiveContainerId
                                                                                                    , inPassiveContainerId := _tmpItem_byProfitLoss.PassiveContainerId
                                                                                                    , inActiveAccountId    := _tmpItem_byProfitLoss.ActiveAccountId
                                                                                                    , inPassiveAccountId   := _tmpItem_byProfitLoss.PassiveAccountId
                                                                                                     )
                                              , inChildReportContainerId := lpInsertFind_ChildReportContainer (inActiveContainerId  := _tmpItem_byProfitLoss.ActiveContainerId
                                                                                                             , inPassiveContainerId := _tmpItem_byProfitLoss.PassiveContainerId
                                                                                                             , inActiveAccountId    := _tmpItem_byProfitLoss.ActiveAccountId
                                                                                                             , inPassiveAccountId   := _tmpItem_byProfitLoss.PassiveAccountId
                                                                                                             , inAccountKindId_1    := zc_Enum_AccountKind_All()
                                                                                                             , inContainerId_1      := _tmpItem.ContainerId_Partner
                                                                                                             , inAccountId_1        := _tmpItem.AccountId_Partner
                                                                                                     )
                                              , inAmount   := _tmpItem_byProfitLoss.OperSumm
                                              , inOperDate := vbOperDate
                                               )
     FROM (SELECT ABS (_tmpCalc.OperSumm) AS OperSumm
                , CASE WHEN _tmpCalc.OperSumm > 0 THEN _tmpCalc.ContainerId_ProfitLoss ELSE _tmpCalc.ContainerId            END AS ActiveContainerId
                , CASE WHEN _tmpCalc.OperSumm > 0 THEN _tmpCalc.ContainerId            ELSE _tmpCalc.ContainerId_ProfitLoss END AS PassiveContainerId
                , CASE WHEN _tmpCalc.OperSumm > 0 THEN _tmpCalc.AccountId_ProfitLoss   ELSE _tmpCalc.AccountId              END AS ActiveAccountId
                , CASE WHEN _tmpCalc.OperSumm > 0 THEN _tmpCalc.AccountId              ELSE _tmpCalc.AccountId_ProfitLoss   END AS PassiveAccountId -- 100301; "������� �������� �������"
                , _tmpCalc.MovementItemId
           FROM (SELECT _tmpItemSumm.MovementItemId
                      , _tmpItemSumm.ContainerId
                      , _tmpItemSumm.AccountId
                      , _tmpItemSumm.ContainerId_ProfitLoss_10500 AS ContainerId_ProfitLoss
                      , zc_Enum_Account_100301 () AS AccountId_ProfitLoss   -- 100301; "������� �������� �������"
                      , (_tmpItemSumm.OperSumm - _tmpItemSumm.OperSumm_ChangePercent) AS OperSumm -- !!!�� ���� >0, ������ "������"!!!
                                                                                                  -- �.�. ������: Active=ContainerId_ProfitLoss � �����: Passive=ContainerId_ProfitLoss
                 FROM _tmpItemSumm
                ) AS _tmpCalc
           WHERE _tmpCalc.OperSumm <> 0
          ) AS _tmpItem_byProfitLoss
          LEFT JOIN _tmpItem ON _tmpItem.MovementItemId = _tmpItem_byProfitLoss.MovementItemId
     ;
     -- 5.1.3. ����������� �������� ��� ������ (�����: �����(�/�) <-> ����(������������� ����������))
     PERFORM lpInsertUpdate_MovementItemReport (inMovementDescId     := vbMovementDescId
                                              , inMovementId         := inMovementId
                                              , inMovementItemId     := _tmpItem_byProfitLoss.MovementItemId
                                              , inActiveContainerId  := _tmpItem_byProfitLoss.ActiveContainerId
                                              , inPassiveContainerId := _tmpItem_byProfitLoss.PassiveContainerId
                                              , inActiveAccountId    := _tmpItem_byProfitLoss.ActiveAccountId
                                              , inPassiveAccountId   := _tmpItem_byProfitLoss.PassiveAccountId
                                              , inReportContainerId  := lpInsertFind_ReportContainer (inActiveContainerId  := _tmpItem_byProfitLoss.ActiveContainerId
                                                                                                    , inPassiveContainerId := _tmpItem_byProfitLoss.PassiveContainerId
                                                                                                    , inActiveAccountId    := _tmpItem_byProfitLoss.ActiveAccountId
                                                                                                    , inPassiveAccountId   := _tmpItem_byProfitLoss.PassiveAccountId
                                                                                                     )
                                              , inChildReportContainerId := lpInsertFind_ChildReportContainer (inActiveContainerId  := _tmpItem_byProfitLoss.ActiveContainerId
                                                                                                             , inPassiveContainerId := _tmpItem_byProfitLoss.PassiveContainerId
                                                                                                             , inActiveAccountId    := _tmpItem_byProfitLoss.ActiveAccountId
                                                                                                             , inPassiveAccountId   := _tmpItem_byProfitLoss.PassiveAccountId
                                                                                                             , inAccountKindId_1    := zc_Enum_AccountKind_All()
                                                                                                             , inContainerId_1      := _tmpItem.ContainerId_Partner
                                                                                                             , inAccountId_1        := _tmpItem.AccountId_Partner
                                                                                                     )
                                              , inAmount   := _tmpItem_byProfitLoss.OperSumm
                                              , inOperDate := vbOperDate
                                               )
     FROM (SELECT ABS (_tmpCalc.OperSumm) AS OperSumm
                , CASE WHEN _tmpCalc.OperSumm > 0 THEN _tmpCalc.ContainerId_ProfitLoss ELSE _tmpCalc.ContainerId            END AS ActiveContainerId
                , CASE WHEN _tmpCalc.OperSumm > 0 THEN _tmpCalc.ContainerId            ELSE _tmpCalc.ContainerId_ProfitLoss END AS PassiveContainerId
                , CASE WHEN _tmpCalc.OperSumm > 0 THEN _tmpCalc.AccountId_ProfitLoss   ELSE _tmpCalc.AccountId              END AS ActiveAccountId
                , CASE WHEN _tmpCalc.OperSumm > 0 THEN _tmpCalc.AccountId              ELSE _tmpCalc.AccountId_ProfitLoss   END AS PassiveAccountId -- 100301; "������� �������� �������"
                , _tmpCalc.MovementItemId
           FROM (SELECT _tmpItemSumm.MovementItemId
                      , _tmpItemSumm.ContainerId
                      , _tmpItemSumm.AccountId
                      , _tmpItemSumm.ContainerId_ProfitLoss_10400 AS ContainerId_ProfitLoss
                      , zc_Enum_Account_100301 () AS AccountId_ProfitLoss   -- 100301; "������� �������� �������"
                      , (_tmpItemSumm.OperSumm_Partner) AS OperSumm -- !!!�� ���� >0, ������ "������"!!!
                                                                    -- �.�. ������: Active=ContainerId_ProfitLoss � �����: Passive=ContainerId_ProfitLoss
                 FROM _tmpItemSumm
                ) AS _tmpCalc
           WHERE _tmpCalc.OperSumm <> 0
          ) AS _tmpItem_byProfitLoss
          LEFT JOIN _tmpItem ON _tmpItem.MovementItemId = _tmpItem_byProfitLoss.MovementItemId
     ;

     -- 5.2.1. ����������� �������� ��� ������ (�����: ��.����(����� �� ������) <-> ����(����� ����������)) ���������: !!!����� ����� ����� �� �/�, � ���� ��� ��� ����� �������������� � ��� inAccountId_1 �� ����������!!! 
     PERFORM lpInsertUpdate_MovementItemReport (inMovementDescId     := vbMovementDescId
                                              , inMovementId         := inMovementId
                                              , inMovementItemId     := _tmpItem_byProfitLoss.MovementItemId
                                              , inActiveContainerId  := _tmpItem_byProfitLoss.ActiveContainerId
                                              , inPassiveContainerId := _tmpItem_byProfitLoss.PassiveContainerId
                                              , inActiveAccountId    := _tmpItem_byProfitLoss.ActiveAccountId
                                              , inPassiveAccountId   := _tmpItem_byProfitLoss.PassiveAccountId
                                              , inReportContainerId  := lpInsertFind_ReportContainer (inActiveContainerId  := _tmpItem_byProfitLoss.ActiveContainerId
                                                                                                    , inPassiveContainerId := _tmpItem_byProfitLoss.PassiveContainerId
                                                                                                    , inActiveAccountId    := _tmpItem_byProfitLoss.ActiveAccountId
                                                                                                    , inPassiveAccountId   := _tmpItem_byProfitLoss.PassiveAccountId
                                                                                                     )
                                              , inChildReportContainerId := lpInsertFind_ChildReportContainer (inActiveContainerId  := _tmpItem_byProfitLoss.ActiveContainerId
                                                                                                             , inPassiveContainerId := _tmpItem_byProfitLoss.PassiveContainerId
                                                                                                             , inActiveAccountId    := _tmpItem_byProfitLoss.ActiveAccountId
                                                                                                             , inPassiveAccountId   := _tmpItem_byProfitLoss.PassiveAccountId
                                                                                                             , inAccountKindId_1    := zc_Enum_AccountKind_All()
                                                                                                             , inContainerId_1      := COALESCE (_tmpItemSumm_group.ContainerId, _tmpItem_byProfitLoss.ContainerId_Goods)
                                                                                                             , inAccountId_1        := COALESCE (_tmpItemSumm_group.AccountId, zc_Enum_Account_100301 ()) -- 100301; "������� �������� �������"
                                                                                                     )
                                              , inAmount   := _tmpItem_byProfitLoss.OperSumm
                                              , inOperDate := _tmpItem_byProfitLoss.OperDate
                                               )
     FROM (SELECT ABS (_tmpCalc.OperSumm) AS OperSumm
                , CASE WHEN _tmpCalc.OperSumm >= 0 THEN _tmpCalc.ContainerId_ProfitLoss ELSE _tmpCalc.ContainerId            END AS ActiveContainerId
                , CASE WHEN _tmpCalc.OperSumm >= 0 THEN _tmpCalc.ContainerId            ELSE _tmpCalc.ContainerId_ProfitLoss END AS PassiveContainerId
                , CASE WHEN _tmpCalc.OperSumm >= 0 THEN _tmpCalc.AccountId_ProfitLoss   ELSE _tmpCalc.AccountId              END AS ActiveAccountId
                , CASE WHEN _tmpCalc.OperSumm >= 0 THEN _tmpCalc.AccountId              ELSE _tmpCalc.AccountId_ProfitLoss   END AS PassiveAccountId -- 100301; "������� �������� �������"
                , _tmpCalc.MovementItemId
                , _tmpCalc.ContainerId_Goods
                , _tmpCalc.OperDate
           FROM (SELECT _tmpCalc_all.MovementItemId
                      , _tmpCalc_all.ContainerId_Goods
                      , tmpOperDate.OperDate
                      , CASE WHEN tmpOperDate.OperDate = vbOperDate AND _tmpCalc_all.AccountId_Transit <> 0 THEN _tmpCalc_all.ContainerId_Transit ELSE _tmpCalc_all.ContainerId END AS ContainerId
                      , CASE WHEN tmpOperDate.OperDate = vbOperDate AND _tmpCalc_all.AccountId_Transit <> 0 THEN _tmpCalc_all.AccountId_Transit ELSE _tmpCalc_all.AccountId END AS AccountId
                      , CASE WHEN tmpOperDate.OperDate = vbOperDate THEN _tmpCalc_all.ContainerId_ProfitLoss ELSE _tmpCalc_all.ContainerId_Transit END AS ContainerId_ProfitLoss
                      , CASE WHEN tmpOperDate.OperDate = vbOperDate THEN _tmpCalc_all.AccountId_ProfitLoss ELSE _tmpCalc_all.AccountId_Transit END AS AccountId_ProfitLoss
                      , _tmpCalc_all.OperSumm
                 FROM (SELECT _tmpItem.MovementItemId
                            , _tmpItem.ContainerId_Goods
                            , _tmpItem.ContainerId_Partner AS ContainerId
                            , _tmpItem.AccountId_Partner   AS AccountId
                            , _tmpItem.ContainerId_Transit
                            , _tmpItem.AccountId_Transit
                            , _tmpItem.ContainerId_ProfitLoss_10100 AS ContainerId_ProfitLoss
                            , zc_Enum_Account_100301 () AS AccountId_ProfitLoss   -- 100301; "������� �������� �������"
                            , -1 * _tmpItem.OperSumm_PriceList AS OperSumm -- !!!�����, ������ "�����"!!!
                                                                           -- �.�. ������: Active=ContainerId_ProfitLoss � �����: Passive=ContainerId_ProfitLoss
                       FROM _tmpItem
                      ) AS _tmpCalc_all
                      LEFT JOIN (SELECT vbOperDate AS OperDate UNION SELECT vbOperDatePartner AS OperDate) AS tmpOperDate ON tmpOperDate.OperDate = vbOperDate
                                                                                                                         OR  (tmpOperDate.OperDate = vbOperDatePartner
                                                                                                                          AND COALESCE (_tmpCalc_all.AccountId_Transit, 0) <> 0)
                 -- !!!������ ������������, �.�. �������� ��� ������ ����� ������ ������!!!
                 -- WHERE _tmpCalc_all.OperSumm <> 0
                ) AS _tmpCalc
          ) AS _tmpItem_byProfitLoss
          LEFT JOIN (SELECT _tmpItemSumm.MovementItemId
                          , _tmp_byContainer.ContainerId
                          , MAX (_tmpItemSumm.AccountId) AS AccountId
                     FROM _tmpItemSumm
                          JOIN (SELECT _tmpItemSumm.MovementItemId, MAX  (_tmpItemSumm.ContainerId) AS ContainerId FROM _tmpItemSumm GROUP BY _tmpItemSumm.MovementItemId
                               ) AS _tmp_byContainer ON _tmp_byContainer.MovementItemId = _tmpItemSumm.MovementItemId
                     GROUP BY _tmpItemSumm.MovementItemId
                            , _tmp_byContainer.ContainerId
                    ) AS _tmpItemSumm_group ON _tmpItemSumm_group.MovementItemId = _tmpItem_byProfitLoss.MovementItemId
     ;

     -- 5.2.2. ����������� �������� ��� ������ (�����: ��.����(����� �� ������ "�����" ����� �����������) <-> ����(������ �� ������)) ���������: !!!����� ����� ����� �� �/�, � ���� ��� ��� ����� �������������� � ��� inAccountId_1 �� ����������!!! 
     PERFORM lpInsertUpdate_MovementItemReport (inMovementDescId     := vbMovementDescId
                                              , inMovementId         := inMovementId
                                              , inMovementItemId     := _tmpItem_byProfitLoss.MovementItemId
                                              , inActiveContainerId  := _tmpItem_byProfitLoss.ActiveContainerId
                                              , inPassiveContainerId := _tmpItem_byProfitLoss.PassiveContainerId
                                              , inActiveAccountId    := _tmpItem_byProfitLoss.ActiveAccountId
                                              , inPassiveAccountId   := _tmpItem_byProfitLoss.PassiveAccountId
                                              , inReportContainerId  := lpInsertFind_ReportContainer (inActiveContainerId  := _tmpItem_byProfitLoss.ActiveContainerId
                                                                                                    , inPassiveContainerId := _tmpItem_byProfitLoss.PassiveContainerId
                                                                                                    , inActiveAccountId    := _tmpItem_byProfitLoss.ActiveAccountId
                                                                                                    , inPassiveAccountId   := _tmpItem_byProfitLoss.PassiveAccountId
                                                                                                     )
                                              , inChildReportContainerId := lpInsertFind_ChildReportContainer (inActiveContainerId  := _tmpItem_byProfitLoss.ActiveContainerId
                                                                                                             , inPassiveContainerId := _tmpItem_byProfitLoss.PassiveContainerId
                                                                                                             , inActiveAccountId    := _tmpItem_byProfitLoss.ActiveAccountId
                                                                                                             , inPassiveAccountId   := _tmpItem_byProfitLoss.PassiveAccountId
                                                                                                             , inAccountKindId_1    := zc_Enum_AccountKind_All()
                                                                                                             , inContainerId_1      := COALESCE (_tmpItemSumm_group.ContainerId, _tmpItem_byProfitLoss.ContainerId_Goods)
                                                                                                             , inAccountId_1        := COALESCE (_tmpItemSumm_group.AccountId, zc_Enum_Account_100301 ()) -- 100301; "������� �������� �������"
                                                                                                     )
                                              , inAmount   := _tmpItem_byProfitLoss.OperSumm
                                              , inOperDate := _tmpItem_byProfitLoss.OperDate
                                               )
     FROM (SELECT ABS (_tmpCalc.OperSumm) AS OperSumm
                , CASE WHEN _tmpCalc.OperSumm >= 0 THEN _tmpCalc.ContainerId_ProfitLoss ELSE _tmpCalc.ContainerId            END AS ActiveContainerId
                , CASE WHEN _tmpCalc.OperSumm >= 0 THEN _tmpCalc.ContainerId            ELSE _tmpCalc.ContainerId_ProfitLoss END AS PassiveContainerId
                , CASE WHEN _tmpCalc.OperSumm >= 0 THEN _tmpCalc.AccountId_ProfitLoss   ELSE _tmpCalc.AccountId              END AS ActiveAccountId
                , CASE WHEN _tmpCalc.OperSumm >= 0 THEN _tmpCalc.AccountId              ELSE _tmpCalc.AccountId_ProfitLoss   END AS PassiveAccountId -- 100301; "������� �������� �������"
                , _tmpCalc.MovementItemId
                , _tmpCalc.ContainerId_Goods
                , _tmpCalc.OperDate
           FROM (SELECT _tmpCalc_all.MovementItemId
                      , _tmpCalc_all.ContainerId_Goods
                      , tmpOperDate.OperDate
                      , CASE WHEN tmpOperDate.OperDate = vbOperDate AND _tmpCalc_all.AccountId_Transit <> 0 THEN _tmpCalc_all.ContainerId_Transit ELSE _tmpCalc_all.ContainerId END AS ContainerId
                      , CASE WHEN tmpOperDate.OperDate = vbOperDate AND _tmpCalc_all.AccountId_Transit <> 0 THEN _tmpCalc_all.AccountId_Transit ELSE _tmpCalc_all.AccountId END AS AccountId
                      , CASE WHEN tmpOperDate.OperDate = vbOperDate THEN _tmpCalc_all.ContainerId_ProfitLoss ELSE _tmpCalc_all.ContainerId_Transit END AS ContainerId_ProfitLoss
                      , CASE WHEN tmpOperDate.OperDate = vbOperDate THEN _tmpCalc_all.AccountId_ProfitLoss ELSE _tmpCalc_all.AccountId_Transit END AS AccountId_ProfitLoss
                      , _tmpCalc_all.OperSumm
                 FROM (SELECT _tmpItem.MovementItemId
                            , _tmpItem.ContainerId_Goods
                            , _tmpItem.ContainerId_Partner AS ContainerId
                            , _tmpItem.AccountId_Partner   AS AccountId
                            , _tmpItem.ContainerId_Transit
                            , _tmpItem.AccountId_Transit
                            , _tmpItem.ContainerId_ProfitLoss_10200 AS ContainerId_ProfitLoss
                            , zc_Enum_Account_100301 () AS AccountId_ProfitLoss   -- 100301; "������� �������� �������"
                            , 1 * (_tmpItem.OperSumm_PriceList - _tmpItem.OperSumm_Partner) AS OperSumm -- !!!�� �����, ������ ������, �.�. ��������� "�����" �� ������!!!
                                                                                                        -- �.�. ������: Active=ContainerId_ProfitLoss � �����: Passive=ContainerId_ProfitLoss
                       FROM _tmpItem
                      ) AS _tmpCalc_all
                      LEFT JOIN (SELECT vbOperDate AS OperDate UNION SELECT vbOperDatePartner AS OperDate) AS tmpOperDate ON tmpOperDate.OperDate = vbOperDate
                                                                                                                         OR  (tmpOperDate.OperDate = vbOperDatePartner
                                                                                                                          AND COALESCE (_tmpCalc_all.AccountId_Transit, 0) <> 0)
                 -- !!!������ ������������, �.�. �������� ��� ������ ����� ������ ������!!!
                 -- WHERE _tmpCalc_all.OperSumm <> 0
                ) AS _tmpCalc
          ) AS _tmpItem_byProfitLoss
          LEFT JOIN (SELECT _tmpItemSumm.MovementItemId
                          , _tmp_byContainer.ContainerId
                          , MAX (_tmpItemSumm.AccountId) AS AccountId
                     FROM _tmpItemSumm
                          JOIN (SELECT _tmpItemSumm.MovementItemId, MAX  (_tmpItemSumm.ContainerId) AS ContainerId FROM _tmpItemSumm GROUP BY _tmpItemSumm.MovementItemId
                               ) AS _tmp_byContainer ON _tmp_byContainer.MovementItemId = _tmpItemSumm.MovementItemId
                     GROUP BY _tmpItemSumm.MovementItemId
                            , _tmp_byContainer.ContainerId
                    ) AS _tmpItemSumm_group ON _tmpItemSumm_group.MovementItemId = _tmpItem_byProfitLoss.MovementItemId
     ;

     -- 5.2.3. ����������� �������� ��� ������ (�����: ��.����(����� ����������� "�����" �������� ����� �� �����������) <-> ����(������ ��������������)) ���������: !!!����� ����� ����� �� �/�, � ���� ��� ��� ����� �������������� � ��� inAccountId_1 �� ����������!!! 
     PERFORM lpInsertUpdate_MovementItemReport (inMovementDescId     := vbMovementDescId
                                              , inMovementId         := inMovementId
                                              , inMovementItemId     := _tmpItem_byProfitLoss.MovementItemId
                                              , inActiveContainerId  := _tmpItem_byProfitLoss.ActiveContainerId
                                              , inPassiveContainerId := _tmpItem_byProfitLoss.PassiveContainerId
                                              , inActiveAccountId    := _tmpItem_byProfitLoss.ActiveAccountId
                                              , inPassiveAccountId   := _tmpItem_byProfitLoss.PassiveAccountId
                                              , inReportContainerId  := lpInsertFind_ReportContainer (inActiveContainerId  := _tmpItem_byProfitLoss.ActiveContainerId
                                                                                                    , inPassiveContainerId := _tmpItem_byProfitLoss.PassiveContainerId
                                                                                                    , inActiveAccountId    := _tmpItem_byProfitLoss.ActiveAccountId
                                                                                                    , inPassiveAccountId   := _tmpItem_byProfitLoss.PassiveAccountId
                                                                                                     )
                                              , inChildReportContainerId := lpInsertFind_ChildReportContainer (inActiveContainerId  := _tmpItem_byProfitLoss.ActiveContainerId
                                                                                                             , inPassiveContainerId := _tmpItem_byProfitLoss.PassiveContainerId
                                                                                                             , inActiveAccountId    := _tmpItem_byProfitLoss.ActiveAccountId
                                                                                                             , inPassiveAccountId   := _tmpItem_byProfitLoss.PassiveAccountId
                                                                                                             , inAccountKindId_1    := zc_Enum_AccountKind_All()
                                                                                                             , inContainerId_1      := COALESCE (_tmpItemSumm_group.ContainerId, _tmpItem_byProfitLoss.ContainerId_Goods)
                                                                                                             , inAccountId_1        := COALESCE (_tmpItemSumm_group.AccountId, zc_Enum_Account_100301 ()) -- 100301; "������� �������� �������"
                                                                                                     )
                                              , inAmount   := _tmpItem_byProfitLoss.OperSumm
                                              , inOperDate := _tmpItem_byProfitLoss.OperDate
                                               )
     FROM (SELECT ABS (_tmpCalc.OperSumm) AS OperSumm
                , CASE WHEN _tmpCalc.OperSumm >= 0 THEN _tmpCalc.ContainerId_ProfitLoss ELSE _tmpCalc.ContainerId            END AS ActiveContainerId
                , CASE WHEN _tmpCalc.OperSumm >= 0 THEN _tmpCalc.ContainerId            ELSE _tmpCalc.ContainerId_ProfitLoss END AS PassiveContainerId
                , CASE WHEN _tmpCalc.OperSumm >= 0 THEN _tmpCalc.AccountId_ProfitLoss   ELSE _tmpCalc.AccountId              END AS ActiveAccountId
                , CASE WHEN _tmpCalc.OperSumm >= 0 THEN _tmpCalc.AccountId              ELSE _tmpCalc.AccountId_ProfitLoss   END AS PassiveAccountId -- 100301; "������� �������� �������"
                , _tmpCalc.MovementItemId
                , _tmpCalc.ContainerId_Goods
                , _tmpCalc.OperDate
           FROM (SELECT _tmpCalc_all.MovementItemId
                      , _tmpCalc_all.ContainerId_Goods
                      , tmpOperDate.OperDate
                      , CASE WHEN tmpOperDate.OperDate = vbOperDate AND _tmpCalc_all.AccountId_Transit <> 0 THEN _tmpCalc_all.ContainerId_Transit ELSE _tmpCalc_all.ContainerId END AS ContainerId
                      , CASE WHEN tmpOperDate.OperDate = vbOperDate AND _tmpCalc_all.AccountId_Transit <> 0 THEN _tmpCalc_all.AccountId_Transit ELSE _tmpCalc_all.AccountId END AS AccountId
                      , CASE WHEN tmpOperDate.OperDate = vbOperDate THEN _tmpCalc_all.ContainerId_ProfitLoss ELSE _tmpCalc_all.ContainerId_Transit END AS ContainerId_ProfitLoss
                      , CASE WHEN tmpOperDate.OperDate = vbOperDate THEN _tmpCalc_all.AccountId_ProfitLoss ELSE _tmpCalc_all.AccountId_Transit END AS AccountId_ProfitLoss
                      , _tmpCalc_all.OperSumm
                 FROM (SELECT _tmpItem.MovementItemId
                            , _tmpItem.ContainerId_Goods
                            , _tmpItem.ContainerId_Partner AS ContainerId
                            , _tmpItem.AccountId_Partner   AS AccountId
                            , _tmpItem.ContainerId_Transit
                            , _tmpItem.AccountId_Transit
                            , _tmpItem.ContainerId_ProfitLoss_10300 AS ContainerId_ProfitLoss
                            , zc_Enum_Account_100301 () AS AccountId_ProfitLoss   -- 100301; "������� �������� �������"
                            , 1 * (_tmpItem.OperSumm_Partner - _tmpItem.OperSumm_Partner_ChangePercent) AS OperSumm -- !!!�� �����, ������ "������", �.�. ��������� "�����" �� ������!!!
                                                                                                                    -- �.�. ������: Active=ContainerId_ProfitLoss � �����: Passive=ContainerId_ProfitLoss
                       FROM _tmpItem
                      ) AS _tmpCalc_all
                      LEFT JOIN (SELECT vbOperDate AS OperDate UNION SELECT vbOperDatePartner AS OperDate) AS tmpOperDate ON tmpOperDate.OperDate = vbOperDate
                                                                                                                         OR  (tmpOperDate.OperDate = vbOperDatePartner
                                                                                                                          AND COALESCE (_tmpCalc_all.AccountId_Transit, 0) <> 0)
                 -- !!!������ ������������, �.�. �������� ��� ������ ����� ������ ������!!!
                 -- WHERE _tmpCalc_all.OperSumm <> 0
                ) AS _tmpCalc
          ) AS _tmpItem_byProfitLoss
          LEFT JOIN (SELECT _tmpItemSumm.MovementItemId
                          , _tmp_byContainer.ContainerId
                          , MAX (_tmpItemSumm.AccountId) AS AccountId
                     FROM _tmpItemSumm
                          JOIN (SELECT _tmpItemSumm.MovementItemId, MAX  (_tmpItemSumm.ContainerId) AS ContainerId FROM _tmpItemSumm GROUP BY _tmpItemSumm.MovementItemId
                               ) AS _tmp_byContainer ON _tmp_byContainer.MovementItemId = _tmpItemSumm.MovementItemId
                     GROUP BY _tmpItemSumm.MovementItemId
                            , _tmp_byContainer.ContainerId
                    ) AS _tmpItemSumm_group ON _tmpItemSumm_group.MovementItemId = _tmpItem_byProfitLoss.MovementItemId
     ;


     -- !!!6.0. ����������� �������� � ��������� ��������� �� ������ ��� ��������!!!
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_Branch(), tmp.MovementItemId, vbBranchId_From)
     FROM (SELECT _tmpItem.MovementItemId
           FROM _tmpItem
          ) AS tmp;

     -- 6.1. ����� - ����������� ��������� ��������
     PERFORM lpInsertUpdate_MovementItemContainer_byTable ();

     -- 6.2. ����� - ����������� ������ ������ ��������� + ��������� ��������
     PERFORM lpComplete_Movement (inMovementId := inMovementId
                                , inDescId     := zc_Movement_Sale()
                                , inUserId     := inUserId
                                 );

     -- 6.3. ����� - ������������ ���������
     IF (vbIsHistoryCost = FALSE)
        AND vbCurrencyDocumentId = zc_Enum_Currency_Basis()
        AND vbCurrencyPartnerId = zc_Enum_Currency_Basis()
        AND EXISTS (SELECT MovementLinkMovement_Master.MovementId
                    FROM MovementLinkMovement AS MovementLinkMovement_Master
                         INNER JOIN Movement AS Movement_DocumentMaster ON Movement_DocumentMaster.Id = MovementLinkMovement_Master.MovementChildId
                                                                       AND Movement_DocumentMaster.StatusId <> zc_Enum_Status_Erased()
                         INNER JOIN MovementLinkObject AS MovementLinkObject_DocumentTaxKind_Master
                                                       ON MovementLinkObject_DocumentTaxKind_Master.MovementId = Movement_DocumentMaster.Id
                                                      AND MovementLinkObject_DocumentTaxKind_Master.DescId = zc_MovementLinkObject_DocumentTaxKind()
                                                      AND MovementLinkObject_DocumentTaxKind_Master.ObjectId = zc_Enum_DocumentTaxKind_Tax()
                    WHERE MovementLinkMovement_Master.MovementId = inMovementId
                      AND MovementLinkMovement_Master.DescId = zc_MovementLinkMovement_Master()
                   )
     THEN PERFORM lpInsertUpdate_Movement_Tax_From_Kind (inMovementId            := inMovementId
                                                       , inDocumentTaxKindId     := zc_Enum_DocumentTaxKind_Tax()
                                                       , inDocumentTaxKindId_inf := NULL
                                                       , inUserId                := inUserId
                                                        );
     END IF;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.
 19.10.14                                        * add inIsLastComplete = FALSE, ����� ������������ ���������
 07.09.14                                        * add zc_ContainerLinkObject_Branch to vbPartnerId_To
 05.09.14                                        * add zc_ContainerLinkObject_Branch to ���.���� (����������� ����)
 02.09.14                                        * add vbIsHistoryCost
 23.08.14                                        * add vbPartnerId_To
 17.08.14                                        * add MovementDescId
 12.08.14                                        * add inBranchId :=
 12.08.14                                        * add !!!����������� ����������!!!
 22.07.14                                        * add ...Price
 25.05.14                                        * add lpComplete_Movement
 22.05.14                                        * modify lfSelect_ObjectHistory_PriceListItem ... inOperDate:= vbOperDatePartner
 16.05.14                                        * add ����� - ������������ ���������
 10.05.14                                        * add lpInsert_MovementProtocol
 04.05.14                                        * rem zc_Enum_AccountDirection_30400
 30.04.14                                        * set lp
 26.04.14                                        * !!!RESTORE!!!
 05.04.14                                        * add !!!��� �����������!!! : _tmp1___ and _tmp2___
 25.03.14                                        * ������� - !!!��� �����������!!!
 14.02.14                                        *
*/

-- ����
-- SELECT * FROM gpUnComplete_Movement (inMovementId:= 122175 , inSession:= '2')
-- SELECT * FROM lpComplete_Movement_Sale (inMovementId:= 122175, inIsLastComplete:= FALSE, inSession:= zfCalc_UserAdmin())
-- SELECT * FROM gpSelect_MovementItemContainer_Movement (inMovementId:= 122175 , inSession:= '2')
