-- View: Object_ContractCondition_ValueView

-- DROP VIEW IF EXISTS Object_ContractCondition_ValueView;

CREATE OR REPLACE VIEW Object_ContractCondition_ValueView AS
  SELECT ObjectLink_ContractCondition_Contract.ChildObjectId  AS ContractId

       , MAX (CASE WHEN tmpContractConditionKind.Id = zc_Enum_ContractConditionKind_ChangePercent() THEN ObjectFloat_Value.ValueData ELSE NULL END) :: TFloat AS ChangePercent
       , MAX (CASE WHEN tmpContractConditionKind.Id = zc_Enum_ContractConditionKind_ChangePrice()   THEN ObjectFloat_Value.ValueData ELSE NULL END) :: TFloat AS ChangePrice
       
       , MAX (CASE WHEN tmpContractConditionKind.Id = zc_Enum_ContractConditionKind_DelayDayCalendar() THEN ObjectFloat_Value.ValueData ELSE NULL END) :: TFloat AS DayCalendar
       , MAX (CASE WHEN tmpContractConditionKind.Id = zc_Enum_ContractConditionKind_DelayDayBank()     THEN ObjectFloat_Value.ValueData ELSE NULL END) :: TFloat AS DayBank
       , CASE WHEN 0 <> MAX (CASE WHEN tmpContractConditionKind.Id = zc_Enum_ContractConditionKind_DelayDayCalendar() THEN ObjectFloat_Value.ValueData ELSE NULL END)
                  THEN (MAX (CASE WHEN tmpContractConditionKind.Id = zc_Enum_ContractConditionKind_DelayDayCalendar() THEN ObjectFloat_Value.ValueData ELSE NULL END) :: Integer) :: TVarChar || ' �.��.'
              WHEN 0 <> MAX (CASE WHEN tmpContractConditionKind.Id = zc_Enum_ContractConditionKind_DelayDayBank()     THEN ObjectFloat_Value.ValueData ELSE NULL END)
                  THEN (MAX (CASE WHEN tmpContractConditionKind.Id = zc_Enum_ContractConditionKind_DelayDayBank()     THEN ObjectFloat_Value.ValueData ELSE NULL END) :: Integer) :: TVarChar || ' �.��.'
              ELSE '0 ��.'
         END :: TVarChar  AS DelayDay

  FROM (SELECT zc_Enum_ContractConditionKind_ChangePercent() AS Id -- (-)% ������ (+)% �������
       UNION ALL
        SELECT zc_Enum_ContractConditionKind_ChangePrice()   AS Id -- ������ � ����

       UNION ALL
        SELECT zc_Enum_ContractConditionKind_DelayDayCalendar() AS Id -- �������� � ����������� ���� 
       UNION ALL
        SELECT zc_Enum_ContractConditionKind_DelayDayBank()     AS Id --  �������� � ���������� ���� 

       ) AS tmpContractConditionKind
       INNER JOIN ObjectLink AS ObjectLink_ContractCondition_ContractConditionKind
                             ON ObjectLink_ContractCondition_ContractConditionKind.ChildObjectId = tmpContractConditionKind.Id
                            AND ObjectLink_ContractCondition_ContractConditionKind.DescId = zc_ObjectLink_ContractCondition_ContractConditionKind()
       INNER JOIN ObjectFloat AS ObjectFloat_Value
                              ON ObjectFloat_Value.ObjectId = ObjectLink_ContractCondition_ContractConditionKind.ObjectId
                             AND ObjectFloat_Value.DescId = zc_ObjectFloat_ContractCondition_Value()
                             AND ObjectFloat_Value.ValueData <> 0
       INNER JOIN ObjectLink AS ObjectLink_ContractCondition_Contract
                             ON ObjectLink_ContractCondition_Contract.ObjectId = ObjectLink_ContractCondition_ContractConditionKind.ObjectId
                            AND ObjectLink_ContractCondition_Contract.DescId = zc_ObjectLink_ContractCondition_Contract()

  GROUP BY ObjectLink_ContractCondition_Contract.ChildObjectId;

ALTER TABLE Object_ContractCondition_ValueView  OWNER TO postgres;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 18.11.13                                        *
*/

-- ����
-- SELECT * FROM Object_ContractCondition_ValueView