-- Function: gpInsertUpdate_Object_Goods()

DROP FUNCTION IF EXISTS gpUpdate_Goods_isFirst(Integer, Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpUpdate_Goods_isFirst(
    IN inId                  Integer   ,    -- ���� ������� <�����>
    IN inisFirst             Boolean   ,    -- 1-�����
    IN inSession             TVarChar       -- ������� ������������
)
RETURNS VOID AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN

   IF COALESCE(inId, 0) = 0 THEN
      RETURN;
   END IF;

   vbUserId := lpGetUserBySession (inSession);
  
   PERFORM lpInsertUpdate_ObjectBoolean (zc_ObjectBoolean_Goods_First(), inId, inisFirst);

   
   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (inId, vbUserId);

END;$BODY$

LANGUAGE plpgsql VOLATILE;
  
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 15.03.16         *

*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_Goods
