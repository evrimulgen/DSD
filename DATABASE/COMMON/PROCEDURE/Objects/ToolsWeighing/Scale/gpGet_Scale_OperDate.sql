-- Function: gpGet_Scale_OperDate (TVarChar)

-- DROP FUNCTION IF EXISTS gpSelect_Scale_OperDate (TVarChar);
-- DROP FUNCTION IF EXISTS gpGet_Scale_OperDate (TVarChar);
-- DROP FUNCTION IF EXISTS gpGet_Scale_OperDate (Integer, TVarChar);
DROP FUNCTION IF EXISTS gpGet_Scale_OperDate (Boolean, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpGet_Scale_OperDate(
    IN inIsCeh       Boolean       --
  , IN inBranchCode  Integer       -- 
  , IN inSession     TVarChar      -- ������ ������������
)
RETURNS TABLE (OperDate  TDateTime)
AS
$BODY$
   DECLARE vbUserId     Integer;
BEGIN
   -- �������� ���� ������������ �� ����� ���������
   -- vbUserId:= lpGetUserBySession (inSession);

    -- ���������
    RETURN QUERY
      SELECT DATE_TRUNC ('DAY', CURRENT_TIMESTAMP) :: TDateTime AS OperDate;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpGet_Scale_OperDate (Boolean, Integer, TVarChar) OWNER TO postgres;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 18.01.15                                        *
*/

-- ����
-- SELECT * FROM gpGet_Scale_OperDate (TRUE, 1, zfCalc_UserAdmin())
-- SELECT * FROM gpGet_Scale_OperDate (FALSE, 1, zfCalc_UserAdmin())