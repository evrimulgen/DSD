DROP FUNCTION IF EXISTS gpSelect_Report_SoldDay (TDateTime, Integer, Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Report_SoldDay(
    IN inMonth         TDateTime , -- ����� �����
    IN inUnitId        Integer   , -- �������������
    IN inQuasiSchedule Boolean   , -- �������������
    IN inSession       TVarChar    -- ������ ������������
)
RETURNS TABLE (

    PlanDate          TDateTime,  --����� �����
    UnitName          TVarChar,   --�������������
    PlanAmount        TFloat,     --����
    PlanAmountAccum   TFloat,     --���� � �����������
    FactAmount        TFloat,     --����
    FactAmountAccum   TFloat,     --���� � �����������
    DiffAmount        TFloat,     --������� (���� - ����) 
    DiffAmountAccum   TFloat,     --������� � ���������� (���� � ����������� - ���� � �����������)
    PercentMake       TFloat,     --% ���������� �����
    PercentMakeAccum  TFloat      --% ��������� �� ����������
)

AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbStartDate TDateTime;
   DECLARE vbEndDate TDateTime;
   DECLARE vbTmpDate TDateTime;
   DECLARE vbDayInMonth TFloat;
BEGIN
    vbStartDate := date_trunc('month', inMonth);
    vbEndDate := date_trunc('month', inMonth) + Interval '1 MONTH';
    vbDayInMonth := (DATE_PART('day', vbEndDate - vbStartDate))::TFloat;
    
    
    CREATE TEMP TABLE _TIME(
        PlanDate          TDateTime,  --����� �����
        DayOfWeek         Integer,    --���� � ������
        CountDay          NUMERIC(20,10)    --���-�� ����(������������� / ���������) � ������ 
        ) ON COMMIT DROP;
    CREATE TEMP TABLE _PartDay(
        PlanDate          TDateTime,  --����� �����
        DayOfWeek         Integer,    --���� � ������
        UnitId            Integer,
        Part              NUMERIC(20,10)
        ) ON COMMIT DROP;
        
    CREATE TEMP TABLE _TMP(
        PlanDate          TDateTime,  --����� �����
        DayOfWeek         Integer,    --���� � ������
        UnitId            Integer,    --�� �������������
        UnitName          TVarChar,   --�������������
        PlanMonthAmount   NUMERIC(20,10),     --���� � �����
        PlanAmount        NUMERIC(20,10),     --���� � ����
        PlanAmountAccum   NUMERIC(20,10),     --���� � �����������
        FactAmount        NUMERIC(20,10),     --���� � ����
        FactAmountAccum   NUMERIC(20,10),     --���� � �����������
        DiffAmount        NUMERIC(20,10),     --������� (���� - ����) 
        DiffAmountAccum   NUMERIC(20,10),     --������� � ���������� (���� � ����������� - ���� � �����������)
        PercentMake       NUMERIC(20,10),     --% ���������� �����
        PercentMakeAccum  NUMERIC(20,10)      --% ��������� �� ����������
    ) ON COMMIT DROP;
    
    --��������� ����� ����������
    vbTmpDate := vbStartDate;
    WHILE vbTmpDate < vbEndDate
    LOOP
        INSERT INTO _TIME(PlanDate,DayOfWeek)
        VALUES(vbTmpDate, date_part('dow', vbTmpDate));
        vbTmpDate := vbTmpDate + INTERVAL '1 DAY';
    END LOOP;
    
    UPDATE _TIME SET 
        CountDay = (SELECT COUNT(*) FROM _TIME AS T1 WHERE T1.DayOfWeek = _TIME.DayOfWeek);
    
    INSERT INTO _TMP(PlanDate,DayOfWeek,UnitId,PlanMonthAmount)
    SELECT
        Object_ReportSoldParams.PlanDate::TDateTime       AS PlanDate,
        date_part('dow',Object_ReportSoldParams.PlanDate) AS DayOfWeek, 
        Object_ReportSoldParams.UnitId                    AS UnitId,
        Object_ReportSoldParams.PlanAmount                AS PlanAmount 
    FROM
        Object_ReportSoldParams_View AS Object_ReportSoldParams
    WHERE
        Object_ReportSoldParams.PlanDate >= vbStartDate 
        AND 
        Object_ReportSoldParams.PlanDate < vbEndDate
        AND
        (
            Object_ReportSoldParams.UnitId = inUnitId
            or
            inUnitId = 0
        );
    INSERT INTO _TMP(PlanDate,DayOfWeek,UnitId,FactAmount)
    SELECT
        date_trunc('day', MovementCheck.OperDate)::TDateTime  AS PlanDate,
        date_part('dow',MovementCheck.OperDate)               AS DayOfWeek,
        MovementCheck.UnitId                                  AS UnitID,
        SUM(TotalSumm)                                        AS FactAmount
    FROM
        Movement_Check_View AS MovementCheck
    WHERE
        MovementCheck.OperDate >= vbStartDate
        AND 
        MovementCheck.OperDate < vbEndDate
        AND
        MovementCheck.StatusId = zc_Enum_Status_Complete()
        AND
        (
            MovementCheck.UnitId = inUnitId
            or
            inUnitId = 0
        )
    GROUP BY
        date_trunc('day', MovementCheck.OperDate)::TDateTime,
        date_part('dow',MovementCheck.OperDate),
        MovementCheck.UnitID;
    
    
    --���� ����������� - ���������� ���� ���� � ������ �� ��������� 2 ������
    IF inQuasiSchedule = True THEN
        INSERT INTO _PartDay(PlanDate,DayOfWeek,UnitId,Part)
        SELECT
            _TIME.PlanDate,
            _TIME.DayOfWeek,
            UNIT.UnitId,
            COALESCE(COALESCE(SOLD.FactAmount,0) / SOLD.FactAmountUnit / _TIME.CountDay,0) AS PartDayOfWeek
        FROM 
            _TIME
            CROSS JOIN (SELECT DISTINCT _TMP.UnitId FROM _Tmp) AS UNIT
            LEFT OUTER JOIN(SELECT
                                T0.DayOfWeek,
                                T0.UnitID,
                                T0.FactAmount,
                                SUM(T0.FactAmount)OVER(PARTITION BY T0.UnitId) AS FactAmountUnit
                            FROM(
                                SELECT
                                    date_part('dow', MovementCheck.OperDate) AS DayOfWeek,
                                    MovementCheck.UnitId                     AS UnitID,
                                    SUM(TotalSumm)                           AS FactAmount
                                FROM
                                    Movement_Check_View AS MovementCheck
                                WHERE
                                    MovementCheck.OperDate >= (vbStartDate-INTERVAL '56 DAY')
                                    AND 
                                    MovementCheck.OperDate < vbStartDate
                                    AND
                                    MovementCheck.StatusId = zc_Enum_Status_Complete()
                                    AND
                                    (
                                        MovementCheck.UnitId = inUnitId
                                        or
                                        inUnitId = 0
                                    )
                                GROUP BY
                                    date_part('dow', MovementCheck.OperDate),
                                    MovementCheck.UnitID
                                ) AS T0
                            ) AS SOLD 
                              ON _TIME.DayOfWeek = SOLD.DayOfWeek
                             AND UNIT.UnitId = SOLD.UnitId;
                              
            
    ELSE --����� �������������
        INSERT INTO _PartDay(PlanDate,DayOfWeek,UnitId,Part)
        SELECT
            _TIME.PlanDate,
            _TIME.DayOfWeek,
            T.UnitId,
            100.0/vbDayInMonth/100.0 AS PartDayOfWeek
        FROM 
            _TIME 
            CROSS JOIN (SELECT DISTINCT 
                                _TMP.UnitId
                            FROM
                                _Tmp
                        ) AS T;
    END IF;
    
    INSERT INTO _TMP(PlanDate,DayOfWeek,UnitId,PlanAmount)
    SELECT
        _TIME.PlanDate,
        _TIME.DayOfWeek,
        TMP.UnitId,
        TMP.PlanMonthAmount * COALESCE(_PartDay.Part,100.0/vbDayInMonth/100.0)
    FROM
        (SELECT * FROM _TMP WHERE _TMP.PlanMonthAmount is not null) AS TMP
        CROSS JOIN _TIME
        LEFT OUTER JOIN _PartDay ON TMP.UnitId = _PartDay.UnitId
                                AND _TIME.PlanDate = _PartDay.PlanDate;
                                
    
    RETURN QUERY
        SELECT
            T0.PlanDate::TDateTime                                              AS PlanAmount
           ,Object_Unit.ValueData::TVarChar                                     AS UnitName
           ,T0.PlanAmount::TFloat                                               AS PlanAmount
           ,(SUM(T0.PlanAmount)OVER(PARTITION BY T0.UnitId 
                                    ORDER BY T0.PlanDate))::TFloat              AS PlanAmountAccum
           ,T0.FactAmount::TFloat                                               AS FactAmount
           ,(SUM(T0.FactAmount)OVER(PARTITION BY T0.UnitId 
                                    ORDER BY T0.PlanDate))::TFloat              AS FactAmountAccum
           ,T0.DiffAmount::TFloat                                               AS DiffAmount
           ,(SUM(T0.DiffAmount)OVER(PARTITION BY T0.UnitId 
                                    ORDER BY T0.PlanDate))::TFloat              AS DiffAmountAccum
           ,CASE
                WHEN COALESCE(T0.PlanAmount,0)<>0
                    THEN 100.0*COALESCE(T0.FactAmount,0)/T0.PlanAmount
            END::TFloat                                                         AS PercentMake
           ,CASE
                WHEN COALESCE((SUM(T0.PlanAmount)OVER(PARTITION BY T0.UnitId 
                                                      ORDER BY T0.PlanDate)),0)<>0
                    THEN 100.0
                        *(SUM(T0.DiffAmount)OVER(PARTITION BY T0.UnitId 
                                                 ORDER BY T0.PlanDate))
                         /(SUM(T0.PlanAmount)OVER(PARTITION BY T0.UnitId 
                                                  ORDER BY T0.PlanDate))
            END::TFloat                                                         AS PercentMakeAccum
            
        FROM(
            SELECT
                _PartDay.PlanDate
               ,_PartDay.UnitId
               ,COALESCE(SUM(_TMP.PlanAmount),0) AS PlanAmount
               ,COALESCE(SUM(_TMP.FactAmount),0) AS FactAmount
               ,COALESCE(SUM(_TMP.FactAmount),0)-COALESCE(SUM(_TMP.PlanAmount),0) AS DiffAmount
            FROM
                _PartDay
                LEFT OUTER JOIN _TMP ON _PartDay.PlanDate = _TMP.PlanDate
                                    AND _PartDay.UnitId = _TMP.UnitId
            GROUP BY
                _PartDay.PlanDate
               ,_PartDay.UnitId
           ) AS T0
           INNER JOIN Object AS Object_Unit ON T0.UnitId = Object_Unit.ID
       ORDER BY
           Object_Unit.ValueData
          ,T0.PlanDate;
END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION gpSelect_Report_SoldDay (TDateTime, Integer, Boolean, TVarChar) OWNER TO postgres;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.  ��������� �.�.
 28.09.15                                                                        *
*/
/*
-- !!!
-- !!!��������������!!!, ��� � ������ ��������� :)
-- !!!
select Movement.InvNumber, Movement.OperDate, MIFloat_Price.ValueData, tmp.*, Object.*
   -- , gpReComplete_Movement_Check (Movement.Id, '3')
from (select Movement_Check.InvNumber, MI_Check.Id, MI_Check.ObjectId, MI_Check.Amount, coalesce (-1 * SUM (MIContainer.Amount), 0) as calcAmount , Movement_Check.Id as MovementId
      FROM
          Movement AS Movement_Check
          INNER JOIN MovementLinkObject AS MovementLinkObject_Unit
                                        ON MovementLinkObject_Unit.MovementId = Movement_Check.Id
                                       AND MovementLinkObject_Unit.DescId = zc_MovementLinkObject_Unit()
                                       -- AND MovementLinkObject_Unit.ObjectId = 183292 -- ������_1 ��_������_6
            INNER JOIN MovementItem AS MI_Check
                                    ON MI_Check.MovementId = Movement_Check.Id
                                   AND MI_Check.DescId = zc_MI_Master()
                                   AND MI_Check.isErased = FALSE
            LEFT OUTER JOIN MovementItemContainer AS MIContainer
                                                  ON MIContainer.MovementItemId = MI_Check.Id
                                                 AND MIContainer.DescId = zc_MIContainer_Count() 

      where Movement_Check.OperDate >= '01.01.2016' and Movement_Check.OperDate < '01.02.2016'
--    where Movement_Check.OperDate >= '01.02.2016' and Movement_Check.OperDate < '01.03.2016'
        and Movement_Check.DescId = zc_Movement_Check()
        AND Movement_Check.StatusId = zc_Enum_Status_Complete()
      group by Movement_Check.InvNumber, MI_Check.Id, MI_Check.Amount , Movement_Check.Id, MI_Check.ObjectId
      having MI_Check.Amount <> coalesce (-1 * SUM (MIContainer.Amount), 0)
      ) as tmp 
             LEFT JOIN Object on Object.Id = tmp.ObjectId
             LEFT JOIN Movement on  Movement.Id = tmp.MovementId
             LEFT OUTER JOIN MovementItemFloat AS MIFloat_Price
                                               ON MIFloat_Price.MovementItemId =  tmp.Id
                                              AND MIFloat_Price.DescId = zc_MIFloat_Price()
select *  FROM MovementItem where Id = 26009762
select *  FROM MovementItemContainer where MovementItemId = 26009762
*/

-- Select * from gpSelect_Report_SoldDay ('20150901'::TDateTime, 0, True, '3')
