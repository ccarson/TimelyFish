
-- =============================================
-- Author:		Unknown
-- Create date: Unknown
-- Description:	Returns Contacts with the given role types

-- Update: Added Trucking company and contact type filter - ddahle 8/28/2015
-- =============================================

CREATE  PROC [dbo].[pXT100ContactPV]
	@RoleTypeID1 int=NULL,
	@RoleTypeID2 int=NULL,
	@RoleTypeID3 int=NULL
	

AS
Select  Distinct c.*,dc.TruckingCompanyName
from cftContact c 
JOIN vXT100Contact v on c.ContactID=v.ContactID
left join [CentralData].[dbo].[cfv_DriverCompany] dc (NOLOCK) on cast(c.ContactID as Integer) = dc.DriverContactID
where  (v.RoleTypeID in (@RoleTypeID1,@RoleTypeID2,@RoleTYpeID3)) 
and v.statustypeID = 1  -- 20111116, added this line to filter out inactive truckers
and c.ContactTypeID = '03'

order by dc.TruckingCompanyName,c.ContactName



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT100ContactPV] TO [SOLOMON]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT100ContactPV] TO [MSDSL]
    AS [dbo];

