﻿-- Function: gpInsertUpdate_Object_Form()

-- DROP FUNCTION gpInsertUpdate_Object_Form();

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_Form(
IN inFormName    TVarChar  ,    /* главное Название объекта <Форма> */
IN inFormData    TBLOB     ,    /* Данные формы */
IN inSession     TVarChar       /* текущий пользователь */
)
  RETURNS integer AS
$BODY$
DECLARE 
  Id integer;
BEGIN
--   PERFORM lpCheckRight(inSession, zc_Enum_Process_Forms());
   
   SELECT Object.Id INTO Id 
   FROM Object 
   WHERE DescId = zc_Object_Form() AND ValueData = inFormName;

   PERFORM lpCheckUnique_Object_ValueData(Id, zc_Object_Form(), inFormName);

   Id := lpInsertUpdate_Object(Id, zc_Object_Form(), 0, inFormName);

   PERFORM lpInsertUpdate_ObjectBLOB(zc_Object_Form_Data(), Id, inFormData);
   
   RETURN 0;
 
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
  
                            