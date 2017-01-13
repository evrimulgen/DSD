-- Function: gpSelect_Movement_PriceList()

DROP FUNCTION IF EXISTS gpReport_Check_Promo (TDateTime, TDateTime, TVarChar);

CREATE OR REPLACE FUNCTION gpReport_Check_Promo(
    IN inStartDate     TDateTime ,
    IN inEndDate       TDateTime ,
    IN inSession       TVarChar    -- ������ ������������
)
RETURNS TABLE (
    PlanDate          TDateTime,  --����� 
    UnitName          TVarChar,   --�������������
    TotalAmount       TFloat,     --����� ������� ��
    TotalSumma        TFloat,     --����� ������� ���
    AmountPromo       TFloat,     --������� ����� ��
    SummaPromo        TFloat,     --������� ����� ���
    Amount            TFloat,     --������� ����� ��
    Summa             TFloat,     --������� ����� ���
    PercentPromo      TFloat,     --% ����� �� ���� ������
    PlanAmount        TFloat,     --���� �� ���������� ���
    DiffAmount        TFloat      --������� (���� ����� - ����) 
              )
AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbTmpDate TDateTime;
BEGIN
    -- �������� ���� ������������ �� ����� ���������
    vbUserId:= lpGetUserBySession (inSession);

    --inStartDate := date_trunc('month', inStartDate);
    --inEndDate := date_trunc('month', inEndDate) + Interval '1 MONTH';
    inEndDate := inEndDate + interval '1  day';
        
    CREATE TEMP TABLE _tmpDate(PlanDate TDateTime) ON COMMIT DROP;
    --��������� ����� ����������
    vbTmpDate := inStartDate;
    WHILE vbTmpDate < inEndDate
    LOOP
        INSERT INTO _tmpDate(PlanDate)
        VALUES(Date_trunc('month', vbTmpDate)::TDateTime);
        vbTmpDate := vbTmpDate + INTERVAL '1 DAY';
    END LOOP;

        
    RETURN QUERY
      WITH
           -- �������� ��� ������ �� ��������  ( ����, ��� ����������)
             tmpData AS (SELECT Date_trunc('month', MIContainer.OperDate)::TDateTime AS OperDate
                              , COALESCE (MIContainer.WhereObjectId_analyzer,0) AS UnitId
                              , SUM (COALESCE (-1 * MIContainer.Amount, 0)) AS TotalAmount
                              , SUM (COALESCE (-1 * MIContainer.Amount, 0) * COALESCE (MIContainer.Price,0)) AS TotalSumma
                              , SUM (CASE WHEN COALESCE (MIContainer.ObjectIntId_analyzer,0) = 0 THEN 0 ELSE COALESCE (-1 * MIContainer.Amount, 0) END) AS AmountPromo
                              , SUM (CASE WHEN COALESCE (MIContainer.ObjectIntId_analyzer,0) = 0 THEN 0 ELSE COALESCE (-1 * MIContainer.Amount, 0) * COALESCE (MIContainer.Price,0) END) AS SummaPromo

                         FROM MovementItemContainer AS MIContainer
                         WHERE MIContainer.DescId = zc_MIContainer_Count()
                           AND MIContainer.MovementDescId = zc_Movement_Check()
                           AND MIContainer.OperDate >= inStartDate AND MIContainer.OperDate < inEndDate
                          -- AND MIContainer.OperDate >= '03.10.2016' AND MIContainer.OperDate < '01.12.2016'
                         GROUP BY date_trunc('month', MIContainer.OperDate)
                                , COALESCE (MIContainer.WhereObjectId_analyzer,0)
                         HAVING SUM (COALESCE (-1 * MIContainer.Amount, 0)) <> 0
                        )
   -- �������� ����� �� ����������
   , tmpPlanPromo AS (SELECT Object_ReportPromoParams.UnitId     AS UnitId
                           , Object_ReportPromoParams.PlanDate   AS PlanDate
                           , Object_ReportPromoParams.PlanAmount AS PlanAmount
                      FROM (SELECT DISTINCT _tmpDate.PlanDate FROM _tmpDate) AS _tmpDate
                           INNER JOIN Object_ReportPromoParams_View AS Object_ReportPromoParams
                                                                    ON Object_ReportPromoParams.PlanDate = _tmpDate.PlanDate
                      )

         -- ���������
         SELECT tmpData.OperDate           AS PlanDate      
              , Object_Unit.ValueData      AS UnitName
              , tmpData.TotalAmount        :: TFloat
              , tmpData.TotalSumma         :: TFloat
              , tmpData.AmountPromo        :: TFloat
              , tmpData.SummaPromo         :: TFloat
              , (tmpData.TotalAmount - tmpData.AmountPromo)     :: TFloat AS Amount
              , (tmpData.TotalSumma - tmpData.SummaPromo)       :: TFloat AS SummaSale
              , CASE WHEN tmpData.TotalSumma <> 0 THEN (tmpData.SummaPromo * 100 / tmpData.TotalSumma) ELSE 0 END :: TFloat AS PercentPromo
              , COALESCE (tmpPlanPromo.PlanAmount,0)            :: TFloat AS PlanAmount
              , (COALESCE (tmpData.SummaPromo,0) - COALESCE (tmpPlanPromo.PlanAmount,0))                          :: TFloat AS DiffAmount
          FROM tmpData
               LEFT JOIN tmpPlanPromo ON tmpPlanPromo.UnitId = tmpData.UnitId 
                                     AND tmpPlanPromo.PlanDate = tmpData.OperDate 
               LEFT JOIN Object AS Object_Unit ON Object_Unit.Id = tmpData.UnitId 
     ;

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.  ��������� �.�.
 09.01.17         * �� ���������
 12.12.16         *
*/

-- ����
--SELECT * FROM gpReport_Check_Promo (inMakerId:= 2336604  , inStartDate:= '08.11.2016', inEndDate:= '08.11.2016', inSession:= '2')
--SELECT * FROM gpReport_Check_Promo (inMakerId:= 2336604  , inStartDate:= '08.05.2016', inEndDate:= '08.05.2016', inSession:= '2')
--select * from gpReport_Check_Promo( inStartDate := ('02.11.2016')::TDateTime , inEndDate := ('03.11.2016')::TDateTime ,  inSession := '3');