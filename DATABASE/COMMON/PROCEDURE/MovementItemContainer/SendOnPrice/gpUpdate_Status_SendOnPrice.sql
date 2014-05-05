-- Function: gpUpdate_Status_SendOnPrice()

DROP FUNCTION IF EXISTS gpUpdate_Status_SendOnPrice (Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpUpdate_Status_SendOnPrice(
    IN inMovementId          Integer   , -- ���� ������� <��������>
    IN inStatusCode          Integer   , -- ������ ���������. ������������ ������� ������ ����
    IN inSession             TVarChar    -- ������ ������������
)
RETURNS VOID AS
$BODY$
BEGIN
     CASE inStatusCode
         WHEN zc_Enum_StatusCode_UnComplete() THEN
            PERFORM gpUnComplete_Movement_SendOnPrice (inMovementId, inSession);
         WHEN zc_Enum_StatusCode_Complete() THEN
            PERFORM gpComplete_Movement_SendOnPrice (inMovementId, FALSE,inSession);
         WHEN zc_Enum_StatusCode_Erased() THEN
            PERFORM gpSetErased_Movement_SendOnPrice (inMovementId, inSession);
         ELSE
            RAISE EXCEPTION '��� ������� � ����� <%>', inStatusCode;
     END CASE;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 05.05.14                                                       *
 29.10.13                                        *
 06.10.13                                        *
*/

-- ����
-- SELECT * FROM gpUpdate_Status_SendOnPrice (ioId:= 0, inSession:= zfCalc_UserAdmin())