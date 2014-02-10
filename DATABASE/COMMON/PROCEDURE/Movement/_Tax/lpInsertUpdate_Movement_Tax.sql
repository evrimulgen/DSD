-- Function: lpInsertUpdate_Movement_Tax()

DROP FUNCTION IF EXISTS lpInsertUpdate_Movement_Tax (integer, TVarChar, TVarChar, TDateTime, TDateTime, Boolean, Boolean, Boolean, Boolean,
                                                      TFloat, Integer, Integer, Integer, Integer, Integer);

CREATE OR REPLACE FUNCTION lpInsertUpdate_Movement_Tax(
 INOUT ioId                  Integer   , -- ���� ������� <�������� ���������>
    IN inInvNumber           TVarChar  , -- ����� ���������
    IN inInvNumberPartner    TVarChar  , -- ����� ���������� ���������
    IN inOperDate            TDateTime , -- ���� ���������
    IN inDateRegistered      TDateTime , -- ���� �����������
    IN inChecked             Boolean   , -- ��������
    IN inRegistered          Boolean   , -- ���������������� (��/���)
    IN inDocument            Boolean   , -- ���� �� ����������� ��������
    IN inPriceWithVAT        Boolean   , -- ���� � ��� (��/���)
    IN inVATPercent          TFloat    , -- % ���
    IN inFromId              Integer   , -- �� ���� (� ���������)
    IN inToId                Integer   , -- ���� (� ���������)
    IN inContractId          Integer   , -- ��������
    IN inDocumentTaxKind     Integer   , -- ��� ������������ ���������� ���������
    IN inUserId              Integer     -- ������������
)
RETURNS INTEGER AS
$BODY$
   DECLARE vbAccessKeyId Integer;
BEGIN
     -- ���������� ���� �������
--      vbAccessKeyId:= lpGetAccessKey (inUserId, zc_Enum_Process_InsertUpdate_Movement_Tax());

     -- ��������� <��������>
     ioId := lpInsertUpdate_Movement (ioId, zc_Movement_Tax(), inInvNumber, inOperDate, NULL, vbAccessKeyId);

     --Date
     -- ��������� �������� <���� �����������>
     PERFORM lpInsertUpdate_MovementDate (zc_MovementDate_DateRegistered(), ioId, inDateRegistered);

     --String
     -- ��������� �������� <����� ��������� � �����������>
     PERFORM lpInsertUpdate_MovementString (zc_MovementString_InvNumberPartner(), ioId, inInvNumberPartner);

     --Boolean
     -- ��������� �������� <��������>
     PERFORM lpInsertUpdate_MovementBoolean (zc_MovementBoolean_Checked(), ioId, inChecked);
     -- ��������� �������� <���������������� (��/���)>
     PERFORM lpInsertUpdate_MovementBoolean (zc_MovementBoolean_Registered(), ioId, inRegistered);
     -- ��������� �������� <���� �� ����������� ��������>
     PERFORM lpInsertUpdate_MovementBoolean (zc_MovementBoolean_Document(), ioId, inDocument);
     -- ��������� �������� <���� � ��� (��/���)>
     PERFORM lpInsertUpdate_MovementBoolean (zc_MovementBoolean_PriceWithVAT(), ioId, inPriceWithVAT);

     --Float
     -- ��������� �������� <% ���>
     PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_VATPercent(), ioId, inVATPercent);

     --Link
     -- ��������� ����� � <�� ���� (� ���������)>
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_From(), ioId, inFromId);
     -- ��������� ����� � <���� (� ���������)>
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_To(), ioId, inToId);
     -- ��������� ����� � <��������>
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_Contract(), ioId, inContractId);
     -- ��������� ����� � <��� ������������ ���������� ���������>
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_DocumentTaxKind(), ioId, inDocumentTaxKind);


END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.
 09.02.14                                                         *
*/

-- ����
-- SELECT * FROM lpInsertUpdate_Movement_Tax (ioId:= 0, inInvNumber:= '-1',inInvNumberPartner:= '-1', inOperDate:= '01.01.2013', inDateRegistered:= '01.01.2013', inChecked:= FALSE, inRegistered:= FALSE, inDocument:=FALSE, inPriceWithVAT:= true, inVATPercent:= 20, inFromId:= 1, inToId:= 2, inContractId:= 0, inDocumentTaxKind:= 0, inUserId:=24)

