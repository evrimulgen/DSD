-- Function: gpUpdateMovement_EdiOrdspr 


DROP FUNCTION IF EXISTS gpUpdateMovement_Edi (Integer, Boolean, TVarChar, TVarChar);
DROP FUNCTION IF EXISTS gpUpdateMovement_Edi (Integer, TVarChar, TVarChar);

CREATE OR REPLACE FUNCTION gpUpdateMovement_Edi (
    IN ioId                  Integer   , -- Ключ объекта <Документ>
   OUT inValue               Boolean   , -- Проверен
    IN inDesc                TVarChar  , -- 
    IN inSession             TVarChar    -- сессия пользователя
)
RETURNS Boolean 
AS
$BODY$
    DECLARE vbUserId Integer;
BEGIN
     -- проверка
     -- проверка прав пользователя на вызов процедуры
     vbUserId := lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_Movement_Sale());

     -- определили признак
     inValue:= True;
     
     -- сохранили свойство
     PERFORM lpInsertUpdate_MovementBoolean (tmpDesc.Id, ioId, inValue)
           FROM MovementBooleanDesc AS tmpDesc
           WHERE ItemName = inDesc;
   
  -- сохранили протокол
     PERFORM lpInsert_MovementProtocol (ioId, vbUserId, FALSE);
  
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ИСТОРИЯ РАЗРАБОТКИ: ДАТА, АВТОР
               Фелонюк И.В.   Кухтин И.В.   Климентьев К.И.   Манько Д.
 06.02.15         * 
*/


-- тест
-- SELECT * FROM gpUpdateMovement_Edi (ioId:=  83674 , inValue:= false , inDesc := 'Счет', inSession:= '5')
