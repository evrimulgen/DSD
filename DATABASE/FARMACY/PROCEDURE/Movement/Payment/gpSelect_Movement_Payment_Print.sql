-- Function: gpSelect_Movement_Payment_Print()

DROP FUNCTION IF EXISTS gpSelect_Movement_Payment_Print (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Movement_Payment_Print(
    IN inMovementId        Integer  , -- ���� ���������
    IN inSession       TVarChar    -- ������ ������������
)
RETURNS SETOF refcursor
AS
$BODY$
    DECLARE vbUserId Integer;

    DECLARE Cursor1 refcursor;
    DECLARE Cursor2 refcursor;
    DECLARE Cursor3 refcursor;
BEGIN
    -- �������� ���� ������������ �� ����� ���������
    -- vbUserId:= lpCheckRight (inSession, zc_Enum_Process_Select_Movement_Payment());
    vbUserId:= inSession;

    OPEN Cursor1 FOR
        SELECT
            Movement_Payment.Id
          , Movement_Payment.InvNumber
          , Movement_Payment.OperDate
          , Movement_Payment.TotalCount
          , Movement_Payment.TotalSumm
          , Movement_Payment.JuridicalName
        FROM
            Movement_Payment_View AS Movement_Payment
        WHERE 
            Movement_Payment.Id = inMovementId;
    RETURN NEXT Cursor1;


    OPEN Cursor2 FOR
        SELECT
            MI_Payment.Income_JuridicalName
          , MI_Payment.Income_UnitName
          , MI_Payment.Income_InvNumber
          , MI_Payment.Income_OperDate
          , MI_Payment.Income_TotalSumm
          , MI_Payment.Income_NDSKindName
          , MI_Payment.SummaPay
        FROM
            MovementItem_Payment_View AS MI_Payment
        WHERE
            MI_Payment.MovementId = inMovementId
            AND
            MI_Payment.isErased = FALSE
            AND
            MI_Payment.NeedPay = TRUE
        ORDER BY
            MI_Payment.Income_JuridicalName
           ,MI_Payment.Income_OperDate
           ,MI_Payment.Income_InvNumber;

    RETURN NEXT Cursor2;

    OPEN Cursor3 FOR
        SELECT
            MI_Payment.Income_NDSKindName
          , SUM(MI_Payment.Income_TotalSumm)::TFloat AS TotalSumm
          , SUM(MI_Payment.SummaPay)::TFloat         AS SummaPay
          , COUNT(*)::Integer                        AS TotalCount
        FROM
            MovementItem_Payment_View AS MI_Payment
        WHERE
            MI_Payment.MovementId = inMovementId
            AND
            MI_Payment.isErased = FALSE
            AND
            MI_Payment.NeedPay = TRUE
        GROUP BY
            MI_Payment.Income_NDSKindName
        ORDER BY
            MI_Payment.Income_NDSKindName;

    RETURN NEXT Cursor3;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpSelect_Movement_Payment_Print (Integer,TVarChar) OWNER TO postgres;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.   ��������� �.�
 29.10.15                                                                       *
*/

-- SELECT * FROM gpSelect_Movement_Payment_Print (inMovementId := 570596, inSession:= '5');