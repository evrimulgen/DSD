-- Function: lpInsertUpdate_MovementItem_PersonalService()

DROP FUNCTION IF EXISTS lpInsertUpdate_MovementItem_PersonalService (Integer, Integer, Integer, Boolean, TFloat, TFloat, TFloat, TFloat, TFloat, TFloat, TFloat, TVarChar, Integer, Integer, Integer, Integer, Integer);
DROP FUNCTION IF EXISTS lpInsertUpdate_MovementItem_PersonalService (Integer, Integer, Integer, Boolean, TFloat, TFloat, TFloat, TFloat, TFloat, TFloat, TFloat, TVarChar, Integer, Integer, Integer, Integer, Integer, Integer);


CREATE OR REPLACE FUNCTION lpInsertUpdate_MovementItem_PersonalService(
 INOUT ioId                  Integer   , -- ���� ������� <������� ���������>
    IN inMovementId          Integer   , -- ���� ������� <��������>
    IN inPersonalId          Integer   , -- ����������
    IN inisMain              Boolean   , -- �������� ����� ������
   OUT outAmount             TFloat    , -- ����� (�������)
   OUT outAmountToPay        TFloat    , -- ����� � ������� (����)
   OUT outAmountCash         TFloat    , -- ����� � ������� �� �����
    IN inSummService         TFloat    , -- ����� ���������
    IN inSummCardRecalc      TFloat    , -- ����� �� �������� (��) ��� �������������
    IN inSummMinus           TFloat    , -- ����� ���������
    IN inSummAdd             TFloat    , -- ����� ������
    
    IN inSummSocialIn        TFloat    , -- ����� ��� ������� (�� ��������)
    IN inSummSocialAdd       TFloat    , -- ����� ��� ������� (���. ��������)
    IN inSummChild           TFloat    , -- ����� �������� (���������)
    
    IN inComment             TVarChar  , -- 
    IN inInfoMoneyId         Integer   , -- ������ ����������
    IN inUnitId              Integer   , -- �������������
    IN inPositionId          Integer   , -- ���������
    IN inMemberId            Integer   , -- ��� ���� (���� ��������� ��������)
    IN inPersonalServiceListId   Integer   , -- ��������� ����������
    IN inUserId              Integer     -- ������������
)
RETURNS RECORD AS
$BODY$
   DECLARE vbIsInsert Boolean;
   DECLARE vbAccessKeyId Integer;
BEGIN
     -- ��������
     IF COALESCE (inMovementId, 0) = 0
     THEN
         RAISE EXCEPTION '������.� ��������� �� ��������� �������� <���������>.';
     END IF;
     -- ��������
     IF COALESCE (inPersonalId, 0) = 0
     THEN
         RAISE EXCEPTION '������.�� ��������� �������� <��� (���������)>.';
     END IF;
     -- ��������
     IF COALESCE (inInfoMoneyId, 0) = 0
     THEN
         RAISE EXCEPTION '������.�� ��������� �������� <�� ������>.';
     END IF;
     -- ��������
     IF COALESCE (inUnitId, 0) = 0
     THEN
         RAISE EXCEPTION '������.�� ��������� �������� <�������������>.';
     END IF;
     -- ��������
     IF COALESCE (inPositionId, 0) = 0
     THEN
         RAISE EXCEPTION '������.�� ��������� �������� <���������>.';
     END IF;


     -- !!!�����!!!
     -- ���������� ���� �������
     vbAccessKeyId:= lpGetAccessKey ((SELECT ObjectLink_User_Member.ObjectId
                                      FROM ObjectLink
                                           INNER JOIN ObjectLink AS ObjectLink_User_Member ON ObjectLink_User_Member.ChildObjectId = ObjectLink.ChildObjectId
                                                                                          AND ObjectLink_User_Member.DescId = zc_ObjectLink_User_Member()
                                       WHERE ObjectLink.DescId = zc_ObjectLink_PersonalServiceList_Member()
                                         AND ObjectLink.ObjectId = (SELECT MLO.ObjectId FROM MovementLinkObject AS MLO WHERE MLO.MovementId = inMovementId AND MLO.DescId = zc_MovementLinkObject_PersonalServiceList())
                                       LIMIT 1
                                     )
                                   , zc_Enum_Process_InsertUpdate_Movement_PersonalService()
                                    );
     -- !!!�����!!!
     UPDATE Movement SET AccessKeyId = vbAccessKeyId WHERE Id = inMovementId;

     -- ������������ ����� (�������)
     outAmount:= COALESCE (inSummService, 0) - COALESCE (inSummMinus, 0) + COALESCE (inSummAdd, 0); -- - COALESCE (inSummSocialIn, 0);
     -- ������������ ����� � �������
     outAmountToPay:= COALESCE (inSummService, 0) - COALESCE (inSummMinus, 0) + COALESCE (inSummAdd, 0) + COALESCE (inSummSocialAdd, 0);
     -- ������������ ����� � ������� �� �����
     outAmountCash:= outAmountToPay - COALESCE (inSummChild, 0); -- - COALESCE (inSummCard, 0) 

     -- ������������ ������� ��������/�������������
     vbIsInsert:= COALESCE (ioId, 0) = 0;

     -- ��������� <������� ���������>
     ioId := lpInsertUpdate_MovementItem (ioId, zc_MI_Master(), inPersonalId, inMovementId, outAmount, NULL);

     -- ��������� �������� <>
     PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_SummToPay(), ioId, outAmountToPay);
     -- ��������� �������� <>
     PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_SummService(), ioId, inSummService);
     -- ��������� �������� <>
     PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_SummCardRecalc(), ioId, inSummCardRecalc);
     -- ��������� �������� <>
     PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_SummMinus(), ioId, inSummMinus);
     -- ��������� �������� <>
     PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_SummAdd (), ioId, inSummAdd );
     -- ��������� �������� <>
     PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_SummSocialIn(), ioId, inSummSocialIn);
     -- ��������� �������� <>
     PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_SummSocialAdd(), ioId, inSummSocialAdd);
     -- ��������� �������� <>
     PERFORM lpInsertUpdate_MovementItemBoolean (zc_MIBoolean_Main(), ioId, inisMain);

     -- ��������� �������� <>
     PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_SummChild(), ioId, inSummChild);

     -- ��������� �������� <>
     PERFORM lpInsertUpdate_MovementItemString (zc_MIString_Comment(), ioId, inComment);

     -- ��������� ����� � <>
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_InfoMoney(), ioId, inInfoMoneyId);
     -- ��������� ����� � <>
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_Unit(), ioId, inUnitId);
     -- ��������� ����� � <>
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_Position(), ioId, inPositionId);
     -- ��������� ����� � <>
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_Member(), ioId, inMemberId);
     -- ��������� ����� � <>
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_PersonalServiceList(), ioId, inPersonalServiceListId);

     -- ����������� �������� ����� �� ���������
     PERFORM lpInsertUpdate_MovementFloat_TotalSumm (inMovementId);

      -- ��������� ��������
      PERFORM lpInsert_MovementItemProtocol (ioId, inUserId, vbIsInsert);

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 07.05.15         * add PersonalServiceList
 02.10.14                                        * del inSummCard
 01.10.14         * add redmine 30.09
 14.09.14                                        * add out...
 11.09.14         *
*/

-- ����
-- SELECT * FROM lpInsertUpdate_MovementItem_PersonalService (ioId:= 0, inMovementId:= 10, inGoodsId:= 1, inAmount:= 0, inHeadCount:= 0, inPartionGoods:= '', inGoodsKindId:= 0, inSession:= '2')
