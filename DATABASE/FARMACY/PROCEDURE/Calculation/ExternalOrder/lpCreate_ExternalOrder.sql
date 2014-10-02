-- Function: gpSelect_Movement_Income()

DROP FUNCTION IF EXISTS lpCreate_ExternalOrder(Integer, Integer, Integer, Integer, Integer, TFloat, TFloat, Integer);

CREATE OR REPLACE FUNCTION lpCreate_ExternalOrder(
    IN inInternalOrder     Integer ,
    IN inJuridicalId       Integer ,
    IN inUnitId            Integer ,
    IN inMainGoodsId       Integer ,
    IN inGoodsId           Integer ,
    IN inAmount            TFloat  , 
    IN inPrice             TFloat  , 
    IN inUserId            Integer     -- ������ ������������
)
RETURNS VOID
AS
$BODY$
   DECLARE vbMovementId Integer;
   DECLARE vbMovementItemId Integer;
BEGIN

   -- ���� ��������� �����
   SELECT  Movement.Id INTO vbMovementId
     FROM  Movement 
     
                 JOIN MovementLinkMovement 
                   ON MovementLinkMovement.MovementId = Movement.Id
                  AND MovementLinkMovement.DescId = zc_MovementLinkMovement_Master()
                  AND ((MovementLinkMovement.MovementChildId = inInternalOrder AND inInternalOrder <> 0) OR 
                       (MovementLinkMovement.MovementChildId IS NULL AND inInternalOrder = 0))

                 JOIN MovementLinkObject 
                   ON MovementLinkObject.MovementId = Movement.Id
                  AND MovementLinkObject.DescId = zc_MovementLinkObject_From()
                  AND ((MovementLinkObject.ObjectId = inJuridicalId AND COALESCE(inJuridicalId, 0) <> 0) OR 
                       (MovementLinkObject.ObjectId IS NULL AND COALESCE(inJuridicalId, 0) = 0))

    WHERE  Movement.DescId = zc_Movement_OrderExternal() AND Movement.OperDate = CURRENT_DATE;
   
    IF COALESCE(vbMovementId, 0) = 0 THEN
       vbMovementId := lpInsertUpdate_Movement_OrderExternal(
                     ioId := 0  , -- ���� ������� <�������� �����������>
              inInvNumber := '' , -- ����� ���������
               inOperDate := CURRENT_DATE , -- ���� ���������
                 inFromId := inJuridicalId , -- �� ���� (� ���������)
                   inToId := inUnitId , -- ����
        inInternalOrderId := inInternalOrder, -- ������ �� ���������� �����
                 inUserId := inUserId);
    END IF;
 
    SELECT MovementItem.id INTO vbMovementItemId
      FROM MovementItem
      
           JOIN MovementItemLinkObject AS MILinkObject_Goods
                                       ON MILinkObject_Goods.MovementItemId = MovementItem.Id
                                      AND MILinkObject_Goods.DescId = zc_MILinkObject_Goods()
                                      AND ((MILinkObject_Goods.ObjectId = inGoodsId AND COALESCE(inGoodsId, 0) <> 0) OR (MILinkObject_Goods.ObjectId IS NULL AND COALESCE(inGoodsId, 0) = 0))
     WHERE MovementItem.movementid = vbMovementId AND MovementItem.objectid = inMainGoodsId;
    
    PERFORM lpInsertUpdate_MovementItem_OrderExternal(vbMovementItemId, vbMovementId, inMainGoodsId, inGoodsId
                                                    , inAmount, inPrice, inAmount * inPrice, inUserId);


END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION lpCreate_ExternalOrder(Integer, Integer, Integer, Integer, Integer, TFloat, TFloat, Integer) OWNER TO postgres;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 19.09.14                         *

*/

-- ����
-- SELECT * FROM gpSelect_Movement_Income (inStartDate:= '30.01.2014', inEndDate:= '01.02.2014', inIsErased := FALSE, inSession:= '2')