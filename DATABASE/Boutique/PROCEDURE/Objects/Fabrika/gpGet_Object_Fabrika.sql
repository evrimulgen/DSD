﻿-- Фабрика производитель

DROP FUNCTION IF EXISTS gpGet_Object_Fabrika (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpGet_Object_Fabrika(
    IN inId          Integer,       -- Ключь <Фабрика производитель>
    IN inSession     TVarChar       -- сессия пользователя
)
RETURNS TABLE (Id Integer, Code Integer, Name TVarChar) 
AS
$BODY$
BEGIN

  -- проверка прав пользователя на вызов процедуры
  -- PERFORM lpCheckRight(inSession, zc_Enum_Process_Fabrika());

  IF COALESCE (inId, 0) = 0
   THEN
       RETURN QUERY
       SELECT
             0 :: Integer      AS Id
           , lfGet_ObjectCode(0, zc_Object_Fabrika())   AS Code
           ,'' :: TVarChar     AS Name
       ;
   ELSE
       RETURN QUERY
       SELECT
             Object.Id         AS Id
           , Object.ObjectCode AS Code
           , Object.ValueData  AS Name
       FROM Object
       WHERE Object.Id = inId;
   END IF;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;


/*-------------------------------------------------------------------------------*/
/*
 ИСТОРИЯ РАЗРАБОТКИ: ДАТА, АВТОР
               Фелонюк И.В.   Кухтин И.В.   Климентьев К.И.   Полятыкин А.А.
08.05.17                                                          *
06.03.17                                                          *
19.02.17                                                          *
*/

-- тест
-- SELECT * FROM gpSelect_Fabrika (1,'2')
