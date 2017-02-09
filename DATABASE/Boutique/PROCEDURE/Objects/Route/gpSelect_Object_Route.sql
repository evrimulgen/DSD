-- Function: gpSelect_Object_Route (TVarChar)

DROP FUNCTION IF EXISTS gpSelect_Object_Route (TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Object_Route(
    IN inSession        TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, Code Integer, Name TVarChar 
             , RateSumma Tfloat, RatePrice  Tfloat, TimePrice  Tfloat
             , UnitId Integer, UnitCode Integer, UnitName TVarChar
             , BranchId Integer, BranchCode Integer, BranchName TVarChar
             , RouteKindId Integer, RouteKindCode Integer, RouteKindName TVarChar
             , FreightId Integer, FreightCode Integer, FreightName TVarChar
             , RouteGroupId Integer, RouteGroupCode Integer, RouteGroupName TVarChar           
             , isErased Boolean
             ) AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbAccessKeyAll Boolean;
BEGIN
   -- �������� ���� ������������ �� ����� ���������
   -- vbUserId:= lpCheckRight (inSession, zc_Enum_Process_Select_Object_Route());
   vbUserId:= lpGetUserBySession (inSession);
   -- ������������ - ����� �� ���������� ������ ���� ����������
   vbAccessKeyAll:= zfCalc_AccessKey_GuideAll (vbUserId);

   -- ���������
   RETURN QUERY 
   SELECT
         Object_Route.Id         AS Id 
       , Object_Route.ObjectCode AS Code
       , Object_Route.ValueData  AS Name
              
       , ObjectFloat_RateSumma.ValueData AS RateSumma
       , ObjectFloat_RatePrice.ValueData AS RatePrice
       , ObjectFloat_TimePrice.ValueData AS TimePrice

       , Object_Unit.Id         AS UnitId 
       , Object_Unit.ObjectCode AS UnitCode
       , Object_Unit.ValueData  AS UnitName

       , Object_Branch.Id         AS BranchId 
       , Object_Branch.ObjectCode AS BranchCode
       , Object_Branch.ValueData  AS BranchName

       , Object_RouteKind.Id         AS RouteKindId 
       , Object_RouteKind.ObjectCode AS RouteKindCode
       , Object_RouteKind.ValueData  AS RouteKindName

       , Object_Freight.Id         AS FreightId 
       , Object_Freight.ObjectCode AS FreightCode
       , Object_Freight.ValueData  AS FreightName
  
       , Object_RouteGroup.Id         AS RouteGroupId 
       , Object_RouteGroup.ObjectCode AS RouteGroupCode
       , Object_RouteGroup.ValueData  AS RouteGroupName       
       
       , Object_Route.isErased   AS isErased
       
   FROM Object AS Object_Route
        LEFT JOIN (SELECT AccessKeyId FROM Object_RoleAccessKey_View WHERE UserId = vbUserId GROUP BY AccessKeyId) AS tmpRoleAccessKey ON NOT vbAccessKeyAll AND tmpRoleAccessKey.AccessKeyId = Object_Route.AccessKeyId

        LEFT JOIN ObjectFloat AS ObjectFloat_RateSumma
                              ON ObjectFloat_RateSumma.ObjectId = Object_Route.Id
                             AND ObjectFloat_RateSumma.DescId = zc_ObjectFloat_Route_RateSumma()

        LEFT JOIN ObjectFloat AS ObjectFloat_RatePrice
                              ON ObjectFloat_RatePrice.ObjectId = Object_Route.Id
                             AND ObjectFloat_RatePrice.DescId = zc_ObjectFloat_Route_RatePrice()
        LEFT JOIN ObjectFloat AS ObjectFloat_TimePrice
                              ON ObjectFloat_TimePrice.ObjectId = Object_Route.Id
                             AND ObjectFloat_TimePrice.DescId = zc_ObjectFloat_Route_TimePrice()
        
        LEFT JOIN ObjectLink AS ObjectLink_Route_Unit ON ObjectLink_Route_Unit.ObjectId = Object_Route.Id
                                                     AND ObjectLink_Route_Unit.DescId = zc_ObjectLink_Route_Unit()
        LEFT JOIN Object AS Object_Unit ON Object_Unit.Id = ObjectLink_Route_Unit.ChildObjectId
        
        LEFT JOIN ObjectLink AS ObjectLink_Route_Branch ON ObjectLink_Route_Branch.ObjectId = Object_Route.Id
                                                     AND ObjectLink_Route_Branch.DescId = zc_ObjectLink_Route_Branch()
        LEFT JOIN Object AS Object_Branch ON Object_Branch.Id = ObjectLink_Route_Branch.ChildObjectId
          
        LEFT JOIN ObjectLink AS ObjectLink_Route_RouteKind ON ObjectLink_Route_RouteKind.ObjectId = Object_Route.Id
                                                          AND ObjectLink_Route_RouteKind.DescId = zc_ObjectLink_Route_RouteKind()
        LEFT JOIN Object AS Object_RouteKind ON Object_RouteKind.Id = ObjectLink_Route_RouteKind.ChildObjectId

        LEFT JOIN ObjectLink AS ObjectLink_Route_Freight ON ObjectLink_Route_Freight.ObjectId = Object_Route.Id
                                                        AND ObjectLink_Route_Freight.DescId = zc_ObjectLink_Route_Freight()
        LEFT JOIN Object AS Object_Freight ON Object_Freight.Id = ObjectLink_Route_Freight.ChildObjectId
  
        LEFT JOIN ObjectLink AS ObjectLink_Route_RouteGroup ON ObjectLink_Route_RouteGroup.ObjectId = Object_Route.Id
                                                           AND ObjectLink_Route_RouteGroup.DescId = zc_ObjectLink_Route_RouteGroup()
        LEFT JOIN Object AS Object_RouteGroup ON Object_RouteGroup.Id = ObjectLink_Route_RouteGroup.ChildObjectId
        		        		   
   WHERE Object_Route.DescId = zc_Object_Route()
     AND (tmpRoleAccessKey.AccessKeyId IS NOT NULL OR vbAccessKeyAll)

      UNION ALL
       SELECT 
             0 AS Id
           , NULL :: Integer AS Code
           , '�������' :: TVarChar AS Name

           , 0 :: Tfloat AS RateSumma
           , 0 :: Tfloat AS RatePrice
           , 0 :: Tfloat AS TimePrice
       
           , 0 AS UnitId 
           , 0 AS UnitCode
           , '' :: TVarChar AS UnitName

           , 0 AS BranchId 
           , 0 AS BranchCode
           , '' :: TVarChar AS BranchName

           , 0 AS RouteKindId 
           , 0 AS RouteKindCode
           , '' :: TVarChar AS RouteKindName

           , 0 AS FreightId 
           , 0 AS FreightCode
           , '' :: TVarChar AS FreightName
  
           , 0 AS RouteGroupId 
           , 0 AS RouteGroupCode
           , '' :: TVarChar AS RouteGroupName       

           , FALSE AS isErased
  ;
  
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpSelect_Object_Route (TVarChar) OWNER TO postgres;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 24.05.16         * add TimePrice
 17.04.16         * 
 20.04.15         * RouteGroup             
 14.12.13                                        * add vbAccessKeyAll
 13.12.13         * add Branch             
 08.12.13                                        * add Object_RoleAccessKey_View
 24.09.13         *  add Unit, RouteKind, Freight
 03.06.13         *
*/
/*
insert into ObjectLink (DescId, ObjectId, ChildObjectId) select zc_ObjectLink_Route_Branch(), Object.Id, (select Id from Object WHERE Object.DescId = zc_Object_Branch() and ObjectCode=1) from Object WHERE Object.DescId = zc_Object_Route() ;
UPDATE Object SET AccessKeyId = Object2.AccessKeyId  from ObjectLink  left join Object as Object2 on Object2.Id = ObjectLink.ChildObjectId  WHERE Object.DescId = zc_Object_Route() and ObjectLink.ObjectId = Object.Id and ObjectLink.DescId = zc_ObjectLink_Route_Branch();
*/
-- ����
-- SELECT * FROM gpSelect_Object_Route (zfCalc_UserAdmin())
