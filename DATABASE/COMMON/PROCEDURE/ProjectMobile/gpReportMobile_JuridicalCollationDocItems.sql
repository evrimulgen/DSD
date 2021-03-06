-- Function: gpReportMobile_JuridicalCollationDocItems

DROP FUNCTION IF EXISTS gpReportMobile_JuridicalCollationDocItems (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpReportMobile_JuridicalCollationDocItems (
    IN inMovementId Integer  , -- �� ���������
    IN inSession    TVarChar   -- ������ ������������
)
RETURNS TABLE (MovementId     Integer
             , MovementItemId Integer
             , GoodsId        Integer
             , GoodsCode      Integer
             , GoodsName      TVarChar
             , GoodsKindId    Integer
             , GoodsKindName  TVarChar
             , Price          TFloat
             , Amount         TFloat
             , isPromo        Boolean
              )
AS $BODY$
   DECLARE vbUserId Integer;
BEGIN
      -- �������� ���� ������������ �� ����� ���������
      -- vbUserId:= lpCheckRight (inSession, zc_Enum_Process_...());
      vbUserId:= lpGetUserBySession (inSession);

      -- ���������
      RETURN QUERY
        WITH -- ���������� ���� ��������� � ����������
             tmpMovement AS (SELECT Movement.Id
                                  , Movement.OperDate
                                  , CASE
                                         WHEN Movement.DescId = zc_Movement_Sale() THEN MovementLinkObject_To.ObjectId
                                         WHEN Movement.DescId = zc_Movement_ReturnIn() THEN MovementLinkObject_From.ObjectId
                                         ELSE 0::Integer
                                    END AS PartnerId
                             FROM Movement
                                  LEFT JOIN MovementLinkObject AS MovementLinkObject_From
                                                               ON MovementLinkObject_From.MovementId = Movement.Id
                                                              AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From() 
                                  LEFT JOIN MovementLinkObject AS MovementLinkObject_To
                                                               ON MovementLinkObject_To.MovementId = Movement.Id
                                                              AND MovementLinkObject_To.DescId = zc_MovementLinkObject_From() 
                             WHERE Movement.DescId IN (zc_Movement_ReturnIn(), zc_Movement_Sale())
                               AND Movement.Id = inMovementId
                            )
             -- ������ �� ���������� �����, ��� ��������� ��� ����������� 
           , tmpPromo AS (SELECT Movement_Promo.Id
                          FROM Movement AS Movement_PromoPartner
                               JOIN MovementItem AS MI_PromoPartner
                                                 ON MI_PromoPartner.MovementId = Movement_PromoPartner.Id
                                                AND MI_PromoPartner.DescId = zc_MI_Master()
                                                AND MI_PromoPartner.IsErased = FALSE
                               JOIN tmpMovement ON tmpMovement.PartnerId = MI_PromoPartner.ObjectId
                               JOIN Movement AS Movement_Promo 
                                             ON Movement_Promo.Id = Movement_PromoPartner.ParentId
                                            AND Movement_Promo.StatusId = zc_Enum_Status_Complete()
                               JOIN MovementDate AS MovementDate_StartSale
                                                 ON MovementDate_StartSale.MovementId = Movement_Promo.Id
                                                AND MovementDate_StartSale.DescId = zc_MovementDate_StartSale()
                                                AND MovementDate_StartSale.ValueData <= tmpMovement.OperDate
                               JOIN MovementDate AS MovementDate_EndSale
                                                 ON MovementDate_EndSale.MovementId = Movement_Promo.Id
                                                AND MovementDate_EndSale.DescId = zc_MovementDate_EndSale()
                                                AND MovementDate_EndSale.ValueData >= tmpMovement.OperDate
                          WHERE Movement_PromoPartner.DescId = zc_Movement_PromoPartner()
                            AND Movement_PromoPartner.StatusId <> zc_Enum_Status_Erased()
                         )
             -- ������ ��������� ������� �� ��������� ����������
           , tmpPromoGoods AS (SELECT DISTINCT MovementItem_PromoGoods.ObjectId AS GoodsId
                               FROM tmpPromo
                                    JOIN MovementItem AS MovementItem_PromoGoods 
                                                      ON MovementItem_PromoGoods.MovementId = tmpPromo.Id
                                                     AND MovementItem_PromoGoods.DescId = zc_MI_Master()
                                                     AND MovementItem_PromoGoods.IsErased = FALSE
                              )
        SELECT MovementItem.MovementId
             , MovementItem.Id                 AS MovementItemId
             , MovementItem.ObjectId           AS GoodsId
             , Object_Goods.ObjectCode         AS GoodsCode
             , Object_Goods.ValueData          AS GoodsName
             , COALESCE (MILinkObject_GoodsKind.ObjectId, 0)       AS GoodsKindId
             , COALESCE (Object_GoodsKind.ValueData, '')::TVarChar AS GoodsKindName
             , MIFloat_Price.ValueData         AS Price
             , MovementItem.Amount
             , (tmpPromoGoods.GoodsId IS NOT NULL)::Boolean AS isPromo
        FROM tmpMovement
             JOIN MovementItem ON MovementItem.MovementId = tmpMovement.Id
                              AND MovementItem.DescId = zc_MI_Master()
                              AND MovementItem.isErased = FALSE
             LEFT JOIN Object AS Object_Goods
                              ON Object_Goods.Id = MovementItem.ObjectId
                             AND Object_Goods.DescId = zc_Object_Goods() 
             LEFT JOIN MovementItemFloat AS MIFloat_Price
                                         ON MIFloat_Price.MovementItemId = MovementItem.Id
                                        AND MIFloat_Price.DescId = zc_MIFloat_Price()
             LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                              ON MILinkObject_GoodsKind.MovementItemId = MovementItem.Id
                                             AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
             LEFT JOIN Object AS Object_GoodsKind
                              ON Object_GoodsKind.Id = MILinkObject_GoodsKind.ObjectId
                             AND Object_GoodsKind.DescId = zc_Object_GoodsKind() 
             LEFT JOIN tmpPromoGoods ON tmpPromoGoods.GoodsId = MovementItem.ObjectId;

END; $BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ��������� �.�.   �������� �.�.
 04.09.17                                                                         *
*/

-- SELECT * FROM gpReportMobile_JuridicalCollationDocItems (inMovementId:= 5280790, inSession:= zfCalc_UserAdmin());
