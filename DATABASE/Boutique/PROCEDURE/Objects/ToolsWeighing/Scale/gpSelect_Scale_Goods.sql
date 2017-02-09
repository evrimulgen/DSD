-- Function: gpSelect_Scale_Goods()

-- DROP FUNCTION IF EXISTS gpSelect_Scale_Goods (TDateTime, Integer, Integer, Integer, TVarChar);
-- DROP FUNCTION IF EXISTS gpSelect_Scale_Goods (TDateTime, Integer, Integer, Integer, Integer, TVarChar);
-- DROP FUNCTION IF EXISTS gpSelect_Scale_Goods (Boolean, TDateTime, Integer, Integer, Integer, TVarChar);
DROP FUNCTION IF EXISTS gpSelect_Scale_Goods (Boolean, TDateTime, Integer, Integer, Integer, Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Scale_Goods(
    IN inIsGoodsComplete       Boolean  ,    -- ����� ��/������������/�������� or �������
    IN inOperDate              TDateTime,
    IN inMovementId            Integer,      -- �������� ��� ���������� (��� ��������)
    IN inOrderExternalId       Integer,      -- ������ ��� ������� (��� ��������)
    IN inPriceListId           Integer,
    IN inGoodsCode             Integer,
    IN inDayPrior_PriceReturn  Integer,
    IN inSession               TVarChar      -- ������ ������������
)
RETURNS TABLE (GoodsGroupNameFull TVarChar
             , GoodsId Integer, GoodsCode Integer, GoodsName TVarChar
             , GoodsKindId Integer, GoodsKindCode Integer, GoodsKindName TVarChar, GoodsKindId_list TVarChar, GoodsKindId_max Integer, GoodsKindCode_max Integer, GoodsKindName_max TVarChar
             , MeasureId Integer, MeasureName TVarChar
             , ChangePercentAmount TFloat
             , Amount_Order TFloat
             , Amount_OrderWeight TFloat
             , Amount_Weighing TFloat
             , Amount_WeighingWeight TFloat
             , Amount_diff TFloat
             , Amount_diffWeight TFloat
             , isTax_diff Boolean
             , Price TFloat
             , Price_Return TFloat
             , CountForPrice         TFloat
             , CountForPrice_Return  TFloat
             , Color_calc            Integer
             , MovementId_Promo      Integer
             , isPromo               Boolean
             , isTare                Boolean
              )
AS
$BODY$
    DECLARE vbUserId Integer;

    DECLARE vbRetailId    Integer;
    DECLARE vbFromId      Integer;
    DECLARE vbGoodsId     Integer;
    DECLARE vbOperDate_price TDateTime;
    DECLARE vbPriceListId Integer;
BEGIN
   -- �������� ���� ������������ �� ����� ���������
   vbUserId:= lpGetUserBySession (inSession);


   -- ����� �������� ��� ��� �� � ������, �� ��� ��� ����� ���� ��������
   IF inOrderExternalId > 0 AND inGoodsCode <> 0 THEN vbGoodsId:= (SELECT Object.Id FROM Object WHERE Object.ObjectCode = inGoodsCode AND Object.DescId = zc_Object_Goods() AND Object.isErased = FALSE);
   END IF;


   IF inOrderExternalId > 0
   THEN

        -- ��������� �� ���������
        SELECT COALESCE (MovementLinkObject_Retail.ObjectId, 0)        AS RetailId
             , COALESCE (MovementLinkObject_From.ObjectId, 0)          AS FromId
               INTO vbRetailId, vbFromId
        FROM Movement
             LEFT JOIN MovementLinkObject AS MovementLinkObject_Retail
                                          ON MovementLinkObject_Retail.MovementId = Movement.Id
                                         AND MovementLinkObject_Retail.DescId = zc_MovementLinkObject_Retail()
             LEFT JOIN MovementLinkObject AS MovementLinkObject_From
                                          ON MovementLinkObject_From.MovementId = Movement.Id
                                         AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
        WHERE Movement.Id = inOrderExternalId;


         IF vbGoodsId <> 0
         THEN
              -- ����������
              SELECT tmp.PriceListId, tmp.OperDate
                    INTO vbPriceListId, vbOperDate_price
              FROM lfGet_Object_Partner_PriceList_onDate (inContractId     := COALESCE ((SELECT MLO.ObjectId FROM MovementLinkObject AS MLO WHERE MLO.MovementId = inMovementId AND MLO.DescId = zc_MovementLinkObject_Contract()), 1)
                                                        , inPartnerId      := (SELECT MLO.ObjectId FROM MovementLinkObject AS MLO WHERE MLO.MovementId = inMovementId AND MLO.DescId = zc_MovementLinkObject_From())
                                                        , inMovementDescId := zc_Movement_Sale()
                                                        , inOperDate_order := COALESCE ((SELECT Movement.OperDate FROM Movement WHERE Movement.Id = inOrderExternalId), CURRENT_TIMESTAMP)
                                                        , inOperDatePartner:= NULL
                                                        , inDayPrior_PriceReturn:= NULL
                                                        , inIsPrior        := FALSE -- !!!���������� �� ������ ���!!!
                                                         ) AS tmp;
         END IF;


    -- ��������� - �� ������
    RETURN QUERY
       WITH tmpMovement AS (SELECT Movement_find.Id AS MovementId
                            FROM (SELECT inOrderExternalId AS MovementId WHERE vbRetailId <> 0) AS tmpMovement
                                 INNER JOIN Movement ON Movement.Id = tmpMovement.MovementId
                                 INNER JOIN Movement AS Movement_find ON Movement_find.OperDate = Movement.OperDate
                                                                     AND Movement_find.DescId   = Movement.DescId
                                                                     AND Movement_find.StatusId = zc_Enum_Status_Complete()
                                 INNER JOIN MovementLinkObject AS MovementLinkObject_From_find
                                                               ON MovementLinkObject_From_find.MovementId = Movement_find.Id
                                                              AND MovementLinkObject_From_find.DescId = zc_MovementLinkObject_From()
                                                              AND MovementLinkObject_From_find.ObjectId = vbFromId
                                 INNER JOIN MovementLinkObject AS MovementLinkObject_Retail_find
                                                               ON MovementLinkObject_Retail_find.MovementId = Movement_find.Id
                                                              AND MovementLinkObject_Retail_find.DescId = zc_MovementLinkObject_Retail()
                                                              AND MovementLinkObject_Retail_find.ObjectId = vbRetailId
                           UNION
                            SELECT inOrderExternalId AS MovementId WHERE vbRetailId = 0
                           )
          , tmpMI_Order2 AS (SELECT MovementItem.ObjectId                                                AS GoodsId
                                 , COALESCE (MILinkObject_GoodsKind.ObjectId, CASE WHEN inIsGoodsComplete = FALSE THEN 0 ELSE zc_Enum_GoodsKind_Main() END) AS GoodsKindId
                                 , MovementItem.Amount + COALESCE (MIFloat_AmountSecond.ValueData, 0)   AS Amount
                                 , COALESCE (MIFloat_Price.ValueData, 0)                                AS Price
                                 , CASE WHEN MIFloat_CountForPrice.ValueData > 0 THEN MIFloat_CountForPrice.ValueData ELSE 1 END AS CountForPrice
                                 , COALESCE (MIFloat_PromoMovement.ValueData, 0)                        AS MovementId_Promo
                                 , FALSE AS isTare
                            FROM tmpMovement
                                 INNER JOIN MovementItem ON MovementItem.MovementId = tmpMovement.MovementId
                                                        AND MovementItem.DescId     = zc_MI_Master()
                                                        AND MovementItem.isErased   = FALSE
                                 LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                                                  ON MILinkObject_GoodsKind.MovementItemId = MovementItem.Id
                                                                 AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
                                 LEFT JOIN MovementItemFloat AS MIFloat_AmountSecond
                                                             ON MIFloat_AmountSecond.MovementItemId = MovementItem.Id
                                                            AND MIFloat_AmountSecond.DescId = zc_MIFloat_AmountSecond()
                                 LEFT JOIN MovementItemFloat AS MIFloat_Price
                                                             ON MIFloat_Price.MovementItemId = MovementItem.Id
                                                            AND MIFloat_Price.DescId = zc_MIFloat_Price()
                                 LEFT JOIN MovementItemFloat AS MIFloat_CountForPrice
                                                             ON MIFloat_CountForPrice.MovementItemId = MovementItem.Id
                                                            AND MIFloat_CountForPrice.DescId = zc_MIFloat_CountForPrice()
                                 LEFT JOIN MovementItemFloat AS MIFloat_PromoMovement
                                                             ON MIFloat_PromoMovement.MovementItemId = MovementItem.Id
                                                            AND MIFloat_PromoMovement.DescId = zc_MIFloat_PromoMovementId()
                            WHERE MovementItem.Amount <> 0 OR COALESCE (MIFloat_AmountSecond.ValueData, 0) <> 0
                           )
          , tmpMI_Order AS (SELECT tmpMI_Order2.GoodsId
                                 , tmpMI_Order2.GoodsKindId
                                 , tmpMI_Order2.Amount
                                 , tmpMI_Order2.Price
                                 , tmpMI_Order2.CountForPrice
                                 , tmpMI_Order2.MovementId_Promo
                                 , tmpMI_Order2.isTare
                            FROM tmpMI_Order2
                           UNION ALL
                            SELECT Object_Goods.Id AS GoodsId
                                 , CASE WHEN inIsGoodsComplete = FALSE THEN 0 ELSE zc_Enum_GoodsKind_Main() END  AS GoodsKindId
                                 , 0 AS Amount
                                 , 0 AS Price
                                 , 0 AS CountForPrice
                                 , 0 AS MovementId_Promo
                                 , TRUE AS isTare
                            FROM Object_InfoMoney_View AS View_InfoMoney
                                 INNER JOIN ObjectLink AS ObjectLink_Goods_InfoMoney
                                                       ON ObjectLink_Goods_InfoMoney.ChildObjectId = View_InfoMoney.InfoMoneyId
                                                      AND ObjectLink_Goods_InfoMoney.DescId = zc_ObjectLink_Goods_InfoMoney()
                                 INNER JOIN Object AS Object_Goods ON Object_Goods.Id = ObjectLink_Goods_InfoMoney.ObjectId
                                                                  AND Object_Goods.isErased = FALSE
                                                                  AND Object_Goods.ObjectCode > 0
                            WHERE View_InfoMoney.InfoMoneyDestinationId IN (zc_Enum_InfoMoneyDestination_20500() -- ������������� + ��������� ����
                                                                          , zc_Enum_InfoMoneyDestination_20600() -- ������������� + ������ ���������
                                                                           )
                             AND Object_Goods.Id NOT IN (SELECT tmpMI_Order2.GoodsId FROM tmpMI_Order2)
                              -- AND vbUserId = 5
                           )
       , tmpMI_Weighing AS (SELECT MovementItem.ObjectId                         AS GoodsId
                                 , COALESCE (MILinkObject_GoodsKind.ObjectId, 0) AS GoodsKindId
                                 , MovementItem.Amount                           AS Amount
                                 , COALESCE (MIFloat_PromoMovement.ValueData, 0) AS MovementId_Promo
                                 , COALESCE (MIFloat_Price.ValueData, 0)         AS Price
                                 , CASE WHEN MIFloat_CountForPrice.ValueData > 0 THEN MIFloat_CountForPrice.ValueData ELSE 1 END AS CountForPrice
                            FROM MovementLinkMovement
                                 INNER JOIN Movement ON Movement.Id = MovementLinkMovement.MovementId
                                                    AND Movement.DescId = zc_Movement_WeighingPartner()
                                                    AND Movement.StatusId <> zc_Enum_Status_Erased()
                                 INNER JOIN MovementItem ON MovementItem.MovementId = Movement.Id
                                                        AND MovementItem.DescId     = zc_MI_Master()
                                                        AND MovementItem.isErased   = FALSE
                                 LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                                                  ON MILinkObject_GoodsKind.MovementItemId = MovementItem.Id
                                                                 AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
                                 LEFT JOIN MovementItemFloat AS MIFloat_Price
                                                             ON MIFloat_Price.MovementItemId = MovementItem.Id
                                                            AND MIFloat_Price.DescId = zc_MIFloat_Price()
                                 LEFT JOIN MovementItemFloat AS MIFloat_CountForPrice
                                                             ON MIFloat_CountForPrice.MovementItemId = MovementItem.Id
                                                            AND MIFloat_CountForPrice.DescId = zc_MIFloat_CountForPrice()
                                 LEFT JOIN MovementItemFloat AS MIFloat_PromoMovement
                                                             ON MIFloat_PromoMovement.MovementItemId = MovementItem.Id
                                                            AND MIFloat_PromoMovement.DescId = zc_MIFloat_PromoMovementId()
                            WHERE MovementLinkMovement.MovementChildId = inOrderExternalId
                              AND MovementLinkMovement.DescId = zc_MovementLinkMovement_Order()
                           )
                , tmpMI AS (SELECT tmpMI.GoodsId
                                 , tmpMI.GoodsKindId
                                 , tmpMI.Amount AS Amount_Order
                                 , 0            AS Amount_Weighing
                                 , tmpMI.MovementId_Promo
                                 , tmpMI.Price
                                 , tmpMI.CountForPrice
                                 , tmpMI.isTare
                            FROM tmpMI_Order AS tmpMI
                           UNION ALL
                            SELECT tmp.GoodsId
                                 , 0            AS GoodsKindId
                                 , 0            AS Amount_Order
                                 , 0            AS Amount_Weighing
                                 , 0            AS MovementId_Promo
                                 , (SELECT lpGet.ValuePrice FROM lpGet_ObjectHistory_PriceListItem (vbOperDate_price, vbPriceListId, vbGoodsId) AS lpGet) AS Price
                                 , 1 AS CountForPrice -- ������ �������
                                 , FALSE AS isTare
                            FROM (SELECT vbGoodsId AS GoodsId WHERE vbGoodsId <> 0) AS tmp
                                 LEFT JOIN tmpMI_Order ON tmpMI_Order.GoodsId = tmp.GoodsId
                                 LEFT JOIN tmpMI_Weighing ON tmpMI_Weighing.GoodsId = tmp.GoodsId
                            WHERE tmpMI_Order.GoodsId IS NULL AND tmpMI_Weighing.GoodsId IS NULL
                           UNION ALL
                            SELECT tmpMI.GoodsId
                                 , tmpMI.GoodsKindId
                                 , 0            AS Amount_Order
                                 , tmpMI.Amount AS Amount_Weighing
                                 , tmpMI.MovementId_Promo
                                 , tmpMI.Price
                                 , tmpMI.CountForPrice
                                 , FALSE AS isTare
                            FROM tmpMI_Weighing AS tmpMI
                           )
       -- ��������� - �� ������
       SELECT ObjectString_Goods_GoodsGroupFull.ValueData AS GoodsGroupNameFull
            , Object_Goods.Id             AS GoodsId
            , Object_Goods.ObjectCode     AS GoodsCode
            , Object_Goods.ValueData      AS GoodsName
            , Object_GoodsKind.Id         AS GoodsKindId
            , Object_GoodsKind.ObjectCode AS GoodsKindCode
            , Object_GoodsKind.ValueData  AS GoodsKindName
            , Object_GoodsKind.Id :: TVarChar AS GoodsKindId_list
            , Object_GoodsKind.Id         AS GoodsKindId_max
            , Object_GoodsKind.ObjectCode AS GoodsKindCode_max
            , Object_GoodsKind.ValueData  AS GoodsKindName_max
            , Object_Measure.Id           AS MeasureId
            , Object_Measure.ValueData    AS MeasureName
            , CASE WHEN Object_Measure.Id = zc_Measure_Kg() THEN 1 ELSE 0 END :: TFloat AS ChangePercentAmount
            , tmpMI.Amount_Order :: TFloat    AS Amount_Order
            , (tmpMI.Amount_Order * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Kg() THEN 1 WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN ObjectFloat_Weight.ValueData ELSE 0 END) :: TFloat    AS Amount_OrderWeight
            , tmpMI.Amount_Weighing :: TFloat AS Amount_Weighing
            , (tmpMI.Amount_Weighing * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Kg() THEN 1 WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN ObjectFloat_Weight.ValueData ELSE 0 END) :: TFloat AS Amount_WeighingWeight
            , (tmpMI.Amount_Order - tmpMI.Amount_Weighing) :: TFloat AS Amount_diff
            , ((tmpMI.Amount_Order - tmpMI.Amount_Weighing)  * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Kg() THEN 1 WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN ObjectFloat_Weight.ValueData ELSE 0 END) :: TFloat AS Amount_diffWeight
            , CASE WHEN tmpMI.Amount_Weighing > tmpMI.Amount_Order
                        THEN CASE WHEN tmpMI.Amount_Order = 0
                                       THEN TRUE
                                  WHEN (tmpMI.Amount_Weighing / tmpMI.Amount_Order * 100 - 100) > 2
                                       THEN TRUE
                                  ELSE FALSE
                             END
                        ELSE FALSE
              END :: Boolean AS isTax_diff
            , tmpMI.Price :: TFloat           AS Price
            , 0 :: TFloat                     AS Price_Return
            , tmpMI.CountForPrice :: TFloat   AS CountForPrice
            , 0 :: TFloat                     AS CountForPrice_Return

            , CASE WHEN (tmpMI.Amount_Order - tmpMI.Amount_Weighing) > 0
                        THEN 1118719 -- clRed
                   WHEN tmpMI.Amount_Weighing > tmpMI.Amount_Order
                        THEN CASE WHEN tmpMI.Amount_Order = 0
                                       THEN 16711680 -- clBlue
                                  WHEN (tmpMI.Amount_Weighing / tmpMI.Amount_Order * 100 - 100) > 2
                                       THEN 16711680 -- clBlue
                                  ELSE 0 -- clBlack
                             END
                   ELSE 0 -- clBlack
              END :: Integer AS Color_calc


            , tmpMI.MovementId_Promo :: Integer AS MovementId_Promo
            , CASE WHEN tmpMI.MovementId_Promo > 0 THEN TRUE ELSE FALSE END :: Boolean AS isPromo
            , tmpMI.isTare

       FROM (SELECT tmpMI.GoodsId
                  , tmpMI.GoodsKindId
                  , SUM (tmpMI.Amount_Order)     AS Amount_Order
                  , SUM (tmpMI.Amount_Weighing)  AS Amount_Weighing
                  , MAX (tmpMI.MovementId_Promo) AS MovementId_Promo
                  , MAX (tmpMI.Price)            AS Price
                  , tmpMI.CountForPrice
                  , tmpMI.isTare
             FROM tmpMI
             GROUP BY tmpMI.GoodsId
                    , tmpMI.GoodsKindId
                    -- , tmpMI.Price
                    , tmpMI.CountForPrice
                    , tmpMI.isTare
            ) AS tmpMI

            LEFT JOIN Object AS Object_Goods ON Object_Goods.Id = tmpMI.GoodsId
            LEFT JOIN Object AS Object_GoodsKind ON Object_GoodsKind.Id = tmpMI.GoodsKindId

            LEFT JOIN ObjectString AS ObjectString_Goods_GoodsGroupFull
                                   ON ObjectString_Goods_GoodsGroupFull.ObjectId = tmpMI.GoodsId
                                  AND ObjectString_Goods_GoodsGroupFull.DescId = zc_ObjectString_Goods_GroupNameFull()

            LEFT JOIN ObjectFloat AS ObjectFloat_Weight
                                  ON ObjectFloat_Weight.ObjectId = tmpMI.GoodsId
                                 AND ObjectFloat_Weight.DescId = zc_ObjectFloat_Goods_Weight()
            LEFT JOIN ObjectLink AS ObjectLink_Goods_Measure
                                 ON ObjectLink_Goods_Measure.ObjectId = tmpMI.GoodsId
                                AND ObjectLink_Goods_Measure.DescId = zc_ObjectLink_Goods_Measure()
            LEFT JOIN Object AS Object_Measure ON Object_Measure.Id = ObjectLink_Goods_Measure.ChildObjectId

       ORDER BY Object_Goods.ValueData
              , Object_GoodsKind.ValueData
              -- , ObjectString_Goods_GoodsGroupFull.ValueData
      ;
   ELSE

    -- 
    CREATE TEMP TABLE _tmpWord_Goods (GoodsId Integer, GoodsKindId_max Integer, WordList TVarChar) ON COMMIT DROP;
    CREATE TEMP TABLE _tmpWord_Split_from (WordList TVarChar) ON COMMIT DROP;
    CREATE TEMP TABLE _tmpWord_Split_to (Ord Integer, Word TVarChar, WordList TVarChar) ON COMMIT DROP;
    -- 
    INSERT INTO _tmpWord_Goods (GoodsId, GoodsKindId_max, WordList) 
                            SELECT DISTINCT ObjectLink_GoodsListSale_Goods.ChildObjectId AS GoodsId
                                 , ObjectLink_GoodsListSale_GoodsKind.ChildObjectId      AS GoodsKindId_max
                                 , COALESCE (ObjectString_GoodsKind.ValueData, '')       AS WordList
                            FROM Object AS Object_GoodsListSale
                                 INNER JOIN ObjectLink AS ObjectLink_GoodsListSale_Partner
                                                       ON ObjectLink_GoodsListSale_Partner.ObjectId      = Object_GoodsListSale.Id
                                                      AND ObjectLink_GoodsListSale_Partner.DescId        = zc_ObjectLink_GoodsListSale_Partner()
                                                      -- !!!����������� �� �����������!!!
                                                      AND ObjectLink_GoodsListSale_Partner.ChildObjectId = CASE WHEN inMovementId < 0 THEN -1 * inMovementId END :: Integer
                                 INNER JOIN ObjectLink AS ObjectLink_GoodsListSale_Contract
                                                       ON ObjectLink_GoodsListSale_Contract.ObjectId      = Object_GoodsListSale.Id
                                                      AND ObjectLink_GoodsListSale_Contract.DescId        = zc_ObjectLink_GoodsListSale_Contract()
                                                      -- !!!����������� �� ��������!!!
                                                      AND ObjectLink_GoodsListSale_Contract.ChildObjectId = CASE WHEN inOrderExternalId < 0 THEN -1 * inOrderExternalId ELSE ObjectLink_GoodsListSale_Contract.ChildObjectId END :: Integer
                                 LEFT JOIN ObjectLink AS ObjectLink_GoodsListSale_Goods
                                                      ON ObjectLink_GoodsListSale_Goods.ObjectId = Object_GoodsListSale.Id
                                                     AND ObjectLink_GoodsListSale_Goods.DescId = zc_ObjectLink_GoodsListSale_Goods()
                                 LEFT JOIN ObjectLink AS ObjectLink_GoodsListSale_GoodsKind
                                                      ON ObjectLink_GoodsListSale_GoodsKind.ObjectId = Object_GoodsListSale.Id
                                                     AND ObjectLink_GoodsListSale_GoodsKind.DescId = zc_ObjectLink_GoodsListSale_GoodsKind()
                                 LEFT JOIN ObjectString AS ObjectString_GoodsKind
                                                        ON ObjectString_GoodsKind.ObjectId = Object_GoodsListSale.Id
                                                       AND ObjectString_GoodsKind.DescId = zc_ObjectString_GoodsListSale_GoodsKind()
                            WHERE Object_GoodsListSale.DescId   = zc_Object_GoodsListSale()
                              AND Object_GoodsListSale.isErased = FALSE
                           ;
    -- 
    INSERT INTO _tmpWord_Split_from (WordList) 
       SELECT DISTINCT _tmpWord_Goods.WordList FROM _tmpWord_Goods WHERE inOrderExternalId < 0;


    -- 
    inMovementId:= COALESCE (inMovementId, 0);
    -- ��������� - ��� ������
    RETURN QUERY
       WITH tmpInfoMoney AS (SELECT View_InfoMoney.InfoMoneyDestinationId, View_InfoMoney.InfoMoneyId, FALSE AS isTare
                             FROM Object_InfoMoney_View AS View_InfoMoney
                             WHERE inIsGoodsComplete = TRUE
                               AND (View_InfoMoney.InfoMoneyId IN (zc_Enum_InfoMoney_20901() -- ���� + ����
                                                                , zc_Enum_InfoMoney_30101() -- ������ + ������� ���������
                                                                , zc_Enum_InfoMoney_30102() -- ������ + �������
                                                                , zc_Enum_InfoMoney_30103() -- ������ + ����
                                                                , zc_Enum_InfoMoney_30201() -- ������ + ������ �����
                                                                 )
                               OR View_InfoMoney.InfoMoneyDestinationId IN (zc_Enum_InfoMoneyDestination_30300() -- ������ + �����������
                                                                           )
                                 )
                            UNION
                             SELECT View_InfoMoney.InfoMoneyDestinationId, View_InfoMoney.InfoMoneyId, FALSE AS isTare
                             FROM Object_InfoMoney_View AS View_InfoMoney
                             WHERE inIsGoodsComplete = FALSE
                               AND View_InfoMoney.InfoMoneyDestinationId IN (zc_Enum_InfoMoneyDestination_10100() -- �������� ����� + ������ �����
                                                                           , zc_Enum_InfoMoneyDestination_30300() -- ������ + �����������
                                                                            )
                            UNION
                             SELECT View_InfoMoney.InfoMoneyDestinationId, View_InfoMoney.InfoMoneyId, FALSE AS isTare
                             FROM Object_InfoMoney_View AS View_InfoMoney
                             WHERE inIsGoodsComplete = FALSE
                               AND View_InfoMoney.InfoMoneyId IN (zc_Enum_InfoMoney_10204() -- �������� ����� + ������ �����
                                                                 )
                            UNION
                             SELECT View_InfoMoney.InfoMoneyDestinationId, View_InfoMoney.InfoMoneyId, CASE WHEN View_InfoMoney.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20500() THEN TRUE ELSE FALSE END AS isTare
                             FROM Object_InfoMoney_View AS View_InfoMoney
                             WHERE View_InfoMoney.InfoMoneyDestinationId IN (zc_Enum_InfoMoneyDestination_20500() -- ������������� + ��������� ����
                                                                           , zc_Enum_InfoMoneyDestination_20600() -- ������������� + ������ ���������
                                                                            )
                            )
      , tmpGoods_Return AS (SELECT tmp.GoodsId
                                 , MAX (tmp.GoodsKindId_max) AS GoodsKindId_max
                                 , MAX (tmp.WordList) AS WordList
                                 , MAX (tmp.GoodsKindName_list) AS GoodsKindName_list
                            FROM
                           (SELECT _tmpWord_Goods.GoodsId
                                 , _tmpWord_Goods.GoodsKindId_max
                                 , _tmpWord_Goods.WordList
                                 , STRING_AGG (Object.ValueData :: TVarChar, ',')  AS GoodsKindName_list
                            FROM _tmpWord_Goods
                                 LEFT JOIN zfSelect_Word_Split (inSep:= ',', inUserId:= vbUserId) AS zfSelect ON zfSelect.WordList = _tmpWord_Goods.WordList
                                 LEFT JOIN Object ON Object.Id = zfSelect.Word :: Integer
                            GROUP BY _tmpWord_Goods.GoodsId
                                   , _tmpWord_Goods.GoodsKindId_max
                                   , _tmpWord_Goods.WordList
                           ) AS tmp
                            GROUP BY tmp.GoodsId
                           )
    , tmpGoods_ScaleCeh AS (SELECT ObjectLink_GoodsByGoodsKind_Goods.ChildObjectId                                                 AS GoodsId
                                 , STRING_AGG (COALESCE (ObjectLink_GoodsByGoodsKind_GoodsKind.ChildObjectId, 0) :: TVarChar, ',') AS GoodsKindId_List
                                 , STRING_AGG (COALESCE (Object_GoodsKind.ValueData, '') ::TVarChar, ',')                          AS GoodsKindName_List
                                 , ABS (MIN (COALESCE (CASE WHEN ObjectLink_GoodsByGoodsKind_GoodsKind.ChildObjectId = zc_GoodsKind_Basis() THEN -1 ELSE 1 END * ObjectLink_GoodsByGoodsKind_GoodsKind.ChildObjectId, 0))) AS GoodsKindId_max
                            FROM ObjectBoolean AS ObjectBoolean_ScaleCeh
                                 INNER JOIN Object AS Object_GoodsByGoodsKind ON Object_GoodsByGoodsKind.Id = ObjectBoolean_ScaleCeh.ObjectId AND Object_GoodsByGoodsKind.isErased = FALSE
                                 LEFT JOIN ObjectLink AS ObjectLink_GoodsByGoodsKind_Goods
                                                      ON ObjectLink_GoodsByGoodsKind_Goods.ObjectId = ObjectBoolean_ScaleCeh.ObjectId
                                                     AND ObjectLink_GoodsByGoodsKind_Goods.DescId = zc_ObjectLink_GoodsByGoodsKind_Goods()
                                 LEFT JOIN ObjectLink AS ObjectLink_GoodsByGoodsKind_GoodsKind
                                                      ON ObjectLink_GoodsByGoodsKind_GoodsKind.ObjectId = ObjectBoolean_ScaleCeh.ObjectId
                                                     AND ObjectLink_GoodsByGoodsKind_GoodsKind.DescId = zc_ObjectLink_GoodsByGoodsKind_GoodsKind()
                                 LEFT JOIN Object AS Object_GoodsKind ON Object_GoodsKind.Id = ObjectLink_GoodsByGoodsKind_GoodsKind.ChildObjectId
                            WHERE ObjectBoolean_ScaleCeh.DescId    = zc_ObjectBoolean_GoodsByGoodsKind_ScaleCeh()
                              AND ObjectBoolean_ScaleCeh.ValueData = TRUE
                              AND inMovementId >= 0
                            GROUP BY ObjectLink_GoodsByGoodsKind_Goods.ChildObjectId
                           )
      , tmpGoods AS (SELECT Object_Goods.Id                               AS GoodsId
                          , Object_Goods.ObjectCode                       AS GoodsCode
                          , Object_Goods.ValueData                        AS GoodsName
                          , COALESCE (tmpGoods_ScaleCeh.GoodsKindId_list,   tmpGoods_Return.WordList)           AS GoodsKindId_list
                          , COALESCE (tmpGoods_ScaleCeh.GoodsKindName_list, tmpGoods_Return.GoodsKindName_list) AS GoodsKindName_list
                          , COALESCE (tmpGoods_ScaleCeh.GoodsKindId_max,    tmpGoods_Return.GoodsKindId_max)    AS GoodsKindId_max
                          , tmpInfoMoney.InfoMoneyId
                          , tmpInfoMoney.InfoMoneyDestinationId
                     FROM tmpInfoMoney
                          JOIN ObjectLink AS ObjectLink_Goods_InfoMoney
                                          ON ObjectLink_Goods_InfoMoney.ChildObjectId = tmpInfoMoney.InfoMoneyId
                                         AND ObjectLink_Goods_InfoMoney.DescId = zc_ObjectLink_Goods_InfoMoney()
                          JOIN Object AS Object_Goods ON Object_Goods.Id = ObjectLink_Goods_InfoMoney.ObjectId
                                                     AND Object_Goods.isErased = FALSE
                                                     AND Object_Goods.ObjectCode <> 0
                          LEFT JOIN tmpGoods_ScaleCeh ON tmpGoods_ScaleCeh.GoodsId = Object_Goods.Id
                          LEFT JOIN tmpGoods_Return ON tmpGoods_Return.GoodsId = Object_Goods.Id
                     WHERE tmpGoods_Return.GoodsId > 0 OR inMovementId >= 0 OR tmpInfoMoney.isTare = TRUE
                     
                    )
      , tmpPrice1 AS (SELECT tmpGoods.GoodsId
                           , COALESCE (ObjectHistoryFloat_PriceListItem_Value.ValueData, 0) AS Price
                      FROM tmpGoods
                            INNER JOIN ObjectLink AS ObjectLink_PriceListItem_Goods
                                                  ON ObjectLink_PriceListItem_Goods.ChildObjectId = tmpGoods.GoodsId
                                                 AND ObjectLink_PriceListItem_Goods.DescId = zc_ObjectLink_PriceListItem_Goods()
                            INNER JOIN ObjectLink AS ObjectLink_PriceListItem_PriceList
                                                  ON ObjectLink_PriceListItem_PriceList.ObjectId      = ObjectLink_PriceListItem_Goods.ObjectId
                                                 AND ObjectLink_PriceListItem_PriceList.ChildObjectId = zc_PriceList_Basis()
                                                 AND ObjectLink_PriceListItem_PriceList.DescId        = zc_ObjectLink_PriceListItem_PriceList()
                            LEFT JOIN ObjectHistory AS ObjectHistory_PriceListItem
                                                    ON ObjectHistory_PriceListItem.ObjectId = ObjectLink_PriceListItem_Goods.ObjectId
                                                   AND ObjectHistory_PriceListItem.DescId = zc_ObjectHistory_PriceListItem()
                                                   AND inOperDate >= ObjectHistory_PriceListItem.StartDate AND inOperDate < ObjectHistory_PriceListItem.EndDate
                            LEFT JOIN ObjectHistoryFloat AS ObjectHistoryFloat_PriceListItem_Value
                                                         ON ObjectHistoryFloat_PriceListItem_Value.ObjectHistoryId = ObjectHistory_PriceListItem.Id
                                                        AND ObjectHistoryFloat_PriceListItem_Value.DescId = zc_ObjectHistoryFloat_PriceListItem_Value()
                     )
      , tmpPrice2 AS (SELECT tmpGoods.GoodsId
                           , COALESCE (ObjectHistoryFloat_PriceListItem_Value.ValueData, 0) AS Price
                      FROM tmpGoods
                            INNER JOIN ObjectLink AS ObjectLink_PriceListItem_Goods
                                                  ON ObjectLink_PriceListItem_Goods.ChildObjectId = tmpGoods.GoodsId
                                                 AND ObjectLink_PriceListItem_Goods.DescId = zc_ObjectLink_PriceListItem_Goods()
                            INNER JOIN ObjectLink AS ObjectLink_PriceListItem_PriceList
                                                  ON ObjectLink_PriceListItem_PriceList.ObjectId      = ObjectLink_PriceListItem_Goods.ObjectId
                                                 AND ObjectLink_PriceListItem_PriceList.ChildObjectId = zc_PriceList_Basis()
                                                 AND ObjectLink_PriceListItem_PriceList.DescId        = zc_ObjectLink_PriceListItem_PriceList()
                            LEFT JOIN ObjectHistory AS ObjectHistory_PriceListItem
                                                    ON ObjectHistory_PriceListItem.ObjectId = ObjectLink_PriceListItem_Goods.ObjectId
                                                   AND ObjectHistory_PriceListItem.DescId = zc_ObjectHistory_PriceListItem()
                                                   AND (inOperDate - (inDayPrior_PriceReturn :: TVarChar || ' DAY') :: INTERVAL) >= ObjectHistory_PriceListItem.StartDate
                                                   AND (inOperDate - (inDayPrior_PriceReturn :: TVarChar || ' DAY') :: INTERVAL) < ObjectHistory_PriceListItem.EndDate
                            LEFT JOIN ObjectHistoryFloat AS ObjectHistoryFloat_PriceListItem_Value
                                                         ON ObjectHistoryFloat_PriceListItem_Value.ObjectHistoryId = ObjectHistory_PriceListItem.Id
                                                        AND ObjectHistoryFloat_PriceListItem_Value.DescId = zc_ObjectHistoryFloat_PriceListItem_Value()
                     )
       -- ���������
       SELECT ObjectString_Goods_GoodsGroupFull.ValueData AS GoodsGroupNameFull
            , tmpGoods.GoodsId            AS GoodsId
            , tmpGoods.GoodsCode          AS GoodsCode
            , tmpGoods.GoodsName          AS GoodsName
            , 0                           AS GoodsKindId
            , 0                           AS GoodsKindCode
            , tmpGoods.GoodsKindName_list :: TVarChar AS GoodsKindName
            , tmpGoods.GoodsKindId_list   :: TVarChar AS GoodsKindId_list
            , tmpGoods.GoodsKindId_max    :: Integer  AS GoodsKindId_max
            , Object_GoodsKind_max.ObjectCode         AS GoodsKindCode_max
            , Object_GoodsKind_max.ValueData          AS GoodsKindName_max
            , Object_Measure.Id           AS MeasureId
            , Object_Measure.ValueData    AS MeasureName
            , CASE WHEN tmpGoods.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30300() THEN 0 -- ������ + �����������
                   WHEN Object_Measure.Id = zc_Measure_Kg() THEN 1
                   ELSE 0
              END :: TFloat AS ChangePercentAmount
            , 0 :: TFloat AS Amount_Order
            , 0 :: TFloat AS Amount_OrderWeight
            , 0 :: TFloat AS Amount_Weighing
            , 0 :: TFloat AS Amount_WeighingWeight
            , 0 :: TFloat AS Amount_diff
            , 0 :: TFloat AS Amount_diffWeight
            , FALSE :: Boolean AS isTax_diff
            , lfObjectHistory_PriceListItem.Price        :: TFloat AS Price
            , lfObjectHistory_PriceListItem_Return.Price :: TFloat AS Price_Return
            , 1 :: TFloat                 AS CountForPrice
            , 1 :: TFloat                 AS CountForPrice_Return
            , 0                           AS Color_calc -- clBlack
            , 0                           AS MovementId_Promo
            , FALSE                       AS isPromo
            , FALSE                       AS isTare
       FROM tmpGoods

            LEFT JOIN ObjectString AS ObjectString_Goods_GoodsGroupFull
                                   ON ObjectString_Goods_GoodsGroupFull.ObjectId = tmpGoods.GoodsId
                                  AND ObjectString_Goods_GoodsGroupFull.DescId = zc_ObjectString_Goods_GroupNameFull()

            LEFT JOIN ObjectLink AS ObjectLink_Goods_Measure
                                 ON ObjectLink_Goods_Measure.ObjectId = tmpGoods.GoodsId
                                AND ObjectLink_Goods_Measure.DescId = zc_ObjectLink_Goods_Measure()
            LEFT JOIN Object AS Object_Measure ON Object_Measure.Id = ObjectLink_Goods_Measure.ChildObjectId
            LEFT JOIN Object AS Object_GoodsKind_max ON Object_GoodsKind_max.Id = tmpGoods.GoodsKindId_max :: Integer

            LEFT JOIN tmpPrice1 AS lfObjectHistory_PriceListItem ON lfObjectHistory_PriceListItem.GoodsId = tmpGoods.GoodsId
            LEFT JOIN tmpPrice2 AS lfObjectHistory_PriceListItem_Return ON lfObjectHistory_PriceListItem_Return.GoodsId = tmpGoods.GoodsId

       ORDER BY tmpGoods.GoodsName
              -- , ObjectString_Goods_GoodsGroupFull.ValueData
      ;
   END IF;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpSelect_Scale_Goods (Boolean, TDateTime, Integer, Integer, Integer, Integer, Integer, TVarChar) OWNER TO postgres;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 30.11.15                                        *
 18.01.15                                        *
*/

-- ����
-- SELECT * FROM gpSelect_Scale_Goods (inIsGoodsComplete:= TRUE, inOperDate:= '01.12.2016', inMovementId:= -79137, inOrderExternalId:= 0, inPriceListId:=0, inGoodsCode:= 0, inDayPrior_PriceReturn:= 10, inSession:=zfCalc_UserAdmin()) WHERE GoodsCode = 901