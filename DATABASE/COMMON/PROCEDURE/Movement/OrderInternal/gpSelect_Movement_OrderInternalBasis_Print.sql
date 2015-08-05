-- Function: gpSelect_Movement_OrderInternalBasis_Print()

DROP FUNCTION IF EXISTS gpSelect_Movement_OrderInternalBasis_Print (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Movement_OrderInternalBasis_Print(
    IN inMovementId        Integer  , -- ���� ���������
    IN inSession       TVarChar    -- ������ ������������
)
RETURNS SETOF refcursor
AS
$BODY$
    DECLARE vbUserId Integer;

    DECLARE Cursor1 refcursor;
    DECLARE Cursor2 refcursor;

    DECLARE vbDescId Integer;
    DECLARE vbStatusId Integer;
    DECLARE vbOperDate TDateTime;
    DECLARE vbFromId Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId:= lpCheckRight (inSession, zc_Enum_Process_Select_Movement_OrderInternal());
     vbUserId:= lpGetUserBySession (inSession);


     -- ��������� �� ���������
     SELECT Movement.DescId
          , Movement.StatusId
          , Movement.OperDate
          , MovementLinkObject_From.ObjectId
            INTO vbDescId, vbStatusId, vbOperDate, vbFromId
     FROM Movement
          LEFT JOIN MovementLinkObject AS MovementLinkObject_From
                                       ON MovementLinkObject_From.MovementId = Movement.Id
                                      AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
     WHERE Movement.Id = inMovementId;


     -- ����� ������ ��������
     IF COALESCE (vbStatusId, 0) <> zc_Enum_Status_Complete()
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
      SELECT Movement.Id                                AS Id
           , Movement.InvNumber                         AS InvNumber
           , Movement.OperDate                          AS OperDate
           , MovementDate_OperDatePartner.ValueData     AS OperDatePartner
           , Object_From.ValueData                      AS FromName
           , Object_To.ValueData               		AS ToName
       FROM Movement
            LEFT JOIN MovementDate AS MovementDate_OperDatePartner
                                   ON MovementDate_OperDatePartner.MovementId =  Movement.Id
                                  AND MovementDate_OperDatePartner.DescId = zc_MovementDate_OperDatePartner()
            LEFT JOIN MovementLinkObject AS MovementLinkObject_From
                                         ON MovementLinkObject_From.MovementId = Movement.Id
                                        AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
            LEFT JOIN Object AS Object_From ON Object_From.Id = MovementLinkObject_From.ObjectId
            LEFT JOIN MovementLinkObject AS MovementLinkObject_To
                                         ON MovementLinkObject_To.MovementId = Movement.Id
                                        AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
            LEFT JOIN Object AS Object_To ON Object_To.Id = MovementLinkObject_To.ObjectId
       WHERE Movement.Id =  inMovementId
         AND Movement.StatusId = zc_Enum_Status_Complete()
      ;
    RETURN NEXT Cursor1;


    OPEN Cursor2 FOR
       WITH tmpUnit AS (SELECT UnitId FROM lfSelect_Object_Unit_byGroup (vbFromId) AS lfSelect_Object_Unit_byGroup)
          , tmpMI_Send AS (-- ������������ �����������
                           SELECT tmpMI.GoodsId                          AS GoodsId
                                , SUM (tmpMI.Amount)                     AS Amount
                           FROM (SELECT MIContainer.ObjectId_Analyzer AS GoodsId
                                      , SUM (MIContainer.Amount) AS Amount
                                 FROM MovementItemContainer AS MIContainer
                                      INNER JOIN tmpUnit ON tmpUnit.UnitId = MIContainer.WhereObjectId_Analyzer
                                 WHERE MIContainer.OperDate   = vbOperDate
                                   AND MIContainer.DescId     = zc_MIContainer_Count()
                                   AND MIContainer.MovementDescId = zc_Movement_Send()
                                   AND MIContainer.isActive = TRUE
                                 GROUP BY MIContainer.ObjectId_Analyzer
                                ) AS tmpMI
                            GROUP BY tmpMI.GoodsId
                          )
       SELECT
             Object_Unit.ObjectCode          AS UnitCode
           , Object_Unit.ValueData           AS UnitName 

           , ObjectString_Goods_GoodsGroupFull.ValueData AS GoodsGroupNameFull
           , Object_GoodsGroup.ValueData     AS GoodsGroupName
           , Object_Goods.ObjectCode  	     AS GoodsCode
           , Object_Goods.ValueData          AS GoodsName
           , Object_GoodsKind.ValueData      AS GoodsKindName
           , Object_Measure.ValueData        AS MeasureName

           , CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN tmpMI.Amount             ELSE 0 END AS Amount_sh
           , CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN tmpMI.AmountSecond       ELSE 0 END AS AmountSecond_sh
           , CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN tmpMI.AmountSend         ELSE 0 END AS AmountSend_sh
           , CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN tmpMI.AmountPartner      ELSE 0 END AS AmountPartner_sh
           , CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN tmpMI.AmountPartnerPrior ELSE 0 END AS AmountPartnerPrior_sh
           , CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN tmpMI.AmountSend         ELSE 0 END AS Amount_sh_calc

           , tmpMI.Amount             * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN COALESCE (ObjectFloat_Weight.ValueData, 0) ELSE 1 END AS Amount
           , tmpMI.AmountSecond       * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN COALESCE (ObjectFloat_Weight.ValueData, 0) ELSE 1 END AS AmountSecond
           , tmpMI.AmountSend         * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN COALESCE (ObjectFloat_Weight.ValueData, 0) ELSE 1 END AS AmountSend
           , tmpMI.AmountPartner      * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN COALESCE (ObjectFloat_Weight.ValueData, 0) ELSE 1 END AS AmountPartner
           , tmpMI.AmountPartnerPrior * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN COALESCE (ObjectFloat_Weight.ValueData, 0) ELSE 1 END AS AmountPartnerPrior
           , tmpMI.Amount_calc        * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN COALESCE (ObjectFloat_Weight.ValueData, 0) ELSE 1 END AS Amount_calc

       FROM (SELECT tmpMI.GoodsId
                  , tmpMI.GoodsKindId
                  , MAX (tmpMI.ReceiptId)     AS ReceiptId
                  , SUM (tmpMI.Amount)        AS Amount
                  , SUM (tmpMI.AmountSecond)  AS AmountSecond
                  , SUM (tmpMI.AmountPartner) AS AmountPartner
                  , SUM (tmpMI.AmountPartnerPrior) AS AmountPartnerPrior
                  , SUM (tmpMI.AmountSend)    AS AmountSend
                  , SUM (CASE WHEN tmpMI.AmountRemains < tmpMI.AmountPartner THEN tmpMI.AmountPartner - tmpMI.AmountRemains ELSE 0 END) AS Amount_calc -- ��������� �����
             FROM (-- ������ �����
                   SELECT MovementItem.ObjectId                                  AS GoodsId
                        , COALESCE (MILinkObject_GoodsKind.ObjectId, 0)          AS GoodsKindId
                        , MAX (COALESCE (MILinkObject_Receipt.ObjectId, 0))      AS ReceiptId
                        , SUM (MovementItem.Amount)                              AS Amount
                        , SUM (COALESCE (MIFloat_AmountSecond.ValueData, 0))     AS AmountSecond
                        , SUM (COALESCE (MIFloat_AmountRemains.ValueData, 0))    AS AmountRemains
                        , SUM (COALESCE (MIFloat_AmountPartner.ValueData, 0))    AS AmountPartner
                        , SUM (COALESCE (MIFloat_AmountPartnerPrior.ValueData, 0)) AS AmountPartnerPrior
                        , 0                                                      AS AmountSend
                   FROM MovementItem
                        LEFT JOIN MovementItemLinkObject AS MILinkObject_Receipt
                                                         ON MILinkObject_Receipt.MovementItemId = MovementItem.Id
                                                        AND MILinkObject_Receipt.DescId = zc_MILinkObject_Receipt()
                        LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                                         ON MILinkObject_GoodsKind.MovementItemId = MovementItem.Id
                                                        AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
                        LEFT JOIN MovementItemFloat AS MIFloat_AmountSecond
                                                    ON MIFloat_AmountSecond.MovementItemId = MovementItem.Id
                                                   AND MIFloat_AmountSecond.DescId = zc_MIFloat_AmountSecond()
                        LEFT JOIN MovementItemFloat AS MIFloat_AmountRemains
                                                    ON MIFloat_AmountRemains.MovementItemId = MovementItem.Id
                                             AND MIFloat_AmountRemains.DescId = zc_MIFloat_AmountRemains()
                        LEFT JOIN MovementItemFloat AS MIFloat_AmountPartner
                                                    ON MIFloat_AmountPartner.MovementItemId = MovementItem.Id
                                                   AND MIFloat_AmountPartner.DescId = zc_MIFloat_AmountPartner()
                        LEFT JOIN MovementItemFloat AS MIFloat_AmountPartnerPrior
                                                    ON MIFloat_AmountPartnerPrior.MovementItemId = MovementItem.Id
                                                   AND MIFloat_AmountPartnerPrior.DescId = zc_MIFloat_AmountPartnerPrior()
                   WHERE MovementItem.MovementId = inMovementId
                     AND MovementItem.DescId     = zc_MI_Master()
                     AND MovementItem.isErased   = FALSE
                   GROUP BY MovementItem.ObjectId
                          , MILinkObject_GoodsKind.ObjectId
                  UNION ALL
                   -- �����������
                   SELECT tmpMI_Send.GoodsId
                        , 0 AS GoodsKindId
                        , 0 AS ReceiptId
                        , 0 AS Amount
                        , 0 AS AmountSecond
                        , 0 AS AmountRemains
                        , 0 AS AmountPartner
                        , 0 AS AmountPartnerPrior
                        , (tmpMI_Send.Amount) AS AmountSend
                   FROM tmpMI_Send
                  ) AS tmpMI
             WHERE tmpMI.GoodsId <> zc_Goods_WorkIce()
             GROUP BY tmpMI.GoodsId
                    , tmpMI.GoodsKindId
            ) AS tmpMI

            LEFT JOIN ObjectLink AS ObjectLink_Goods_InfoMoney
                                 ON ObjectLink_Goods_InfoMoney.ObjectId = tmpMI.GoodsId
                                AND ObjectLink_Goods_InfoMoney.DescId = zc_ObjectLink_Goods_InfoMoney()
            LEFT JOIN Object_InfoMoney_View ON Object_InfoMoney_View.InfoMoneyId = ObjectLink_Goods_InfoMoney.ChildObjectId

            LEFT JOIN Object AS Object_Unit ON Object_Unit.Id = CASE WHEN tmpMI.ReceiptId > 0
                                                                          THEN vbFromId
                                                                     WHEN Object_InfoMoney_View.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10200() -- �������� ����� + ������ �����
                                                                          THEN 8455 -- ����� ������
                                                                     ELSE 8439 -- ������� ������� �����
                                                                END

            LEFT JOIN Object AS Object_Goods ON Object_Goods.Id = tmpMI.GoodsId
            LEFT JOIN Object AS Object_GoodsKind ON Object_GoodsKind.Id = tmpMI.GoodsKindId

            LEFT JOIN ObjectLink AS ObjectLink_Goods_Measure
                                 ON ObjectLink_Goods_Measure.ObjectId = Object_Goods.Id
                                AND ObjectLink_Goods_Measure.DescId = zc_ObjectLink_Goods_Measure()
            LEFT JOIN Object AS Object_Measure ON Object_Measure.Id = ObjectLink_Goods_Measure.ChildObjectId

            LEFT JOIN ObjectFloat AS ObjectFloat_Weight
                                  ON ObjectFloat_Weight.ObjectId = tmpMI.GoodsId
                                 AND ObjectFloat_Weight.DescId = zc_ObjectFloat_Goods_Weight()
            LEFT JOIN ObjectString AS ObjectString_Goods_GoodsGroupFull
                                   ON ObjectString_Goods_GoodsGroupFull.ObjectId = tmpMI.GoodsId
                                  AND ObjectString_Goods_GoodsGroupFull.DescId = zc_ObjectString_Goods_GroupNameFull()

            LEFT JOIN ObjectLink AS ObjectLink_Goods_GoodsGroup
                                 ON ObjectLink_Goods_GoodsGroup.ObjectId = tmpMI.GoodsId
                                AND ObjectLink_Goods_GoodsGroup.DescId = zc_ObjectLink_Goods_GoodsGroup()
            LEFT JOIN Object AS Object_GoodsGroup ON Object_GoodsGroup.Id = ObjectLink_Goods_GoodsGroup.ChildObjectId


       WHERE tmpMI.Amount <> 0 OR tmpMI.AmountSecond <> 0 OR tmpMI.AmountSend <> 0 OR tmpMI.AmountPartner <> 0 OR tmpMI.AmountPartnerPrior <> 0 -- OR tmpMI.Amount_calc <> 0
       ;
    RETURN NEXT Cursor2;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpSelect_Movement_OrderInternalBasis_Print (Integer, TVarChar) OWNER TO postgres;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 27.06.15                                        *
*/

-- ����
-- SELECT * FROM gpSelect_Movement_OrderInternalBasis_Print (inMovementId := 388160, inSession:= zfCalc_UserAdmin())