-- Function: gpInsertUpdate_MI_EDI()

DROP FUNCTION IF EXISTS gpInsert_Protocol_EDIReceipt(Boolean, TVarChar, TVarChar, TDateTime, TVarChar);

CREATE OR REPLACE FUNCTION gpInsert_Protocol_EDIReceipt(
    IN inisOk                Boolean   ,
    IN inTaxNumber           TVarChar  , 
    IN inEDIEvent            TVarChar  , -- �������� �������
    IN inOperMonth           TDateTime , 
    IN inSession             TVarChar     -- ������������
)                              
RETURNS VOID AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbMovementId Integer;
   DECLARE vbTaxMovementId Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_Movement_EDI());
   vbUserId := lpGetUserBySession(inSession);

   -- ������ ����� �������� EDI �� ������ ��������� � ����
    SELECT Movement.Id, Movement_Tax.Id INTO vbMovementId, vbTaxMovementId
      FROM Movement
            JOIN MovementLinkMovement AS MovementLinkMovement_Tax
                                      ON MovementLinkMovement_Tax.MovementChildId = Movement.Id 
                                     AND MovementLinkMovement_Tax.DescId = zc_MovementLinkMovement_Tax()
            JOIN Movement AS Movement_Tax ON Movement_Tax.Id = MovementLinkMovement_Tax.MovementId
                                         AND Movement_Tax.StatusId = zc_Enum_Status_Complete()
            JOIN MovementString AS MovementString_InvNumberPartner_Tax
                                ON MovementString_InvNumberPartner_Tax.MovementId =  Movement_Tax.Id
                               AND MovementString_InvNumberPartner_Tax.DescId = zc_MovementString_InvNumberPartner()

     WHERE Movement.DescId = zc_movement_EDI() 
       AND Movement_Tax.OperDate BETWEEN inOperMonth AND (inOperMonth + (interval '1 MONTH'))
       AND MovementString_InvNumberPartner_Tax.valuedata = inTaxNumber;

   IF COALESCE(vbMovementId, 0) <> 0 THEN 
      PERFORM lpInsert_Movement_EDIEvents(vbMovementId, inEDIEvent, vbUserId);
      PERFORM lpInsertUpdate_MovementBoolean(zc_MovementBoolean_Electron(), vbMovementId, inisOk);
      PERFORM lpInsertUpdate_MovementBoolean(zc_MovementBoolean_Electron(), vbTaxMovementId, inisOk);
   END IF;

END;
$BODY$
LANGUAGE PLPGSQL VOLATILE;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 04.08.14                         * 

*/

-- ����
-- SELECT * FROM gpInsertUpdate_MI_EDI (ioId:= 0, inMovementId:= 10, inGoodsId:= 1, inAmount:= 0, inAmountSecond:= 0, inGoodsKindId:= 0, inSession:= '2')