
DROP FUNCTION IF EXISTS gpInsertUpdate_Movement_LoadPriceListSelf 
          (Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_Movement_LoadPriceListSelf(
    IN inJuridicalId         Integer   , -- ����������� ����
    IN inGoodsCode           Integer   , 
    IN inSession             TVarChar    -- ������ ������������
)
RETURNS VOID AS
$BODY$
  DECLARE vbLoadPriceListId Integer;
  DECLARE vbLoadPriceListItemsId Integer;
BEGIN
	
  DELETE FROM LoadPriceListItem WHERE LoadPriceListId IN
    (SELECT Id FROM LoadPriceList WHERE JuridicalId = inJuridicalId 
                                    AND OperDate < CURRENT_DATE);

  DELETE FROM LoadPriceList WHERE Id IN
    (SELECT Id FROM LoadPriceList WHERE JuridicalId = inJuridicalId 
                                    AND OperDate < CURRENT_DATE);
   
  SELECT Id INTO vbLoadPriceListId 
    FROM LoadPriceList
   WHERE JuridicalId = inJuridicalId AND OperDate = Current_Date;

  IF COALESCE(vbLoadPriceListId, 0) = 0 THEN
     INSERT INTO LoadPriceList (JuridicalId, ContractId, OperDate, NDSinPrice)
             VALUES(inJuridicalId, NULL, Current_Date, True);
  END IF;

  SELECT Id INTO vbLoadPriceListItemsId 
    FROM LoadPriceListItem 
   WHERE LoadPriceListId = vbLoadPriceListId AND GoodsCode = inGoodsCode::TVarChar;

   IF COALESCE(vbLoadPriceListItemsId, 0) = 0 THEN
      INSERT INTO LoadPriceListItem (LoadPriceListId, CommonCode, BarCode, GoodsCode, GoodsName, GoodsNDS, GoodsId, Price, ExpirationDate, PackCount, ProducerName)
             SELECT vbLoadPriceListId, 0, '', inGoodsCode, Object_Goods_Main_View.GoodsName, Object_Goods_Main_View.NDS, Object_Goods_Main_View.Id, 0.01, NULL, NULL, NULL
              FROM Object_Goods_Main_View WHERE Object_Goods_Main_View.GoodsCode = inGoodsCode;
   END IF;

END;
$BODY$
LANGUAGE PLPGSQL VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.
 30.01.15                        *   
*/
