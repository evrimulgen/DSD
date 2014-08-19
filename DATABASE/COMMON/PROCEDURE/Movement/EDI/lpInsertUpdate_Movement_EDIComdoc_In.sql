-- Function: lpInsertUpdate_Movement_EDIComdoc_In()

DROP FUNCTION IF EXISTS lpInsertUpdate_Movement_EDIComdoc_In (Integer, Integer);
DROP FUNCTION IF EXISTS lpInsertUpdate_Movement_EDIComdoc_In (Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION lpInsertUpdate_Movement_EDIComdoc_In(
    IN inMovementId      Integer   , --
    IN inUserId          Integer   , -- ������������
    IN inSession         TVarChar    -- ������ ������������
)                              
RETURNS VOID
AS
$BODY$
   DECLARE vbMovementId_ReturnIn      Integer;
   DECLARE vbMovementId_TaxCorrective Integer;
   DECLARE vbMovementId_Tax           Integer;

   DECLARE vbInvNumberPartner_Tax     TVarChar;
   DECLARE vbOperDate_Tax             TDateTime;
   DECLARE vbJuridicalId_Tax          Integer;
BEGIN

     -- ������������ ���������
     SELECT MovementLinkMovement_MasterEDI.MovementId, MovementLinkMovement_ChildEDI.MovementId
          , MovementString_InvNumberTax.ValueData, MovementDate_OperDateTax.ValueData, MovementLinkObject_Juridical.ObjectId
            INTO vbMovementId_ReturnIn, vbMovementId_TaxCorrective
               , vbInvNumberPartner_Tax, vbOperDate_Tax, vbJuridicalId_Tax
     FROM Movement
          LEFT JOIN MovementLinkMovement AS MovementLinkMovement_MasterEDI
                                         ON MovementLinkMovement_MasterEDI.MovementId = Movement.Id
                                        AND MovementLinkMovement_MasterEDI.DescId = zc_MovementLinkMovement_MasterEDI()
          LEFT JOIN MovementLinkMovement AS MovementLinkMovement_ChildEDI
                                         ON MovementLinkMovement_ChildEDI.MovementId = Movement.Id
                                        AND MovementLinkMovement_ChildEDI.DescId = zc_MovementLinkMovement_ChildEDI()
          LEFT JOIN MovementString AS MovementString_InvNumberTax
                                   ON MovementString_InvNumberTax.MovementChildId =  Movement.Id
                                  AND MovementString_InvNumberTax.DescId = zc_MovementString_InvNumberTax()
          LEFT JOIN MovementDate AS MovementDate_OperDateTax
                                 ON MovementDate_OperDateTax.MovementChildId =  Movement.Id
                                AND MovementDate_OperDateTax.DescId = zc_MovementDate_OperDateTax()
          LEFT JOIN MovementLinkObject AS MovementLinkObject_Juridical
                                       ON MovementLinkObject_Juridical.MovementId = Movement.Id
                                      AND MovementLinkObject_Juridical.DescId = zc_MovementLinkObject_Juridical()
     WHERE Id = inMovementId;

     -- ��������
     IF COALESCE (vbInvNumberPartner_Tax, '') = ''
     THEN
         RAISE EXCEPTION '������.����� ��������� <��������� ���������> �� ����������.';
     END IF;
     -- ��������
     IF COALESCE (vbJuridicalId_Tax, 0) = 0
     THEN
         RAISE EXCEPTION '������.�������� <����������� ����> �� ����������.';
     END IF;


     -- ����� ��������� <��������� ���������>
     vbMovementId_Tax:= (SELECT Movement.Id
                         FROM MovementString AS MovementString_InvNumberPartner
                              INNER JOIN Movement ON Movement.Id = MovementString_InvNumberPartner.MovementId
                                                 AND Movement.StatusId = zc_Enum_Status_Complete()
                                                 AND Movement.DescId = zc_Movement_Tax()
                                                 AND Movement.OperDate = vbOperDate_Tax
                               INNER JOIN MovementLinkObject AS MovementLinkObject_To
                                                             ON MovementLinkObject_To.MovementId = Movement.Id
                                                            AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
                                                            AND MovementLinkObject_To.ObjectId = vbJuridicalId_Tax
                         WHERE MovementString_InvNumberPartner.ValueData = vbInvNumberPartner_Tax
                           AND MovementString_InvNumberPartner.DescId = zc_MovementString_InvNumberPartner());

     -- ��������
     IF COALESCE (vbMovementId_Tax, 0) = 0
     THEN
         RAISE EXCEPTION '������.�������� <��������� ���������> �� ������.';
     END IF;

     -- ��������� <������� �� ����������>
     SELECT lpInsertUpdate_Movement_ReturnIn
                                       (ioId               := vbMovementId_ReturnIn
                                      , inInvNumber        := CASE WHEN vbMovementId_ReturnIn <> 0 THEN (SELECT InvNumber FROM Movement WHERE Id = vbMovementId_ReturnIn) ELSE CAST (NEXTVAL ('movement_returnin_seq') AS TVarChar) END :: TVarChar
                                      , inInvNumberPartner := MovementString_InvNumberPartner.ValueData
                                      , inInvNumberMark    := (SELECT ValueData FROM MovementString WHERE MovementId = vbMovementId_ReturnIn AND DescId = zc_MovementString_InvNumberMark()) :: TVarChar
                                      , inOperDate         := MovementDate_OperDatePartner.ValueData
                                      , inOperDatePartner  := MovementDate_OperDatePartner.ValueData
                                      , inChecked          := (SELECT ValueData FROM MovementBoolean WHERE MovementId = vbMovementId_ReturnIn AND DescId = zc_MovementBoolean_Checked()) :: Boolean
                                      , inPriceWithVAT     := MovementBoolean_PriceWithVAT.ValueData
                                      , inVATPercent       := MovementFloat_VATPercent.ValueData
                                      , inChangePercent    := (SELECT ValueData FROM MovementFloat WHERE MovementId = vbMovementId_ReturnIn AND DescId = zc_MovementFloat_ChangePercent())
                                      , inFromId           := (SELECT ObjectId FROM MovementLinkObject WHERE MovementId = vbMovementId_Tax AND DescId = zc_MovementLinkObject_Partner())
                                      , inToId             := 8461 -- !!!����� ���������!!!
                                      , inPaidKindId       := zc_Enum_PaidKind_FirstForm() 
                                      , inContractId       := (SELECT ObjectId FROM MovementLinkObject WHERE MovementId = vbMovementId_Tax AND DescId = zc_MovementLinkObject_Contract())
                                      , inCurrencyDocumentId := NULL
                                      , inCurrencyPartnerId  := NULL
                                      , inUserId           := inUserId
                                       ) INTO vbMovementId_ReturnIn
     FROM Movement
          LEFT JOIN MovementDate AS MovementDate_OperDatePartner
                                 ON MovementDate_OperDatePartner.MovementId =  Movement.Id
                                AND MovementDate_OperDatePartner.DescId = zc_MovementDate_OperDatePartner()
          LEFT JOIN MovementString AS MovementString_InvNumberPartner
                                   ON MovementString_InvNumberPartner.MovementId =  Movement.Id
                                  AND MovementString_InvNumberPartner.DescId = zc_MovementString_InvNumberPartner()
          LEFT JOIN MovementBoolean AS MovementBoolean_PriceWithVAT
                                    ON MovementBoolean_PriceWithVAT.MovementId =  Movement.Id
                                   AND MovementBoolean_PriceWithVAT.DescId = zc_MovementBoolean_PriceWithVAT()
          LEFT JOIN MovementFloat AS MovementFloat_VATPercent
                                  ON MovementFloat_VATPercent.MovementId =  Movement.Id
                                 AND MovementFloat_VATPercent.DescId = zc_MovementFloat_VATPercent()
     WHERE Movement.Id = inMovementId;

     -- ��������� �������� ����� <������� �� ����������>
     PERFORM lpInsertUpdate_MovementItem_ReturnIn (ioId                 := tmpMI.MovementItemId
                                                 , inMovementId         := vbMovementId_ReturnIn
                                                 , inGoodsId            := tmpMI.GoodsId
                                                 , inAmount             := tmpMI.Amount
                                                 , inAmountPartner      := tmpMI.AmountPartner
                                                 , inPrice              := tmpMI.Price
                                                 , ioCountForPrice      := 1
                                                 , inHeadCount          := 0
                                                 , inPartionGoods       := ''
                                                 , inGoodsKindId        := tmpMI.GoodsKindId
                                                 , inAssetId            := NULL
                                                 , inUserId             := inUserId
                                                  )
     FROM (SELECT MAX (tmpMI.MovementItemId) AS MovementItemId
                , tmpMI.GoodsId
                , tmpMI.GoodsKindId
                , SUM (tmpMI.Amount)         AS Amount
                , SUM (tmpMI.AmountPartner)  AS AmountPartner
                , tmpMI.Price
           FROM (SELECT 0                                                   AS MovementItemId
                      , MovementItem.ObjectId                               AS GoodsId
                      , COALESCE (MILinkObject_GoodsKind.ObjectId, 0)       AS GoodsKindId
                      , 0                                                   AS Amount
                      , COALESCE (MIFloat_AmountPartner.ValueData, 0)       AS AmountPartner
                      , COALESCE (MIFloat_Price.ValueData, 0)               AS Price
                 FROM MovementItem
                      LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                                       ON MILinkObject_GoodsKind.MovementItemId = MovementItem.Id
                                                      AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
                      LEFT JOIN MovementItemFloat AS MIFloat_AmountPartner
                                                  ON MIFloat_AmountPartner.MovementItemId = MovementItem.Id
                                                 AND MIFloat_AmountPartner.DescId = zc_MIFloat_AmountPartner()
                      LEFT JOIN MovementItemFloat AS MIFloat_Price
                                                  ON MIFloat_Price.MovementItemId = MovementItem.Id
                                                 AND MIFloat_Price.DescId = zc_MIFloat_Price()
                 WHERE MovementItem.MovementId = inMovementId
                   AND MovementItem.DescId =  zc_MI_Master()
                   AND MovementItem.isErased = FALSE
                UNION ALL
                 SELECT MovementItem.Id                                     AS MovementItemId
                      , MovementItem.ObjectId                               AS GoodsId
                      , COALESCE (MILinkObject_GoodsKind.ObjectId, 0)       AS GoodsKindId
                      , MovementItem.Amount                                 AS Amount
                      , 0                                                   AS AmountPartner
                      , COALESCE (MIFloat_Price.ValueData, 0)               AS Price
                 FROM MovementItem
                      LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                                       ON MILinkObject_GoodsKind.MovementItemId = MovementItem.Id
                                                      AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
                        LEFT JOIN MovementItemFloat AS MIFloat_AmountPartner
                                                    ON MIFloat_AmountPartner.MovementItemId = MovementItem.Id
                                                   AND MIFloat_AmountPartner.DescId = zc_MIFloat_AmountPartner()
                        LEFT JOIN MovementItemFloat AS MIFloat_Price
                                                    ON MIFloat_Price.MovementItemId = MovementItem.Id
                                                   AND MIFloat_Price.DescId = zc_MIFloat_Price()
                 WHERE MovementItem.MovementId = vbMovementId_ReturnIn
                   AND MovementItem.DescId =  zc_MI_Master()
                   AND MovementItem.isErased = FALSE
                ) AS tmpMI
           GROUP BY tmpMI.GoodsId
                  , tmpMI.GoodsKindId
                  , tmpMI.Price
          ) AS tmpMI
    ;

     -- ��������� <������������� � ��������� ���������>
     SELECT tmp.outMovementId_Corrective INTO vbMovementId_TaxCorrective
     FROM gpInsertUpdate_Movement_TaxCorrective_From_Kind (inMovementId            := vbMovementId_ReturnIn
                                                         , inDocumentTaxKindId     := zc_Enum_DocumentTaxKind_Corrective()
                                                         , inDocumentTaxKindId_inf := NULL
                                                         , inIsTaxLink             := FALSE
                                                         , inSession               := inSession
                                                          ) AS tmp;
     -- ������������ ����� ������������� � ���������
     PERFORM lpInsertUpdate_MovementLinkMovement (zc_MovementLinkMovement_Child(), vbMovementId_TaxCorrective, vbMovementId_Tax);

     -- ������������ ����� <������� �� ����������> � EDI
     PERFORM lpInsertUpdate_MovementLinkMovement (zc_MovementLinkMovement_MasterEDI(), vbMovementId_ReturnIn, inMovementId);

     -- ������������ ����� <������������� � ��������� ���������> � EDI
     PERFORM lpInsertUpdate_MovementLinkMovement (zc_MovementLinkMovement_ChildEDI(), vbMovementId_TaxCorrective, inMovementId);

     -- ����� - �������� <������� �� ����������>
     PERFORM gpComplete_Movement_ReturnIn (inMovementId     := vbMovementId_ReturnIn
                                         , inIsLastComplete := TRUE
                                         , inSession        := inSession);

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 31.07.14                                        *
*/

-- ����
-- SELECT * FROM lpInsertUpdate_Movement_EDIComdoc_In (inMovementId:= 0, inUserId:= 2)