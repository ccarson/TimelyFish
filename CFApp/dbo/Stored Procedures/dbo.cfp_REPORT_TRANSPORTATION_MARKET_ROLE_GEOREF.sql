


--*************************************************************
--	Purpose:Data source for Market Schedule Driver Setup  Report
--		
--	Author: Doran Dahle
--	Date: 11/28/2011
--	Usage: Transportation SSRS Reports	 
--	Parms: @RoleID
--	
--	
--*************************************************************

CREATE PROC [dbo].[cfp_REPORT_TRANSPORTATION_MARKET_ROLE_GEOREF]
	@RoleID		varchar(40)   -- RoleID
AS

Select Source, addr.addressid ,AddGeo.GeoRef
from 
(Select distinct Contact.ShortName as Source, ContactAddress.AddressID as addressid
from [$(SolomonApp)].dbo.cftContact Contact
INNER JOIN [$(CentralData)].dbo.ContactAddress ContactAddress (NOLOCK) ON ContactAddress.ContactID = Contact.ContactID
left outer JOIN [$(CentralData)].dbo.ContactRoleType ContactRole (NOLOCK)
	ON Contact.ContactID=ContactRole.ContactID 
	left outer JOIN [$(CentralData)].dbo.RoleType RoleType (NOLOCK)
	ON ContactRole.RoleTypeID=RoleType.RoleTypeID

WHERE Contact.StatusTypeID = 1 --Active
AND ContactRole.RoleTypeID like @RoleID
AND ContactAddress.AddressTypeID = 1) as addr

INNER JOIN [$(CentralData)].dbo.cft_Address_attrib AddGeo (NOLOCK) ON AddGeo.AddressID=addr.AddressID --wHere AddGeo.GeoRef is not null	
order by Source



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_TRANSPORTATION_MARKET_ROLE_GEOREF] TO [db_sp_exec]
    AS [dbo];

