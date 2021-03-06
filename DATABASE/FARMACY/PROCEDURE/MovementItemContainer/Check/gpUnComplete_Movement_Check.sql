-- Function: gpUnComplete_Movement_Income (Integer, TVarChar, TVarChar)

-- DROP FUNCTION IF EXISTS gpUnComplete_Movement_Check (Integer, TVarChar);
DROP FUNCTION IF EXISTS gpUnComplete_Movement_Check (Integer, TVarChar, TVarChar);

CREATE OR REPLACE FUNCTION gpUnComplete_Movement_Check(
    IN inMovementId        Integer               , -- ���� ���������
    IN inUsersession	   TVarChar              , -- ������ ������������ (��������� ��������)
--    IN inSession         TVarChar DEFAULT ''     -- ������ ������������
    IN inSession           TVarChar                -- ������ ������������
)
RETURNS VOID
AS
$BODY$
  DECLARE vbUserId Integer;
  DECLARE vbOperDate    TDateTime;
  DECLARE vbUnit        Integer;
BEGIN
    if coalesce(inUserSession, '') <> '' then 
     inSession := inUserSession;
    end if;
    -- �������� ���� ������������ �� ����� ���������
    IF (SELECT Movement.StatusId FROM Movement WHERE Movement.Id = inMovementId) = zc_Enum_Status_Complete()
    THEN
        vbUserId:= lpCheckRight(inSession, zc_Enum_Process_UnComplete_Income());
    ELSE
        vbUserId:=inSession::Integer;
    END IF;
     -- �������� - ���� <Master> ������, �� <������>
     PERFORM lfCheck_Movement_ParentStatus (inMovementId:= inMovementId, inNewStatusId:= zc_Enum_Status_UnComplete(), inComment:= '�����������');
    -- ���������, ��� �� �� ���� ��������� ����� ���� ���������
    SELECT
        date_trunc('day', Movement.OperDate),
        Movement_Unit.ObjectId AS Unit
    INTO
        vbOperDate,
        vbUnit
    FROM Movement
        INNER JOIN MovementLinkObject AS Movement_Unit
                                      ON Movement_Unit.MovementId = Movement.Id
                                     AND Movement_Unit.DescId = zc_MovementLinkObject_Unit()
    WHERE Movement.Id = inMovementId;

/*    IF EXISTS(SELECT 1
              FROM Movement AS Movement_Inventory
                  INNER JOIN MovementItem AS MI_Inventory
                                          ON MI_Inventory.MovementId = Movement_Inventory.Id
                                         AND MI_Inventory.DescId = zc_MI_Master()
                                         AND MI_Inventory.IsErased = FALSE
                  INNER JOIN MovementLinkObject AS Movement_Inventory_Unit
                                                ON Movement_Inventory_Unit.MovementId = Movement_Inventory.Id
                                               AND Movement_Inventory_Unit.DescId = zc_MovementLinkObject_Unit()
                                               AND Movement_Inventory_Unit.ObjectId = vbUnit
                  Inner Join MovementItem AS MI_Send
                                          ON MI_Inventory.ObjectId = MI_Send.ObjectId
                                         AND MI_Send.DescId = zc_MI_Master()
                                         AND MI_Send.IsErased = FALSE
                                         AND MI_Send.Amount > 0
                                         AND MI_Send.MovementId = inMovementId
                                         
              WHERE
                  Movement_Inventory.DescId = zc_Movement_Inventory()
                  AND
                  Movement_Inventory.OperDate >= vbOperDate
                  AND
                  Movement_Inventory.StatusId = zc_Enum_Status_Complete()
              )
    THEN
        RAISE EXCEPTION '������. �� ������ ��� ����� ������� ���� �������� ��������� ����� ���� ������� �������. ������ ���������� ��������� ���������!';
    END IF;*/
     -- ����������� ��������
     PERFORM lpUnComplete_Movement (inMovementId := inMovementId
                                  , inUserId     := vbUserId);

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 03.07.14                                                       *
*/

-- ����
-- SELECT * FROM gpUnComplete_Movement_Check (inMovementId:= 149639, inSession:= zfCalc_UserAdmin())
