-- Function: gpInsert_Scale_MI()

DROP FUNCTION IF EXISTS gpInsert_Scale_MI (Integer, Integer, Integer, Integer, TFloat, TFloat, TFloat, TFloat, Integer, TVarChar);
DROP FUNCTION IF EXISTS gpInsert_Scale_MI (Integer, Integer, Integer, Integer, TFloat, TFloat, TFloat, TFloat, Integer, Integer, TVarChar);
DROP FUNCTION IF EXISTS gpInsert_Scale_MI (Integer, Integer, Integer, Integer, TFloat, TFloat, TFloat, TFloat, TFloat, TFloat, Integer, Integer, TVarChar);
DROP FUNCTION IF EXISTS gpInsert_Scale_MI (Integer, Integer, Integer, Integer, TFloat, TFloat, TFloat, TFloat, TFloat, TFloat, TFloat, TFloat, Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpInsert_Scale_MI(
    IN inId                    Integer   , -- ���� ������� <������� ���������>
    IN inMovementId            Integer   , -- ���� ������� <��������>
    IN inGoodsId               Integer   , -- ������
    IN inGoodsKindId           Integer   , -- ���� �������
    IN inRealWeight            TFloat    , -- �������� ��� (��� ����� % ������ ��� ���-��)
    IN inChangePercentAmount   TFloat    , -- % ������ ��� ���-��
    IN inCountTare             TFloat    , -- ���������� ����
    IN inWeightTare            TFloat    , -- ��� 1-�� ����
    IN inPrice                 TFloat    , -- ����
    IN inPrice_Return          TFloat    , -- ����
    IN inCountForPrice         TFloat    , -- ���� �� ����������
    IN inCountForPrice_Return  TFloat    , -- ���� �� ����������
    IN inDayPrior_PriceReturn  Integer,
    IN inPriceListId           Integer   , -- 
    IN inSession               TVarChar    -- ������ ������������
)                              
RETURNS TABLE (Id        Integer
             , TotalSumm TFloat
              )
AS
$BODY$
   DECLARE vbUserId Integer;

   DECLARE vbId Integer;
   DECLARE vbMovementDescId Integer;
   DECLARE vbOperDate TDateTime;
   DECLARE vbTotalSumm TFloat;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId := lpCheckRight (inSession, zc_Enum_Process_Insert_Scale_MI());
     vbUserId:= lpGetUserBySession (inSession);


     -- 
     SELECT MovementFloat.ValueData :: Integer, Movement.OperDate INTO vbMovementDescId, vbOperDate FROM Movement INNER JOIN MovementFloat ON MovementFloat.MovementId = Movement.Id AND MovementFloat.DescId = zc_MovementFloat_MovementDesc() WHERE Movement.Id = inMovementId;

     -- ���������
     vbId:= gpInsertUpdate_MovementItem_WeighingPartner (ioId                  := 0
                                                       , inMovementId          := inMovementId
                                                       , inGoodsId             := inGoodsId
                                                       , inAmount              := inRealWeight - inCountTare * inWeightTare
                                                       , inAmountPartner       := CAST ((inRealWeight - inCountTare * inWeightTare) * (1 - inChangePercentAmount/100) AS NUMERIC (16, 3))
                                                       , inRealWeight          := inRealWeight
                                                       , inChangePercentAmount := inChangePercentAmount
                                                       , inCountTare           := inCountTare
                                                       , inWeightTare          := inWeightTare
                                                       , inCount               := 0
                                                       , inHeadCount           := 0
                                                       , inBoxCount            := 0
                                                       , inBoxNumber           := CASE WHEN vbMovementDescId <> zc_Movement_Sale() THEN 0 ELSE  1 + COALESCE ((SELECT MAX (MovementItemFloat.ValueData) FROM MovementItem INNER JOIN MovementItemFloat ON MovementItemFloat.MovementItemId = MovementItem.Id AND MovementItemFloat.DescId = zc_MIFloat_BoxNumber() WHERE MovementItem.MovementId = inMovementId AND MovementItem.isErased = FALSE), 0) END
                                                       , inLevelNumber         := 0
                                                       , inPrice               := CASE WHEN vbMovementDescId = zc_Movement_ReturnIn() THEN inPrice_Return ELSE inPrice END
                                                                                   /*CASE WHEN vbMovementDescId IN (zc_Movement_Sale(), zc_Movement_ReturnOut(), zc_Movement_ReturnIn(), zc_Movement_Income(), zc_Movement_SendOnPrice())
                                                                                            THEN (SELECT tmp.ValuePrice FROM gpGet_ObjectHistory_PriceListItem (inOperDate   := CASE WHEN vbMovementDescId = zc_Movement_ReturnIn() THEN vbOperDate - (inDayPrior_PriceReturn :: TVarChar || ' DAY') :: INTERVAL ELSE vbOperDate END
                                                                                                                                                              , inPriceListId:= inPriceListId
                                                                                                                                                              , inGoodsId    := inGoodsId
                                                                                                                                                              , inSession    := inSession
                                                                                                                                                               ) AS tmp)
                                                                                       ELSE 0
                                                                                  END*/
                                                       , inCountForPrice       := CASE WHEN vbMovementDescId = zc_Movement_ReturnIn() THEN inCountForPrice_Return ELSE inCountForPrice END
                                                       , inPartionGoodsDate    := NULL
                                                       , inGoodsKindId         := inGoodsKindId
                                                       , inPriceListId         := inPriceListId
                                                       , inBoxId               := NULL
                                                       , inSession             := inSession
                                                        );

     -- 
     vbTotalSumm:= (SELECT ValueData FROM MovementFloat WHERE MovementId = inMovementId AND DescId = zc_MovementFloat_TotalSumm());

     -- ���������
     RETURN QUERY
       SELECT vbId, vbTotalSumm;

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 13.10.14                                        * all
 13.03.14         *
*/

-- ����
-- SELECT * FROM gpInsert_Scale_MI (ioId:= 0, inMovementId:= 10, inGoodsId:= 1, inAmount:= 0, inAmountPartner:= 0, inAmountPacker:= 0, inPrice:= 1, inCountForPrice:= 1, inLiveWeight:= 0, inHeadCount:= 0, inPartionGoods:= '', inGoodsKindId:= 0, inAssetId:= 0, inSession:= '2')