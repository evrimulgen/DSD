-- Function: gpSelect_Movement_Inventory_Print()

DROP FUNCTION IF EXISTS gpSelect_Movement_Inventory_Print (Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Movement_Inventory_Print(
    IN inMovementId                 Integer  , -- ���� ���������
    IN inMovementId_Weighing        Integer  , -- ���� ��������� �����������
    IN inSession                    TVarChar    -- ������ ������������
)
RETURNS SETOF refcursor
AS
$BODY$
    DECLARE vbUserId Integer;

    DECLARE Cursor1 refcursor;
    DECLARE Cursor2 refcursor;

    DECLARE vbGoodsPropertyId Integer;
    DECLARE vbGoodsPropertyId_basis Integer;

    DECLARE vbDescId Integer;
    DECLARE vbStatusId Integer;
    DECLARE vbPriceWithVAT Boolean;
    DECLARE vbVATPercent TFloat;
    DECLARE vbDiscountPercent TFloat;
    DECLARE vbExtraChargesPercent TFloat;
    DECLARE vbPaidKindId Integer;
    DECLARE vbOperDate TDateTime;

    DECLARE vbStoreKeeperName TVarChar;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId:= lpCheckRight (inSession, zc_Enum_Process_...());
     vbUserId:= lpGetUserBySession (inSession);


     -- ��������� �� ���������
     SELECT Movement.DescId
          , Movement.StatusId
          , Movement.OperDate                  AS OperDate
       INTO vbDescId, vbStatusId, vbOperDate
     FROM Movement
     WHERE Movement.Id = inMovementId
    ;

     -- ��������� �� �����������
     vbStoreKeeperName:= (SELECT Object_User.ValueData
                          FROM Movement
                               LEFT JOIN MovementLinkObject AS MovementLinkObject_User
                                                            ON MovementLinkObject_User.MovementId = Movement.Id
                                                           AND MovementLinkObject_User.DescId = zc_MovementLinkObject_User()
                               LEFT JOIN Object AS Object_User ON Object_User.Id = MovementLinkObject_User.ObjectId
                          WHERE Movement.ParentId = inMovementId AND Movement.DescId IN (zc_Movement_WeighingPartner(), zc_Movement_WeighingProduction())
                            AND Movement.StatusId = zc_Enum_Status_Complete()
                          LIMIT 1
                         );


    -- ����� ������ ��������
    IF COALESCE (vbStatusId, 0) = zc_Enum_Status_Erased()
    THEN
        IF vbStatusId = zc_Enum_Status_Erased()
        THEN
            RAISE EXCEPTION '������.�������� <%> � <%> �� <%> ������.', (SELECT ItemName FROM MovementDesc WHERE Id = vbDescId), (SELECT InvNumber FROM Movement WHERE Id = inMovementId), (SELECT DATE (OperDate) FROM Movement WHERE Id = inMovementId);
        END IF;
        IF vbStatusId = zc_Enum_Status_UnComplete()
        THEN
            RAISE EXCEPTION '������.�������� <%> � <%> �� <%> �� ��������.', (SELECT ItemName FROM MovementDesc WHERE Id = vbDescId), (SELECT InvNumber FROM Movement WHERE Id = inMovementId), (SELECT DATE (OperDate) FROM Movement WHERE Id = inMovementId);
        END IF;
        -- ��� ��� �������� ������
        RAISE EXCEPTION '������.�������� <%>.', (SELECT ItemName FROM MovementDesc WHERE Id = vbDescId);
    END IF;



     --
    OPEN Cursor1 FOR
        WITH tmpMovementWeighing AS (SELECT Movement.Id AS MovementId FROM Movement WHERE Movement.ParentId = inMovementId AND Movement.StatusId = zc_Enum_Status_Complete()) 
        SELECT
           Movement.InvNumber             AS InvNumber
         , Movement.OperDate              AS OperDate

         , Object_From.ValueData          AS FromName
         , Object_To.ValueData            AS ToName

         , tmpCount.Count :: TFloat        AS TotalNumber
         , MFloat_WeighingNumber.ValueData AS WeighingNumber

         , vbStoreKeeperName AS StoreKeeper -- ���������
     FROM Movement 
          LEFT JOIN (SELECT COUNT(*) AS Count from tmpMovementWeighing) AS tmpCount ON 1 = 1

          LEFT JOIN MovementFloat AS MFloat_WeighingNumber
                                  ON MFloat_WeighingNumber.MovementId = inMovementId_Weighing
                                 AND MFloat_WeighingNumber.DescId = zc_MovementFloat_WeighingNumber()

          LEFT JOIN MovementLinkObject AS MovementLinkObject_From
                                       ON MovementLinkObject_From.MovementId = Movement.Id
                                      AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
          LEFT JOIN Object AS Object_From ON Object_From.Id = MovementLinkObject_From.ObjectId

          LEFT JOIN MovementLinkObject AS MovementLinkObject_To
                                       ON MovementLinkObject_To.MovementId = Movement.Id
                                      AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
          LEFT JOIN Object AS Object_To ON Object_To.Id = MovementLinkObject_To.ObjectId

     WHERE Movement.Id = inMovementId
       AND Movement.StatusId <> zc_Enum_Status_Erased()
    ;
    RETURN NEXT Cursor1;


     OPEN Cursor2 FOR
     WITH tmpWeighing AS (SELECT MovementItem.ObjectId                                     AS GoodsId
                               , COALESCE (MILinkObject_GoodsKind.ObjectId, 0)             AS GoodsKindId
                               , COALESCE (MIString_PartionGoods.ValueData, '')            AS PartionGoods
                               , COALESCE (MIDate_PartionGoods.ValueData, zc_DateStart())  AS PartionGoodsDate
                               , SUM (MovementItem.Amount)                                 AS Amount
                          FROM (SELECT Movement.Id AS MovementId
                                FROM Movement
                                WHERE Movement.ParentId = inMovementId
                                  AND (Movement.Id = inMovementId_Weighing OR COALESCE (inMovementId_Weighing, 0) = 0)
                                  AND Movement.StatusId = zc_Enum_Status_Complete()
                                ) AS tmp
                                INNER JOIN MovementItem ON MovementItem.MovementId = tmp.MovementId
                                                       AND MovementItem.DescId     = zc_MI_Master()
                                                       AND MovementItem.isErased   = FALSE
                                LEFT JOIN MovementItemDate AS MIDate_PartionGoods
                                                           ON MIDate_PartionGoods.MovementItemId =  MovementItem.Id
                                                          AND MIDate_PartionGoods.DescId = zc_MIDate_PartionGoods()
                                LEFT JOIN MovementItemString AS MIString_PartionGoods
                                                             ON MIString_PartionGoods.MovementItemId =  MovementItem.Id
                                                            AND MIString_PartionGoods.DescId = zc_MIString_PartionGoods()
                                LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                                                 ON MILinkObject_GoodsKind.MovementItemId = MovementItem.Id
                                                                AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
                          GROUP BY MovementItem.ObjectId
                                 , COALESCE (MILinkObject_GoodsKind.ObjectId, 0)
                                 , COALESCE (MIString_PartionGoods.ValueData, '')
                                 , COALESCE (MIDate_PartionGoods.ValueData, zc_DateStart())
                         )
              , tmpMI AS (SELECT MovementItem.ObjectId                                     AS GoodsId
                               , COALESCE (MILinkObject_GoodsKind.ObjectId, 0)             AS GoodsKindId
                               , COALESCE (MIString_PartionGoods.ValueData, '')            AS PartionGoods
                               , COALESCE (MIDate_PartionGoods.ValueData, zc_DateStart())  AS PartionGoodsDate
                               , SUM (MovementItem.Amount)                                 AS Amount
                           FROM MovementItem
                                LEFT JOIN MovementItemDate AS MIDate_PartionGoods
                                                           ON MIDate_PartionGoods.MovementItemId =  MovementItem.Id
                                                          AND MIDate_PartionGoods.DescId = zc_MIDate_PartionGoods()
                                LEFT JOIN MovementItemString AS MIString_PartionGoods
                                                             ON MIString_PartionGoods.MovementItemId =  MovementItem.Id
                                                            AND MIString_PartionGoods.DescId = zc_MIString_PartionGoods()
                                LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                                                 ON MILinkObject_GoodsKind.MovementItemId = MovementItem.Id
                                                                AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
                          WHERE MovementItem.MovementId = inMovementId
                            AND MovementItem.DescId     = zc_MI_Master()
                            AND MovementItem.isErased   = FALSE
                            AND MovementItem.Amount <> 0
                          GROUP BY MovementItem.ObjectId
                                 , COALESCE (MILinkObject_GoodsKind.ObjectId, 0)
                                 , COALESCE (MIString_PartionGoods.ValueData, '')
                                 , COALESCE (MIDate_PartionGoods.ValueData, zc_DateStart())
                         )
          , tmpResult AS (SELECT COALESCE (tmpWeighing.GoodsId, tmpMI.GoodsId)                   AS GoodsId
                               , COALESCE (tmpWeighing.GoodsKindId, tmpMI.GoodsKindId)           AS GoodsKindId
                               , COALESCE (tmpWeighing.PartionGoods, tmpMI.PartionGoods)         AS PartionGoods
                               , COALESCE (tmpWeighing.PartionGoodsDate, tmpMI.PartionGoodsDate) AS PartionGoodsDate
                               , COALESCE (tmpWeighing.Amount, 0)                                AS Amount_Weighing
                               , COALESCE (tmpMI.Amount, 0)                                      AS Amount
                           FROM tmpWeighing
                                FULL JOIN tmpMI ON tmpMI.GoodsId          =  tmpWeighing.GoodsId
                                               AND tmpMI.GoodsKindId      =  tmpWeighing.GoodsKindId
                                               AND tmpMI.PartionGoods     =  tmpWeighing.PartionGoods
                                               AND tmpMI.PartionGoodsDate =  tmpWeighing.PartionGoodsDate
                         )

       SELECT Object_Goods.ObjectCode  			  AS GoodsCode
            , Object_Goods.ValueData   			  AS GoodsName
            , Object_GoodsKind.ValueData                  AS GoodsKindName
            , Object_GoodsGroup.ValueData   		  AS GoodsGroupName
            , ObjectString_Goods_GoodsGroupFull.ValueData AS GoodsGroupNameFull
            , Object_Measure.ValueData                    AS MeasureName

            , CASE WHEN Object_Measure.Id = zc_Measure_Sh() THEN tmpResult.Amount ELSE 0 END                                :: TFloat AS Amount_Sh
            , tmpResult.Amount * CASE WHEN Object_Measure.Id = zc_Measure_Sh() THEN ObjectFloat_Weight.ValueData ELSE 1 END :: TFloat AS Amount_Weight

            , CASE WHEN Object_Measure.Id = zc_Measure_Sh() THEN tmpResult.Amount_Weighing ELSE 0 END                                :: TFloat AS Amount_Weighing_Sh
            , tmpResult.Amount_Weighing * CASE WHEN Object_Measure.Id = zc_Measure_Sh() THEN ObjectFloat_Weight.ValueData ELSE 1 END :: TFloat AS Amount_Weighing_Weight

            , CASE WHEN tmpResult.PartionGoods <> '' THEN tmpResult.PartionGoods WHEN tmpResult.PartionGoodsDate <> zc_DateStart() THEN TO_CHAR (tmpResult.PartionGoodsDate, 'DD.MM.YYYY') ELSE '' END :: TVarChar AS PartionGoods

       FROM tmpResult
                      
            LEFT JOIN Object AS Object_Goods ON Object_Goods.Id = tmpResult.GoodsId

            LEFT JOIN ObjectString AS ObjectString_Goods_GoodsGroupFull
                                   ON ObjectString_Goods_GoodsGroupFull.ObjectId = tmpResult.GoodsId
                                  AND ObjectString_Goods_GoodsGroupFull.DescId = zc_ObjectString_Goods_GroupNameFull()

            LEFT JOIN ObjectLink AS ObjectLink_Goods_Measure
                                 ON ObjectLink_Goods_Measure.ObjectId = tmpResult.GoodsId
                                AND ObjectLink_Goods_Measure.DescId = zc_ObjectLink_Goods_Measure()
            LEFT JOIN Object AS Object_Measure ON Object_Measure.Id = ObjectLink_Goods_Measure.ChildObjectId
     
            LEFT JOIN ObjectFloat AS ObjectFloat_Weight	
                                  ON ObjectFloat_Weight.ObjectId = tmpResult.GoodsId
                                 AND ObjectFloat_Weight.DescId = zc_ObjectFloat_Goods_Weight()

            LEFT JOIN Object AS Object_GoodsKind ON Object_GoodsKind.Id = tmpResult.GoodsKindId

            LEFT JOIN ObjectLink AS ObjectLink_Goods_GoodsGroup
                                 ON ObjectLink_Goods_GoodsGroup.ObjectId = tmpResult.GoodsId
                                AND ObjectLink_Goods_GoodsGroup.DescId = zc_ObjectLink_Goods_GoodsGroup()
            LEFT JOIN Object AS Object_GoodsGroup ON Object_GoodsGroup.Id = ObjectLink_Goods_GoodsGroup.ChildObjectId
      ;
      

    RETURN NEXT Cursor2;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpSelect_Movement_Inventory_Print (Integer,Integer, TVarChar) OWNER TO postgres;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 10.07.15                                        * ALL
 04.07.15         *
*/

-- ����
-- SELECT * FROM gpSelect_Movement_Inventory_Print (inMovementId := 597300, inMovementId_Weighing:= 0, inSession:= zfCalc_UserAdmin());