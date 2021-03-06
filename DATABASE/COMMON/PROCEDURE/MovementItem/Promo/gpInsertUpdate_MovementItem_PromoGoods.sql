-- Function: gpInsertUpdate_MovementItem_PromoGoods()

DROP FUNCTION IF EXISTS gpInsertUpdate_MovementItem_PromoGoods (Integer, Integer, Integer, TFloat, TFloat, TFloat, TFloat, TFloat, TFloat, TVarChar);
DROP FUNCTION IF EXISTS gpInsertUpdate_MovementItem_PromoGoods (Integer, Integer, Integer, TFloat, TFloat, TFloat, TFloat, TFloat, Integer, TVarChar);
DROP FUNCTION IF EXISTS gpInsertUpdate_MovementItem_PromoGoods (Integer, Integer, Integer, TFloat, TFloat, TFloat, TFloat, TFloat, Integer, TVarChar, TVarChar);
DROP FUNCTION IF EXISTS gpInsertUpdate_MovementItem_PromoGoods (Integer, Integer, Integer, TFloat, TFloat, TFloat, TFloat, TFloat, TFloat, Integer, TVarChar, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_MovementItem_PromoGoods(
 INOUT ioId                  Integer   , -- ���� ������� <������� ���������>
    IN inMovementId          Integer   , -- ���� ������� <��������>
    IN inGoodsId             Integer   , -- ������
    IN inAmount              TFloat    , -- % ������ �� �����
 INOUT ioPrice               TFloat    , --���� � ������
    IN inPriceSale           TFloat    , --���� �� �����
   OUT outPriceWithOutVAT    TFloat    , --���� �������� ��� ����� ���, � ������ ������, ���
   OUT outPriceWithVAT       TFloat    , --���� �������� � ������ ���, � ������ ������, ���
    IN inAmountReal          TFloat    , --����� ������ � ����������� ������, ��
   OUT outAmountRealWeight   TFloat    , --����� ������ � ����������� ������, �� ���
    IN inAmountPlanMin       TFloat    , --������� ������������ ������ ������ �� ��������� ������ (� ��)
   OUT outAmountPlanMinWeight TFloat   , --������� ������������ ������ ������ �� ��������� ������ (� ��) ���
    IN inAmountPlanMax       TFloat    , --�������� ������������ ������ ������ �� ��������� ������ (� ��)
   OUT outAmountPlanMaxWeight TFloat   , --�������� ������������ ������ ������ �� ��������� ������ (� ��) ���
    IN inGoodsKindId         Integer   , --�� ������� <��� ������>
    IN inComment             TVarChar  , --�����������
    IN inSession             TVarChar    -- ������ ������������
)
AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbIsInsert Boolean;
   DECLARE vbPriceList Integer;
   DECLARE vbPriceWithWAT Boolean;
   DECLARE vbVAT TFloat;
BEGIN
    -- �������� ���� ������������ �� ����� ���������
    vbUserId := CASE WHEN inSession = '-12345' THEN inSession :: Integer ELSE lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_MI_Promo()) END;


    -- ��������� ������������ �����/��� ������
    IF EXISTS (SELECT 1 
               FROM MovementItem_PromoGoods_View AS MI_PromoGoods
               WHERE MI_PromoGoods.MovementId                  = inMovementId
                   AND MI_PromoGoods.GoodsId                   = inGoodsId
                   AND COALESCE (MI_PromoGoods.GoodsKindId, 0) = COALESCE (inGoodsKindId, 0)
                   AND MI_PromoGoods.Id                        <> COALESCE(ioId, 0)
                   AND MI_PromoGoods.isErased                  = FALSE
              )
    THEN
        RAISE EXCEPTION '������. � ��������� ��� ������� ������ ��� ������ = <%> � ��� = <%>.', lfGet_Object_ValueData (inGoodsId), lfGet_Object_ValueData (inGoodsKindId);
    END IF;
    
    -- ����� �����-����
    SELECT COALESCE (Movement_Promo.PriceListId, zc_PriceList_Basis())
           INTO vbPriceList
    FROM Movement_Promo_View AS Movement_Promo
    WHERE Movement_Promo.Id = inMovementId;

    -- ��������� ������ �����-���� "� ���" � "�������� ���"
    SELECT PriceList.PriceWithVAT, PriceList.VATPercent
           INTO vbPriceWithWAT, vbVAT
    FROM gpGet_Object_PriceList(vbPriceList,inSession) AS PriceList;
    
    -- ����� ���� �� �������� ������
    IF COALESCE (ioPrice,0) = 0
    THEN
        SELECT Price.ValuePrice
               INTO ioPrice
        FROM lfSelect_ObjectHistory_PriceListItem (inPriceListId:= vbPriceList
                                                 , inOperDate   := (SELECT OperDate FROM Movement WHERE Id = inMovementId)
                                                  ) AS Price
        WHERE Price.GoodsId = inGoodsId;
    
        -- ���� ���������� - �������� ���� � ���� � ���
        IF vbPriceWithWAT = TRUE
        THEN
            ioPrice := ROUND (ioPrice / (vbVAT / 100.0 + 1), 2);
        END IF;
    END IF;
    
    -- ��������� <���� �������� ��� ����� ���, � ������ ������, ���>
    outPriceWithOutVAT := ROUND(ioPrice - COALESCE(ioPrice * inAmount/100.0),2);
    -- ��������� <���� �������� � ������ ���, � ������ ������, ���>
    outPriceWithVAT := ROUND(outPriceWithOutVAT * ((vbVAT/100.0)+1),2);
    
    -- ��������� ������� ����������
    SELECT inAmountPlanMin * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN ObjectFloat_Goods_Weight.ValueData ELSE 1 END
         , inAmountPlanMax * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN ObjectFloat_Goods_Weight.ValueData ELSE 1 END
         , inAmountReal    * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN ObjectFloat_Goods_Weight.ValueData ELSE 1 END
           INTO outAmountPlanMinWeight
              , outAmountPlanMaxWeight
              , outAmountRealWeight
    FROM ObjectLink AS ObjectLink_Goods_Measure
         LEFT OUTER JOIN ObjectFloat AS ObjectFloat_Goods_Weight
                                     ON ObjectFloat_Goods_Weight.ObjectId = ObjectLink_Goods_Measure.ObjectId
                                    AND ObjectFloat_Goods_Weight.DescId = zc_ObjectFloat_Goods_Weight()
    WHERE ObjectLink_Goods_Measure.ObjectId = inGoodsId
      AND ObjectLink_Goods_Measure.DescId = zc_ObjectLink_Goods_Measure();
    
    
    -- ���������
    ioId := lpInsertUpdate_MovementItem_PromoGoods (ioId                 := ioId
                                            , inMovementId         := inMovementId
                                            , inGoodsId            := inGoodsId
                                            , inAmount             := inAmount
                                            , inPrice              := ioPrice
                                            , inPriceSale          := inPriceSale
                                            , inPriceWithOutVAT    := outPriceWithOutVAT
                                            , inPriceWithVAT       := outPriceWithVAT
                                            , inAmountReal         := inAmountReal
                                            , inAmountPlanMin      := inAmountPlanMin
                                            , inAmountPlanMax      := inAmountPlanMax
                                            , inGoodsKindId        := inGoodsKindId
                                            , inComment            := inComment
                                            , inUserId             := vbUserId
                                             );

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpInsertUpdate_MovementItem_PromoGoods (Integer, Integer, Integer, TFloat, TFloat, TFloat, TFloat, TFloat, TFloat, Integer, TVarChar, TVarChar) OWNER TO postgres;
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.    ��������� �.�.
 25.11.15                                                                         * Comment
 13.10.15                                                                         *
*/