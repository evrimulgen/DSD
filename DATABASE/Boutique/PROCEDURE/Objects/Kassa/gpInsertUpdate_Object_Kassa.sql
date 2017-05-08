-- Function: gpInsertUpdate_Object_Kassa (Integer, Integer, TVarChar, TVarChar)

DROP FUNCTION IF EXISTS gpInsertUpdate_Object_Kassa (Integer, Integer, TVarChar, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_Kassa(
 INOUT ioId           Integer,       -- ���� ������� <�����>         
 INOUT ioCode         Integer,       -- ��� ������� <�����>          
    IN inName         TVarChar,      -- �������� ������� <�����>     
    IN inSession      TVarChar       -- ������ ������������
)
RETURNS record
AS
$BODY$
  DECLARE vbUserId Integer;
BEGIN

   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight(inSession, zc_Enum_Process_Kassa());
   vbUserId:= lpGetUserBySession (inSession);

   -- ����� ��� �������� �� Sybase �.�. ��� ��� = 0 
   IF COALESCE (ioId, 0) = 0 AND COALESCE(ioCode,0) = 0  THEN  ioCode := NEXTVAL ('Object_Kassa_seq'); 
   ELSEIF ioCode = 0
         THEN ioCode := coalesce((SELECT ObjectCode FROM Object WHERE Id = ioId),0);
   END IF; 

   -- ����� ������- ��� ����� ����� � ioCode -> ioCode
   IF COALESCE (ioId, 0) = 0 THEN  ioCode := NEXTVAL ('Object_Kassa_seq'); 
   END IF; 

   -- �������� ������������ ��� �������� <������������ Kassa>
   PERFORM lpCheckUnique_Object_ValueData(ioId, zc_Object_Kassa(), inName); 
   -- �������� ������������ ��� �������� <��� Kassa>
   PERFORM lpCheckUnique_Object_ObjectCode (ioId, zc_Object_Kassa(), ioCode);

   -- ��������� <������>
   ioId := lpInsertUpdate_Object(ioId, zc_Object_Kassa(), ioCode, inName);

   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (ioId, vbUserId);

END;
$BODY$

LANGUAGE plpgsql VOLATILE;



/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ��������� �.�.
06.03.17                                                          *
20.02.17                                                          *
*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_Kassa()
