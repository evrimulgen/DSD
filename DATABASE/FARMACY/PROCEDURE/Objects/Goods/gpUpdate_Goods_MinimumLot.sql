-- Function: gpInsertUpdate_Object_Goods()

DROP FUNCTION IF EXISTS gpUpdate_Goods_MinimumLot(Integer, TFloat, TVarChar);

CREATE OR REPLACE FUNCTION gpUpdate_Goods_MinimumLot(
    IN inId                  Integer   ,    -- ���� ������� <�����>
    IN inMinimumLot          TFloat    ,    -- ��������� ��������
   OUT outUpdateDate         TDateTime ,
   OUT outUpdateName         TVarChar  ,
    IN inSession             TVarChar       -- ������� ������������
)
RETURNS record AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbMinimumLot TFloat; 
BEGIN

   IF COALESCE(inId, 0) = 0 THEN
      RETURN;
   END IF;

   vbUserId := lpGetUserBySession (inSession);

   IF inMinimumLot = 0 THEN 
      inMinimumLot := NULL;
   END IF;   	

    -- �������� ����������� �������� ��-��
    vbMinimumLot:=COALESCE((SELECT ObjectFloat.ValueData FROM ObjectFloat WHERE ObjectFloat.DescId = zc_ObjectFloat_Goods_MinimumLot() AND ObjectFloat.ObjectId = inId),0);


   PERFORM lpInsertUpdate_ObjectFloat (zc_ObjectFloat_Goods_MinimumLot(), inId, inMinimumLot);

   IF COALESCE(inMinimumLot,0) <> vbMinimumLot 
   THEN
          -- ��������� �������� <���� �������������>
         PERFORM lpInsertUpdate_ObjectDate (zc_ObjectDate_Protocol_Update(), inId, CURRENT_TIMESTAMP);
         -- ��������� �������� <������������ (�������������)>
         PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Protocol_Update(), inId, vbUserId);
   
   END IF;

          outUpdateDate:=COALESCE((SELECT ObjectDate.ValueData FROM ObjectDate WHERE ObjectDate.ObjectId = inId AND ObjectDate.DescId = zc_ObjectDate_Protocol_Update()),Null) ::TDateTime;    

          outUpdateName:=COALESCE((SELECT Object.ValueData
                                   FROM ObjectLink
                                     LEFT JOIN Object ON Object.Id = ObjectLink.ChildObjectId
                                   WHERE ObjectLink.ObjectId = inId AND ObjectLink.DescId =  zc_ObjectLink_Protocol_Update()),'') ::TVarChar;    

   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (inId, vbUserId);

END;$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpUpdate_Goods_MinimumLot(Integer, TFloat, TVarChar) OWNER TO postgres;

  
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 11.11.14                        *

*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_Goods
