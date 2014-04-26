-- Function: gpInsertUpdate_Object_Contract()

DROP FUNCTION IF EXISTS gpInsertUpdate_Object_Contract (integer, tvarchar, tdatetime, tdatetime, tdatetime, tfloat, tfloat, tvarchar, integer, integer, integer, integer, tvarchar);
DROP FUNCTION IF EXISTS gpInsertUpdate_Object_Contract (Integer, Integer, TVarChar, TVarChar, TVarChar, TDateTime, TDateTime, TDateTime, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, TVarChar);
DROP FUNCTION IF EXISTS gpInsertUpdate_Object_Contract (Integer, Integer, TVarChar, TVarChar, TVarChar, TDateTime, TDateTime, TDateTime, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, TVarChar);
DROP FUNCTION IF EXISTS gpInsertUpdate_Object_Contract (Integer, Integer, TVarChar, TVarChar, TVarChar, TVarChar, TDateTime, TDateTime, TDateTime, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, TVarChar);
DROP FUNCTION IF EXISTS gpInsertUpdate_Object_Contract (Integer, Integer, TVarChar, TVarChar, TVarChar, TVarChar, TDateTime, TDateTime, TDateTime, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Boolean, TVarChar);
DROP FUNCTION IF EXISTS gpInsertUpdate_Object_Contract (Integer, Integer, TVarChar, TVarChar, TVarChar, TVarChar, TDateTime, TDateTime, TDateTime, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Boolean, Boolean, TVarChar);
DROP FUNCTION IF EXISTS gpInsertUpdate_Object_Contract (Integer, Integer, TVarChar, TVarChar, TVarChar, TVarChar, TDateTime, TDateTime, TDateTime, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Boolean, Boolean, TVarChar);


CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_Contract(
 INOUT ioId                  Integer,       -- ���� ������� <�������>
    IN inCode                Integer,       -- ���
    IN inInvNumber           TVarChar,      -- ����� ��������
    IN inInvNumberArchive    TVarChar,      -- ����� �������������
    IN inComment             TVarChar,      -- ����������
    IN inBankAccountExternal TVarChar,      -- �.���� (���.������)
    
    IN inSigningDate         TDateTime,     -- ���� ���������� ��������
    IN inStartDate           TDateTime,     -- ���� � ������� ��������� �������
    IN inEndDate             TDateTime,     -- ���� �� ������� ��������� �������    
    
    IN inJuridicalId         Integer  ,     -- ����������� ����
    IN inJuridicalBasisId    Integer  ,     -- ������� ����������� ����
    IN inInfoMoneyId         Integer  ,     -- �� ������ ����������
    IN inContractKindId      Integer  ,     -- ��� ��������
    IN inPaidKindId          Integer  ,     -- ��� ����� ������
    
    IN inPersonalId          Integer  ,     -- ��������� (������������ ����)
    IN inPersonalTradeId     Integer  ,     -- ��������� (��������)
    IN inPersonalCollationId Integer  ,     -- ��������� (������)
    IN inBankAccountId       Integer  ,     -- ��������� ���� (��.������)
    IN inContractTagId       Integer  ,     -- ������� ��������
    
    IN inAreaId              Integer  ,     -- ������
    IN inContractArticleId   Integer  ,     -- ������� ��������
    IN inContractStateKindId Integer  ,     -- ��������� ��������
    IN inBankId              Integer  ,     -- ���� (���.������)
    IN inisDefault           Boolean  ,     -- �� ���������
    IN inisStandart          Boolean  ,     -- �������
    IN inSession             TVarChar       -- ������ ������������
)
RETURNS Integer AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbCode Integer;   
   DECLARE vbIsUpdate Boolean;   
BEGIN
   -- �������� ���� ������������ �� ����� ���������
   -- vbUserId := lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_Object_Contract());
   vbUserId:= lpGetUserBySession (inSession);

   /*
   IF ioId <> 0 
        -- �������� ����� ���
   THEN vbCode := (SELECT ObjectCode FROM Object WHERE Id = ioId); 
        -- �����, ���������� ��� ��� ���������+1
   ELSE vbCode:= inCode; -- lfGet_ObjectCode (inCode, zc_Object_Contract()); 
   END IF;*/

   IF COALESCE (ioId, 0) = 0 AND EXISTS (SELECT ObjectCode FROM Object WHERE ObjectCode = inCode AND DescId = zc_Object_Contract())
   THEN 
       -- ���� ��� �� ����������, ���������� ��� ��� ��������� + 1
       vbCode:= lfGet_ObjectCode (0, zc_Object_Contract());
   ELSE
       -- ���� ��� �� ����������, ���������� ��� ��� ��������� + 1
       vbCode:= lfGet_ObjectCode (inCode, zc_Object_Contract());
   END IF;

   -- �������� ������������ <���>
   PERFORM lpCheckUnique_Object_ObjectCode (ioId, zc_Object_Contract(), vbCode);

   -- �������� ������������ ��� �������� <����� ��������>
   -- PERFORM lpCheckUnique_Object_ValueData(ioId, zc_Object_Contract(), inInvNumber);

   -- �������� ������������ <����� ��������> ��� !!!������!! ��. ���� � !!!�����!! ������
   IF TRIM (inInvNumber) <> '' -- and inInvNumber <> '100398' and inInvNumber <> '877' and inInvNumber <> '24849' and inInvNumber <> '19' and inInvNumber <> '�/�' and inInvNumber <> '369/1' and inInvNumber <> '63/12' and inInvNumber <> '4600034104' and inInvNumber <> '19�'
   THEN
       IF EXISTS (SELECT ObjectLink.ChildObjectId
                  FROM ObjectLink
                       JOIN ObjectLink AS ObjectLink_InfoMoney
                                       ON ObjectLink_InfoMoney.ObjectId = ObjectLink.ObjectId
                                      AND ObjectLink_InfoMoney.ChildObjectId = inInfoMoneyId
                                      AND ObjectLink_InfoMoney.DescId = zc_ObjectLink_Contract_InfoMoney()
                       JOIN Object ON Object.Id = ObjectLink.ObjectId
                                  AND TRIM (Object.ValueData) = TRIM (inInvNumber)
                  WHERE ObjectLink.ChildObjectId = inJuridicalId
                    AND ObjectLink.ObjectId <> COALESCE (ioId, 0)
                    AND ObjectLink.DescId = zc_ObjectLink_Contract_Juridical())
       THEN
           RAISE EXCEPTION '������. ����� �������� <%> ��� ���������� � <%>.', TRIM (inInvNumber), lfGet_Object_ValueData (inJuridicalId);
       END IF;
   END IF;

   -- ��������
   IF COALESCE (inJuridicalBasisId, 0) = 0
   THEN
      RAISE EXCEPTION '������.<������� ����������� ����> �� �������.';
   END IF;
   -- ��������
   IF COALESCE (inJuridicalId, 0) = 0
   THEN
      RAISE EXCEPTION '������.<����������� ����> �� �������.';
   END IF;
   -- ��������
   IF COALESCE (inInfoMoneyId, 0) = 0
   THEN
      RAISE EXCEPTION '������.<�� ������ ����������> �� �������.';
   END IF;
   -- ��������
   IF COALESCE (inPaidKindId, 0) = 0
   THEN
      RAISE EXCEPTION '������.<����� ������> �� �������.';
   END IF;
   -- ��������
   IF inPaidKindId = zc_Enum_PaidKind_FirstForm() AND NOT EXISTS (SELECT JuridicalId FROM ObjectHistory_JuridicalDetails_View WHERE JuridicalId = inJuridicalId AND OKPO <> '')
   THEN
      RAISE EXCEPTION '������.� <����������� ����> �� ���������� <����>.';
   END IF;
   -- �������� ��� 
   IF COALESCE (inContractTagId, 0) = 0
      AND EXISTS (SELECT InfoMoneyId FROM Object_InfoMoney_View WHERE InfoMoneyId = inInfoMoneyId
                                                                  AND InfoMoneyDestinationId IN (zc_Enum_InfoMoneyDestination_30100() -- ���������
                                                                                               , zc_Enum_InfoMoneyDestination_30200() -- ������ �����
                                                                                                ))
   THEN
       RAISE EXCEPTION '������.��� <%> ���������� ���������� <������� ��������>.', lfGet_Object_ValueData (inInfoMoneyId);
   END IF;

   -- ��������
   IF inSigningDate <> DATE_TRUNC ('DAY', inSigningDate) OR inStartDate <> DATE_TRUNC ('DAY', inStartDate) OR inEndDate <> DATE_TRUNC ('DAY', inEndDate) 
   THEN
       RAISE EXCEPTION '������.�������� ������ ����.';
   END IF;


   -- ���������� <�������>
   vbIsUpdate:= COALESCE (ioId, 0) > 0;

   -- ��������� <������>
   ioId := lpInsertUpdate_Object (ioId, zc_Object_Contract(), vbCode, TRIM (inInvNumber));

   -- ��������� �������� <����� ��������>
   -- PERFORM lpInsertUpdate_ObjectString (zc_ObjectString_Contract_InvNumber(), ioId, inInvNumber);

   -- ��������� �������� <>
   PERFORM lpInsertUpdate_ObjectDate (zc_ObjectDate_Contract_Signing(), ioId, inSigningDate);
   -- ��������� �������� <>
   PERFORM lpInsertUpdate_ObjectDate (zc_ObjectDate_Contract_Start(), ioId, inStartDate);
   -- ��������� �������� <>
   PERFORM lpInsertUpdate_ObjectDate (zc_ObjectDate_Contract_End(), ioId, inEndDate);

   -- ��������� �������� <����� �������������>
   PERFORM lpInsertUpdate_ObjectString (zc_ObjectString_Contract_InvNumberArchive(), ioId, inInvNumberArchive);

   -- ��������� �������� <�����������>
   PERFORM lpInsertUpdate_ObjectString (zc_ObjectString_Contract_Comment(), ioId, inComment);
   -- ��������� �������� <>
   PERFORM lpInsertUpdate_ObjectString (zc_ObjectString_Contract_BankAccount(), ioId, inBankAccountExternal);

   -- ��������� �������� <>
   PERFORM lpInsertUpdate_ObjectBoolean (zc_ObjectBoolean_Contract_Default(), ioId, inisDefault);
   -- ��������� �������� <>
   PERFORM lpInsertUpdate_ObjectBoolean (zc_ObjectBoolean_Contract_Standart(), ioId, inisStandart);


   -- ��������� ����� � <����������� ����>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Contract_Juridical(), ioId, inJuridicalId);
   -- ��������� ����� � <������� ����������� �����>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Contract_JuridicalBasis(), ioId, inJuridicalBasisId);
   -- ��������� ����� � <������ ����������>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Contract_InfoMoney(), ioId, inInfoMoneyId);
   -- ��������� ����� � <���� ���������>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Contract_ContractKind(), ioId, inContractKindId);
   -- ��������� ����� � <���� ���� ������>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Contract_PaidKind(), ioId, inPaidKindId);

   -- ��������� ����� � <���������� (������������ ����)>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Contract_Personal(), ioId, inPersonalId);
   
   -- ��������� ����� � <���������� (������������ ����)>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Contract_Personal(), ioId, inPersonalId);

   -- ��������� ����� � <���������� (��������)>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Contract_PersonalTrade(), ioId, inPersonalTradeId);
   -- ��������� ����� � <���������� (������)>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Contract_PersonalCollation(), ioId, inPersonalCollationId);
   -- ��������� ����� � <��������� �����(������ ���)>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Contract_BankAccount(), ioId, inBankAccountId);
   -- ��������� ����� � <������� ��������>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Contract_ContractTag(), ioId, inContractTagId);
   
   -- ��������� ����� � <������>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Contract_Area(), ioId, inAreaId);
   -- ��������� ����� � <������� ��������>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Contract_ContractArticle(), ioId, inContractArticleId);
   -- ��������� ����� � <��������� ��������>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Contract_ContractStateKind(), ioId, inContractStateKindId);   
   -- ��������� ����� � <����>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Contract_Bank(), ioId, inBankId);
   
     -- !!!�����������!!! ������������ ����
    PERFORM lpInsertFind_Object_ContractKey (inJuridicalId_basis:= inJuridicalBasisId
                                           , inJuridicalId      := inJuridicalId
                                           , inInfoMoneyId      := inInfoMoneyId
                                           , inPaidKindId       := inPaidKindId
                                           , inContractTagId    := inContractTagId
                                           , inContractId_begin := ioId
                                            );

   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (inObjectId:= ioId, inUserId:= vbUserId, inIsUpdate:= vbIsUpdate, inIsErased:= NULL);

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 26.04.14                                        * add lpInsertFind_Object_ContractKey
 21.04.14         * add zc_ObjectLink_Contract_PersonalTrade
                        zc_ObjectLink_Contract_PersonalCollation
                        zc_ObjectLink_Contract_BankAccount
                        zc_ObjectLink_Contract_ContractTag
 17.04.14                                        * add TRIM
 19.03.14         * add inisStandart
 13.03.14         * add inisDefault
 05.01.14                                        * add �������� ������������ <����� ��������> ��� !!!������!! ��. ���� � !!!�����!! ������
 25.02.14                                        * add inIsUpdate and inIsErased
 21.02.14         * add Bank, BankAccount
 08.11.14                        *
 05.01.14                                        * add �������� ������������ <����� ��������> ��� !!!������!! ��. ����
 04.01.14                                        * add !!!inInvNumber not unique!!!
 14.11.13         * add from redmaine               
 21.10.13                                        * add vbCode
 20.10.13                                        * add from redmaine
 19.10.13                                        * del zc_ObjectString_Contract_InvNumber()
 22.07.13         * add  SigningDate, StartDate, EndDate              
 12.04.13                                        *
 16.06.13                                        * �������
*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_Contract ()
