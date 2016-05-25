-- Function: lpUpdate_Movement_ReturnIn_Auto()

DROP FUNCTION IF EXISTS lpUpdate_Movement_ReturnIn_Auto (Integer, Integer);
DROP FUNCTION IF EXISTS lpUpdate_Movement_ReturnIn_Auto (TDateTime, TDateTime, Integer, Integer);
DROP FUNCTION IF EXISTS lpUpdate_Movement_ReturnIn_Auto (Integer, TDateTime, TDateTime, Integer);

CREATE OR REPLACE FUNCTION lpUpdate_Movement_ReturnIn_Auto(
    IN inMovementId          Integer   , -- ���� ���������
    IN inStartDateSale       TDateTime , --
    IN inEndDateSale         TDateTime , --
   OUT outMessageText        Text      ,
    IN inUserId              Integer     -- ������������
)
RETURNS Text
AS
$BODY$
   DECLARE vbPeriod1 INTERVAL;
   DECLARE vbPeriod2 INTERVAL;
   DECLARE vbPeriod3 INTERVAL;

   DECLARE vbStartDate  TDateTime;
   DECLARE vbEndDate    TDateTime;
   DECLARE vbPartnerId  Integer;
   DECLARE vbPaidKindId Integer;
   DECLARE vbContractId Integer;

   DECLARE vbMovementItemId_return Integer;
   DECLARE vbMovementId_sale       Integer;
   DECLARE vbMovementItemId_sale   Integer;

   DECLARE vbGoodsId     Integer;
   DECLARE vbGoodsKindId Integer;
   DECLARE vbAmount      TFloat;
   DECLARE vbAmount_sale TFloat;
   DECLARE vbOperPrice   TFloat;

   DECLARE vbStep Integer;

   DECLARE curMI_ReturnIn refcursor;
   DECLARE curMI_Sale refcursor;
   DECLARE curMI_Sale_two refcursor;
BEGIN
     -- �������������, �� ���� ���������� ����� �������� ��������
     vbPeriod1:= '15 DAY'  :: INTERVAL;
     vbPeriod2:= '15 DAY'  :: INTERVAL;
     vbPeriod3:= '1 MONTH' :: INTERVAL;
     --
     vbStep:= 1;



     -- �������
     IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.tables WHERE TABLE_NAME = LOWER ('_tmpItem'))
     THEN
         -- ������� - ������� ��������***
         CREATE TEMP TABLE _tmpItem (MovementItemId Integer, GoodsId Integer, GoodsKindId Integer, OperCount_Partner TFloat, Price_original TFloat)  ON COMMIT DROP;
         -- ������� �������� - ������������ ���� ���***
         INSERT INTO _tmpItem (MovementItemId, GoodsId, GoodsKindId, OperCount_Partner, Price_original)
            SELECT MI.Id, MI.ObjectId, COALESCE (MILinkObject_GoodsKind.ObjectId, 0), COALESCE (MIF_AmountPartner.ValueData, 0), COALESCE (MIF_Price.ValueData, 0)
            FROM MovementItem AS MI
                 LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind ON MILinkObject_GoodsKind.MovementItemId = MI.Id AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
                 LEFT JOIN MovementItemFloat AS MIF_AmountPartner ON MIF_AmountPartner.MovementItemId = MI.Id AND MIF_AmountPartner.DescId = zc_MIFloat_AmountPartner()
                 LEFT JOIN MovementItemFloat AS MIF_Price ON MIF_Price.MovementItemId = MI.Id AND MIF_Price.DescId = zc_MIFloat_Price()
            WHERE MI.MovementId = inMovementId AND MI.DescId = zc_MI_Master() AND MI.isErased = FALSE
              AND MIF_AmountPartner.ValueData <> 0
       ;
     END IF;

     -- �������
     IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.tables WHERE TABLE_NAME = LOWER ('_tmpResult_ReturnIn_Auto'))
     THEN
         --
         -- DELETE FROM _tmpItem;
         --
         DELETE FROM _tmpResult_ReturnIn_Auto;
         --
         DELETE FROM _tmpPartner_ReturnIn_Auto;
     ELSE
         -- ������� - ������ (��� ������ ������) + �����������
         CREATE TEMP TABLE _tmpResult_Sale_Auto (PartnerId Integer, OperDate TDateTime, MovementId Integer, MovementItemId Integer, GoodsId Integer, GoodsKindId Integer, Amount TFloat, Price_original TFloat) ON COMMIT DROP;
         -- ������� - ��������� (����� ������)***
         CREATE TEMP TABLE _tmpResult_ReturnIn_Auto (ParentId Integer, MovementId_sale Integer, MovementItemId_sale Integer, GoodsId Integer, GoodsKindId Integer, GoodsKindId_return Integer, Amount TFloat, Price_original TFloat) ON COMMIT DROP;
         -- ������� - ������ ������������ (��� �����������)***
         CREATE TEMP TABLE _tmpPartner_ReturnIn_Auto (PartnerId Integer) ON COMMIT DROP;
         -- ������� - ������ ������� (��� �����������)
         CREATE TEMP TABLE _tmpGoods_ReturnIn_Auto_all (MovementItemId Integer, GoodsId Integer, GoodsKindId Integer, Price_original TFloat, Amount TFloat) ON COMMIT DROP;
         CREATE TEMP TABLE _tmpGoods_ReturnIn_Auto (GoodsId Integer) ON COMMIT DROP;

     END IF;



     -- !!!��������!!!
     IF zc_isReturnIn_bySale() = TRUE OR inUserId = 5
     THEN



     -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
     -- !!! �� � ������ - ����� ������ !!!
     -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


     -- ���� - ������������ "��������� � (�������)" ��� �������� � ��������� "�������"
     IF TRUE = (SELECT MovementBoolean.ValueData FROM MovementBoolean WHERE MovementBoolean.MovementId = inMovementId AND MovementBoolean.DescId = zc_MovementBoolean_List())
     THEN
         -- !!!����� ���� ������� ������������� ������ �������!!!
         INSERT INTO _tmpResult_ReturnIn_Auto (ParentId, MovementId_sale, MovementItemId_sale, GoodsId, GoodsKindId, Amount, Price_original)
           WITH -- ������� ������� - ����� "������" ��������
                tmpMI_all AS (SELECT _tmpItem.MovementItemId
                                   , _tmpItem.GoodsId
                                   , _tmpItem.GoodsKindId
                                   , _tmpItem.OperCount_Partner                            AS Amount
                                   , _tmpItem.Price_original                               AS Price_original
                                   , COALESCE (MIFloat_MovementId.ValueData, 0) :: Integer AS MovementId_sale
                              FROM _tmpItem
                                   LEFT JOIN MovementItemFloat AS MIFloat_MovementId
                                                               ON MIFloat_MovementId.MovementItemId = _tmpItem.MovementItemId
                                                              AND MIFloat_MovementId.DescId = zc_MIFloat_MovementId()
                             )
                -- ������� ������� - ������������
              , tmpMI AS (SELECT MIN (tmpMI_all.MovementItemId) AS MovementItemId
                               , tmpMI_all.GoodsId
                               , tmpMI_all.GoodsKindId
                               , tmpMI_all.Price_original
                               , SUM (tmpMI_all.Amount) AS Amount
                               , tmpMI_all.MovementId_sale
                          FROM tmpMI_all
                          WHERE tmpMI_all.MovementId_sale > 0
                          GROUP BY tmpMI_all.GoodsId
                                 , tmpMI_all.GoodsKindId
                                 , tmpMI_all.Price_original
                                 , tmpMI_all.MovementId_sale
                         )
            -- �������, ������������� �������������
          , tmpMI_sale_all AS (SELECT tmpMI.MovementItemId
                                    , tmpMI.MovementId_sale
                                    , tmpMI.GoodsId
                                    , tmpMI.GoodsKindId
                                    , tmpMI.Price_original
                                    , MIFloat_Price.ValueData    AS Price_find
                                    , MIN (MovementItem.Id)      AS MovementItemId_sale
                                    , SUM (MovementItem.Amount)  AS Amount_sale
                               FROM tmpMI
                                    INNER JOIN MovementItem ON MovementItem.MovementId = tmpMI.MovementId_sale
                                                           AND MovementItem.isErased   = FALSE
                                                           AND MovementItem.DescId     = zc_MI_Master()
                                                           AND MovementItem.ObjectId   = tmpMI.GoodsId
                                    LEFT JOIN MovementItemFloat AS MIFloat_Price
                                                                ON MIFloat_Price.MovementItemId = MovementItem.Id
                                                               AND MIFloat_Price.DescId         = zc_MIFloat_Price()
                                                               -- AND MIFloat_Price.ValueData      = tmpMI.Price_original
                                    LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                                                     ON MILinkObject_GoodsKind.MovementItemId = MovementItem.Id
                                                                    AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
                               WHERE COALESCE (MILinkObject_GoodsKind.ObjectId, 0) = tmpMI.GoodsKindId
                               GROUP BY tmpMI.MovementItemId
                                      , tmpMI.MovementId_sale
                                      , tmpMI.GoodsId
                                      , tmpMI.GoodsKindId
                                      , tmpMI.Price_original
                                      , MIFloat_Price.ValueData
                              )
                -- ��� �������� �������
              , tmpMI_sale AS (SELECT tmpMI_sale_all.* FROM tmpMI_sale_all WHERE  tmpMI_sale_all.Price_original = tmpMI_sale_all.Price_find)
                -- ������� �� ���., ������� ��� �������� � �������
              , tmpMI_ReturnIn AS (SELECT tmpMI_sale.MovementId_sale
                                        , tmpMI_sale.GoodsId
                                        , tmpMI_sale.GoodsKindId
                                        , MIFloat_Price.ValueData    AS Price_find
                                        , SUM (MovementItem.Amount)  AS Amount_return
                                   FROM tmpMI_sale
                                        INNER JOIN MovementItemFloat AS MIFloat_MovementId
                                                                     ON MIFloat_MovementId.ValueData = tmpMI_sale.MovementId_sale
                                                                    AND MIFloat_MovementId.DescId    = zc_MIFloat_MovementId()
                                        INNER JOIN MovementItem ON MovementItem.Id       = MIFloat_MovementId.MovementItemId
                                                               AND MovementItem.ObjectId = tmpMI_sale.GoodsId
                                                               AND MovementItem.isErased = FALSE
                                                               AND MovementItem.DescId     = zc_MI_Child()
                                        INNER JOIN Movement ON Movement.Id       = MovementItem.MovementId
                                                           AND Movement.DescId   IN (zc_Movement_ReturnIn(), zc_Movement_TransferDebtIn())
                                                           AND Movement.StatusId = zc_Enum_Status_Complete()
                                        LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                                                         ON MILinkObject_GoodsKind.MovementItemId = MovementItem.ParentId -- !!!��  "��������"!!!
                                                                        AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
                                        LEFT JOIN MovementItemFloat AS MIFloat_Price
                                                                    ON MIFloat_Price.MovementItemId = MovementItem.ParentId -- !!!��  "��������"!!!
                                                                   AND MIFloat_Price.DescId         = zc_MIFloat_Price()
                                                                   -- AND MIFloat_Price.ValueData      = tmpMI_sale.Price_original
                                   WHERE COALESCE (MILinkObject_GoodsKind.ObjectId, 0) = tmpMI_sale.GoodsKindId
                                   GROUP BY tmpMI_sale.MovementId_sale
                                          , tmpMI_sale.GoodsId
                                          , tmpMI_sale.GoodsKindId
                                          , MIFloat_Price.ValueData
                                  )
                -- ������� ����� ��� ����������� ������� �� ���.
              , tmpResult AS (SELECT tmpMI_sale.MovementItemId
                                   , tmpMI_sale.MovementId_sale
                                   , tmpMI_sale.MovementItemId_sale
                                   , tmpMI_sale.GoodsId
                                   , tmpMI_sale.GoodsKindId
                                     -- ��� �������� � �������
                                   , tmpMI_sale.Amount_sale - COALESCE (tmpMI_ReturnIn.Amount_return, 0) AS Amount
                              FROM tmpMI_sale
                                   LEFT JOIN tmpMI_ReturnIn ON tmpMI_ReturnIn.MovementId_sale = tmpMI_sale.MovementId_sale
                                                           AND tmpMI_ReturnIn.GoodsId         = tmpMI_sale.GoodsId
                                                           AND tmpMI_ReturnIn.GoodsKindId     = tmpMI_sale.GoodsKindId
                                                           AND tmpMI_ReturnIn.Price_find      = tmpMI_sale.Price_original
                             )
           -- ����� ��������� ... ��� ��� CASE WHEN ��� ������������� �������, �.�. ������ � ������ �������� ����������� ��������� �������
           SELECT tmpMI_all.MovementItemId AS ParentId
                , CASE WHEN tmpResult.MovementItemId = tmpMI_all.MovementItemId THEN tmpMI_all.MovementId_sale     ELSE 0 END AS MovementId_sale
                , CASE WHEN tmpResult.MovementItemId = tmpMI_all.MovementItemId THEN tmpResult.MovementItemId_sale ELSE 0 END AS MovementItemId_sale
                , tmpMI_all.GoodsId
                , tmpMI_all.GoodsKindId
                  -- ���� � �������� <= ��� �������� � �������, ����� = ��������, ����� = ��� �������� � �������
                , CASE WHEN tmpResult.MovementItemId = tmpMI_all.MovementItemId THEN CASE WHEN tmpMI_all.Amount <= tmpResult.Amount THEN tmpMI_all.Amount ELSE tmpResult.Amount END ELSE 0 END AS Amount
                , tmpMI_all.Price_original
           FROM tmpMI_all
                LEFT JOIN tmpResult ON tmpResult.MovementId_sale = tmpMI_all.MovementId_sale
                                   AND tmpResult.GoodsId         = tmpMI_all.GoodsId
                                   AND tmpResult.GoodsKindId     = tmpMI_all.GoodsKindId
                                   AND tmpResult.Amount          > 0
          ;

     ELSE

         -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
         -- !!!����� �������� ������������� ������ �������!!!
         -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

         -- ��������� �� ���������
         SELECT CASE WHEN inStartDateSale >= COALESCE (MovementDate_OperDatePartner.ValueData, Movement.OperDate) - vbPeriod1 THEN inStartDateSale ELSE COALESCE (MovementDate_OperDatePartner.ValueData, Movement.OperDate) - vbPeriod1 END AS StartDate
              , COALESCE (MovementDate_OperDatePartner.ValueData, Movement.OperDate) - INTERVAL '1 DAY' AS EndDate
              , COALESCE (MovementDate_OperDatePartner.ValueData, Movement.OperDate) - INTERVAL '1 DAY' AS inEndDateSale -- !!!������!!!
              , MovementLinkObject_From.ObjectId     AS PartnerId
              , MovementLinkObject_PaidKind.ObjectId AS PaidKindId
              , MovementLinkObject_Contract.ObjectId AS ContractId
                INTO vbStartDate, vbEndDate, inEndDateSale
                   , vbPartnerId, vbPaidKindId, vbContractId
         FROM Movement
              LEFT JOIN MovementDate AS MovementDate_OperDatePartner
                                     ON MovementDate_OperDatePartner.MovementId =  Movement.Id
                                    AND MovementDate_OperDatePartner.DescId     = zc_MovementDate_OperDatePartner()
              LEFT JOIN MovementLinkObject AS MovementLinkObject_From
                                           ON MovementLinkObject_From.MovementId = Movement.Id
                                          AND MovementLinkObject_From.DescId     = zc_MovementLinkObject_From()
              LEFT JOIN MovementLinkObject AS MovementLinkObject_PaidKind
                                           ON MovementLinkObject_PaidKind.MovementId = Movement.Id
                                          AND MovementLinkObject_PaidKind.DescId     = zc_MovementLinkObject_PaidKind()
              LEFT JOIN MovementLinkObject AS MovementLinkObject_Contract
                                           ON MovementLinkObject_Contract.MovementId = Movement.Id
                                          AND MovementLinkObject_Contract.DescId     = zc_MovementLinkObject_Contract()
         WHERE Movement.Id = inMovementId;


         -- ������ ������������ - ������������ ���� ���***
         /*INSERT INTO _tmpPartner_ReturnIn_Auto (PartnerId)
            SELECT ObjectLink_Jur.ObjectId AS PartnerId
            FROM ObjectLink AS ObjectLink_Jur
            WHERE ObjectLink_Jur.ChildObjectId = (SELECT ObjectLink.ChildObjectId FROM ObjectLink WHERE ObjectLink.ObjectId = vbPartnerId AND ObjectLink.DescId = zc_ObjectLink_Partner_Juridical())
              AND ObjectLink_Jur.DescId        = zc_ObjectLink_Partner_Juridical();
         -- �����������
         ANALYZE _tmpPartner_ReturnIn_Auto;*/


         -- ���� �� �������� (��� ������� �������)
         WHILE vbStartDate >= inStartDateSale AND vbStartDate <= vbEndDate LOOP

            -- �������� - ������ ������� (��� �����������)
            DELETE FROM _tmpGoods_ReturnIn_Auto_all;
            DELETE FROM _tmpGoods_ReturnIn_Auto;
            -- ������ ������� - ����������� ������ ���
            INSERT INTO _tmpGoods_ReturnIn_Auto_all (MovementItemId, GoodsId, GoodsKindId, Price_original, Amount)
               -- ������� ������� ����� ������� ������ ����� (�.�. ������� ��������)
               SELECT tmp1.MovementItemId, tmp1.GoodsId, tmp1.GoodsKindId, tmp1.Price_original, tmp1.Amount - COALESCE (tmp2.Amount, 0) AS Amount
               FROM (SELECT MIN (tmp.MovementItemId) AS MovementItemId, tmp.GoodsId, tmp.GoodsKindId, tmp.Price_original, SUM (tmp.OperCount_Partner) AS Amount
                     FROM _tmpItem AS tmp GROUP BY tmp.GoodsId, tmp.GoodsKindId, tmp.Price_original
                    ) AS tmp1
                    LEFT JOIN (SELECT tmp.GoodsId, tmp.GoodsKindId_return AS GoodsKindId, tmp.Price_original, SUM (tmp.Amount) AS Amount
                               FROM _tmpResult_ReturnIn_Auto AS tmp GROUP BY tmp.GoodsId, tmp.GoodsKindId_return, tmp.Price_original
                              ) AS tmp2 ON tmp2.GoodsId        = tmp1.GoodsId
                                       AND tmp2.GoodsKindId    = tmp1.GoodsKindId
                                       AND tmp2.Price_original = tmp1.Price_original
               WHERE tmp1.Amount - COALESCE (tmp2.Amount, 0) > 0;
            -- ... ������ ���
            INSERT INTO _tmpGoods_ReturnIn_Auto (GoodsId) SELECT DISTINCT tmp.GoodsId FROM _tmpGoods_ReturnIn_Auto_all AS tmp;
            -- �����������
            ANALYZE _tmpGoods_ReturnIn_Auto_all; ANALYZE _tmpGoods_ReturnIn_Auto;


            -- �������� - ������� (��� ������ ������) + �����������
            DELETE FROM _tmpResult_Sale_Auto;

            -- ������� (����� ����� ���� ������ ����� ��������� ������) - ����������� ������ ���
            INSERT INTO _tmpResult_Sale_Auto (PartnerId, OperDate, MovementId, MovementItemId, GoodsId, GoodsKindId, Amount, Price_original)

               WITH -- ������� ������� ����� ������� ������ ����� (�.�. ������� ��������)
                    tmpMI_ReturnIn AS (SELECT * FROM _tmpGoods_ReturnIn_Auto_all)
                    -- ������� - ����� ���
                  , tmpMI_sale_all AS (SELECT MovementLinkObject_To.ObjectId                 AS PartnerId
                                            , MD_OperDatePartner.ValueData                   AS OperDate
                                            , MovementItem.MovementId                        AS MovementId
                                            , MovementItem.Id                                AS MovementItemId
                                            , MovementItem.ObjectId                          AS GoodsId
                                            , COALESCE (MILinkObject_GoodsKind.ObjectId, 0)  AS GoodsKindId
                                            , MIFloat_AmountPartner.ValueData                AS Amount
                                            , MIFloat_Price.ValueData                        AS Price_original -- Price_find
                                       FROM MovementDate AS MD_OperDatePartner
                                            INNER JOIN MovementLinkObject AS MovementLinkObject_To
                                                                          ON MovementLinkObject_To.MovementId = MD_OperDatePartner.MovementId
                                                                         AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
                                                                         AND MovementLinkObject_To.ObjectId = vbPartnerId
                                            -- INNER JOIN _tmpPartner_ReturnIn_Auto AS tmpPartner_list ON tmpPartner_list.PartnerId = MovementLinkObject_To.ObjectId
                                            INNER JOIN Movement ON Movement.Id       = MD_OperDatePartner.MovementId
                                                               AND Movement.DescId   = zc_Movement_Sale()
                                                               AND Movement.StatusId = zc_Enum_Status_Complete()

                                            INNER JOIN MovementLinkObject AS MLO_PaidKind
                                                                          ON MLO_PaidKind.MovementId = MD_OperDatePartner.MovementId
                                                                         AND MLO_PaidKind.DescId     = zc_MovementLinkObject_PaidKind()
                                                                         AND MLO_PaidKind.ObjectId   = vbPaidKindId
                                            INNER JOIN MovementLinkObject AS MLO_Contract
                                                                          ON MLO_Contract.MovementId = MD_OperDatePartner.MovementId
                                                                         AND MLO_Contract.DescId     = zc_MovementLinkObject_Contract()
                                                                         AND MLO_Contract.ObjectId   = vbContractId

                                            INNER JOIN MovementItem ON MovementItem.MovementId = MD_OperDatePartner.MovementId
                                                                   AND MovementItem.isErased    = FALSE
                                                                   AND MovementItem.DescId      = zc_MI_Master()
                                            INNER JOIN _tmpGoods_ReturnIn_Auto AS tmpGoods_list ON tmpGoods_list.GoodsId = MovementItem.ObjectId
                                            INNER JOIN MovementItemFloat AS MIFloat_AmountPartner
                                                                         ON MIFloat_AmountPartner.MovementItemId = MovementItem.Id
                                                                        AND MIFloat_AmountPartner.DescId         = zc_MIFloat_AmountPartner()
                                                                        AND MIFloat_AmountPartner.ValueData    <> 0

                                            LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                                                             ON MILinkObject_GoodsKind.MovementItemId = MovementItem.Id
                                                                            AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()

                                            LEFT JOIN MovementItemFloat AS MIFloat_Price
                                                                        ON MIFloat_Price.MovementItemId = MovementItem.Id
                                                                       AND MIFloat_Price.DescId         = zc_MIFloat_Price()

                                       WHERE MD_OperDatePartner.ValueData BETWEEN vbStartDate AND vbEndDate
                                         AND MD_OperDatePartner.DescId = zc_MovementDate_OperDatePartner()
                                      )
                        -- ������� - � ������������� (��� ���� �������)
                      , tmpMI_sale AS (SELECT tmpMI_sale_all.*
                                       FROM tmpMI_sale_all
                                            INNER JOIN _tmpGoods_ReturnIn_Auto_all ON _tmpGoods_ReturnIn_Auto_all.GoodsId        = tmpMI_sale_all.GoodsId
                                                                                  AND _tmpGoods_ReturnIn_Auto_all.GoodsKindId    = tmpMI_sale_all.GoodsKindId
                                                                                  AND _tmpGoods_ReturnIn_Auto_all.Price_original = tmpMI_sale_all.Price_original
                                      )
                   -- ������� ��� ������ - ������� ��� ��������� � ���������
                 , tmpMI_ReturnIn_find AS (SELECT tmpMI_sale.MovementItemId
                                                , SUM (MovementItem.Amount) AS Amount
                                           FROM tmpMI_sale
                                                INNER JOIN MovementItemFloat AS MIFloat_MovementItemId
                                                                             ON MIFloat_MovementItemId.ValueData = tmpMI_sale.MovementItemId
                                                                            AND MIFloat_MovementItemId.DescId    = zc_MIFloat_MovementItemId()
                                                INNER JOIN MovementItem ON MovementItem.Id          = MIFloat_MovementItemId.ValueData :: Integer
                                                                       AND MovementItem.isErased    = FALSE
                                                                       AND MovementItem.DescId      = zc_MI_Master()
                                                                       AND MovementItem.MovementId <> inMovementId -- !!!��� � �� ����� ������� �������!!!
                                                INNER JOIN Movement ON Movement.Id       = MovementItem.MovementId
                                                                   AND Movement.DescId   IN (zc_Movement_ReturnIn(), zc_Movement_TransferDebtIn())
                                                                   AND Movement.StatusId = zc_Enum_Status_Complete()
                                           GROUP BY tmpMI_sale.MovementItemId
                                          )
               -- ��������� - ����� ���� ������ ����� ��������� ������
               SELECT tmpMI_sale.PartnerId
                    , tmpMI_sale.OperDate
                    , tmpMI_sale.MovementId
                    , MIN (tmpMI_sale.MovementItemId) AS MovementItemId
                    , tmpMI_sale.GoodsId
                    , tmpMI_sale.GoodsKindId
                    , SUM (tmpMI_sale.Amount - COALESCE (tmpMI_ReturnIn_find.Amount, 0))
                    , tmpMI_sale.Price_original
               FROM tmpMI_sale
                    LEFT JOIN tmpMI_ReturnIn_find ON tmpMI_ReturnIn_find.MovementItemId = tmpMI_sale.MovementItemId
               GROUP BY tmpMI_sale.PartnerId
                      , tmpMI_sale.OperDate
                      , tmpMI_sale.MovementId
                      , tmpMI_sale.GoodsId
                      , tmpMI_sale.GoodsKindId
                      , tmpMI_sale.Price_original
             ;


            -- ������1 - ������� ������� ����� ������� ������ ����� (�.�. ������� ��������)
            OPEN curMI_ReturnIn FOR SELECT tmp.MovementItemId, tmp.GoodsId, tmp.GoodsKindId, tmp.Price_original, tmp.Amount FROM _tmpGoods_ReturnIn_Auto_all AS tmp;
            -- ������ ����� �� �������1 - ��������
            LOOP
                -- ������ �� ���������
                FETCH curMI_ReturnIn INTO vbMovementItemId_return, vbGoodsId, vbGoodsKindId, vbOperPrice, vbAmount;
                -- ���� ������ �����������, ����� �����
                IF NOT FOUND THEN EXIT; END IF;


                -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!
                -- !!!!! 1 - ALL PARAM !!!!!!!!
                -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!

                -- ������2 - ��� ������� ��� ������ �������� ��������
                OPEN curMI_Sale FOR
                   SELECT _tmpResult_Sale_Auto.MovementId, _tmpResult_Sale_Auto.MovementItemId, _tmpResult_Sale_Auto.Amount
                   FROM _tmpResult_Sale_Auto
                   WHERE _tmpResult_Sale_Auto.GoodsId        = vbGoodsId
                     AND _tmpResult_Sale_Auto.GoodsKindId    = vbGoodsKindId
                     AND _tmpResult_Sale_Auto.Price_original = vbOperPrice
                     AND _tmpResult_Sale_Auto.PartnerId      = vbPartnerId
                   ORDER BY _tmpResult_Sale_Auto.OperDate DESC, _tmpResult_Sale_Auto.Amount DESC
                  ;

                -- ������ ����� �� �������2 - �������
                LOOP
                    -- ������ �� ��������
                    FETCH curMI_Sale INTO vbMovementId_sale, vbMovementItemId_sale, vbAmount_sale;
                    -- ���� ������ �����������, ��� ��� ���-�� ������� ����� �����
                    IF NOT FOUND OR vbAmount = 0 THEN EXIT; END IF;

                    --
                    IF vbAmount_sale > vbAmount
                    THEN
                        -- ���������� � ������� ������ ��� ������, !!!��������� � ����-����������!!!
                        INSERT INTO _tmpResult_ReturnIn_Auto (ParentId, MovementId_sale, MovementItemId_sale, GoodsId, GoodsKindId, GoodsKindId_return, Amount, Price_original)
                           SELECT vbMovementItemId_return, vbMovementId_sale, vbMovementItemId_sale, vbGoodsId, vbGoodsKindId, vbGoodsKindId, vbAmount, vbOperPrice;
                        -- �������� ���-�� ��� �� ������ �� ������
                        vbAmount:= 0;
                    ELSE
                        -- ���������� � ������� ������ ��� ������, !!!��������� � ����-����������!!!
                        INSERT INTO _tmpResult_ReturnIn_Auto (ParentId, MovementId_sale, MovementItemId_sale, GoodsId, GoodsKindId, GoodsKindId_return, Amount, Price_original)
                           SELECT vbMovementItemId_return, vbMovementId_sale, vbMovementItemId_sale, vbGoodsId, vbGoodsKindId, vbGoodsKindId, vbAmount_sale, vbOperPrice;
                        -- ��������� �� ���-�� ������� ����� � ���������� �����
                        vbAmount:= vbAmount - vbAmount_sale;
                    END IF;


                END LOOP; -- ����� ����� �� �������2 - �������
                CLOSE curMI_Sale; -- ������� ������2 - �������

                -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                -- !!!!! 1 - END ALL PARAM !!!!!!!!
                -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

/*
                IF vbAmount > 0 THEN
                -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                -- !!!!! 2 - NOT vbPartnerId!!!!!
                -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

                -- ������3 - ��� ������� ��� ������ �������� ��������
                OPEN curMI_Sale_two FOR
                   SELECT _tmpResult_Sale_Auto.MovementId, _tmpResult_Sale_Auto.MovementItemId, _tmpResult_Sale_Auto.Amount
                   FROM _tmpResult_Sale_Auto
                   WHERE _tmpResult_Sale_Auto.GoodsId        = vbGoodsId
                     AND _tmpResult_Sale_Auto.GoodsKindId    = vbGoodsKindId
                     AND _tmpResult_Sale_Auto.Price_original = vbOperPrice
                     AND _tmpResult_Sale_Auto.PartnerId      <> vbPartnerId -- !!!��� ����� ���������!!!
                   ORDER BY _tmpResult_Sale_Auto.OperDate DESC, _tmpResult_Sale_Auto.Amount DESC
                  ;

                -- ������ ����� �� �������3 - �������
                LOOP
                    -- ������ �� ��������
                    FETCH curMI_Sale_two INTO vbMovementId_sale, vbMovementItemId_sale, vbAmount_sale;
                    -- ���� ������ �����������, ��� ��� ���-�� ������� ����� �����
                    IF NOT FOUND OR vbAmount = 0 THEN EXIT; END IF;


                    --
                    IF vbAmount_sale > vbAmount
                    THEN
                        -- ���������� � ������� ������ ��� ������, !!!��������� � ����-����������!!!
                        INSERT INTO _tmpResult_ReturnIn_Auto (ParentId, MovementId_sale, MovementItemId_sale, GoodsId, GoodsKindId, GoodsKindId_return, Amount, Price_original)
                           SELECT vbMovementItemId_return, vbMovementId_sale, vbMovementItemId_sale, vbGoodsId, vbGoodsKindId, vbGoodsKindId, vbAmount, vbOperPrice;
                        -- �������� ���-�� ��� �� ������ �� ������
                        vbAmount:= 0;
                    ELSE
                        -- ���������� � ������� ������ ��� ������, !!!��������� � ����-����������!!!
                        INSERT INTO _tmpResult_ReturnIn_Auto (ParentId, MovementId_sale, MovementItemId_sale, GoodsId, GoodsKindId, GoodsKindId_return, Amount, Price_original)
                           SELECT vbMovementItemId_return, vbMovementId_sale, vbMovementItemId_sale, vbGoodsId, vbGoodsKindId, vbGoodsKindId, vbAmount_sale, vbOperPrice;
                        -- ��������� �� ���-�� ������� ����� � ���������� �����
                        vbAmount:= vbAmount - vbAmount_sale;
                    END IF;


                END LOOP; -- ����� ����� �� �������3 - �������
                CLOSE curMI_Sale_two; -- ������� ������3 - �������

                END IF; -- IF vbAmount > 0 THEN
                -- !!!!!!!!!!!!!!!!!!!!!!!
                -- !!!!! 2 - End vbGoodsKindId AND NOT vbPartnerId!!!!!
                -- !!!!!!!!!!!!!!!!!!!!!!!
*/

            END LOOP; -- ����� ����� �� �������1 - ��������
            CLOSE curMI_ReturnIn; -- ������� ������1 - ��������



            -- ������ ��������� ������
            vbStep:= vbStep + 1;
            vbEndDate:= vbStartDate - INTERVAL '1 DAY';
            vbStartDate:= (WITH tmp AS (SELECT CASE WHEN vbStep = 2 THEN vbStartDate - vbPeriod2 ELSE vbStartDate - vbPeriod3 END AS StartDate)
                           SELECT CASE WHEN inStartDateSale >= tmp.StartDate THEN inStartDateSale ELSE tmp.StartDate END FROM tmp);


         END LOOP; -- ���� �� �������� (��� ������� �������)


     END IF; -- ������ ������� - ������������


     -- !!!����������!!!
     PERFORM lpInsertUpdate_MovementItem_ReturnIn_Child (ioId                  := tmp.MovementItemId
                                                       , inMovementId          := inMovementId
                                                       , inParentId            := tmp.ParentId
                                                       , inGoodsId             := tmp.GoodsId
                                                       , inAmount              := CASE WHEN tmp.MovementId_sale > 0 AND tmp.MovementItemId_sale > 0 THEN COALESCE (tmp.Amount, 0) ELSE 0 END
                                                       , inMovementId_sale     := COALESCE (tmp.MovementId_sale, 0)
                                                       , inMovementItemId_sale := COALESCE (tmp.MovementItemId_sale, 0)
                                                       , inUserId              := inUserId
                                                       , inIsRightsAll         := FALSE
                                                        )
     FROM (WITH MI_Master AS (SELECT MovementItem.Id, MovementItem.ObjectId AS GoodsId
                              FROM MovementItem
                              WHERE MovementItem.MovementId = inMovementId
                                AND MovementItem.DescId     = zc_MI_Master()
                             )
               , MI_Child AS (SELECT MovementItem.Id, MovementItem.ParentId, COALESCE (MIFloat_MovementItemId.ValueData, 0) :: Integer AS MovementItemId_sale
                              FROM MovementItem
                                   LEFT JOIN MovementItemFloat AS MIFloat_MovementItemId
                                                               ON MIFloat_MovementItemId.MovementItemId = MovementItem.Id
                                                              AND MIFloat_MovementItemId.DescId         = zc_MIFloat_MovementItemId()
                              WHERE MovementItem.MovementId = inMovementId
                                AND MovementItem.DescId     = zc_MI_Child()
                             )
                 , MI_All AS (SELECT MI_Child.Id AS MovementItemId
                                   , COALESCE (_tmpResult_ReturnIn_Auto.ParentId, COALESCE (MI_Child.ParentId, 0)) AS ParentId
                                   , _tmpResult_ReturnIn_Auto.MovementId_sale
                                   , _tmpResult_ReturnIn_Auto.MovementItemId_sale
                                   , _tmpResult_ReturnIn_Auto.Amount
                              FROM _tmpResult_ReturnIn_Auto
                                   FULL JOIN MI_Child ON MI_Child.ParentId            = _tmpResult_ReturnIn_Auto.ParentId
                                                     AND MI_Child.MovementItemId_sale = _tmpResult_ReturnIn_Auto.MovementItemId_sale
                             )
           -- ���������
           SELECT MI_Master.Id AS ParentId
                , MI_Master.GoodsId
                , MI_All.MovementItemId
                , MI_All.MovementId_sale
                , MI_All.MovementItemId_sale
                , MI_All.Amount
           FROM MI_Master
                LEFT JOIN MI_All ON MI_All.ParentId = MI_Master.Id
          ) AS tmp;

    

     END IF;
     -- !!!��������!!! -- IF 1=1 AND inUserId = 5


     -- !!!������� ������, ���� ����!!!
     outMessageText:= lpCheck_Movement_ReturnIn_Auto (inMovementId    := inMovementId
                                                    , inUserId        := inUserId
                                                     )
       || CHR (13) || '�� ������ � <' || DATE (inStartDateSale) :: TVarChar || '> �� <' || DATE (inEndDateSale) :: TVarChar || '>'
       || CHR (13) || '(' || (vbStep - 1) :: TVarChar || ')'
       -- || CHR (13) || (SELECT COUNT(*) FROM _tmpResult_Sale_Auto) :: TVarChar
            -- || ' ' || (SELECT COUNT(*) FROM _tmpResult_ReturnIn_Auto) :: TVarChar
            -- || ' ' || DATE (vbStartDate) :: TVarChar
            -- || ' ' || DATE (vbEndDate) :: TVarChar
                     ;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 14.05.16                                        *
*/

-- ����
-- SELECT * FROM MovementItem WHERE MovementId = 3662505 AND DescId = zc_MI_Child() -- SELECT * FROM MovementItemFloat WHERE MovementItemId IN (SELECT Id FROM MovementItem WHERE MovementId = 3662505 AND DescId = zc_MI_Child())
-- SELECT lpUpdate_Movement_ReturnIn_Auto (inMovementId:= Movement.Id, inStartDateSale:= Movement.OperDate - INTERVAL '15 DAY', inEndDateSale:= Movement.OperDate, inUserId:= zfCalc_UserAdmin() :: Integer) || CHR (13), Movement.* FROM Movement WHERE Movement.Id = 3662505
-- SELECT lpUpdate_Movement_ReturnIn_Auto (inMovementId:= Movement.Id, inStartDateSale:= Movement.OperDate - INTERVAL '4 MONTH', inEndDateSale:= Movement.OperDate, inUserId:= zfCalc_UserAdmin() :: Integer) || CHR (13), Movement.* FROM Movement WHERE Movement.Id = 3662505