﻿-- Function: gpGet_Object_Unit()

DROP FUNCTION IF EXISTS gpGet_Object_Unit (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpGet_Object_Unit(
    IN inId          Integer,       -- Подразделения
    IN inSession     TVarChar       -- сессия пользователя
)
RETURNS TABLE (Id Integer, Code Integer, Name TVarChar,  JuridicalId Integer, JuridicalName TVarChar) 
AS
$BODY$
BEGIN

  -- проверка прав пользователя на вызов процедуры
  -- PERFORM lpCheckRight(inSession, zc_Enum_Process_Unit());

  IF COALESCE (inId, 0) = 0
   THEN
       RETURN QUERY
       SELECT
             CAST (0 as Integer)                 AS Id
           , COALESCE(MAX (Object.ObjectCode), 0) + 1 AS Code
           , CAST ('' as TVarChar)               AS Name
           , CAST (0 as Integer)                 AS JuridicalId
           , CAST ('' as TVarChar)               AS JuridicalName
       FROM Object
       WHERE Object.DescId = zc_Object_Unit();
   ELSE
       RETURN QUERY
       SELECT 
             Object_Unit.Id                  AS Id
           , Object_Unit.ObjectCode          AS Code
           , Object_Unit.ValueData           AS Name
           , Object_Juridical.Id             AS JuridicalId
           , Object_Juridical.ValueData      AS JuridicalName      
       FROM Object AS Object_Unit
            LEFT JOIN ObjectLink AS ObjectLink_Unit_Juridical
                                 ON ObjectLink_Unit_Juridical.ObjectId = Object_Unit.Id
                                AND ObjectLink_Unit_Juridical.DescId = zc_ObjectLink_Unit_Juridical()
            LEFT JOIN Object AS Object_Juridical ON Object_Juridical.Id = ObjectLink_Unit_Juridical.ChildObjectId

      WHERE Object_Unit.Id = inId;

   END IF;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;


/*-------------------------------------------------------------------------------*/
/*
 ИСТОРИЯ РАЗРАБОТКИ: ДАТА, АВТОР
               Фелонюк И.В.   Кухтин И.В.   Климентьев К.И.   Полятыкин А.А.
28.02.17                                                          *
 
*/

-- тест
-- SELECT * FROM gpSelect_Unit(1,'2')
