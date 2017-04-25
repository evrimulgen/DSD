-- Function: lpUnComplete_Movement_OrderExternal (Integer, Integer)

DROP FUNCTION IF EXISTS lpUnComplete_Movement_OrderExternal (Integer, Integer);

CREATE OR REPLACE FUNCTION lpUnComplete_Movement_OrderExternal(
    IN inMovementId        Integer               , -- ���� ���������
   OUT outPrinted          Boolean               ,
    IN inUserId            Integer     -- ������������

)
RETURNS Boolean
AS
$BODY$
BEGIN
     --
     outPrinted := gpUpdate_Movement_OrderExternal_Print (inId := inMovementId, inNewPrinted := FALSE, inSession := inUserId :: TVarChar);

     -- �������� - ���� <Master> ������, �� <������>
     PERFORM lfCheck_Movement_ParentStatus (inMovementId:= inMovementId, inNewStatusId:= zc_Enum_Status_UnComplete(), inComment:= '�����������');

     -- !!!���������� �������� � ��������� ���������!!!
     PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_Summ(), MovementItem.Id, 0)
     FROM MovementItem
     WHERE MovementItem.MovementId = inMovementId;

     -- ����������� ��������
     PERFORM lpUnComplete_Movement (inMovementId := inMovementId
                                  , inUserId     := inUserId);

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 21.04.17                                        *
*/

-- ����
-- SELECT * FROM lpUnComplete_Movement_OrderExternal (inMovementId:= 149639, inSession:= zfCalc_UserAdmin())