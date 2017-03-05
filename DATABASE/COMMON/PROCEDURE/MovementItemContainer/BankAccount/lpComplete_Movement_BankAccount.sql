-- Function: lpComplete_Movement_BankAccount (Integer, Boolean)

DROP FUNCTION IF EXISTS lpComplete_Movement_BankAccount (Integer, Integer);

CREATE OR REPLACE FUNCTION lpComplete_Movement_BankAccount(
    IN inMovementId        Integer  , -- ���� ���������
    IN inUserId            Integer    -- ������������
)                              
RETURNS VOID
AS
$BODY$
BEGIN
     -- ���� ������ �� ��
     IF EXISTS (SELECT Object.Id FROM Object WHERE Object.Id = (SELECT MI_LO.ObjectId
                                                                FROM MovementItem AS MI
                                                                     INNER JOIN MovementItemLinkObject AS MI_LO ON MI_LO.MovementItemId = MI.Id AND MI_LO.DescId = zc_MILinkObject_MoneyPlace()
                                                                WHERE MI.MovementId = inMovementId AND MI.DescId = zc_MI_Master())
                                               AND Object.DescId = zc_Object_PersonalServiceList())
     THEN
         -- ������������ ������ <��������� ����, ������� �� ���������>
         PERFORM lpComplete_Movement_BankAccount_Recalc (inMovementId := inMovementId
                                                       , inUserId     := inUserId);
     END IF;


     -- !!!�����������!!! �������� ������� ��������
     DELETE FROM _tmpMIContainer_insert;
     DELETE FROM _tmpMIReport_insert;
     -- !!!�����������!!! �������� ������� - �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     DELETE FROM _tmpItem;

     -- ��������� ������� - �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     INSERT INTO _tmpItem (MovementDescId, OperDate, ObjectId, ObjectDescId, OperSumm, OperSumm_Currency, OperSumm_Diff
                         , MovementItemId, ContainerId, ContainerId_Currency, ContainerId_Diff, ProfitLossId_Diff
                         , AccountGroupId, AccountDirectionId, AccountId
                         , ProfitLossGroupId, ProfitLossDirectionId
                         , InfoMoneyGroupId, InfoMoneyDestinationId, InfoMoneyId
                         , BusinessId_Balance, BusinessId_ProfitLoss, JuridicalId_Basis
                         , UnitId, PositionId, PersonalServiceListId, BranchId_Balance, BranchId_ProfitLoss, ServiceDateId, ContractId, PaidKindId
                         , CurrencyId
                         , IsActive, IsMaster
                          )
        SELECT Movement.DescId
             , Movement.OperDate
             , COALESCE (MovementItem.ObjectId, 0) AS ObjectId
             , COALESCE (Object.DescId, 0) AS ObjectDescId
             , MovementItem.Amount AS OperSumm
             , COALESCE (MovementFloat_AmountCurrency.ValueData, 0) AS OperSumm_Currency
             , 0 AS OperSumm_Diff
             , MovementItem.Id AS MovementItemId

             , 0 AS ContainerId                                                     -- ���������� �����
             , 0 AS ContainerId_Currency                                            -- ���������� �����
             , 0 AS ContainerId_Diff, 0 AS ProfitLossId_Diff                        -- ���������� �����
             , 0 AS AccountGroupId, 0 AS AccountDirectionId, 0 AS AccountId         -- ���������� �����
             , 0 AS ProfitLossGroupId, 0 AS ProfitLossDirectionId                   -- �� ������������

               -- �������������� ������ ����������
             , COALESCE (View_InfoMoney.InfoMoneyGroupId, 0) AS InfoMoneyGroupId
               -- �������������� ����������
             , COALESCE (View_InfoMoney.InfoMoneyDestinationId, 0) AS InfoMoneyDestinationId
               -- �������������� ������ ����������
             , COALESCE (View_InfoMoney.InfoMoneyId, 0) AS InfoMoneyId

               -- ������ ������: �� ������������
             , 0 AS BusinessId_Balance
               -- ������ ����: �� ������������
             , 0 AS BusinessId_ProfitLoss

               -- ������� ��.���� ������ �� �/��.
             , COALESCE (BankAccount_Juridical.ChildObjectId, 0) AS JuridicalId_Basis

             , 0 AS UnitId                -- �� ������������
             , 0 AS PositionId            -- �� ������������
             , 0 AS PersonalServiceListId -- �� ������������

               -- ������ ������: �� ������������
             , 0 AS BranchId_Balance
               -- ������ ����: �� ������������
             , 0 AS BranchId_ProfitLoss

               -- ����� ����������: �� ������������
             , 0 AS ServiceDateId

             , 0 AS ContractId -- �� ������������
             , 0 AS PaidKindId -- �� ������������

               -- ������
             , COALESCE (MILinkObject_Currency.ObjectId, zc_Enum_Currency_Basis()) AS CurrencyId

             , CASE WHEN MovementItem.Amount >= 0 THEN TRUE ELSE FALSE END AS IsActive
             , TRUE AS IsMaster

        FROM Movement
             INNER JOIN MovementItem ON MovementItem.MovementId = Movement.Id AND MovementItem.DescId = zc_MI_Master()

             LEFT JOIN MovementFloat AS MovementFloat_AmountCurrency
                                     ON MovementFloat_AmountCurrency.MovementId = Movement.Id
                                    AND MovementFloat_AmountCurrency.DescId = zc_MovementFloat_AmountCurrency()

             LEFT JOIN MovementItemLinkObject AS MILinkObject_InfoMoney
                                              ON MILinkObject_InfoMoney.MovementItemId = MovementItem.Id
                                             AND MILinkObject_InfoMoney.DescId = zc_MILinkObject_InfoMoney()
            LEFT JOIN MovementItemLinkObject AS MILinkObject_Currency
                                             ON MILinkObject_Currency.MovementItemId = MovementItem.Id
                                            AND MILinkObject_Currency.DescId = zc_MILinkObject_Currency()

             LEFT JOIN Object ON Object.Id = MovementItem.ObjectId
             LEFT JOIN ObjectLink AS BankAccount_Juridical ON BankAccount_Juridical.ObjectId = MovementItem.ObjectId
                                                          AND BankAccount_Juridical.DescId = zc_ObjectLink_BankAccount_Juridical()
             LEFT JOIN Object_InfoMoney_View AS View_InfoMoney ON View_InfoMoney.InfoMoneyId = MILinkObject_InfoMoney.ObjectId
        WHERE Movement.Id = inMovementId
          AND Movement.DescId = zc_Movement_BankAccount()
          AND Movement.StatusId IN (zc_Enum_Status_UnComplete(), zc_Enum_Status_Erased())
       ;


     -- ��������
     IF EXISTS (SELECT _tmpItem.ObjectId FROM _tmpItem WHERE _tmpItem.ObjectId = 0)
     THEN
         RAISE EXCEPTION '������.� ��������� �� ��������� ��������� ����.���������� ����������.';
     END IF;
   
     -- ��������
     IF EXISTS (SELECT _tmpItem.JuridicalId_Basis FROM _tmpItem WHERE _tmpItem.JuridicalId_Basis = 0)
     THEN
         RAISE EXCEPTION '������.� ���������� ����� �� ����������� ������� �� ����.���������� ����������.';
     END IF;


     -- ��������� ������� - �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     WITH tmpPersonal AS (SELECT tmp.Id AS MemberId
                               , tmp.PersonalId
                               , tmp.PositionId
                               , tmp.UnitId
                               , tmp.PersonalServiceListId
                          FROM gpGet_Object_Member ((SELECT MILinkObject_MoneyPlace.ObjectId
                                                     FROM _tmpItem
                                                          INNER JOIN MovementItemLinkObject AS MILinkObject_MoneyPlace
                                                                                            ON MILinkObject_MoneyPlace.MovementItemId = _tmpItem.MovementItemId
                                                                                           AND MILinkObject_MoneyPlace.DescId = zc_MILinkObject_MoneyPlace()
                                                     WHERE _tmpItem.InfoMoneyGroupId = zc_Enum_InfoMoneyGroup_60000()) -- ���������� �����
                                                  , inUserId :: TVarChar) AS tmp
                         )
     INSERT INTO _tmpItem (MovementDescId, OperDate, ObjectId, ObjectDescId, OperSumm, OperSumm_Currency, OperSumm_Diff
                         , MovementItemId, ContainerId, ContainerId_Currency, ContainerId_Diff, ProfitLossId_Diff
                         , AccountGroupId, AccountDirectionId, AccountId
                         , ProfitLossGroupId, ProfitLossDirectionId
                         , InfoMoneyGroupId, InfoMoneyDestinationId, InfoMoneyId
                         , BusinessId_Balance, BusinessId_ProfitLoss, JuridicalId_Basis
                         , UnitId, PositionId, PersonalServiceListId, BranchId_Balance, BranchId_ProfitLoss, ServiceDateId, ContractId, PaidKindId
                         , CurrencyId
                         , IsActive, IsMaster
                          )
        SELECT _tmpItem.MovementDescId
             , _tmpItem.OperDate
             , COALESCE (MI_Child.ObjectId, COALESCE (tmpPersonal.PersonalId, COALESCE (ObjectLink_Founder_InfoMoney.ObjectId, MILinkObject_MoneyPlace.ObjectId))) AS ObjectId
             , COALESCE (Object.DescId, 0) AS ObjectDescId
             , CASE WHEN /*_tmpItem.CurrencyId = zc_Enum_Currency_Basis()
                     AND _tmpItem.isActive = TRUE
                     AND*/ _tmpItem.isActive = TRUE
                       AND _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_41000() -- �������/������� ������
                         THEN -1 * COALESCE (MovementFloat_Amount.ValueData, 0)
                    WHEN _tmpItem.CurrencyId = zc_Enum_Currency_Basis()
                         THEN COALESCE (MI_Child.Amount, -1 * _tmpItem.OperSumm)
                    ELSE -1 * /*CASE WHEN _tmpItem.IsActive = TRUE THEN -1 ELSE 1 END*/ CAST (CASE WHEN MovementFloat_ParPartnerValue.ValueData <> 0 THEN _tmpItem.OperSumm_Currency * MovementFloat_CurrencyPartnerValue.ValueData / MovementFloat_ParPartnerValue.ValueData ELSE 0 END AS NUMERIC (16, 2))
               END AS OperSumm
             , CASE WHEN Object.DescId IN (zc_Object_Juridical(), zc_Object_Partner())
                         THEN -1 * _tmpItem.OperSumm_Currency
                    WHEN Object.DescId IN (zc_Object_BankAccount(), zc_Object_Cash())
                         THEN -1 * _tmpItem.OperSumm_Currency
                    ELSE 0
               END AS OperSumm_Currency
             , CASE WHEN /*_tmpItem.CurrencyId = zc_Enum_Currency_Basis()
                     AND _tmpItem.isActive = TRUE
                     AND*/ _tmpItem.isActive = TRUE
                       AND _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_41000() -- �������/������� ������
                         THEN COALESCE (MovementFloat_Amount.ValueData, 0) - _tmpItem.OperSumm
                    WHEN _tmpItem.CurrencyId = zc_Enum_Currency_Basis()
                         THEN 0
                    ELSE -1 * _tmpItem.OperSumm + 1 * /*CASE WHEN _tmpItem.IsActive = TRUE THEN -1 ELSE 1 END*/ CAST (CASE WHEN MovementFloat_ParPartnerValue.ValueData <> 0 THEN _tmpItem.OperSumm_Currency * MovementFloat_CurrencyPartnerValue.ValueData / MovementFloat_ParPartnerValue.ValueData ELSE 0 END AS NUMERIC (16, 2))
               END AS OperSumm_Diff
 
             , COALESCE (MI_Child.Id, _tmpItem.MovementItemId) AS MovementItemId

             , 0 AS ContainerId                                               -- ���������� �����
             , 0 AS ContainerId_Currency                                      -- ���������� �����
             , 0 AS ContainerId_Diff                                          -- ���������� �����

             , CASE WHEN Object.DescId IN (zc_Object_BankAccount(), zc_Object_Cash())
                      OR _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_41000() -- �������/������� ������
                         THEN zc_Enum_ProfitLoss_80105() -- ������� ��� �������/������� ������
                    ELSE zc_Enum_ProfitLoss_80103() -- �������� �������
               END AS ProfitLossId_Diff

             , 0 AS AccountGroupId, 0 AS AccountDirectionId                   -- ���������� �����

             , CASE WHEN Object.DescId IN (zc_Object_BankAccount(), zc_Object_Cash())
                         THEN CASE WHEN _tmpItem.CurrencyId = zc_Enum_Currency_Basis()
                                        THEN zc_Enum_Account_110301() -- ������� + ��������� ���� + ��������� ����
                                   ELSE zc_Enum_Account_110302() -- ������� + ��������� ���� + ��������
                              END
                    ELSE 0
               END AS AccountId -- ... ��� ���������� �����

               -- ������ ����
             , COALESCE (lfObject_Unit_byProfitLossDirection.ProfitLossGroupId, 0) AS ProfitLossGroupId
               -- ��������� ���� - �����������
             , COALESCE (lfObject_Unit_byProfitLossDirection.ProfitLossDirectionId, 0) AS ProfitLossDirectionId

               -- �������������� ������ ����������
             , _tmpItem.InfoMoneyGroupId
               -- �������������� ����������
             , _tmpItem.InfoMoneyDestinationId
               -- �������������� ������ ����������
             , _tmpItem.InfoMoneyId

               -- ������ ������: ������ �� �/��. (� �������� ������=0)
             , _tmpItem.BusinessId_Balance
               -- ������ ����: ObjectLink_Unit_Business
             , COALESCE (ObjectLink_Unit_Business.ChildObjectId, 0) AS BusinessId_ProfitLoss

               -- ������� ��.���� ������ �� �/��.
             , _tmpItem.JuridicalId_Basis

             , COALESCE (MILinkObject_Unit.ObjectId, COALESCE (tmpPersonal.UnitId, 0))         AS UnitId
             , COALESCE (MILinkObject_Position.ObjectId, COALESCE (tmpPersonal.PositionId, 0)) AS PositionId -- ������������
             /*, CASE WHEN MI_Child.Id > 0
                         THEN COALESCE (MILinkObject_MoneyPlace.ObjectId, 0)
                    ELSE COALESCE (MLO_PersonalServiceList.ObjectId, 0)
               END AS PersonalServiceListId*/
             , COALESCE (MILinkObject_PersonalServiceList.ObjectId, COALESCE (tmpPersonal.PersonalServiceListId, 0)) AS PersonalServiceListId

               -- ������ ������: ������ �� �/��. (� �������� ������=0) !!!�� ��� �� - ��� � �����������!!!
             , CASE WHEN MI_Child.Id > 0 OR tmpPersonal.MemberId > 0
                         THEN COALESCE (ObjectLink_Unit_Branch.ChildObjectId, zc_Branch_Basis())
                    ELSE _tmpItem.BranchId_Balance
               END AS BranchId_Balance
               -- ������ ����: ������ �� ������������� !!!�� ��� �� - �� ������������!!!
             , CASE WHEN MI_Child.Id > 0
                         THEN 0
                    ELSE COALESCE (ObjectLink_Unit_Branch.ChildObjectId, 0)
               END AS BranchId_ProfitLoss

               -- ����� ����������: ����
             , CASE WHEN tmpPersonal.MemberId > 0
                         THEN lpInsertFind_Object_ServiceDate (inOperDate:= _tmpItem.OperDate) -- !!!�.�. �� ���� ���������!!!
                    WHEN _tmpItem.InfoMoneyGroupId = zc_Enum_InfoMoneyGroup_60000() -- ���������� �����
                         THEN lpInsertFind_Object_ServiceDate (inOperDate:= MIDate_ServiceDate.ValueData)
                    ELSE 0
               END AS ServiceDateId

             , COALESCE (MILinkObject_Contract.ObjectId, 0) AS ContractId
             , zc_Enum_PaidKind_FirstForm() AS PaidKindId -- ������ ��

             , CASE WHEN Object.DescId IN (zc_Object_Juridical(), zc_Object_Partner())
                     AND _tmpItem.CurrencyId <> zc_Enum_Currency_Basis()
                     /*AND _tmpItem.isActive = FALSE*/
                     AND _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_41000() -- �������/������� ������
                         THEN zc_Enum_Currency_Basis() -- !!!�������� ������!!!
                    WHEN Object.DescId IN (zc_Object_Juridical(), zc_Object_Partner())
                         THEN _tmpItem.CurrencyId
                    WHEN Object.DescId IN (zc_Object_BankAccount(), zc_Object_Cash())
                         THEN _tmpItem.CurrencyId
                    ELSE 0
               END AS CurrencyId

             , NOT _tmpItem.IsActive
             , NOT _tmpItem.IsMaster
        FROM _tmpItem
             LEFT JOIN MovementItem AS MI_Child ON MI_Child.MovementId = inMovementId
                                               AND MI_Child.DescId = zc_MI_Child()
                                               AND MI_Child.isErased = FALSE
             LEFT JOIN MovementItemDate AS MIDate_ServiceDate
                                        ON MIDate_ServiceDate.MovementItemId = MI_Child.Id
                                       AND MIDate_ServiceDate.DescId = zc_MIDate_ServiceDate()
             LEFT JOIN MovementItemLinkObject AS MILinkObject_PersonalServiceList
                                              ON MILinkObject_PersonalServiceList.MovementItemId = MI_Child.Id
                                             AND MILinkObject_PersonalServiceList.DescId = zc_MILinkObject_PersonalServiceList()

             LEFT JOIN MovementFloat AS MovementFloat_Amount
                                     ON MovementFloat_Amount.MovementId = inMovementId
                                    AND MovementFloat_Amount.DescId = zc_MovementFloat_Amount()
             LEFT JOIN MovementFloat AS MovementFloat_CurrencyPartnerValue
                                     ON MovementFloat_CurrencyPartnerValue.MovementId = inMovementId
                                    AND MovementFloat_CurrencyPartnerValue.DescId = zc_MovementFloat_CurrencyPartnerValue()
             LEFT JOIN MovementFloat AS MovementFloat_ParPartnerValue
                                     ON MovementFloat_ParPartnerValue.MovementId = inMovementId
                                    AND MovementFloat_ParPartnerValue.DescId = zc_MovementFloat_ParPartnerValue()
             LEFT JOIN MovementItemLinkObject AS MILinkObject_MoneyPlace
                                              ON MILinkObject_MoneyPlace.MovementItemId = _tmpItem.MovementItemId
                                             AND MILinkObject_MoneyPlace.DescId = zc_MILinkObject_MoneyPlace()
             LEFT JOIN tmpPersonal ON tmpPersonal.MemberId = MILinkObject_MoneyPlace.ObjectId

             LEFT JOIN MovementItemLinkObject AS MILinkObject_Unit
                                              ON MILinkObject_Unit.MovementItemId = COALESCE (MI_Child.Id, _tmpItem.MovementItemId)
                                             AND MILinkObject_Unit.DescId = zc_MILinkObject_Unit()
             LEFT JOIN MovementItemLinkObject AS MILinkObject_Position
                                              ON MILinkObject_Position.MovementItemId = COALESCE (MI_Child.Id, _tmpItem.MovementItemId)
                                             AND MILinkObject_Position.DescId = zc_MILinkObject_Position()
             LEFT JOIN MovementItemLinkObject AS MILinkObject_Contract
                                              ON MILinkObject_Contract.MovementItemId =  _tmpItem.MovementItemId
                                             AND MILinkObject_Contract.DescId = zc_MILinkObject_Contract()

             LEFT JOIN ObjectLink AS ObjectLink_Founder_InfoMoney
                                  ON ObjectLink_Founder_InfoMoney.ChildObjectId = _tmpItem.InfoMoneyId
                                 AND ObjectLink_Founder_InfoMoney.DescId = zc_ObjectLink_Founder_InfoMoney()

             LEFT JOIN Object ON Object.Id = COALESCE (MI_Child.ObjectId, COALESCE (tmpPersonal.PersonalId, COALESCE (ObjectLink_Founder_InfoMoney.ObjectId, MILinkObject_MoneyPlace.ObjectId)))
             LEFT JOIN ObjectLink AS ObjectLink_Unit_Business ON ObjectLink_Unit_Business.ObjectId = COALESCE (MILinkObject_Unit.ObjectId, tmpPersonal.UnitId)
                                                             AND ObjectLink_Unit_Business.DescId = zc_ObjectLink_Unit_Business()
             LEFT JOIN ObjectLink AS ObjectLink_Unit_Branch ON ObjectLink_Unit_Branch.ObjectId = COALESCE (MILinkObject_Unit.ObjectId, tmpPersonal.UnitId)
                                                           AND ObjectLink_Unit_Branch.DescId = zc_ObjectLink_Unit_Branch()
             LEFT JOIN lfSelect_Object_Unit_byProfitLossDirection() AS lfObject_Unit_byProfitLossDirection ON lfObject_Unit_byProfitLossDirection.UnitId = COALESCE (MILinkObject_Unit.ObjectId, tmpPersonal.UnitId)
                                                                                                          AND Object.Id IS NULL -- !!!����� ������ ��� ������!!!
       ;

     -- 5.1. ����� - ���������/��������� ��������
     PERFORM lpComplete_Movement_Finance (inMovementId := inMovementId
                                        , inUserId     := inUserId);

     -- 5.2. ����� - ����������� ������ ������ ��������� + ��������� ��������
     PERFORM lpComplete_Movement (inMovementId := inMovementId
                                , inDescId     := zc_Movement_BankAccount()
                                , inUserId     := inUserId
                                 );

END;$BODY$
  LANGUAGE plpgsql VOLATILE;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 20.09.14                                        * add zc_ObjectLink_Founder_InfoMoney
 12.09.14                                        * add PositionId and ServiceDateId and BusinessId_... and BranchId_...
 17.08.14                                        * add MovementDescId
 25.05.14                                        * add lpComplete_Movement
 10.05.14                                        * add lpInsert_MovementProtocol
 22.01.14                                        * add IsMaster
 16.01.13                                        *
*/

-- ����
-- SELECT * FROM lpUnComplete_Movement (inMovementId:= 3581, inUserId:= zfCalc_UserAdmin() :: Integer)
-- SELECT * FROM gpComplete_Movement_BankAccount (inMovementId:= 3581, inSession:= zfCalc_UserAdmin())
-- SELECT * FROM gpSelect_MovementItemContainer_Movement (inMovementId:= 3581, inSession:= zfCalc_UserAdmin())
