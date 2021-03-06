-- Function: gpInsertUpdate_Movement_BankAccount()

DROP FUNCTION IF EXISTS gpLoadPriceList (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpLoadPriceList(
    IN inId                  Integer   , -- �����-����
    IN inSession             TVarChar    -- ������ ������������
)                              
RETURNS Void AS
$BODY$
   DECLARE vbUserId       Integer;

   DECLARE vbPriceListId  Integer;
   DECLARE vbJuridicalId  Integer;
   DECLARE vbContractId   Integer;
   DECLARE vbAreaId       Integer;
   DECLARE vbOperDate     TDateTime;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId := lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_LoadSaleFrom1C());
     vbUserId := lpGetUserBySession (inSession);

     -- �������� ��������� ����������
     SELECT LoadPriceList.OperDate	 
          , LoadPriceList.JuridicalId 
          , COALESCE (LoadPriceList.ContractId, 0)
          , COALESCE (LoadPriceList.AreaId, 0)
            INTO vbOperDate, vbJuridicalId, vbContractId, vbAreaId
      FROM LoadPriceList WHERE LoadPriceList.Id = inId;

     UPDATE LoadPriceList SET isMoved = true, UserId_Update = vbUserId, Date_Update = CURRENT_TIMESTAMP WHERE Id = inId;

     -- ���� ����� �� ���� ����, ������ � �������� �� ������, �� ���������. � ���� ������, �� ��������� ��
     SELECT
            Movement.Id INTO vbPriceListId
       FROM Movement 
            JOIN MovementLinkObject AS MovementLinkObject_Juridical
                                    ON MovementLinkObject_Juridical.MovementId = Movement.Id
                                   AND MovementLinkObject_Juridical.DescId = zc_MovementLinkObject_Juridical()
            JOIN MovementLinkObject AS MovementLinkObject_Contract
                                    ON MovementLinkObject_Contract.MovementId = Movement.Id
                                   AND MovementLinkObject_Contract.DescId = zc_MovementLinkObject_Contract()
            LEFT JOIN MovementLinkObject AS MovementLinkObject_Area
                                         ON MovementLinkObject_Area.MovementId = Movement.Id
                                        AND MovementLinkObject_Area.DescId     = zc_MovementLinkObject_Area()
      WHERE Movement.OperDate = vbOperDate AND Movement.DescId = zc_Movement_PriceList()
        AND MovementLinkObject_Juridical.ObjectId = vbJuridicalId 
        AND COALESCE (MovementLinkObject_Contract.ObjectId, 0) = vbContractId
        AND COALESCE (MovementLinkObject_Area.ObjectId, 0)     = vbAreaId
       ;

      IF COALESCE (vbPriceListId, 0) = 0 THEN 
         vbPriceListId := gpInsertUpdate_Movement_PriceList (0, '', vbOperDate, vbJuridicalId, vbContractId, vbAreaId, inSession);
      END IF;


     -- ��������� ��������� ���� ������ � ������������� 
     PERFORM CASE WHEN COALESCE (ObjectDate_LastPriceOLd.ValueData, NULL) <> NULL
                  THEN CASE WHEN COALESCE (ObjectDate_LastPrice.ValueData, NULL) <> NULL AND ObjectDate_LastPrice.ValueData > ObjectDate_LastPriceOLd.ValueData
                            THEN lpInsertUpdate_ObjectDate (zc_ObjectDate_Goods_LastPriceOld(), GoodsId, ObjectDate_LastPrice.ValueData)              
                       END
                  ELSE lpInsertUpdate_ObjectDate (zc_ObjectDate_Goods_LastPriceOld(), GoodsId, ObjectDate_LastPrice.ValueData) 
             END 
        
      FROM LoadPriceListItem 
           JOIN LoadPriceList ON LoadPriceList.Id = LoadPriceListItem.LoadPriceListId
              
           LEFT JOIN ObjectDate AS ObjectDate_LastPrice
                                ON ObjectDate_LastPrice.ObjectId = LoadPriceListItem.GoodsId
                               AND ObjectDate_LastPrice.DescId = zc_ObjectDate_Goods_LastPrice()
           LEFT JOIN ObjectDate AS ObjectDate_LastPriceOld
                                ON ObjectDate_LastPriceOld.ObjectId = LoadPriceListItem.GoodsId
                               AND ObjectDate_LastPriceOld.DescId = zc_ObjectDate_Goods_LastPriceOld()
      WHERE GoodsId <> 0 AND LoadPriceListId = inId;
      
     -- ������� ��������� ������
     PERFORM 
         lpInsertUpdate_MovementItem_PriceList(
                                               MovementItem.Id , -- ���� ������� <������� ���������>
                                                 vbPriceListId , -- ���� ������� <��������>
                                                       GoodsId , -- ������
                                               Object_Goods.Id , -- ����� �����-�����
                                       
                                                  CASE WHEN LoadPriceList.NDSinPrice = TRUE
                                                            THEN Price 
                                                       ELSE Price * (100 + ObjectFloat_NDSKind_NDS.ValueData) / 100 
                                                  END:: TFloat  , -- ����
                                       
                                                  CASE WHEN LoadPriceList.NDSinPrice = TRUE
                                                            THEN PriceOriginal 
                                                       ELSE PriceOriginal * (100 + ObjectFloat_NDSKind_NDS.ValueData) / 100
                                                  END:: TFloat  , -- !!!���� ������������!!!
                                       
                                                 ExpirationDate , -- ������ ������
                                                        Remains , -- �������
                                                       vbUserId)
        , lpInsertUpdate_ObjectDate (zc_ObjectDate_Goods_LastPrice(), GoodsId, vbOperDate)              -- ���� ������ --CURRENT_TIMESTAMP
        , lpInsertUpdate_Goods_CountPrice (vbPriceListId, vbOperDate, GoodsId)
       FROM LoadPriceListItem 
               JOIN LoadPriceList ON LoadPriceList.Id = LoadPriceListItem.LoadPriceListId
          LEFT JOIN ObjectLink AS ObjectLink_Goods_NDSKind
                             ON ObjectLink_Goods_NDSKind.ObjectId = LoadPriceListItem.GoodsId
                            AND ObjectLink_Goods_NDSKind.DescId = zc_ObjectLink_Goods_NDSKind()
               
          LEFT JOIN ObjectFloat AS ObjectFloat_NDSKind_NDS
                                ON ObjectFloat_NDSKind_NDS.ObjectId = ObjectLink_Goods_NDSKind.Childobjectid
                               AND ObjectFloat_NDSKind_NDS.DescId = zc_ObjectFloat_NDSKind_NDS()   

               JOIN (SELECT Object_Goods_View.Id, Object_Goods_View.GoodsCode
                                FROM Object_Goods_View 
                               WHERE ObjectId = vbJuridicalId
                    ) AS Object_Goods ON Object_Goods.goodscode = LoadPriceListItem.GoodsCode
                    
          LEFT JOIN MovementItem ON LoadPriceListItem.GoodsId = MovementItem.ObjectId and MovementId = vbPriceListId
          LEFT JOIN MovementItemLinkObject AS MILinkObject_Goods
                                                   ON MILinkObject_Goods.MovementItemId = MovementItem.Id
                                                  AND MILinkObject_Goods.DescId = zc_MILinkObject_Goods()
                                                  AND MILinkObject_Goods.ObjectId = Object_Goods.Id
                    
                    
      WHERE GoodsId <> 0 AND LoadPriceListId = inId;


     -- ��������� ��������
     -- PERFORM lpInsert_MovementProtocol (ioId, vbUserId);

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.
 18.08.17         *
 21.04.17         *
 28.01.15                        *  ������ ���� � ������ ��������� ������
 26.10.14                        *  
 18.09.14                        *  
 10.09.14                        *  
*/

-- ����
-- SELECT * FROM gpLoadSaleFrom1C('01-01-2013'::TDateTime, '01-01-2014'::TDateTime, '')
-- lpInsertUpdate_ObjectDate (zc_ObjectDate_Goods_LastPrice(), GoodsId, vbOperDate) 