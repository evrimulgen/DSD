-- Function: gpInsertUpdate_Object_Goods()

DROP FUNCTION IF EXISTS lpInsertUpdate_Object_Goods(Integer, TVarChar, TVarChar, Integer, Integer, Integer, Integer, Integer, Integer);

CREATE OR REPLACE FUNCTION lpInsertUpdate_Object_Goods(
 INOUT ioId                  Integer   ,    -- ���� ������� <�����>
    IN inCode                TVarChar  ,    -- ��� ������� <�����>
    IN inName                TVarChar  ,    -- �������� ������� <�����>
    IN inGoodsGroupId        Integer   ,    -- ������ �������
    IN inMeasureId           Integer   ,    -- ������ �� ������� ���������
    IN inNDSKindId           Integer   ,    -- ���
    IN inGoodsMainId         Integer   ,    -- ������ �� ������� �����
    IN inObjectId            Integer   ,    -- �� ���� ��� �������� ����
    IN inUserId              Integer        -- ������������
)
RETURNS integer AS
$BODY$
  DECLARE vbCode INTEGER;
BEGIN

   --   PERFORM lpCheckRight(inSession, zc_Enum_Process_GoodsGroup());
   
   -- !!! �������� ������������ <������������>
   IF EXISTS (SELECT GoodsName FROM Object_Goods_View WHERE ObjectId = inObjectId AND GoodsName = inName AND Id <> COALESCE(ioId, 0) ) THEN
      RAISE EXCEPTION '�������� "%" �� ��������� ��� ����������� "������"', inName;
   END IF; 

   -- !!! �������� ������������ <���>
   IF EXISTS (SELECT GoodsName FROM Object_Goods_View WHERE ObjectId = inObjectId AND GoodsCode = inCode AND Id <> COALESCE(ioId, 0)  ) THEN
      RAISE EXCEPTION '��� "%" �� ��������� ��� ����������� "������"', inCode;
   END IF; 

   vbCode := inCode::Integer;

   -- ��������� <������>
   ioId := lpInsertUpdate_Object(ioId, zc_Object_Goods(), vbCode, inName);

   IF COALESCE(inObjectId, 0) <> 0 THEN
      -- ��������� ���
      PERFORM lpInsertUpdate_ObjectString(zc_ObjectString_Goods_Code(), ioId, inCode);
      -- ��������� �������� <����� ��� ������>
      PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Goods_Object(), ioId, inObjectId);
      -- ��������� ����� � <������� �������>
      PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Goods_GoodsMain(), ioId, inGoodsMainId);
   END IF; 

   -- ��������� ����� � <������>
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Goods_GoodsGroup(), ioId, inGoodsGroupId);
   -- ��������� ����� � <>
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Goods_Measure(), ioId, inMeasureId);
   -- ��������� �������� <���>
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Goods_NDSKind(), ioId, inNDSKindId );

   -- ��������� ��������
   -- PERFORM lpInsert_ObjectProtocol (ioId, UserId);

END;$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION lpInsertUpdate_Object_Goods(Integer, TVarChar, TVarChar, Integer, Integer, Integer, Integer, Integer, Integer) OWNER TO postgres;

  
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 29.07.14                        *
 26.06.14                        *
 24.06.14         *
 19.06.13                        * 

*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_Goods