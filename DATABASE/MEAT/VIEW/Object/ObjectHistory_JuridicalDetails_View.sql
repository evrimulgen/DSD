-- View: ObjectHistory_JuridicalDetails_View

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