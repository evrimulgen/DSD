-- Function: gpInsertUpdate_Object_ImportTypeItems()

DROP FUNCTION IF EXISTS gpInsertUpdate_Object_ImportSettingsItems (Integer, TVarChar, Integer, Integer, TVarchar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_ImportSettingsItems(
 INOUT ioId                      Integer   ,   	-- ���� ������� <>
    IN inName                    TVarChar  ,    -- �������� ������� <>
    IN inImportSettingsId        Integer   ,    -- ������ �� ������� ��.����
    IN inImportTypeItemsId       Integer   ,    -- ������ �� 
    IN inSession                 TVarChar       -- ������ ������������
)
  RETURNS Integer AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbCode_calc Integer;  

BEGIN
   -- �������� ���� ������������ �� ����� ���������
   --vbUserId:= lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_Object_ImportTypeItems());
   vbUserId := lpGetUserBySession (inSession); 

   -- �������� ������������ <������������>
   PERFORM lpCheckUnique_Object_ValueData (ioId, zc_Object_ImportSettingsItems(), inName);
   
   -- ��������� <������>
   ioId := lpInsertUpdate_Object (ioId, zc_Object_ImportSettingsItems(), 0, inName);
   
   -- ��������� ����� � <>
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_ImportSettingsItems_ImportSettings(), ioId, inImportSettingsId);
   -- ��������� ����� � <>
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_ImportSettingsItems_ImportTypeItems(), ioId, inImportTypeItemsId);
     
   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (ioId, vbUserId);
END;$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpInsertUpdate_Object_ImportSettingsItems (Integer, TVarChar, Integer, Integer, TVarchar) OWNER TO postgres;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 03.07.14         * 

*/

-- ����
--select * from gpInsertUpdate_Object_ImportSettingsItems(ioId := 0 , inName := 'sfd' , inImportSettingsId := 329 , inImportTypeItemsId := 0 ,  inSession := '8');                            