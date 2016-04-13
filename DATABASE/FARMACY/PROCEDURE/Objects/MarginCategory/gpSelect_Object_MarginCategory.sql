--Function: gpSelect_Object_MarginCategory(TVarChar)

DROP FUNCTION IF EXISTS gpSelect_Object_MarginCategory(TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Object_MarginCategory(
    IN inSession     TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, Code Integer, Name TVarChar
             , Percent TFloat
             , isErased boolean) AS
$BODY$BEGIN

   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight(inSession, zc_Enum_Process_MarginCategory());

   RETURN QUERY 
   SELECT Object_MarginCategory.Id         AS Id 
        , Object_MarginCategory.ObjectCode AS Code
        , Object_MarginCategory.ValueData  AS Name
        , ObjectFloat_Percent.ValueData    AS Percent
        , Object_MarginCategory.isErased   AS isErased
   FROM Object AS Object_MarginCategory
        LEFT JOIN ObjectFloat AS ObjectFloat_Percent 	
                              ON ObjectFloat_Percent.ObjectId = Object_MarginCategory.Id
                             AND ObjectFloat_Percent.DescId = zc_ObjectFloat_MarginCategory_Percent()  
   WHERE Object_MarginCategory.DescId = zc_Object_MarginCategory();
  
END;$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpSelect_Object_MarginCategory(TVarChar)
  OWNER TO postgres;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 05.04.16         *
 09.04.15                         *

*/

-- ����
-- SELECT * FROM gpSelect_Object_MarginCategory('2')