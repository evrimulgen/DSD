-- Function: gpSelectMobile_Object_GoodsByGoodsKind (TDateTime, TVarChar)

DROP FUNCTION IF EXISTS gpSelectMobile_Object_GoodsLinkGoodsKind (TDateTime, TVarChar);
DROP FUNCTION IF EXISTS gpSelectMobile_Object_GoodsByGoodsKind (TDateTime, TVarChar);

CREATE OR REPLACE FUNCTION gpSelectMobile_Object_GoodsByGoodsKind (
    IN inSyncDateIn TDateTime, -- ����/����� ��������� ������������� - ����� "�������" ����������� �������� ���������� - ���������� �����������, ����, �����, �����, ������� � �.�
    IN inSession    TVarChar   -- ������ ������������
)
RETURNS TABLE (Id            Integer
             , GoodsId       Integer  -- �����
             , GoodsKindId   Integer  -- ��� ������
             , AmountRemains TFloat   -- ������� �� ����������� ������
             , AmountIncome  TFloat   -- ������� ������� �� ����������� �����
             , isErased      Boolean  -- ��������� �� �������
             , isSync        Boolean  -- ���������������� (��/���)
              )
AS 
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbPersonalId Integer;
BEGIN
      -- �������� ���� ������������ �� ����� ���������
      -- vbUserId:= lpCheckRight (inSession, zc_Enum_Process_...());
      vbUserId:= lpGetUserBySession (inSession);

      vbPersonalId:= (SELECT PersonalId FROM gpGetMobile_Object_Const (inSession));

      -- ���������
      IF vbPersonalId IS NOT NULL
      THEN
           CREATE TEMP TABLE tmpGoodsByGoodsKind ON COMMIT DROP
           AS (SELECT ObjectLink_GoodsByGoodsKind_Goods.ObjectId AS GoodsByGoodsKindId
                    , COUNT(ObjectLink_GoodsByGoodsKind_Goods.ObjectId) AS GoodsByGoodsKindCount
               FROM Object AS Object_GoodsListSale
                    JOIN ObjectLink AS ObjectLink_GoodsListSale_Goods 
                                    ON ObjectLink_GoodsListSale_Goods.ObjectId = Object_GoodsListSale.Id
                                   AND ObjectLink_GoodsListSale_Goods.DescId = zc_ObjectLink_GoodsListSale_Goods()
                                   AND ObjectLink_GoodsListSale_Goods.ChildObjectId IS NOT NULL
                    JOIN ObjectLink AS ObjectLink_GoodsListSale_Partner
                                    ON ObjectLink_GoodsListSale_Partner.ObjectId = Object_GoodsListSale.Id
                                   AND ObjectLink_GoodsListSale_Partner.DescId = zc_ObjectLink_GoodsListSale_Partner()
                                   AND ObjectLink_GoodsListSale_Partner.ChildObjectId IS NOT NULL
                    JOIN ObjectLink AS ObjectLink_Partner_PersonalTrade
                                    ON ObjectLink_Partner_PersonalTrade.ObjectId = ObjectLink_GoodsListSale_Partner.ChildObjectId
                                   AND ObjectLink_Partner_PersonalTrade.DescId = zc_ObjectLink_Partner_PersonalTrade()
                                   AND ObjectLink_Partner_PersonalTrade.ChildObjectId = vbPersonalId
                    JOIN ObjectLink AS ObjectLink_GoodsByGoodsKind_Goods
                                    ON ObjectLink_GoodsByGoodsKind_Goods.ChildObjectId = ObjectLink_GoodsListSale_Goods.ChildObjectId
                                   AND ObjectLink_GoodsByGoodsKind_Goods.DescId = zc_ObjectLink_GoodsByGoodsKind_Goods()
                                   AND ObjectLink_GoodsByGoodsKind_Goods.ObjectId IS NOT NULL
               WHERE Object_GoodsListSale.DescId = zc_Object_GoodsListSale()
               GROUP BY ObjectLink_GoodsByGoodsKind_Goods.ObjectId
              );
             
           IF inSyncDateIn > zc_DateStart()
           THEN
                RETURN QUERY
                  WITH tmpProtocol AS (SELECT ObjectProtocol.ObjectId AS GoodsByGoodsKindId, MAX(ObjectProtocol.OperDate) AS MaxOperDate
                                       FROM ObjectProtocol
                                            JOIN Object AS Object_GoodsByGoodsKind
                                                        ON Object_GoodsByGoodsKind.Id = ObjectProtocol.ObjectId
                                                       AND Object_GoodsByGoodsKind.DescId = zc_Object_GoodsByGoodsKind() 
                                       WHERE ObjectProtocol.OperDate > inSyncDateIn
                                       GROUP BY ObjectProtocol.ObjectId
                                      )
                  SELECT Object_GoodsByGoodsKind.Id
                       , ObjectLink_GoodsByGoodsKind_Goods.ChildObjectId     AS GoodsId
                       , ObjectLink_GoodsByGoodsKind_GoodsKind.ChildObjectId AS GoodsKindId 
                       , CAST(0.0 AS TFloat)                                 AS AmountRemains
                       , CAST(0.0 AS TFloat)                                 AS AmountIncome 
                       , Object_GoodsByGoodsKind.isErased
                       , EXISTS(SELECT 1 FROM tmpGoodsByGoodsKind WHERE tmpGoodsByGoodsKind.GoodsByGoodsKindId = Object_GoodsByGoodsKind.Id) AS isSync
                  FROM Object AS Object_GoodsByGoodsKind
                       JOIN tmpProtocol ON tmpProtocol.GoodsByGoodsKindId = Object_GoodsByGoodsKind.Id
                       LEFT JOIN ObjectLink AS ObjectLink_GoodsByGoodsKind_Goods
                                            ON ObjectLink_GoodsByGoodsKind_Goods.ObjectId = Object_GoodsByGoodsKind.Id
                                           AND ObjectLink_GoodsByGoodsKind_Goods.DescId = zc_ObjectLink_GoodsByGoodsKind_Goods()
                       LEFT JOIN ObjectLink AS ObjectLink_GoodsByGoodsKind_GoodsKind
                                            ON ObjectLink_GoodsByGoodsKind_GoodsKind.ObjectId = Object_GoodsByGoodsKind.Id
                                           AND ObjectLink_GoodsByGoodsKind_GoodsKind.DescId = zc_ObjectLink_GoodsByGoodsKind_GoodsKind()
                  WHERE Object_GoodsByGoodsKind.DescId = zc_Object_GoodsByGoodsKind();
           ELSE
                RETURN QUERY
                  SELECT Object_GoodsByGoodsKind.Id
                       , ObjectLink_GoodsByGoodsKind_Goods.ChildObjectId     AS GoodsId
                       , ObjectLink_GoodsByGoodsKind_GoodsKind.ChildObjectId AS GoodsKindId 
                       , CAST(0.0 AS TFloat)                                 AS AmountRemains
                       , CAST(0.0 AS TFloat)                                 AS AmountIncome 
                       , Object_GoodsByGoodsKind.isErased
                       , CAST(true AS Boolean) AS isSync
                  FROM Object AS Object_GoodsByGoodsKind
                       LEFT JOIN ObjectLink AS ObjectLink_GoodsByGoodsKind_Goods
                                            ON ObjectLink_GoodsByGoodsKind_Goods.ObjectId = Object_GoodsByGoodsKind.Id
                                           AND ObjectLink_GoodsByGoodsKind_Goods.DescId = zc_ObjectLink_GoodsByGoodsKind_Goods()
                       LEFT JOIN ObjectLink AS ObjectLink_GoodsByGoodsKind_GoodsKind
                                            ON ObjectLink_GoodsByGoodsKind_GoodsKind.ObjectId = Object_GoodsByGoodsKind.Id
                                           AND ObjectLink_GoodsByGoodsKind_GoodsKind.DescId = zc_ObjectLink_GoodsByGoodsKind_GoodsKind()
                  WHERE Object_GoodsByGoodsKind.DescId = zc_Object_GoodsByGoodsKind()
                    AND EXISTS(SELECT 1 FROM tmpGoodsByGoodsKind WHERE tmpGoodsByGoodsKind.GoodsByGoodsKindId = Object_GoodsByGoodsKind.Id);
           END IF;
      END IF;

END; 
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   �������� �.�.
 17.02.17                                                         *
*/

-- ����
-- SELECT * FROM gpSelectMobile_Object_GoodsByGoodsKind(inSyncDateIn := zc_DateStart(), inSession := zfCalc_UserAdmin())