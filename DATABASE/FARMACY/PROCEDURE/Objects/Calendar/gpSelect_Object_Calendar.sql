-- Function: gpSelect_Object_Calendar(TDateTime, TDateTime, TVarChar)

DROP FUNCTION IF EXISTS gpSelect_Object_Calendar(TDateTime, TDateTime, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Object_Calendar(
    IN inStartDate   TDateTime , --
    IN inEndDate     TDateTime , --
    IN inSession     TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer
             , Working Boolean
             , Value TDateTime
             , DayOfWeekName TVarChar
             , Color_calc Integer
             , isErased Boolean
             ) AS
$BODY$
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight(inSession, zc_Enum_Process_Select_Object_Calendar());

   RETURN QUERY 
     SELECT 
           Object_Calendar.Id                 AS Id
         , ObjectBoolean_Working.ValueData    AS Working  
         , ObjectDate_Value.ValueData         AS Value
         , tmpWeekDay.DayOfWeekName_Full ::TVarChar AS DayOfWeekName

         , CASE WHEN ObjectBoolean_Working.ValueData = False THEN 15993821  ELSE 0 /*clBlack*/   END :: Integer AS Color_calc
         
         , Object_Calendar.isErased AS isErased
         
     FROM ObjectDate AS ObjectDate_Period
          LEFT JOIN ObjectDate AS ObjectDate_Value
                               ON ObjectDate_Value.ObjectId = ObjectDate_Period.ObjectId
                              AND ObjectDate_Value.DescId = zc_ObjectDate_Calendar_Value()
          LEFT JOIN Object AS Object_Calendar ON Object_Calendar.Id = ObjectDate_Value.ObjectId
         
          LEFT JOIN ObjectBoolean AS ObjectBoolean_Working 
                                ON ObjectBoolean_Working.ObjectId = Object_Calendar.Id 
                               AND ObjectBoolean_Working.DescId = zc_ObjectBoolean_Calendar_Working()
                               
          LEFT JOIN zfCalc_DayOfWeekName (ObjectDate_period.ValueData) AS tmpWeekDay ON 1=1
          
     WHERE ObjectDate_period.ValueData BETWEEN inStartDate AND inEndDate
       AND Object_Calendar.DescId = zc_Object_Calendar();
  
END;
$BODY$

LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION gpSelect_Object_Calendar (TDateTime, TDateTime, TVarChar) OWNER TO postgres;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 21.01.16         *
*/

-- ����
--SELECT * FROM gpSelect_Object_Calendar (inStartDate:= '01.01.2016', inEndDate:= '17.01.2016', inSession:='2')

--select * from gpSelect_Object_Calendar(inStartDate := ('01.01.2016')::TDateTime , inEndDate := ('22.01.2016')::TDateTime ,  inSession := '3');