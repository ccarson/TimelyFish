
-- ==================================================================
-- Author:		Doran Dahle
-- Create date: 12/08/2011
-- Description:	CENTRAL DATA - Returns all addresses inside a radius
-- ==================================================================
CREATE PROCEDURE [dbo].[cfp_CD_MAP_ADDRESS_SELECT_BY_RADIUS]
(
	@AddressID	int,  -- Address ID of the center popint of the Radius
	@radius		int,  -- Size of the Radius in Meters	
	@RoleID		varchar(40)   -- RoleID
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT Address.AddressID
		,AddGeo.georef.STIntersection(buf.aBuffer)As newgeom
		,round(AddGeo.georef.STDistance(orgin) * 0.000621371192,1) as Miles
		,round(DEGREES(dbo.cff_Bearing(orgin.Lat,orgin.Long,AddGeo.georef.Lat,AddGeo.GeoRef.Long)),1) as bearing
		, Address.Address1
		, Address.City
		, Address.State
		, Address.Zip
		, Address.County
		, Contact.ContactID 
		, Contact.ContactName 
		,RoleType.RoleTypeDescription
		FROM [$(CentralData)].dbo.Contact Contact (NOLOCK)
	INNER JOIN [$(CentralData)].dbo.ContactAddress ContactAddress (NOLOCK)
		ON Contact.ContactID=ContactAddress.ContactID
	INNER JOIN [$(CentralData)].dbo.Address Address (NOLOCK)
		ON ContactAddress.AddressID=Address.AddressID
	INNER JOIN [$(CentralData)].dbo.cft_Address_attrib AddGeo (NOLOCK)
		ON AddGeo.AddressID=Address.AddressID		
	left outer JOIN [$(CentralData)].dbo.ContactRoleType ContactRole (NOLOCK)
	ON Contact.ContactID=ContactRole.ContactID 
	left outer JOIN [$(CentralData)].dbo.RoleType RoleType (NOLOCK)
	ON ContactRole.RoleTypeID=RoleType.RoleTypeID
 INNER JOIN
(SELECT TOP 1 geoRef.STBuffer(@radius) As aBuffer , geoRef As orgin 
FROM [$(CentralData)].dbo.cft_Address_attrib ab WHERE AddressID = @AddressID) As buf
ON (AddGeo.georef.STIntersects(buf.aBuffer) = 1)
	WHERE ContactAddress.AddressTypeID=1
		AND (Address.Longitude IS NOT NULL) 
		AND (Address.Latitude <> 0) 
		AND (Address.Longitude IS NOT NULL) 
		AND (Address.Latitude <> 0)
		AND Contact.StatusTypeID = 1 --Active
		AND ContactRole.RoleTypeID like @RoleID
	ORDER BY Miles;
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_MAP_ADDRESS_SELECT_BY_RADIUS] TO [db_sp_exec]
    AS [dbo];

