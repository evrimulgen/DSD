-- Function: gpSelect_SheetWorkTime_Period()

DROP FUNCTION IF EXISTS gpSelect_SheetWorkTime_Period (TDateTime, TDateTime, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_SheetWorkTime_Period(
    IN inStartDate   TDateTime , --
    IN inEndDate     TDateTime , --
    IN inSession     TVarChar    -- ������ ������������
)
RETURNS TABLE (OperDate TDateTime, UnitId Integer, UnitName TVarChar
              )
AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbMemberId Integer;
   DECLARE vbStartDate TDateTime;
   DECLARE vbEndDate   TDateTime;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId:= lpCheckRight (inSession, zc_Enum_Process_Select_Movement_SheetWorkTime());
     vbUserId:= lpGetUserBySession (inSession);


     -- ����� ���������
     IF EXISTS (SELECT UserId FROM ObjectLink_UserRole_View WHERE UserId = vbUserId AND RoleId IN (zc_Enum_Role_Admin(), 14473)) -- �������� ���� ������������
     THEN vbMemberId:= 0;
     ELSE
         vbMemberId:= 0;
     END IF;


     vbStartDate := date_trunc ('MONTH', inStartDate);    -- ������ ����� ������
     vbEndDate := date_trunc ('MONTH', inEndDate);        -- ��������� ����� ������
 
     RETURN QUERY 
       WITH tmpList AS (SELECT DISTINCT ObjectLink.ChildObjectId AS UnitId
                        FROM ObjectLink
                        WHERE ObjectLink.DescId = zc_ObjectLink_Personal_Unit()
                          AND ObjectLink.ChildObjectId > 0
                       )
       SELECT
             Period.OperDate::TDateTime
           , Object_Unit.Id           AS UnitId
           , Object_Unit.ValueData    AS UnitName
       FROM (SELECT generate_series(vbStartDate, vbEndDate, '1 MONTH'::interval) OperDate) AS Period
          , (SELECT DISTINCT ChildObjectId AS UnitId FROM ObjectLink WHERE DescId = zc_ObjectLink_StaffList_Unit() AND ChildObjectId > 0 AND vbMemberId = 0
            UNION
             SELECT tmpList.UnitId FROM tmpList
            UNION
             SELECT DISTINCT MovementLinkObject_Unit.ObjectId AS UnitId
             FROM Movement
                  LEFT JOIN MovementLinkObject AS MovementLinkObject_Unit
                                               ON MovementLinkObject_Unit.MovementId = Movement.Id
                                              AND MovementLinkObject_Unit.DescId = zc_MovementLinkObject_Unit()
                  LEFT JOIN tmpList ON tmpList.UnitId = MovementLinkObject_Unit.ObjectId
             WHERE Movement.DescId = zc_Movement_SheetWorkTime()
               AND Movement.OperDate BETWEEN inStartDate AND inEndDate
               AND (tmpList.UnitId > 0 OR vbMemberId = 0)
            ) AS ObjectLink_StaffList_Unit
            LEFT JOIN Object AS Object_Unit ON Object_Unit.Id = ObjectLink_StaffList_Unit.UnitId
      ;
  
END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION gpSelect_SheetWorkTime_Period (TDateTime, TDateTime, TVarChar) OWNER TO postgres;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 28.12.13                                        * add zc_ObjectLink_StaffList_Unit
 01.10.13         *
*/

-- ����
-- SELECT * FROM gpSelect_Movement_SheetWorkTime (inStartDate:= '30.01.2013', inEndDate:= '01.02.2013', inSession:= '2')
-- SELECT * FROM gpSelect_SheetWorkTime_Period (inStartDate:= '30.01.2013', inEndDate:= '01.02.2013', inSession:= '2')