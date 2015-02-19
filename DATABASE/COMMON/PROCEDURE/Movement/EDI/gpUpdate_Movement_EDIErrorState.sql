-- Function: gpUpdate_Movement_EDI_Params()

DROP FUNCTION IF EXISTS gpUpdate_Movement_EDIErrorState (Integer, TVarChar, TDateTime, TVarChar, Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpUpdate_Movement_EDIErrorState(
    IN inMovementId          Integer   , -- ���� ������� <��������>
    IN inDocType             TVarChar  , -- ��� ���������
    IN inOperDate            TDateTime , 
    IN inInvNumber           TVarChar  , 
    IN inIsError             Boolean   , -- 
   OUT IsFind                Boolean   ,
    IN inSession             TVarChar     -- ������������
)                              
RETURNS Boolean AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId:= lpCheckRight (inSession, zc_Enum_Process_Update_Movement_EDI_Params());
   vbUserId:= lpGetUserBySession(inSession);

   IsFind := false;

   IF COALESCE(inMovementId, 0) = 0 THEN
      SELECT Movement.Id INTO inMovementId 
        FROM Movement 
       WHERE Movement.DescId = zc_Movement_EDI()
         AND Movement.OperDate = inOperDate AND Movement.InvNumber = inInvNumber;
   END IF;

   IF COALESCE(inMovementId, 0) <> 0 THEN
      PERFORM lpInsertUpdate_MovementBoolean (zc_MovementBoolean_Error(), inMovementId, inIsError);
      IsFind := true;
   END IF;
    
END;
$BODY$
LANGUAGE PLPGSQL VOLATILE;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 16.02.15                        * 
*/

-- ����
-- SELECT * FROM gpUpdate_Movement_EDI_Params (ioId:= 0, inMovementId:= 10, inGoodsId:= 1, inAmount:= 0, inAmountSecond:= 0, inGoodsKindId:= 0, inSession:= '2')