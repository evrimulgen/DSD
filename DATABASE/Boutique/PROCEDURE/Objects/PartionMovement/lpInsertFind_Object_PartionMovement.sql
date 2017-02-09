-- Function: lpInsertFind_Object_PartionMovement (Integer, TDateTime)

DROP FUNCTION IF EXISTS lpInsertFind_Object_PartionMovement (Integer, TDateTime);

CREATE OR REPLACE FUNCTION lpInsertFind_Object_PartionMovement(
    IN inMovementId   Integer,   -- ������ �� ��������
    IN inPaymentDate  TDateTime  -- ������ �� ��������
)
RETURNS Integer
AS
$BODY$
   DECLARE vbPartionMovementId Integer;
BEGIN
   
   -- 
   IF COALESCE (inMovementId, 0) = 0
   THEN vbPartionMovementId:= 0; -- !!!����� ��� ������, � ������� � ������ ������� �� ���������!!!
   ELSE
       -- ������� 
       vbPartionMovementId:= (SELECT ObjectId FROM ObjectFloat WHERE ValueData = inMovementId AND DescId = zc_ObjectFloat_PartionMovement_MovementId());

       IF COALESCE (vbPartionMovementId, 0) = 0
       THEN
           -- ��������� <������>
           vbPartionMovementId:= (SELECT lpInsertUpdate_Object (vbPartionMovementId, zc_Object_PartionMovement(), 0, zfCalc_PartionMovementName (Movement.DescId, MovementDesc.ItemName, Movement.InvNumber, COALESCE (MovementDate_OperDatePartner.ValueData, Movement.OperDate)))
                                  FROM Movement
                                       LEFT JOIN MovementDesc ON MovementDesc.Id = Movement.DescId
                                       LEFT JOIN MovementDate AS MovementDate_OperDatePartner
                                                              ON MovementDate_OperDatePartner.MovementId =  Movement.Id
                                                             AND MovementDate_OperDatePartner.DescId = zc_MovementDate_OperDatePartner()
                                  WHERE Movement.Id = inMovementId
                                 );
           -- ���������
           PERFORM lpInsertUpdate_ObjectFloat (zc_ObjectFloat_PartionMovement_MovementId(), vbPartionMovementId, inMovementId :: TFloat);

           -- ��������
           IF inPaymentDate IS NULL
           THEN 
               RAISE EXCEPTION '������.������ ��������� � <%> �� <%> �� �������.', DATE ((SELECT Movement.InvNumber FROM Movement WHERE Movement.Id = inMovementId), (SELECT MovementDate.ValueData FROM MovementDate WHERE  MovementDate.MovementId = inMovementId AND MovementDate.DescId = zc_MovementDate_OperDatePartner()));
           END IF;

       END IF;

       -- ��������� !!!����� ������!!!
       IF inPaymentDate IS NOT NULL
       THEN PERFORM lpInsertUpdate_ObjectDate (zc_ObjectDate_PartionMovement_Payment(), vbPartionMovementId, inPaymentDate);
       END IF;

   END IF;

   -- ���������� ��������
   RETURN (vbPartionMovementId);

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION lpInsertFind_Object_PartionMovement (Integer, TDateTime) OWNER TO postgres;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 30.04.15                                        * add 
 26.04.15                                        * all
 13.02.14                                        * !!!����� ��� ������!!! �� �� �������
 27.09.13                                        * !!!����� ��� ������!!!
 02.07.13                                        * ������� Find, ����� ���� ���� Insert
 02.07.13          *
*/

-- ����
-- SELECT * FROM lpInsertFind_Object_PartionMovement (inMovementId:= 123, inPaymentDate:= NULL)