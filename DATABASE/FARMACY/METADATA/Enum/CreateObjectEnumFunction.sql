-- !!!
-- !!! ����
-- !!!

CREATE OR REPLACE FUNCTION zc_Enum_Role_Admin() RETURNS integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Role_Admin' AND DescId = zc_ObjectString_Enum()); END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- !!!
-- !!! ���� �����
-- !!!

CREATE OR REPLACE FUNCTION zc_Enum_PaidKind_FirstForm()  RETURNS integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_PaidKind_FirstForm' AND DescId = zc_ObjectString_Enum()); END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_PaidKind_SecondForm() RETURNS integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_PaidKind_SecondForm' AND DescId = zc_ObjectString_Enum()); END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- !!!
-- !!! ���� ���
-- !!!

-- CREATE OR REPLACE FUNCTION zc_Enum_NDSKind_Common()  RETURNS integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_NDSKind_Common' AND DescId = zc_ObjectString_Enum()); END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- CREATE OR REPLACE FUNCTION zc_Enum_NDSKind_Medical() RETURNS integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_NDSKind_Medical' AND DescId = zc_ObjectString_Enum()); END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- !!!
-- !!! ������� ����������
-- !!!

CREATE OR REPLACE FUNCTION zc_Enum_StatusCode_UnComplete() RETURNS Integer AS $BODY$BEGIN RETURN (1); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_StatusCode_Complete() RETURNS Integer AS $BODY$BEGIN RETURN (2); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_StatusCode_Erased() RETURNS Integer AS $BODY$BEGIN RETURN (3); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_Status_UnComplete() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Status_UnComplete' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_Status_Complete() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Status_Complete' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_Status_Erased() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Status_Erased' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- !!!
-- !!! ������� ���������� EDI
-- !!!

CREATE OR REPLACE FUNCTION zc_Enum_EDIStatus_ORDERS() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_EDIStatus_ORDERS' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_EDIStatus_DESADV() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_EDIStatus_DESADV' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_EDIStatus_COMDOC() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_EDIStatus_COMDOC' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_EDIStatus_DECLAR() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_EDIStatus_DECLAR' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- !!!
-- !!! ��� ��������
-- !!!
CREATE OR REPLACE FUNCTION zc_Enum_ContactPersonKind_CreateOrder() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ContactPersonKind_CreateOrder' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_ContactPersonKind_CheckDocument() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ContactPersonKind_CheckDocument' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_ContactPersonKind_AktSverki() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ContactPersonKind_AktSverki' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- !!!
-- !!! ���� ������������ ���������� ���������
-- !!!
CREATE OR REPLACE FUNCTION zc_Enum_DocumentTaxKind_Tax()                   RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_DocumentTaxKind_Tax'                   AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_DocumentTaxKind_TaxSummaryJuridicalS()  RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_DocumentTaxKind_TaxSummaryJuridicalS'  AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_DocumentTaxKind_TaxSummaryJuridicalSR() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_DocumentTaxKind_TaxSummaryJuridicalSR' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_DocumentTaxKind_TaxSummaryPartnerS()    RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_DocumentTaxKind_TaxSummaryPartnerS'    AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_DocumentTaxKind_TaxSummaryPartnerSR()   RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_DocumentTaxKind_TaxSummaryPartnerSR'   AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_DocumentTaxKind_Corrective()                   RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_DocumentTaxKind_Corrective'                   AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_DocumentTaxKind_CorrectiveSummaryJuridicalR()  RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_DocumentTaxKind_CorrectiveSummaryJuridicalR'  AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_DocumentTaxKind_CorrectiveSummaryJuridicalSR() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_DocumentTaxKind_CorrectiveSummaryJuridicalSR' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_DocumentTaxKind_CorrectiveSummaryPartnerR()    RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_DocumentTaxKind_CorrectiveSummaryPartnerR'    AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_DocumentTaxKind_CorrectiveSummaryPartnerSR()   RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_DocumentTaxKind_CorrectiveSummaryPartnerSR'   AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_DocumentTaxKind_CorrectivePrice()              RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_DocumentTaxKind_CorrectivePrice'              AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_DocumentTaxKind_Prepay()                       RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_DocumentTaxKind_Prepay'                       AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;


-- !!!
-- !!! ���� �������
-- !!!
CREATE OR REPLACE FUNCTION zc_Enum_GoodsKind_Main() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_GoodsKind_Main' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- !!!
-- !!! ���� ������
-- !!!
CREATE OR REPLACE FUNCTION zc_Enum_AccountKind_Active() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountKind_Active' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_AccountKind_Passive() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountKind_Passive' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_AccountKind_All() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountKind_All' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- !!!
-- !!! ���� ���������
-- !!!
CREATE OR REPLACE FUNCTION zc_Enum_RouteKind_Internal() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_RouteKind_Internal' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_RouteKind_External() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_RouteKind_External' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- !!!
-- !!! ���� �������� �������
-- !!!
CREATE OR REPLACE FUNCTION zc_Enum_WorkTimeKind_Work()      RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_WorkTimeKind_Work'      AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_WorkTimeKind_Holiday()   RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_WorkTimeKind_Holiday'   AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_WorkTimeKind_Hospital()  RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_WorkTimeKind_Hospital'  AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_WorkTimeKind_Skip()      RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_WorkTimeKind_Skip'      AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_WorkTimeKind_Trainee()   RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_WorkTimeKind_Trainee'   AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_WorkTimeKind_Trainee50() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_WorkTimeKind_Trainee50' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_WorkTimeKind_Quit()      RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_WorkTimeKind_Quit'      AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_WorkTimeKind_Trial()     RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_WorkTimeKind_Trial'     AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_WorkTimeKind_DayOff()    RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_WorkTimeKind_DayOff'    AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- !!!
-- !!! ���� ������ ����������
-- !!!
CREATE OR REPLACE FUNCTION zc_Enum_ModelServiceKind_DaySheetWorkTime()   RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ModelServiceKind_DaySheetWorkTime'   AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_ModelServiceKind_MonthSheetWorkTime() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ModelServiceKind_MonthSheetWorkTime' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_ModelServiceKind_SatSheetWorkTime()   RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ModelServiceKind_SatSheetWorkTime'   AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_ModelServiceKind_MonthFundPay()       RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ModelServiceKind_MonthFundPay'       AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_ModelServiceKind_TurnFundPay()        RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ModelServiceKind_TurnFundPay'        AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- !!!
-- !!! ���� ������ ������
-- !!!
CREATE OR REPLACE FUNCTION zc_Enum_SelectKind_InWeight()  RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_SelectKind_InWeight'  AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_SelectKind_OutWeight() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_SelectKind_OutWeight' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_SelectKind_InAmount()  RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_SelectKind_InAmount'  AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_SelectKind_OutAmount() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_SelectKind_OutAmount' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- !!!
-- !!! ���� ���� ��� �������� ����������
-- !!!
CREATE OR REPLACE FUNCTION zc_Enum_StaffListSummKind_Month()           RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_StaffListSummKind_Month'           AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_StaffListSummKind_Day()             RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_StaffListSummKind_Day'             AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_StaffListSummKind_Personal()        RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_StaffListSummKind_Personal'        AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_StaffListSummKind_HoursPlan()       RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_StaffListSummKind_HoursPlan'       AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_StaffListSummKind_HoursDay()        RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_StaffListSummKind_HoursDay'        AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_StaffListSummKind_HoursPlanConst()  RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_StaffListSummKind_HoursPlanConst'  AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- CREATE OR REPLACE FUNCTION zc_Enum_StaffListSummKind_HoursDayConst()   RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_StaffListSummKind_HoursDayConst'   AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- CREATE OR REPLACE FUNCTION zc_Enum_StaffListSummKind_WorkHours()       RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_StaffListSummKind_WorkHours'       AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- !!!
-- !!! ��������� ��������
-- !!!
CREATE OR REPLACE FUNCTION zc_Enum_ContractStateKind_Signed()   RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ContractStateKind_Signed'   AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_ContractStateKind_UnSigned() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ContractStateKind_UnSigned' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_ContractStateKind_Close() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ContractStateKind_Close' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_ContractStateKind_Partner() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ContractStateKind_Partner' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- !!!
-- !!! ���� ������� ���������
-- !!!
CREATE OR REPLACE FUNCTION zc_Enum_ContractConditionKind_ChangePercent()          RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ContractConditionKind_ChangePercent'          AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_ContractConditionKind_ChangePrice()            RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ContractConditionKind_ChangePrice'            AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_Enum_ContractConditionKind_DelayDayCalendar()       RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ContractConditionKind_DelayDayCalendar'       AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_ContractConditionKind_DelayDayBank()           RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ContractConditionKind_DelayDayBank'           AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_ContractConditionKind_DelayCreditLimit()       RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ContractConditionKind_DelayCreditLimit'       AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_ContractConditionKind_DelayPrepay()            RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ContractConditionKind_DelayPrepay'            AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_Enum_ContractConditionKind_CreditPercent()          RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ContractConditionKind_CreditPercent'          AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_ContractConditionKind_CreditLimit()            RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ContractConditionKind_CreditLimit'            AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_ContractConditionKind_CreditPercentService()   RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ContractConditionKind_CreditPercentService'   AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_ContractConditionKind_CreditPercentReceived()  RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ContractConditionKind_CreditPercentReceived'  AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_Enum_ContractConditionKind_BonusPercentSale()       RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ContractConditionKind_BonusPercentSale'       AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_ContractConditionKind_BonusPercentSaleReturn() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ContractConditionKind_BonusPercentSaleReturn' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_ContractConditionKind_BonusPercentAccount()    RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ContractConditionKind_BonusPercentAccount'    AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_ContractConditionKind_BonusMonthlyPayment()    RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ContractConditionKind_BonusMonthlyPayment'    AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_ContractConditionKind_BonusMonthlyPaymentAdv() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ContractConditionKind_BonusMonthlyPaymentAdv' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_ContractConditionKind_BonusUpSaleSummPVAT()    RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ContractConditionKind_BonusUpSaleSummPVAT'    AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_ContractConditionKind_BonusUpSaleSummMVAT()    RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ContractConditionKind_BonusUpSaleSummMVAT'    AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_ContractConditionKind_BonusYearlyPayment()     RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ContractConditionKind_BonusYearlyPayment'     AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_ContractConditionKind_LimitReturn()            RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ContractConditionKind_LimitReturn'            AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_Enum_ContractConditionKind_TransportTime1()     RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ContractConditionKind_TransportTime1'    AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_ContractConditionKind_TransportTime2()     RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ContractConditionKind_TransportTime2'    AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_ContractConditionKind_TransportTime3()     RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ContractConditionKind_TransportTime3'    AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_ContractConditionKind_TransportTime4()     RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ContractConditionKind_TransportTime4'    AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_ContractConditionKind_TransportDistance()  RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ContractConditionKind_TransportDistance'    AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_ContractConditionKind_TransportOneTrip()   RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ContractConditionKind_TransportOneTrip'    AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_ContractConditionKind_TransportRoundTrip() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ContractConditionKind_TransportRoundTrip'    AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_ContractConditionKind_TransportPoint()     RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ContractConditionKind_TransportPoint'    AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- !!!
-- !!! ������: 1-������� �������������� ������
-- !!!
-- 10000; "����������� ������"
CREATE OR REPLACE FUNCTION zc_Enum_AccountGroup_10000() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountGroup_10000' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 20000; "������"
CREATE OR REPLACE FUNCTION zc_Enum_AccountGroup_20000() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountGroup_20000' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 30000; "��������"
CREATE OR REPLACE FUNCTION zc_Enum_AccountGroup_30000() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountGroup_30000' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 40000; "�������� ��������"
CREATE OR REPLACE FUNCTION zc_Enum_AccountGroup_40000() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountGroup_40000' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 50000; "������� ������� ��������"
CREATE OR REPLACE FUNCTION zc_Enum_AccountGroup_50000() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountGroup_50000' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 60000; "������� ������� ��������"
CREATE OR REPLACE FUNCTION zc_Enum_AccountGroup_60000() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountGroup_60000' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 70000; "���������"
CREATE OR REPLACE FUNCTION zc_Enum_AccountGroup_70000() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountGroup_70000' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 80000; "������������"
CREATE OR REPLACE FUNCTION zc_Enum_AccountGroup_80000() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountGroup_80000' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 90000; "������� � ��������"
CREATE OR REPLACE FUNCTION zc_Enum_AccountGroup_90000() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountGroup_90000' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 100000; "����������� �������"
CREATE OR REPLACE FUNCTION zc_Enum_AccountGroup_100000() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountGroup_100000' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 110000; "�������"
CREATE OR REPLACE FUNCTION zc_Enum_AccountGroup_110000() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountGroup_110000' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- !!!
-- !!! ������: 2-������� �������������� ������
-- !!!
-- 20000; "������"; 20200; "�� �������"
CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_20200() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_20200' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 20000; "������"; 20400; "�� ������������"
CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_20400() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_20400' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 20000; "������"; 20500; "���������� (��)"
CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_20500() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_20500' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 20000; "������"; 20600; "���������� (�����������)"
CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_20600() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_20600' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 20000; "������"; 20900; "��������� ����"
CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_20900() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_20900' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- 30000; "��������"; 30100; "����������"
CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_30100() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_30100' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 30000; "��������"; 30200; "���� ��������"
CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_30200() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_30200' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 30000; "��������"; 30300; "������ ���������������"
CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_30300() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_30300' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 30000; "��������"; 30400; "������ ��������"
CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_30400() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_30400' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 30000; "��������"; 30500; "���������� (����������� ����)"
CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_30500() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_30500' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 30000; "��������"; 30600; "���������� (���������� ������)"
CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_30600() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_30600' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 30000; "��������"; 30700; "������� ����������"
CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_30700() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_30700' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- 40000; "�������� ��������"; 40100; "�����"
CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_40100() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_40100' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 40000; "�������� ��������"; 40200; "����� ��������"
CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_40200() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_40200' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 40000; "�������� ��������"; 40300; "���������� ����"
CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_40300() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_40300' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 40000; "�������� ��������"; 40400; "��������"
CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_40400() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_40400' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 40000; "�������� ��������"; 40500; "���������"
-- CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_40500() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_40500' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- 60000; "������� ������� ��������"; 60100; "���������� (�����������)"
CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_60100() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_60100' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 60000; "������� ������� ��������"; 60200; "�� ��������"
CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_60200() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_60200' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- 70000; "���������"; 70100; "����������"
CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_70100() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_70100' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 70000; "���������"; 70200; "��������� �� �������"
CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_70200() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_70200' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 70000; "���������"; 70300; "��������� �� ����������"
CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_70300() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_70300' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 70000; "���������"; 70400; "������������ ������
CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_70400() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_70400' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 70000; "���������"; 70500; "����������"
CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_70500() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_70500' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 70000; "���������"; 70600; "���������� (������������)
CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_70600() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_70600' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 70000; "���������"; 70700; "���������������� ��
CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_70700() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_70700' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 70000; "���������"; 70800; "���������������� ��
CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_70800() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_70800' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 70000; "���������"; 70900; "���
CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_70900() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_70900' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 70000; "���������"; 71000; "������� ��������
CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_71000() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_71000' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- 80000; "������������"; 80100; "������� ������"
CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_80100() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_80100' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 80000; "������������"; 80200; "������ �������"
CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_80200() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_80200' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 80000; "������������"; 80400; "�������� �� ��������"
CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_80400() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_80400' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- 90000; "������� � ��������"; 90100; "��������� �������"
CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_90100() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_90100' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 90000; "������� � ��������"; 90200; "��������� ������� (������)"
CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_90200() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_90200' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 90000; "������� � ��������"; 90300; "��������� ������� �� ��"
CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_90300() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_90300' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 90000; "������� � ��������"; 90400; "������ � ������"
CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_90400() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_90400' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- 100000; "����������� �������"; 100400; "������� � �����������"
CREATE OR REPLACE FUNCTION zc_Enum_AccountDirection_100400() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_AccountDirection_100400' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;


-- !!!
-- !!! ������: �������������� ����� (1+2+3 �������)
-- !!!
-- 20901; "��������� ����";
CREATE OR REPLACE FUNCTION zc_Enum_Account_20901() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Account_20901' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- 30201; "���� ��������" + "����";
CREATE OR REPLACE FUNCTION zc_Enum_Account_30201() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Account_30201' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 30202; "���� ��������" + "����";
CREATE OR REPLACE FUNCTION zc_Enum_Account_30202() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Account_30202' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 30203; "���� ��������" + "�����";
CREATE OR REPLACE FUNCTION zc_Enum_Account_30203() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Account_30203' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 30204; "���� ��������" + "�������";
CREATE OR REPLACE FUNCTION zc_Enum_Account_30204() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Account_30204' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 30204; "���� ��������" + "�������-���������";
CREATE OR REPLACE FUNCTION zc_Enum_Account_30205() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Account_30205' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- 40101; "�����";
CREATE OR REPLACE FUNCTION zc_Enum_Account_40101() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Account_40101' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 40201; "����� ��������";
CREATE OR REPLACE FUNCTION zc_Enum_Account_40201() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Account_40201' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 40301; "��������� ����";
CREATE OR REPLACE FUNCTION zc_Enum_Account_40301() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Account_40301' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 40302; "���������";
CREATE OR REPLACE FUNCTION zc_Enum_Account_40302() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Account_40302' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 40401; "��������";
CREATE OR REPLACE FUNCTION zc_Enum_Account_40401() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Account_40401' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- 50401; "������� ������� ��������" + "���������";
CREATE OR REPLACE FUNCTION zc_Enum_Account_50401() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Account_50401' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- 100301; "������� �������� �������";
CREATE OR REPLACE FUNCTION zc_Enum_Account_100301() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Account_100301' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- 110101; "�������"; + ����� � ����
CREATE OR REPLACE FUNCTION zc_Enum_Account_110101() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Account_110101' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 110101; "�������"; + ������ � ����
CREATE OR REPLACE FUNCTION zc_Enum_Account_110201() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Account_110201' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 110101; "�������"; + ��������� ����
CREATE OR REPLACE FUNCTION zc_Enum_Account_110301() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Account_110301' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 110101; "�������"; + ����������� �����
CREATE OR REPLACE FUNCTION zc_Enum_Account_110401() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Account_110401' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- !!!
-- !!! ��: 1-������� �������������� ������ ����������
-- !!!
-- 10000; "�������� �����"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyGroup_10000() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyGroup_10000' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 20000; "�������������"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyGroup_20000() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyGroup_20000' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 30000; "������"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyGroup_30000() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyGroup_30000' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 40000; "���������� ������������"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyGroup_40000() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyGroup_40000' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 50000; "������� � ��������"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyGroup_50000() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyGroup_50000' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 60000; "���������� �����"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyGroup_60000() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyGroup_60000' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 70000; "����������"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyGroup_70000() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyGroup_70000' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 80000; "����������� ��������"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyGroup_80000() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyGroup_80000' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;


-- !!!
-- !!! ��: 2-������� �������������� ����������
-- !!!
-- 10000; "�������� �����"; 10100; "������ �����"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_10100() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_10100' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 10000; "�������� �����"; 10200; "������ �����"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_10200() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_10200' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- 20000; "�������������"; 20100; "�������� � �������"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_20100() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_20100' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 20000; "�������������"; 20200; "������ ���"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_20200() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_20200' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 20000; "�������������"; 20300; "������ �������� ��-��"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_20300() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_20300' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 20000; "�������������"; 20400; "���"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_20400() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_20400' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 20000; "�������������"; 20500; "��������� ����"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_20500() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_20500' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 20000; "�������������"; 20600; "������ ���������"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_20600() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_20600' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 20000; "�������������"; 20700; "������"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_20700() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_20700' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 20000; "�������������"; 20800; "����"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_20800() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_20800' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 20000; "�������������"; 20900; "����"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_20900() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_20900' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 20000; "�������������"; 21000; "�����"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_21000() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_21000' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 20000; "�������������"; 21100; "�������"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_21100() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_21100' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 20000; "�������������"; 21100; "�������-���������"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_21150() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_21150' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- 20000; "�������������"; 21200; "����������������"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_21200() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_21200' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 20000; "�������������"; 21300; "������������� ������������"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_21300() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_21300' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 20000; "�������������"; 21400; "������ ����������"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_21400() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_21400' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 20000; "�������������"; 21500; "���������"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_21500() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_21500' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 20000; "�������������"; 21600; "������������ ������"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_21600() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_21600' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- 30000; "������"; 30100; "���������"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_30100() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_30100' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 30000; "������"; 30200; "������ �����"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_30200() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_30200' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 30000; "������"; 30300; "�����������"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_30300() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_30300' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 30000; "������"; 30400; "������ ���������������"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_30400() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_30400' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 30000; "������"; 30500; "������ ������"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_30500() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_30500' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- 40000; "���������� ������������"; 40100; "������� ������"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_40100() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_40100' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 40000; "���������� ������������"; 40200; "������ �������"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_40200() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_40200' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 40000; "���������� ������������"; 40300; "���������"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_40300() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_40300' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 40000; "���������� ������������"; 40400; "�������� �� ��������"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_40400() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_40400' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 40000; "���������� ������������"; 40500; "�����"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_40500() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_40500' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 40000; "���������� ������������"; 40600; "��������"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_40600() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_40600' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 40000; "���������� ������������"; 40700; "����"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_40700() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_40700' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 40000; "���������� ������������"; 40800; "���������� ������"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_40800() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_40800' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 40000; "���������� ������������"; 40900; "���������� ������"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_40900() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_40900' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- 50000; "������� � ��������"; 50100; "��������� ������� �� ��"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_50100() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_50100' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 50000; "������� � ��������"; 50200; "��������� �������"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_50200() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_50200' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 50000; "������� � ��������"; 50300; "��������� ������� (������)"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_50300() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_50300' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 50000; "������� � ��������"; 50400; "������ � ������"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_50400() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_50400' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- 70000; "����������"; 70500; "���"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_70500() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_70500' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- 80000; "����������� ��������"; 80300; "������� � �����������"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoneyDestination_80300() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoneyDestination_80300' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;


-- !!!
-- !!! ��: �������������� ������ ���������� (1+2+3 �������)
-- !!!
-- 20401; "���";
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoney_20401() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoney_20401' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- 20801; "����"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoney_20801() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoney_20801' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 20901; "����"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoney_20901() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoney_20901' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 21001; "�����"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoney_21001() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoney_21001' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 21101; "�������"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoney_21101() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoney_21101' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 21151; "�������-���������"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoney_21151() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoney_21151' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- 21201; "����������������";
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoney_21201() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoney_21201' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 21419; "������ �� �������";
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoney_21419() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoney_21419' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 21501; "������ �� ���������";
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoney_21501() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoney_21501' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 21502; "������ �� ������ �����";
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoney_21502() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoney_21502' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- 30101; "������� ���������"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoney_30101() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoney_30101' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 30102; "�������"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoney_30102() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoney_30102' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 30103; "����"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoney_30103() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoney_30103' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 30201; "������ �����"
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoney_30201() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoney_30201' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 50201; ����� �� �������
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoney_50201() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoney_50201' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 50202; ���
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoney_50202() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoney_50202' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 80401; "������� �������� �������";
CREATE OR REPLACE FUNCTION zc_Enum_InfoMoney_80401() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_InfoMoney_80401' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;


-- !!!
-- !!! ����: 1-������� (������ ����)
-- !!!
-- 10000; "��������� �������� ������������"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossGroup_10000() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossGroup_10000' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 20000; "�������������������� �������"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossGroup_20000() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossGroup_20000' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 30000; "���������������� �������"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossGroup_30000() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossGroup_30000' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 40000; "������� �� ����"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossGroup_40000() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossGroup_40000' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 50000; "������"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossGroup_50000() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossGroup_50000' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 60000; "�����������"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossGroup_60000() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossGroup_60000' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 70000; "�������������� �������"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossGroup_70000() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossGroup_70000' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 80000; "������� � �������"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossGroup_80000() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossGroup_80000' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- !!!
-- !!! ����: 2-������� (��������� ���� - �����������)
-- !!!
-- 10100; "����� ����������"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossDirection_10100() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossDirection_10100' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 10200; "������ �� ���"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossDirection_10200() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossDirection_10200' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 10300; "������ �� ������"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossDirection_10300() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossDirection_10300' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 10400; "������ ��������������"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossDirection_10400() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossDirection_10400' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 10500; "������������� ����������"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossDirection_10500() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossDirection_10500' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 10700; "����� ���������"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossDirection_10700() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossDirection_10700' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 10800; "������������� ���������"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossDirection_10800() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossDirection_10800' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 10900; "���������� ���������"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossDirection_10900() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossDirection_10900' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 11100; "���������"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossDirection_11100() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossDirection_11100' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- 20100; "���������� ������������"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossDirection_20100() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossDirection_20100' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 20200; "���������� �������"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossDirection_20200() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossDirection_20200' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 20300; "���������� ����������"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossDirection_20300() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossDirection_20300' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 20400; "���������� �����"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossDirection_20400() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossDirection_20400' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 20500; "������ ������ (��������+��������������)"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossDirection_20500() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossDirection_20500' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 20600; "������������ ������"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossDirection_20600() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossDirection_20600' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- 40100; "���������� ����������"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossDirection_40100() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossDirection_40100' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 40200; "���������� ��������"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossDirection_40200() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossDirection_40200' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 40300; "�������������"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossDirection_40300() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossDirection_40300' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 40400; "������ ������ (��������+��������������)"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossDirection_40400() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossDirection_40400' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- 50100; ����� �� �������
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossDirection_50100() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossDirection_50100' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 50200; ���
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossDirection_50200() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossDirection_50200' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 50300; ��������� ������� (������)
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossDirection_50300() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossDirection_50300' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 50400; ��������� ������� �� ��
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossDirection_50400() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossDirection_50400' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 50500; ������ � ������*
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossDirection_50500() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossDirection_50500' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- 70100; "���������� ����� ���������
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossDirection_70100() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossDirection_70100' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 70110; "�������� �� ����� ��������
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossDirection_70110() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossDirection_70110' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 70200; "������
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossDirection_70200() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossDirection_70200' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 70300; "���������� (���������, �����)
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossDirection_70300() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossDirection_70300' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 70400; "�������� ������������ �������������
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossDirection_70400() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossDirection_70400' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- 80100; ���������� ������������
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossDirection_80100() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossDirection_80100' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 80200; ������(�������)
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossDirection_80200() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossDirection_80200' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 80300; �������� ����������� �������������
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLossDirection_80300() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLossDirection_80300' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- !!!
-- !!! ����: ������ (1+2+3 �������)
-- !!!
-- 10000; "��������� �������� ������������" 10100; "����� ����������" 10101; "���������"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLoss_10101() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLoss_10101' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 10000; "��������� �������� ������������" 10100; "����� ����������" 10102; "����"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLoss_10102() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLoss_10102' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 10000; "��������� �������� ������������" 10200; "������ �� ������" 10201; "���������"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLoss_10201() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLoss_10201' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 10000; "��������� �������� ������������" 10200; "������ �� ������" 10202; "����"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLoss_10202() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLoss_10202' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 10000; "��������� �������� ������������" 10300; "������ ��������������" 10301; "���������"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLoss_10301() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLoss_10301' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 10000; "��������� �������� ������������" 10300; "������ ��������������" 10301; "����"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLoss_10302() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLoss_10302' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 10000; "��������� �������� ������������" 10400; ������������� ���������� 10401; "���������"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLoss_10401() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLoss_10401' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 10000; "��������� �������� ������������" 10400; ������������� ���������� 10402; "����"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLoss_10402() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLoss_10402' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 10000; "��������� �������� ������������" 10500; "������ �� ���" 10501; "���������"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLoss_10501() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLoss_10501' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 10000; "��������� �������� ������������" 10500; "������ �� ���" 10502; "����"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLoss_10502() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLoss_10502' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- 10000; "��������� �������� ������������" 10700; "����� ���������" 10701; "���������"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLoss_10701() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLoss_10701' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 10000; "��������� �������� ������������" 10700; "����� ���������" 10702; "����"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLoss_10702() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLoss_10702' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 10000; "��������� �������� ������������" 10800; "������������� ���������" 10801; "���������"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLoss_10801() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLoss_10801' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 10000; "��������� �������� ������������" 10800; "������������� ���������" 10802; "����"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLoss_10802() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLoss_10802' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- 10000; "��������� �������� ������������" 10900; "���������� ���������" 10901; "���������"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLoss_10901() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLoss_10901' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 10000; "��������� �������� ������������" 11100; "���������" 11101; "���������"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLoss_11101() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLoss_11101' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- 40000; "������� �� ����" 40200; "���������� ��������" 40208; "������� � ����"
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLoss_40208() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLoss_40208' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- 50000; ������ 50100; ����� �� ������� 50101; ����� �� �������
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLoss_50101() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLoss_50101' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 50000; ������ 50200; ����� �� ������� 50201; ����� �� �������
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLoss_50201() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLoss_50201' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- 70000; �������������� ������� 70100; ���������� ����� ��������� 70101; ���� 
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLoss_70101() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLoss_70101' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 70000; �������������� ������� 70100; ���������� ����� ��������� 70102; �����
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLoss_70102() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLoss_70102' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 70000; �������������� ������� 70110; �������� �� ����� �������� 70111; ���� 
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLoss_70111() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLoss_70111' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- 70000; �������������� ������� 70110; �������� �� ����� �������� 70112; �����
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLoss_70112() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLoss_70112' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- 70000; �������������� ������� 70200; ������ 70203; ������� �����������
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLoss_70203() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLoss_70203' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

-- 80000; ������� � �������  80300; �������� ����������� ������������� 80301; ���������
CREATE OR REPLACE FUNCTION zc_Enum_ProfitLoss_80301() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_ProfitLoss_80301' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.
 23.07.14                        * ���������� ��� �����
*/