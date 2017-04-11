-- Function: gpInsertUpdate_MIEdit_Income()

DROP FUNCTION IF EXISTS gpInsertUpdate_MIEdit_Income (Integer, Integer, TVarChar, TVarChar, TVarChar ,TVarChar,TVarChar,TVarChar,TVarChar,TVarChar,TFloat, TFloat, TFloat, TFloat, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_MIEdit_Income(
 INOUT ioId                  Integer   , -- ���� ������� <������� ���������>
    IN inMovementId          Integer   , -- ���� ������� <��������>
    IN inGoodsGroupName      TVarChar   , --
    IN inGoodsName           TVarChar   , -- ������
    IN inGoodsInfoName       TVarChar   , --
    IN inGoodsSize           TVarChar   , --
    IN inCompositionName     TVarChar   , --
    IN inLineFabricaName     TVarChar   , --
    IN inLabelName           TVarChar   , --
    IN inMeasureName         TVarChar   , --
    IN inAmount              TFloat    , -- ����������
    IN inOperPrice           TFloat    , -- ����
 INOUT ioCountForPrice       TFloat    , -- ���� �� ����������
    IN inOperPriceList       TFloat    , -- ���� �� ������
    IN inSession             TVarChar    -- ������ ������������
)                              
RETURNS RECORD
AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbGoodsGroupId Integer;
   DECLARE vbMeasureId Integer;
   DECLARE vbLineFabricaId Integer;
   DECLARE vbCompositionId Integer; 
   DECLARE vbGoodsSizeId Integer;
   DECLARE vbGoodsId Integer;   
   DECLARE vbGoodsInfoId Integer;
   DECLARE vbGoodsItemId Integer;
   DECLARE vblabelid Integer;   
   DECLARE vbPartionId Integer;   
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     vbUserId := lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_MI_Income());

     -- �������� �������� <���� �� ����������>
     IF COALESCE (ioCountForPrice, 0) = 0 THEN ioCountForPrice := 1; END IF;

   -- ��������� ��� �����������  TVarChar
   IF COALESCE (inGoodsGroupName, '') <> ''
      THEN
          inGoodsGroupName:= TRIM (COALESCE (inGoodsGroupName, ''));
          -- 
          vbGoodsGroupId:= (SELECT Object.Id FROM Object WHERE Object.DescId = zc_Object_GoodsGroup() AND UPPER(CAST(Object.ValueData AS TVarChar)) LIKE UPPER(inGoodsGroupName));
          IF COALESCE (vbGoodsGroupId,0) = 0
             THEN
                 -- �� ����� ���������
                 vbGoodsGroupId := lpInsertUpdate_Object (0, zc_Object_GoodsGroup(), lfGet_ObjectCode(0, zc_Object_GoodsGroup()), inGoodsGroupName);
                 -- ��������� ��������
                 PERFORM lpInsert_ObjectProtocol (vbGoodsGroupId, vbUserId);
          END IF;
   END IF;
  --2
   IF COALESCE (inMeasureName, '') <> ''
      THEN
          inMeasureName:= TRIM (COALESCE (inMeasureName, ''));
          -- 
          vbMeasureId:= (SELECT Object.Id FROM Object WHERE Object.DescId = zc_Object_Measure() AND UPPER(CAST(Object.ValueData AS TVarChar)) LIKE UPPER(inMeasureName));
          IF COALESCE (vbMeasureId,0) = 0
             THEN
                 -- �� ����� ���������
                 vbMeasureId := lpInsertUpdate_Object (0, zc_Object_Measure(), lfGet_ObjectCode(0, zc_Object_Measure()), inMeasureName);
                 -- ��������� ��������
                 PERFORM lpInsert_ObjectProtocol (vbMeasureId, vbUserId);
          END IF;
   END IF;
   --3
   IF COALESCE (inLineFabricaName, '') <> ''
      THEN
          inLineFabricaName:= TRIM (COALESCE (inLineFabricaName, ''));
          -- 
          vbLineFabricaId:= (SELECT Object.Id FROM Object WHERE Object.DescId = zc_Object_LineFabrica() AND UPPER(CAST(Object.ValueData AS TVarChar)) LIKE UPPER(inLineFabricaName));
          IF COALESCE (vbLineFabricaId,0) = 0
             THEN
                 -- �� ����� ���������
                 vbLineFabricaId := gpInsertUpdate_Object_LineFabrica (ioId    := 0
                                                                     , inCode   := lfGet_ObjectCode(0, zc_Object_LineFabrica()) 
                                                                     , inName   := inLineFabricaName
                                                                     , inSession:= inSession
                                                                    );
          END IF;
   END IF;
   --4
   IF COALESCE (inCompositionName, '') <> ''
      THEN
          inCompositionName:= TRIM (COALESCE (inCompositionName, ''));
          -- 
          vbCompositionId:= (SELECT Object.Id FROM Object WHERE Object.DescId = zc_Object_Composition() AND UPPER(CAST(Object.ValueData AS TVarChar)) LIKE UPPER(inCompositionName));
          IF COALESCE (vbCompositionId,0) = 0
             THEN
                 -- �� ����� ���������
                 vbCompositionId := lpInsertUpdate_Object (0, zc_Object_Composition(), lfGet_ObjectCode(0, zc_Object_Composition()), inCompositionName);
                 -- ��������� ��������
                 PERFORM lpInsert_ObjectProtocol (vbCompositionId, vbUserId);
          END IF;
   END IF;
   --5
   IF COALESCE (inGoodsInfoName, '') <> ''
      THEN
          inGoodsInfoName:= TRIM (COALESCE (inGoodsInfoName, ''));
          -- 
          vbGoodsInfoId:= (SELECT Object.Id FROM Object WHERE Object.DescId = zc_Object_GoodsInfo() AND UPPER(CAST(Object.ValueData AS TVarChar)) LIKE UPPER(inGoodsInfoName));
          IF COALESCE (vbGoodsInfoId,0) = 0
             THEN
                 -- �� ����� ���������
                 vbGoodsInfoId := gpInsertUpdate_Object_GoodsInfo (ioId    := 0
                                                                 , inCode  := lfGet_ObjectCode(0, zc_Object_GoodsInfo()) 
                                                                 , inName  := inGoodsInfoName
                                                                 , inSession:= inSession
                                                                  );
          END IF;
   END IF;
   --6
   IF COALESCE (inLabelName, '') <> ''
      THEN
          inLabelName:= TRIM (COALESCE (inLabelName, ''));
          -- 
          vbLabelId:= (SELECT Object.Id FROM Object WHERE Object.DescId = zc_Object_Label() AND UPPER(CAST(Object.ValueData AS TVarChar)) LIKE UPPER(inLabelName));
          IF COALESCE (vbLabelId,0) = 0
             THEN
                 -- �� ����� ���������
                 vbLabelId := gpInsertUpdate_Object_Label (ioId    := 0
                                                         , inCode   := lfGet_ObjectCode(0, zc_Object_Label()) 
                                                         , inName   := inLabelName
                                                         , inSession:= inSession
                                                         );
          END IF;
   END IF;
   --7
   IF COALESCE (inGoodsSize, '') <> ''
      THEN
          inGoodsSize:= TRIM (COALESCE (inGoodsSize, ''));
          -- 
          vbGoodsSizeId:= (SELECT Object.Id FROM Object WHERE Object.DescId = zc_Object_GoodsSize() AND UPPER(CAST(Object.ValueData AS TVarChar)) LIKE UPPER(inGoodsSize));
          IF COALESCE (vbGoodsSizeId,0) = 0
             THEN
                 -- �� ����� ���������
                 vbGoodsSizeId := gpInsertUpdate_Object_GoodsSize (ioId    := 0
                                                                 , inCode  := lfGet_ObjectCode(0, zc_Object_GoodsSize()) 
                                                                 , inName  := inGoodsSize
                                                                 , inSession:= inSession
                                                                    );
          END IF;
   END IF;
   --7
   IF COALESCE (inGoodsName, '') <> ''
      THEN
          inGoodsName:= TRIM (COALESCE (inGoodsName, ''));
          -- 
          vbGoodsId:= (SELECT Object.Id FROM Object WHERE Object.DescId = zc_Object_Goods() AND UPPER(CAST(Object.ValueData AS TVarChar)) LIKE UPPER(inGoodsName));
        --  IF COALESCE (vbGoodsId,0) = 0
          --   THEN
                 -- �� ����� ���������
                 vbGoodsId := gpInsertUpdate_Object_Goods (ioId            := COALESCE (vbGoodsId,0)
                                                         , inCode          := lfGet_ObjectCode(0, zc_Object_Goods()) 
                                                         , inName          := inGoodsName
                                                         , inGoodsGroupId  := COALESCE(vbGoodsGroupId,0)
                                                         , inMeasureId     := COALESCE(vbMeasureId,0)
                                                         , inCompositionId := COALESCE(vbCompositionId,0)
                                                         , inGoodsInfoId   := COALESCE(vbGoodsInfoId,0)
                                                         , inLineFabricaId := COALESCE(vbLineFabricaId,0)
                                                         , inLabelId       := COALESCE(vbLabelId,0)
                                                         , inSession       := inSession
                                                         );
            
      --    END IF;
   END IF;
   ----gpInsertUpdate_Object_GoodsItem ����� ��������� ����� ����� - ������
   IF COALESCE (vbGoodsId, 0) <> 0 AND COALESCE (vbGoodsSizeId, 0) <> 0
      THEN
          --
          vbGoodsItemId := (SELECT Object_GoodsItem.Id FROM Object_GoodsItem WHERE Object_GoodsItem.GoodsId = vbGoodsId AND Object_GoodsItem.GoodsSizeId = vbGoodsSizeId);
          IF COALESCE (vbGoodsItemId,0) = 0
             THEN
                 -- �������� ����� ������� ����������� � ������� �������� <���� �������>
                 INSERT INTO Object_GoodsItem (GoodsId, GoodsSizeId)
                        VALUES (vbGoodsId, vbGoodsSizeId) RETURNING Id INTO vbGoodsItemId;

          END IF;
   END IF;

     -- ���������
     ioId:= lpInsertUpdate_MovementItem_Income (ioId                 := ioId
                                              , inMovementId         := inMovementId
                                              , inGoodsId            := COALESCE (vbGoodsId,0)
                                              , inPartionId          := Null :: integer
                                              , inAmount             := inAmount
                                              , inOperPrice          := inOperPrice
                                              , inCountForPrice      := ioCountForPrice
                                              , inOperPriceList      := inOperPriceList
                                              , inUserId             := vbUserId
                                               );

      -- c�������� Object_PartionGoods
      vbPartionId := lpInsertUpdate_Object_PartionGoods (
                                                  ioMovementItemId := ioId
                                                , inMovementId     := inMovementId
                                                , inSybaseId       := Null
                                                , inPartnerId      := MovementLinkObject_From.ObjectId
                                                , inUnitId         := MovementLinkObject_To.ObjectId
                                                , inOperDate       := Movement.OperDate
                                                , inGoodsId        := vbGoodsId
                                                , inGoodsItemId    := vbGoodsItemId
                                                , inCurrencyId     := MovementLinkObject_CurrencyDocument.ObjectId
                                                , inAmount         := inAmount
                                                , inOperPrice      := inOperPrice
                                                , inPriceSale      := inOperPriceList
                                                , inBrandId        := ObjectLink_Partner_Brand.ChildObjectId
                                                , inPeriodId       := ObjectLink_Partner_Period.ChildObjectId
                                                , inPeriodYear     := ObjectFloat_PeriodYear.ValueData         :: integer
                                                , inFabrikaId      := ObjectLink_Partner_Fabrika.ChildObjectId
                                                , inGoodsGroupId   := vbGoodsGroupId
                                                , inMeasureId      := vbMeasureId
                                                , inCompositionId  := vbCompositionId
                                                , inGoodsInfoId    := vbGoodsInfoId
                                                , inLineFabricaId  := vbLineFabricaId
                                                , inLabelId        := vbLabelId
                                                , inCompositionGroupId := ObjectLink_Composition_CompositionGroup.ChildObjectId
                                                , inGoodsSizeId    := vbGoodsSizeId 
                                                , inUserId         := vbUserId
                                                        )
     FROM Movement
            LEFT JOIN MovementLinkObject AS MovementLinkObject_From
                                         ON MovementLinkObject_From.MovementId = Movement.Id
                                        AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
            LEFT JOIN MovementLinkObject AS MovementLinkObject_To
                                         ON MovementLinkObject_To.MovementId = Movement.Id
                                        AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
            LEFT JOIN MovementLinkObject AS MovementLinkObject_CurrencyDocument
                                         ON MovementLinkObject_CurrencyDocument.MovementId = Movement.Id
                                        AND MovementLinkObject_CurrencyDocument.DescId = zc_MovementLinkObject_CurrencyDocument()
            --
            LEFT JOIN ObjectLink AS ObjectLink_Partner_Brand
                                 ON ObjectLink_Partner_Brand.ObjectId = MovementLinkObject_From.ObjectId
                                AND ObjectLink_Partner_Brand.DescId = zc_ObjectLink_Partner_Brand()
            LEFT JOIN ObjectLink AS ObjectLink_Partner_Period
                                 ON ObjectLink_Partner_Period.ObjectId = MovementLinkObject_From.ObjectId
                                AND ObjectLink_Partner_Period.DescId = zc_ObjectLink_Partner_Period()
            LEFT JOIN ObjectLink AS ObjectLink_Partner_Fabrika
                                 ON ObjectLink_Partner_Fabrika.ObjectId = MovementLinkObject_From.ObjectId
                                AND ObjectLink_Partner_Fabrika.DescId = zc_ObjectLink_Partner_Fabrika()
            LEFT JOIN ObjectFloat AS ObjectFloat_PeriodYear 
                                  ON ObjectFloat_PeriodYear.ObjectId = MovementLinkObject_From.ObjectId
                                 AND ObjectFloat_PeriodYear.DescId = zc_ObjectFloat_Partner_PeriodYear()
            --
            LEFT JOIN ObjectLink AS ObjectLink_Composition_CompositionGroup
                                ON ObjectLink_Composition_CompositionGroup.ObjectId = vbCompositionId
                               AND ObjectLink_Composition_CompositionGroup.DescId = zc_ObjectLink_Composition_CompositionGroup()

     WHERE Movement.Id = inMovementId;

     -- ��������� ������������� � �������
     ioId:= lpInsertUpdate_MovementItem_Income (ioId                 := ioId
                                              , inMovementId         := inMovementId
                                              , inGoodsId            := COALESCE (vbGoodsId,0)
                                              , inPartionId          := vbPartionId
                                              , inAmount             := inAmount
                                              , inOperPrice          := inOperPrice
                                              , inCountForPrice      := ioCountForPrice
                                              , inOperPriceList      := inOperPriceList
                                              , inUserId             := vbUserId
                                               );


END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 10.04.17         *
*/

-- ����
-- 