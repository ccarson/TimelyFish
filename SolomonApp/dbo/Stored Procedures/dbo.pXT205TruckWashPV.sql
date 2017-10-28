
--*************************************************************
--	Purpose:PV for Truck Wash Contacts		
--	Author: Charity Anderson
--	Date: 8/1/2005
--	Usage: Transportation Setup
--	Parms: @parm1 (SolomonContactID)
--	      
--*************************************************************

CREATE PROC dbo.pXT205TruckWashPV
	@parm1 as varchar(10)
AS
Select c.*
FROM cftContact c
JOIN dbo.cftContactRoleType r on 
c.ContactID= r.ContactID
where r.RoleTypeID='021'
and c.ContactID like @parm1  
order by c.ContactID


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT205TruckWashPV] TO [SOLOMON]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT205TruckWashPV] TO [MSDSL]
    AS [dbo];

