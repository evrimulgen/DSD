﻿-- Function: gpSelect_Object_Branch(TVarChar)

--DROP FUNCTION gpSelect_Object_Branch(TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Object_Branch(
    IN inSession     TVarChar       -- сессия пользователя
)
RETURNS TABLE (Id Integer, Code Integer, Name TVarChar, isErased boolean) AS
$BODY$BEGIN

   -- проверка прав пользователя на вызов процедуры
   --PERFORM lpCheckRight(inSession, zc_Enum_Process_User());

     RETURN QUERY 
     SELECT 
       Object.Id           AS Id
     , Object.ObjectCode   AS Code
     , Object.ValueData    AS Name
     , Object.isErased     AS isErased
     FROM Object
    WHERE Object.DescId = zc_Object_Branch();
  
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 100;
ALTER FUNCTION gpSelect_Object_Branch(TVarChar)
  OWNER TO postgres;


/*-------------------------------------------------------------------------------*/
/*
 ИСТОРИЯ РАЗРАБОТКИ: ДАТА, АВТОР
               Фелонюк И.В.   Кухтин И.В.   Климентьев К.И.
 10.05.13          *
 05.06.13          

*/

-- тест
-- SELECT * FROM gpSelect_Object_Branch('2')