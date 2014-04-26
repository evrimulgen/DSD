-- View: ObjectHistory_JuridicalDetails_View

DROP VIEW IF EXISTS ObjectHistory_JuridicalDetails_View CASCADE;

CREATE OR REPLACE VIEW ObjectHistory_JuridicalDetails_View AS
  SELECT ObjectHistory_JuridicalDetails.Id AS ObjectHistoryId
       , ObjectHistory_JuridicalDetails.ObjectId AS JuridicalId
       , ObjectHistoryString_OKPO.ValueData AS OKPO
  FROM ObjectHistory AS ObjectHistory_JuridicalDetails
       LEFT JOIN ObjectHistoryString AS ObjectHistoryString_OKPO
                                     ON ObjectHistoryString_OKPO.ObjectHistoryId = ObjectHistory_JuridicalDetails.Id
                                    AND ObjectHistoryString_OKPO.DescId = zc_ObjectHistoryString_JuridicalDetails_OKPO()
  WHERE ObjectHistory_JuridicalDetails.DescId = zc_ObjectHistory_JuridicalDetails()
    AND ObjectHistory_JuridicalDetails.EndDate = zc_DateEnd()
    -- AND ObjectHistory_JuridicalDetails.EndDate >= '01.01.2015'
    -- update  ObjectDate  set ValueData = DATE_TRUNC ('DAY', ValueData) where DescId in  (zc_ObjectDate_Contract_Signing(), zc_ObjectDate_Contract_Start(), zc_ObjectDate_Contract_End()) and ValueData <> DATE_TRUNC ('DAY', ValueData)

 ;


ALTER TABLE ObjectHistory_JuridicalDetails_View  OWNER TO postgres;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 28.12.13                                        *
*/

-- ����
-- SELECT * FROM ObjectHistory_JuridicalDetails_View
