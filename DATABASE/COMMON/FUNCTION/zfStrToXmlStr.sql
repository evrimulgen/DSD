-- Function: zfConvert_StringToNumber

-- DROP FUNCTION IF EXISTS zfConvert_StringToNumber (TVarChar);

CREATE OR REPLACE FUNCTION zfStrToXmlStr(inStr TVarChar)
RETURNS TVarChar AS
$BODY$
  DECLARE Res TVarChar;
BEGIN
  Res := replace(inStr, '&', '&amp;');
  Res := replace(inStr, '''', '&apos;');
  Res := replace(inStr, '"', '&quot;');
  Res := replace(inStr, '<', '&lt;');
  Res := replace(inStr, '>', '&gt;');
  RETURN Res;
END;
$BODY$
  LANGUAGE PLPGSQL IMMUTABLE;
ALTER FUNCTION zfStrToXmlStr (TVarChar) OWNER TO postgres;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
  09.02.15                        *  
*/

-- ����
-- SELECT * FROM zfConvert_StringToNumber ('TVarChar')
-- SELECT * FROM zfConvert_StringToNumber ('10')
