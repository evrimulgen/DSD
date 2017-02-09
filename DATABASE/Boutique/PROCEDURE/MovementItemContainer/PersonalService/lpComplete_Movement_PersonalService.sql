-- Function: lpComplete_Movement_PersonalService (Integer, Boolean)

DROP FUNCTION IF EXISTS lpComplete_Movement_PersonalService (Integer, Integer);

CREATE OR REPLACE FUNCTION lpComplete_Movement_PersonalService(
    IN inMovementId        Integer  , -- ���� ���������
    IN inUserId            Integer    -- ������������
)                              
RETURNS VOID
AS
$BODY$
   DECLARE vbMovementId_check Integer;
BEGIN
     -- ������� - �� ����������, ��� lpComplete_Movement_PersonalService_Recalc
     CREATE TEMP TABLE _tmpMovement_Recalc (MovementId Integer, StatusId Integer, PersonalServiceListId Integer, PaidKindId Integer, ServiceDate TDateTime) ON COMMIT DROP;
     -- ������� - �� ���������, ��� lpComplete_Movement_PersonalService_Recalc
     CREATE TEMP TABLE _tmpMI_Recalc (MovementId_from Integer, MovementItemId_from Integer, PersonalServiceListId_from Integer, MovementId_to Integer, MovementItemId_to Integer, PersonalServiceListId_to Integer, ServiceDate TDateTime, UnitId Integer, PersonalId Integer, PositionId Integer, InfoMoneyId Integer, SummCardRecalc TFloat, SummNalogRecalc TFloat, isMovementComplete Boolean) ON COMMIT DROP;


     -- �������� - ������ ���� �� ������
     vbMovementId_check:= (SELECT MovementDate_ServiceDate.MovementId
                           FROM (SELECT MovementDate.MovementId     AS MovementId
                                      , MovementDate.ValueData      AS ServiceDate
                                      , MovementLinkObject.ObjectId AS PersonalServiceListId
                                 FROM MovementDate
                                      LEFT JOIN MovementLinkObject ON MovementLinkObject.MovementId = MovementDate.MovementId
                                                                  AND MovementLinkObject.DescId = zc_MovementLinkObject_PersonalServiceList()
                                 WHERE MovementDate.MovementId = inMovementId
                                   AND MovementDate.DescId = zc_MIDate_ServiceDate()
                                 ) tmpMovement
                                INNER JOIN MovementDate AS MovementDate_ServiceDate
                                                        ON MovementDate_ServiceDate.ValueData = tmpMovement.ServiceDate
                                                       AND MovementDate_ServiceDate.DescId = zc_MIDate_ServiceDate()
                                                       AND MovementDate_ServiceDate.MovementId <> tmpMovement.MovementId
                                INNER JOIN Movement ON Movement.Id = MovementDate_ServiceDate.MovementId
                                                   AND Movement.StatusId = zc_Enum_Status_Complete()
                                INNER JOIN MovementLinkObject AS MovementLinkObject_PersonalServiceList
                                                              ON MovementLinkObject_PersonalServiceList.MovementId = MovementDate_ServiceDate.MovementId
                                                             AND MovementLinkObject_PersonalServiceList.DescId = zc_MovementLinkObject_PersonalServiceList()
                                                             AND MovementLinkObject_PersonalServiceList.ObjectId = tmpMovement.PersonalServiceListId
                           LIMIT 1
                          );
     IF vbMovementId_check <> 0
     THEN
         RAISE EXCEPTION '������.������� ������ <��������� ����������> � <%> �� <%> ��� <%> �� <%>.������������ ���������. <%>', (SELECT Movement.InvNumber FROM Movement WHERE Movement.Id = vbMovementId_check)
                                                                                                                           , DATE ((SELECT Movement.OperDate FROM Movement WHERE Movement.Id = vbMovementId_check))
                                                                                                                           , lfGet_Object_ValueData ((SELECT MovementLinkObject.ObjectId FROM MovementLinkObject WHERE MovementLinkObject.MovementId = vbMovementId_check AND MovementLinkObject.DescId = zc_MovementLinkObject_PersonalServiceList()))
                                                                                                                           , zfCalc_MonthYearName ((SELECT MovementDate.ValueData FROM MovementDate WHERE MovementDate.MovementId = vbMovementId_check AND MovementDate.DescId = zc_MIDate_ServiceDate()))
                        , (SELECT MovementDate_ServiceDate.MovementId
                           FROM (SELECT MovementDate.MovementId     AS MovementId
                                      , MovementDate.ValueData      AS ServiceDate
                                      , MovementLinkObject.ObjectId AS PersonalServiceListId
                                 FROM MovementDate
                                      LEFT JOIN MovementLinkObject ON MovementLinkObject.MovementId = MovementDate.MovementId
                                                                  AND MovementLinkObject.DescId = zc_MovementLinkObject_PersonalServiceList()
                                 WHERE MovementDate.MovementId = inMovementId
                                   AND MovementDate.DescId = zc_MIDate_ServiceDate()
                                 ) tmpMovement
                                INNER JOIN MovementDate AS MovementDate_ServiceDate
                                                        ON MovementDate_ServiceDate.ValueData = tmpMovement.ServiceDate
                                                       AND MovementDate_ServiceDate.DescId = zc_MIDate_ServiceDate()
                                                       AND MovementDate_ServiceDate.MovementId <> tmpMovement.MovementId
                                INNER JOIN Movement ON Movement.Id = MovementDate_ServiceDate.MovementId
                                                   AND Movement.StatusId = zc_Enum_Status_Complete()
                                INNER JOIN MovementLinkObject AS MovementLinkObject_PersonalServiceList
                                                              ON MovementLinkObject_PersonalServiceList.MovementId = MovementDate_ServiceDate.MovementId
                                                             AND MovementLinkObject_PersonalServiceList.DescId = zc_MovementLinkObject_PersonalServiceList()
                                                             AND MovementLinkObject_PersonalServiceList.ObjectId = tmpMovement.PersonalServiceListId
                           LIMIT 1
                          )
                         ;
     END IF;


     -- ������������� !!!���� ��� ��!!! - <����� �� �������� (��) ��� �������������> + <����� ������� - ��������� � ���������� ��� �������������> 
     IF EXISTS (SELECT ObjectLink_PersonalServiceList_PaidKind.ChildObjectId
                FROM MovementLinkObject AS MovementLinkObject_PersonalServiceList
                     INNER JOIN ObjectLink AS ObjectLink_PersonalServiceList_PaidKind
                                           ON ObjectLink_PersonalServiceList_PaidKind.ObjectId = MovementLinkObject_PersonalServiceList.ObjectId
                                          AND ObjectLink_PersonalServiceList_PaidKind.DescId = zc_ObjectLink_PersonalServiceList_PaidKind()
                                          AND ObjectLink_PersonalServiceList_PaidKind.ChildObjectId = zc_Enum_PaidKind_FirstForm()
                WHERE MovementLinkObject_PersonalServiceList.MovementId = inMovementId
                  AND MovementLinkObject_PersonalServiceList.DescId = zc_MovementLinkObject_PersonalServiceList()
               )
     THEN
          PERFORM lpComplete_Movement_PersonalService_Recalc (inMovementId := inMovementId
                                                            , inUserId     := inUserId);
     END IF;


     -- !!!�����������!!! �������� ������� ��������
     DELETE FROM _tmpMIContainer_insert;
     DELETE FROM _tmpMIReport_insert;
     -- !!!�����������!!! �������� ������� - �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     DELETE FROM _tmpItem;

     -- ��������� ������� - �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     INSERT INTO _tmpItem (MovementDescId, OperDate, ObjectId, ObjectDescId, OperSumm
                         , MovementItemId, ContainerId
                         , AccountGroupId, AccountDirectionId, AccountId
                         , ProfitLossGroupId, ProfitLossDirectionId
                         , InfoMoneyGroupId, InfoMoneyDestinationId, InfoMoneyId
                         , BusinessId_Balance, BusinessId_ProfitLoss, JuridicalId_Basis
                         , UnitId, PositionId, PersonalServiceListId, BranchId_Balance, BranchId_ProfitLoss, ServiceDateId, ContractId, PaidKindId
                         , AnalyzerId
                         , IsActive, IsMaster
                          )
        -- 1.1. ���� ���������� �� ��, ��� ������� � �����������
        SELECT Movement.DescId
             , Movement.OperDate
             , COALESCE (Object_ObjectTo.Id, COALESCE (MovementItem.ObjectId, 0)) AS ObjectId
             , COALESCE (Object_ObjectTo.DescId, COALESCE (Object.DescId, 0))     AS ObjectDescId
             , -1 * MovementItem.Amount AS OperSumm
             , MovementItem.Id AS MovementItemId

             , 0 AS ContainerId                                                     -- ���������� �����
             , 0 AS AccountGroupId, 0 AS AccountDirectionId, 0 AS AccountId         -- ���������� �����
             , 0 AS ProfitLossGroupId, 0 AS ProfitLossDirectionId                   -- �� ������������

               -- �������������� ������ ����������
             , COALESCE (View_InfoMoney.InfoMoneyGroupId, 0) AS InfoMoneyGroupId
               -- �������������� ����������
             , COALESCE (View_InfoMoney.InfoMoneyDestinationId, 0) AS InfoMoneyDestinationId
               -- �������������� ������ ����������
             , COALESCE (View_InfoMoney.InfoMoneyId, 0) AS InfoMoneyId

               -- ������ ������: �� ����� ����� ����� ���������
             , 0 AS BusinessId_Balance
               -- ������ ����: �� ������������
             , 0 AS BusinessId_ProfitLoss

               -- ������� ��.����: �� ����� ����� ����� ���������
             , zc_Juridical_Basis() AS JuridicalId_Basis

             , COALESCE (ObjectLink_PersonalTo_Unit.ChildObjectId, COALESCE (MILinkObject_Unit.ObjectId, 0))          AS UnitId
             , COALESCE (ObjectLink_PersonalTo_Position.ChildObjectId, COALESCE (MILinkObject_Position.ObjectId, 0))  AS PositionId
             , COALESCE (MovementLinkObject_PersonalServiceList.ObjectId, 0) AS PersonalServiceListId

               -- ������ ������: ������ �� ������������� !!!� ����� � �/����� - ������ ����������!!!
             , COALESCE (ObjectLink_Unit_Branch.ChildObjectId, zc_Branch_Basis()) AS BranchId_Balance
               -- ������ ����: �� ������������ !!!� ����� � �/����� - ������ ����������!!!
             , 0 AS BranchId_ProfitLoss

               -- ����� ���������� - ����
             , CASE WHEN View_InfoMoney.InfoMoneyGroupId = zc_Enum_InfoMoneyGroup_60000() -- ���������� �����
                         THEN lpInsertFind_Object_ServiceDate (inOperDate:= MovementDate_ServiceDate.ValueData)
                    ELSE 0
               END AS ServiceDateId

             , 0 AS ContractId -- �� ������������
             , 0 AS PaidKindId -- �� ������������

             , 0 AS AnalyzerId -- �� ����, �.�. ��� ������� ��

             -- , CASE WHEN -1 * MovementItem.Amount >= 0 THEN TRUE ELSE FALSE END AS IsActive
             , TRUE AS IsActive -- ������ �����
             , TRUE AS IsMaster
        FROM Movement
             INNER JOIN MovementItem ON MovementItem.MovementId = Movement.Id AND MovementItem.DescId = zc_MI_Master() AND MovementItem.isErased = FALSE

             LEFT JOIN MovementDate AS MovementDate_ServiceDate
                                    ON MovementDate_ServiceDate.MovementId = Movement.Id
                                   AND MovementDate_ServiceDate.DescId = zc_MIDate_ServiceDate()

             LEFT JOIN MovementItemLinkObject AS MILinkObject_Unit
                                              ON MILinkObject_Unit.MovementItemId = MovementItem.Id
                                             AND MILinkObject_Unit.DescId = zc_MILinkObject_Unit()
             LEFT JOIN MovementItemLinkObject AS MILinkObject_InfoMoney
                                              ON MILinkObject_InfoMoney.MovementItemId = MovementItem.Id
                                             AND MILinkObject_InfoMoney.DescId = zc_MILinkObject_InfoMoney()
             LEFT JOIN MovementItemLinkObject AS MILinkObject_Position
                                              ON MILinkObject_Position.MovementItemId = MovementItem.Id
                                             AND MILinkObject_Position.DescId = zc_MILinkObject_Position()

             LEFT JOIN MovementLinkObject AS MovementLinkObject_PersonalServiceList
                                          ON MovementLinkObject_PersonalServiceList.MovementId = Movement.Id
                                         AND MovementLinkObject_PersonalServiceList.DescId = zc_MovementLinkObject_PersonalServiceList()

             LEFT JOIN ObjectLink AS ObjectLink_Personal_Member ON ObjectLink_Personal_Member.ObjectId = MovementItem.ObjectId
                                                               AND ObjectLink_Personal_Member.DescId = zc_ObjectLink_Personal_Member()
             LEFT JOIN ObjectLink AS ObjectLink_Member_ObjectTo ON ObjectLink_Member_ObjectTo.ObjectId = ObjectLink_Personal_Member.ChildObjectId
                                                               AND ObjectLink_Member_ObjectTo.DescId = zc_ObjectLink_Member_ObjectTo()
             LEFT JOIN Object AS Object_ObjectTo ON Object_ObjectTo.Id     = ObjectLink_Member_ObjectTo.ChildObjectId
                                                AND Object_ObjectTo.DescId = zc_Object_Personal()
             LEFT JOIN ObjectLink AS ObjectLink_PersonalTo_Unit ON ObjectLink_PersonalTo_Unit.ObjectId = ObjectLink_Member_ObjectTo.ChildObjectId
                                                               AND ObjectLink_PersonalTo_Unit.DescId = zc_ObjectLink_Personal_Unit()
             LEFT JOIN ObjectLink AS ObjectLink_PersonalTo_Position ON ObjectLink_PersonalTo_Position.ObjectId = ObjectLink_Member_ObjectTo.ChildObjectId
                                                                   AND ObjectLink_PersonalTo_Position.DescId = zc_ObjectLink_Personal_Position()

             LEFT JOIN Object ON Object.Id = MovementItem.ObjectId
             LEFT JOIN ObjectLink AS ObjectLink_Unit_Branch ON ObjectLink_Unit_Branch.ObjectId = COALESCE (ObjectLink_PersonalTo_Unit.ChildObjectId, COALESCE (MILinkObject_Unit.ObjectId, 0))
                                                           AND ObjectLink_Unit_Branch.DescId   = zc_ObjectLink_Unit_Branch()
             LEFT JOIN Object_InfoMoney_View AS View_InfoMoney ON View_InfoMoney.InfoMoneyId = MILinkObject_InfoMoney.ObjectId
             LEFT JOIN MovementItemFloat AS MIF ON MIF.MovementItemId = MovementItem.Id AND MIF.DescId = zc_MIFloat_SummNalog()

        WHERE Movement.Id = inMovementId
          AND Movement.DescId = zc_Movement_PersonalService()
          AND Movement.StatusId IN (zc_Enum_Status_UnComplete(), zc_Enum_Status_Erased())
          AND (MovementItem.Amount <> 0 OR MIF.ValueData <> 0)
       ;


     -- ��������
     IF EXISTS (SELECT _tmpItem.ObjectId FROM _tmpItem WHERE _tmpItem.ObjectId = 0)
     THEN
         RAISE EXCEPTION '� ��������� �� ��������� <���������>. ���������� ����������.';
     END IF;
   
     -- ��������
     IF EXISTS (SELECT _tmpItem.JuridicalId_Basis FROM _tmpItem WHERE _tmpItem.JuridicalId_Basis = 0)
     THEN
         RAISE EXCEPTION '� �� ����������� <������� �� ����.> ���������� ����������.';
     END IF;


     -- ��������� ������� - �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     INSERT INTO _tmpItem (MovementDescId, OperDate, ObjectId, ObjectDescId, OperSumm
                         , MovementItemId, ContainerId
                         , AccountGroupId, AccountDirectionId, AccountId
                         , ProfitLossGroupId, ProfitLossDirectionId
                         , InfoMoneyGroupId, InfoMoneyDestinationId, InfoMoneyId
                         , BusinessId_Balance, BusinessId_ProfitLoss, JuridicalId_Basis
                         , UnitId, PositionId, PersonalServiceListId, BranchId_Balance, BranchId_ProfitLoss, ServiceDateId, ContractId, PaidKindId
                         , AnalyzerId
                         , IsActive, IsMaster
                          )
        -- 1.2.1. ���� �� ��
        SELECT _tmpItem.MovementDescId
             , _tmpItem.OperDate
             , 0 AS ObjectId
             , 0 AS ObjectDescId
             , -1 * _tmpItem.OperSumm
             , _tmpItem.MovementItemId

             , 0 AS ContainerId                                               -- ���������� �����
             , 0 AS AccountGroupId, 0 AS AccountDirectionId, 0 AS AccountId   -- ���������� �����

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

               -- ������ ������: �� ������������
             , 0 AS BusinessId_Balance
               -- ������ ����: ObjectLink_Unit_Business
             , COALESCE (ObjectLink_Unit_Business.ChildObjectId, 0) AS BusinessId_ProfitLoss

               -- ������� ��.����: �� ����� ����� ����� ���������
             , _tmpItem.JuridicalId_Basis

             , _tmpItem.UnitId            -- ������������, ��� ��������� WhereObjectId_Analyzer
             , 0 AS PositionId            -- �� ������������
             , 0 AS PersonalServiceListId -- �� ������������

               -- ������ ������: �� ������������
             , 0 AS BranchId_Balance
               -- ������ ����: ������ �� �������������
             , _tmpItem.BranchId_Balance AS BranchId_ProfitLoss

               -- ����� ����������: �� ������������
             , 0 AS ServiceDateId

             , 0 AS ContractId -- �� ������������
             , 0 AS PaidKindId -- �� ������������

             , 0 AS AnalyzerId -- �� ����, �.�. ��� ����
             , NOT _tmpItem.IsActive
             , NOT _tmpItem.IsMaster
        FROM _tmpItem
             LEFT JOIN ObjectLink AS ObjectLink_Unit_Business ON ObjectLink_Unit_Business.ObjectId = _tmpItem.UnitId
                                                             AND ObjectLink_Unit_Business.DescId = zc_ObjectLink_Unit_Business()
             LEFT JOIN ObjectLink AS ObjectLink_Unit_Contract ON ObjectLink_Unit_Contract.ObjectId = _tmpItem.UnitId
                                                             AND ObjectLink_Unit_Contract.DescId = zc_ObjectLink_Unit_Contract()
             LEFT JOIN lfSelect_Object_Unit_byProfitLossDirection() AS lfObject_Unit_byProfitLossDirection ON lfObject_Unit_byProfitLossDirection.UnitId = _tmpItem.UnitId

             LEFT JOIN ObjectLink AS ObjectLink_Personal_Member ON ObjectLink_Personal_Member.ObjectId = _tmpItem.ObjectId
                                                               AND ObjectLink_Personal_Member.DescId = zc_ObjectLink_Personal_Member()
             LEFT JOIN ObjectLink AS ObjectLink_Member_ObjectTo ON ObjectLink_Member_ObjectTo.ObjectId = ObjectLink_Personal_Member.ChildObjectId
                                                               AND ObjectLink_Member_ObjectTo.DescId = zc_ObjectLink_Member_ObjectTo()
             LEFT JOIN Object AS Object_ObjectTo ON Object_ObjectTo.Id     = ObjectLink_Member_ObjectTo.ChildObjectId
                                                AND Object_ObjectTo.DescId = zc_Object_Founder()

        WHERE ObjectLink_Unit_Contract.ChildObjectId IS NULL
          AND Object_ObjectTo.Id IS NULL
       UNION ALL
         -- 1.2.2. ��������������� ������ �� �� ����
        SELECT _tmpItem.MovementDescId
             , _tmpItem.OperDate
             , COALESCE (ObjectLink_Contract_Juridical.ChildObjectId, 0) AS ObjectId
             , COALESCE (Object.DescId, 0) AS ObjectDescId
             , -1 * _tmpItem.OperSumm
             , _tmpItem.MovementItemId

             , 0 AS ContainerId                                               -- ���������� �����
             , 0 AS AccountGroupId, 0 AS AccountDirectionId, 0 AS AccountId   -- ���������� �����

             , 0 AS ProfitLossGroupId, 0 AS ProfitLossDirectionId                   -- �� ������������

               -- �������������� ������ ����������
             , _tmpItem.InfoMoneyGroupId
               -- �������������� ����������
             , _tmpItem.InfoMoneyDestinationId
               -- �������������� ������ ����������
             , _tmpItem.InfoMoneyId

               -- ������ ������: �� ������������
             , 0 AS BusinessId_Balance
               -- ������ ����: �� ������������
             , 0 AS BusinessId_ProfitLoss

               -- ������� ��.���� ������ �� ��������
             , COALESCE (ObjectLink_Contract_JuridicalBasis.ChildObjectId, 0) AS JuridicalId_Basis

             , 0 AS UnitId                -- �� ������������
             , 0 AS PositionId            -- �� ������������
             , 0 AS PersonalServiceListId -- �� ������������

               -- ������ ������: ������ "������� ������" (����� ��� ��� ������)
             , zc_Branch_Basis() AS BranchId_Balance
               -- ������ ����: ����� �� ������������
             , 0 AS BranchId_ProfitLoss

               -- ����� ����������: �� ������������
             , 0 AS ServiceDateId

             , ObjectLink_Unit_Contract.ChildObjectId     AS ContractId
             , ObjectLink_Contract_PaidKind.ChildObjectId AS PaidKindId

             , 0 AS AnalyzerId -- �� ����, �.�. ��� ���������������
             , NOT _tmpItem.IsActive
             , NOT _tmpItem.IsMaster
        FROM _tmpItem
             INNER JOIN ObjectLink AS ObjectLink_Unit_Contract ON ObjectLink_Unit_Contract.ObjectId = _tmpItem.UnitId
                                                              AND ObjectLink_Unit_Contract.DescId = zc_ObjectLink_Unit_Contract()
             LEFT JOIN ObjectLink AS ObjectLink_Contract_Juridical ON ObjectLink_Contract_Juridical.ObjectId = ObjectLink_Unit_Contract.ChildObjectId
                                                                  AND ObjectLink_Contract_Juridical.DescId = zc_ObjectLink_Contract_Juridical()
             LEFT JOIN ObjectLink AS ObjectLink_Contract_PaidKind ON ObjectLink_Contract_PaidKind.ObjectId = ObjectLink_Unit_Contract.ChildObjectId
                                                                 AND ObjectLink_Contract_PaidKind.DescId = zc_ObjectLink_Contract_PaidKind()
             LEFT JOIN ObjectLink AS ObjectLink_Contract_JuridicalBasis ON ObjectLink_Contract_JuridicalBasis.ObjectId = ObjectLink_Unit_Contract.ChildObjectId
                                                                       AND ObjectLink_Contract_JuridicalBasis.DescId = zc_ObjectLink_Contract_JuridicalBasis()
             LEFT JOIN Object ON Object.Id = ObjectLink_Contract_Juridical.ChildObjectId

             LEFT JOIN ObjectLink AS ObjectLink_Personal_Member ON ObjectLink_Personal_Member.ObjectId = _tmpItem.ObjectId
                                                               AND ObjectLink_Personal_Member.DescId = zc_ObjectLink_Personal_Member()
             LEFT JOIN ObjectLink AS ObjectLink_Member_ObjectTo ON ObjectLink_Member_ObjectTo.ObjectId = ObjectLink_Personal_Member.ChildObjectId
                                                               AND ObjectLink_Member_ObjectTo.DescId = zc_ObjectLink_Member_ObjectTo()
             LEFT JOIN Object AS Object_ObjectTo ON Object_ObjectTo.Id     = ObjectLink_Member_ObjectTo.ChildObjectId
                                                AND Object_ObjectTo.DescId = zc_Object_Founder()

        WHERE ObjectLink_Unit_Contract.ChildObjectId > 0
          AND Object_ObjectTo.Id IS NULL

       UNION ALL
         -- 1.2.3. ��������������� ������ �� ����������
        SELECT _tmpItem.MovementDescId
             , _tmpItem.OperDate
             , Object_ObjectTo.Id     AS ObjectId
             , Object_ObjectTo.DescId AS ObjectDescId
             , -1 * _tmpItem.OperSumm
             , _tmpItem.MovementItemId

             , 0 AS ContainerId                                               -- ���������� �����
             , 0 AS AccountGroupId, 0 AS AccountDirectionId, 0 AS AccountId   -- ���������� �����

             , 0 AS ProfitLossGroupId, 0 AS ProfitLossDirectionId                   -- �� ������������

               -- �������������� ������ ���������� - �� ������������
             , 0 AS InfoMoneyGroupId
               -- �������������� ���������� - �� ������������
             , 0 AS InfoMoneyDestinationId
               -- �������������� ������ ���������� - �� ������������
             , 0 AS InfoMoneyId

               -- ������ ������: �� ������������
             , 0 AS BusinessId_Balance
               -- ������ ����: �� ������������
             , 0 AS BusinessId_ProfitLoss

               -- ������� ��.����
             , zc_Juridical_Basis() AS JuridicalId_Basis

             , 0 AS UnitId                -- �� ������������
             , 0 AS PositionId            -- �� ������������
             , 0 AS PersonalServiceListId -- �� ������������

               -- ������ ������: �� ������������
             , 0 AS BranchId_Balance
               -- ������ ����: �� ������������
             , 0 AS BranchId_ProfitLoss

               -- ����� ����������: �� ������������
             , 0 AS ServiceDateId

             , 0 AS ContractId
             , 0 AS PaidKindId

             , 0 AS AnalyzerId -- �� ����, �.�. ��� ���������������
             , NOT _tmpItem.IsActive
             , NOT _tmpItem.IsMaster

        FROM _tmpItem
             INNER JOIN ObjectLink AS ObjectLink_Personal_Member ON ObjectLink_Personal_Member.ObjectId = _tmpItem.ObjectId
                                                                AND ObjectLink_Personal_Member.DescId = zc_ObjectLink_Personal_Member()
             INNER JOIN ObjectLink AS ObjectLink_Member_ObjectTo ON ObjectLink_Member_ObjectTo.ObjectId = ObjectLink_Personal_Member.ChildObjectId
                                                                AND ObjectLink_Member_ObjectTo.DescId = zc_ObjectLink_Member_ObjectTo()
             INNER JOIN Object AS Object_ObjectTo ON Object_ObjectTo.Id     = ObjectLink_Member_ObjectTo.ChildObjectId
                                                 AND Object_ObjectTo.DescId = zc_Object_Founder()


       UNION ALL
        -- 1.3.1. ���� �� ������� - ��������� � �� (��� ����������) - !!!�����!!!
        SELECT _tmpItem.MovementDescId
             , _tmpItem.OperDate
             , 0 AS ObjectId
             , 0 AS ObjectDescId
             , -1 * MIF.ValueData AS OperSumm
             , _tmpItem.MovementItemId

             , 0 AS ContainerId                                               -- ���������� �����
             , 0 AS AccountGroupId, 0 AS AccountDirectionId, 0 AS AccountId   -- ���������� �����

               -- ������ ����
             , 0 AS ProfitLossGroupId     -- ���������� �����
               -- ��������� ���� - �����������
             , 0 AS ProfitLossDirectionId -- ���������� �����

               -- �������������� ������ ����������
             , View_InfoMoney.InfoMoneyGroupId
               -- �������������� ����������
             , View_InfoMoney.InfoMoneyDestinationId
               -- �������������� ������ ���������� - ��������� ������� �� �� - ����������
             , View_InfoMoney.InfoMoneyId

               -- ������ ������: �� ������������
             , 0 AS BusinessId_Balance
               -- ������ ����: ObjectLink_Unit_Business
             , COALESCE (ObjectLink_Unit_Business.ChildObjectId, 0) AS BusinessId_ProfitLoss

               -- ������� ��.����: �� ����� ����� ����� ���������
             , _tmpItem.JuridicalId_Basis

             , _tmpItem.UnitId            -- ������������, ��� ��������� WhereObjectId_Analyzer
             , 0 AS PositionId            -- �� ������������
             , 0 AS PersonalServiceListId -- �� ������������

               -- ������ ������: �� ������������
             , 0 AS BranchId_Balance
               -- ������ ����: ������ �� �������������
             , _tmpItem.BranchId_Balance AS BranchId_ProfitLoss

               -- ����� ����������: �� ������������
             , 0 AS ServiceDateId

             , 0 AS ContractId -- �� ������������
             , 0 AS PaidKindId -- �� ������������

             , 0 AS AnalyzerId -- �� ����, �.�. ��� ����

             , NOT _tmpItem.IsActive
             , NOT _tmpItem.IsMaster
        FROM _tmpItem
             INNER JOIN MovementItemFloat AS MIF ON MIF.MovementItemId = _tmpItem.MovementItemId AND MIF.DescId = zc_MIFloat_SummNalog()
             LEFT JOIN ObjectLink AS ObjectLink_Unit_Business ON ObjectLink_Unit_Business.ObjectId = _tmpItem.UnitId
                                                             AND ObjectLink_Unit_Business.DescId = zc_ObjectLink_Unit_Business()
             LEFT JOIN Object_InfoMoney_View AS View_InfoMoney ON View_InfoMoney.InfoMoneyId = zc_Enum_InfoMoney_50101() -- ��������� ������� �� �� - ����������
        WHERE MIF.ValueData <> 0

       UNION
        -- 1.3.2. ���� ���������� �� �� - ��������� � ��
        SELECT _tmpItem.MovementDescId
             , _tmpItem.OperDate
             , _tmpItem.ObjectId
             , _tmpItem.ObjectDescId
             , 1 * MIF.ValueData AS OperSumm
             , _tmpItem.MovementItemId

             , 0 AS ContainerId                                                     -- ���������� �����
             , 0 AS AccountGroupId, 0 AS AccountDirectionId, 0 AS AccountId         -- ���������� �����
             , 0 AS ProfitLossGroupId, 0 AS ProfitLossDirectionId                   -- �� ������������

               -- �������������� ������ ����������
             , _tmpItem.InfoMoneyGroupId
               -- �������������� ����������
             , _tmpItem.InfoMoneyDestinationId
               -- �������������� ������ ����������
             , _tmpItem.InfoMoneyId

               -- ������ ������: �� ����� ����� ����� ���������
             , 0 AS BusinessId_Balance
               -- ������ ����: �� ������������
             , 0 AS BusinessId_ProfitLoss

               -- ������� ��.����: �� ����� ����� ����� ���������
             , _tmpItem.JuridicalId_Basis

             , _tmpItem.UnitId
             , _tmpItem.PositionId
             , _tmpItem.PersonalServiceListId

               -- ������ ������: ������ �� ������������� !!!� ����� � �/����� - ������ ����������!!!
             , _tmpItem.BranchId_Balance
               -- ������ ����: �� ������������ !!!� ����� � �/����� - ������ ����������!!!
             , 0 AS BranchId_ProfitLoss

               -- ����� ����������: ����
             , _tmpItem.ServiceDateId

             , 0 AS ContractId -- �� ������������
             , 0 AS PaidKindId -- �� ������������

             , zc_Enum_AnalyzerId_PersonalService_Nalog() AS AnalyzerId -- ����, �.�. ��� ��������� � ��

             , _tmpItem.IsActive -- ������ �����
             , FALSE AS IsMaster
        FROM _tmpItem
             INNER JOIN MovementItemFloat AS MIF ON MIF.MovementItemId = _tmpItem.MovementItemId AND MIF.DescId = zc_MIFloat_SummNalog()

             LEFT JOIN ObjectLink AS ObjectLink_Personal_Member ON ObjectLink_Personal_Member.ObjectId = _tmpItem.ObjectId
                                                               AND ObjectLink_Personal_Member.DescId = zc_ObjectLink_Personal_Member()
             LEFT JOIN ObjectLink AS ObjectLink_Member_ObjectTo ON ObjectLink_Member_ObjectTo.ObjectId = ObjectLink_Personal_Member.ChildObjectId
                                                               AND ObjectLink_Member_ObjectTo.DescId = zc_ObjectLink_Member_ObjectTo()
             LEFT JOIN Object AS Object_ObjectTo ON Object_ObjectTo.Id     = ObjectLink_Member_ObjectTo.ChildObjectId
                                                AND Object_ObjectTo.DescId = zc_Object_Founder()
        WHERE MIF.ValueData <> 0
          AND Object_ObjectTo.Id IS NULL

       UNION ALL
         -- 1.3.3. ��������������� �� ������� �� ����������
        SELECT _tmpItem.MovementDescId
             , _tmpItem.OperDate
             , Object_ObjectTo.Id     AS ObjectId
             , Object_ObjectTo.DescId AS ObjectDescId
             , 1 * MIF.ValueData AS OperSumm
             , _tmpItem.MovementItemId

             , 0 AS ContainerId                                               -- ���������� �����
             , 0 AS AccountGroupId, 0 AS AccountDirectionId, 0 AS AccountId   -- ���������� �����

             , 0 AS ProfitLossGroupId, 0 AS ProfitLossDirectionId                   -- �� ������������

               -- �������������� ������ ���������� - �� ������������
             , 0 AS InfoMoneyGroupId
               -- �������������� ���������� - �� ������������
             , 0 AS InfoMoneyDestinationId
               -- �������������� ������ ���������� - �� ������������
             , 0 AS InfoMoneyId

               -- ������ ������: �� ������������
             , 0 AS BusinessId_Balance
               -- ������ ����: �� ������������
             , 0 AS BusinessId_ProfitLoss

               -- ������� ��.����
             , zc_Juridical_Basis() AS JuridicalId_Basis

             , 0 AS UnitId                -- �� ������������
             , 0 AS PositionId            -- �� ������������
             , 0 AS PersonalServiceListId -- �� ������������

               -- ������ ������: �� ������������
             , 0 AS BranchId_Balance
               -- ������ ����: �� ������������
             , 0 AS BranchId_ProfitLoss

               -- ����� ����������: �� ������������
             , 0 AS ServiceDateId

             , 0 AS ContractId
             , 0 AS PaidKindId

             , zc_Enum_AnalyzerId_PersonalService_Nalog() AS AnalyzerId -- ����, �.�. ��� ��������������� - ������
             , NOT _tmpItem.IsActive
             , NOT _tmpItem.IsMaster

        FROM _tmpItem
             INNER JOIN MovementItemFloat AS MIF ON MIF.MovementItemId = _tmpItem.MovementItemId AND MIF.DescId = zc_MIFloat_SummNalog()
             INNER JOIN ObjectLink AS ObjectLink_Personal_Member ON ObjectLink_Personal_Member.ObjectId = _tmpItem.ObjectId
                                                                AND ObjectLink_Personal_Member.DescId = zc_ObjectLink_Personal_Member()
             INNER JOIN ObjectLink AS ObjectLink_Member_ObjectTo ON ObjectLink_Member_ObjectTo.ObjectId = ObjectLink_Personal_Member.ChildObjectId
                                                                AND ObjectLink_Member_ObjectTo.DescId = zc_ObjectLink_Member_ObjectTo()
             INNER JOIN Object AS Object_ObjectTo ON Object_ObjectTo.Id     = ObjectLink_Member_ObjectTo.ChildObjectId
                                                 AND Object_ObjectTo.DescId = zc_Object_Founder()
        WHERE MIF.ValueData <> 0
       ;

/*
     -- ��������� ������� - �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     -- 2.1. ���� ���������� �� ���.����
     INSERT INTO _tmpItem (MovementDescId, OperDate, ObjectId, ObjectDescId, OperSumm
                         , MovementItemId, ContainerId
                         , AccountGroupId, AccountDirectionId, AccountId
                         , ProfitLossGroupId, ProfitLossDirectionId
                         , InfoMoneyGroupId, InfoMoneyDestinationId, InfoMoneyId
                         , BusinessId_Balance, BusinessId_ProfitLoss, JuridicalId_Basis
                         , UnitId, PositionId, BranchId_Balance, BranchId_ProfitLoss, ServiceDateId, ContractId, PaidKindId
                         , IsActive, IsMaster
                          )
        SELECT _tmpItem.MovementDescId
             , _tmpItem.OperDate
             , _tmpItem.ObjectId
             , _tmpItem.ObjectDescId
             , -1 * (COALESCE (MIFloat_SummSocialIn.ValueData, 0) + COALESCE (MIFloat_SummSocialAdd.ValueData, 0)) AS OperSumm
             , _tmpItem.MovementItemId

             , 0 AS ContainerId                                                     -- ���������� �����
             , 0 AS AccountGroupId, 0 AS AccountDirectionId, 0 AS AccountId         -- ���������� �����
             , 0 AS ProfitLossGroupId, 0 AS ProfitLossDirectionId                   -- �� ������������

               -- �������������� ������ ����������
             , View_InfoMoney.InfoMoneyGroupId
               -- �������������� ����������
             , View_InfoMoney.InfoMoneyDestinationId
               -- �������������� ������ ����������
             , View_InfoMoney.InfoMoneyId

               -- ������ ������: �� ����� ����� ����� ���������
             , 0 AS BusinessId_Balance
               -- ������ ����: �� ������������
             , 0 AS BusinessId_ProfitLoss

               -- ������� ��.����: �� ����� ����� ����� ���������
             , _tmpItem.JuridicalId_Basis

             , _tmpItem.UnitId
             , _tmpItem.PositionId

               -- ������ ������: ������ �� �������������
             , _tmpItem.BranchId_Balance
               -- ������ ����: �� ������������
             , 0 AS BranchId_ProfitLoss

               -- ����� ����������: ����
             , _tmpItem.ServiceDateId

             , 0 AS ContractId -- �� ������������
             , 0 AS PaidKindId -- �� ������������

             , FALSE AS IsActive
             , TRUE AS IsMaster
        FROM _tmpItem
              LEFT JOIN MovementItemFloat AS MIFloat_SummSocialIn
                                          ON MIFloat_SummSocialIn.MovementItemId = _tmpItem.MovementItemId
                                         AND MIFloat_SummSocialIn.DescId = zc_MIFloat_SummSocialIn()
              LEFT JOIN MovementItemFloat AS MIFloat_SummSocialAdd
                                          ON MIFloat_SummSocialAdd.MovementItemId = _tmpItem.MovementItemId
                                         AND MIFloat_SummSocialAdd.DescId = zc_MIFloat_SummSocialAdd()                                     
              LEFT JOIN Object_InfoMoney_View AS View_InfoMoney ON View_InfoMoney.InfoMoneyId = zc_Enum_InfoMoney_60103() -- ���������� ����� + ��������
       ;
*/

     -- 5.1. ����� - ���������/��������� ��������
     PERFORM lpComplete_Movement_Finance (inMovementId := inMovementId
                                        , inUserId     := inUserId);

     -- 5.2. ����� - ����������� ������ ������ ��������� + ��������� ��������
     PERFORM lpComplete_Movement (inMovementId := inMovementId
                                , inDescId     := zc_Movement_PersonalService()
                                , inUserId     := inUserId
                                 );
     -- 6.1. ����� - ����������� ����� � ������� (���� ���� "������" �������) - �� ���� "�����" <����� ������� - ��������� � ��>
     PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_SummToPay(), tmpMovement.MovementItemId, -1 * OperSumm
                                                                                                 + COALESCE (MIFloat_SummSocialAdd.ValueData, 0)
                                                                                                 - tmpMovement.SummTransport
                                                                                                 + tmpMovement.SummTransportAdd
                                                                                                 + tmpMovement.SummTransportAddLong
                                                                                                 + tmpMovement.SummTransportTaxi
                                                                                                 - tmpMovement.SummPhone
                                              )
             -- ����� ��� (��������� �� ��������, ���� ����� ���� � ��������...)
           , lpInsertUpdate_MovementItemFloat (zc_MIFloat_SummTransport()       , tmpMovement.MovementItemId, tmpMovement.SummTransport)
             -- ����� ��������������� (�������)
           , lpInsertUpdate_MovementItemFloat (zc_MIFloat_SummTransportAdd()    , tmpMovement.MovementItemId, tmpMovement.SummTransportAdd)
             -- ����� ������������ (�������, ���� ���������������)
           , lpInsertUpdate_MovementItemFloat (zc_MIFloat_SummTransportAddLong(), tmpMovement.MovementItemId, tmpMovement.SummTransportAddLong)
             -- ����� �� ����� (�������)
           , lpInsertUpdate_MovementItemFloat (zc_MIFloat_SummTransportTaxi()   , tmpMovement.MovementItemId, tmpMovement.SummTransportTaxi)
             -- ����� ���.����� (���������)
           , lpInsertUpdate_MovementItemFloat (zc_MIFloat_SummPhone()           , tmpMovement.MovementItemId, tmpMovement.SummPhone)
     FROM (SELECT _tmpItem.MovementItemId
                , _tmpItem.OperSumm
                , COALESCE (SUM (CASE WHEN MIContainer.MovementDescId = zc_Movement_Income() THEN MIContainer.Amount ELSE 0 END), 0) AS SummTransport
                , COALESCE (SUM (CASE WHEN MIContainer.AnalyzerId = zc_Enum_AnalyzerId_Transport_Add()     THEN -1 * MIContainer.Amount ELSE 0 END), 0) AS SummTransportAdd
                , COALESCE (SUM (CASE WHEN MIContainer.AnalyzerId = zc_Enum_AnalyzerId_Transport_AddLong() THEN -1 * MIContainer.Amount ELSE 0 END), 0) AS SummTransportAddLong
                , COALESCE (SUM (CASE WHEN MIContainer.AnalyzerId = zc_Enum_AnalyzerId_Transport_Taxi()    THEN -1 * MIContainer.Amount ELSE 0 END), 0) AS SummTransportTaxi
                , 0 AS SummPhone
           FROM _tmpItem
                LEFT JOIN MovementItemContainer AS MIContainer ON MIContainer.ContainerId    = _tmpItem.ContainerId
                                                              -- AND MIContainer.MovementDescId = zc_Movement_Income()
           WHERE _tmpItem.IsMaster = TRUE
           GROUP BY _tmpItem.MovementItemId
                  , _tmpItem.OperSumm
          ) AS tmpMovement
          LEFT JOIN MovementItemFloat AS MIFloat_SummSocialAdd
                                      ON MIFloat_SummSocialAdd.MovementItemId = tmpMovement.MovementItemId
                                     AND MIFloat_SummSocialAdd.DescId = zc_MIFloat_SummSocialAdd()                                     
    ;
     -- 6.2. ����� - ����������� �������� �����
     PERFORM lpInsertUpdate_MovementFloat_TotalSumm (inMovementId);


END;$BODY$
  LANGUAGE plpgsql VOLATILE;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 09.09.14                                        *
*/

-- ����
-- SELECT * FROM lpUnComplete_Movement (inMovementId:= 3581, inUserId:= zfCalc_UserAdmin() :: Integer)
-- SELECT * FROM gpComplete_Movement_PersonalService (inMovementId:= 3581, inSession:= zfCalc_UserAdmin())
-- SELECT * FROM gpSelect_MovementItemContainer_Movement (inMovementId:= 3581, inSession:= zfCalc_UserAdmin())