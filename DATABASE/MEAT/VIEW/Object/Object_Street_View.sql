-- View: Object_Unit_View

DROP VIEW IF EXISTS Object_Street_View;

CREATE OR REPLACE VIEW Object_Street_View AS 
       SELECT 
             Object_Street.Id          AS Id
           , Object_Street.ValueData   AS Name
           
           , PostalCode.ValueData      AS PostalCode
           
           , Object_StreetKind.Id           AS StreetKindId
           , Object_StreetKind.ValueData    AS StreetKindName
         
           , Object_City.Id                 AS CityId
           , Object_City.ValueData          AS CityName

           , View_ProvinceCity.PersonalId   AS ProvinceCityId
           , View_ProvinceCity.PersonalName AS ProvinceCityName
           
           , Object_Street.isErased    AS isErased
           
       FROM Object AS Object_Street
           -- LEFT JOIN (SELECT AccessKeyId FROM Object_RoleAccessKey_View WHERE UserId = vbUserId GROUP BY AccessKeyId) AS tmpRoleAccessKey ON NOT vbAccessKeyAll AND tmpRoleAccessKey.AccessKeyId = Object_Street.AccessKeyId
       
            LEFT JOIN ObjectString AS PostalCode
                                   ON PostalCode.ObjectId = Object_Street.Id 
                                  AND PostalCode.DescId = zc_ObjectString_Street_PostalCode()
                                                             
            LEFT JOIN ObjectLink AS Street_StreetKind
                                 ON Street_StreetKind.ObjectId = Object_Street.Id
                                AND Street_StreetKind.DescId = zc_ObjectLink_Street_StreetKind()
            LEFT JOIN Object AS Object_StreetKind ON Object_StreetKind.Id = Street_StreetKind.ChildObjectId
            
            LEFT JOIN ObjectLink AS ObjectLink_Street_City 
                                 ON ObjectLink_Street_City.ObjectId = Object_Street.Id
                                AND ObjectLink_Street_City.DescId = zc_ObjectLink_Street_City()
            LEFT JOIN Object AS Object_City ON Object_City.Id = ObjectLink_Street_City.ChildObjectId
            
            LEFT JOIN ObjectLink AS ObjectLink_Street_ProvinceCity 
                                 ON ObjectLink_Street_ProvinceCity.ObjectId = Object_Street.Id
                                AND ObjectLink_Street_ProvinceCity.DescId = zc_ObjectLink_Street_ProvinceCity()
            LEFT JOIN Object_Personal_View AS View_ProvinceCity ON View_ProvinceCity.PersonalId = ObjectLink_Street_ProvinceCity.ChildObjectId
            
     WHERE Object_Street.DescId = zc_Object_Street();

ALTER TABLE Object_Street_View
  OWNER TO postgres;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 09.06.14                        * 
*/

-- ����
-- SELECT * FROM Object_Unit_View