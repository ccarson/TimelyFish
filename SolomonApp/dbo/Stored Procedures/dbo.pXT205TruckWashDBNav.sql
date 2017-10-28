--*************************************************************
--	Purpose:DBNav for TruckWash record
--		
--	Author: Charity Anderson
--	Date: 8/1/2005
--	Usage: Transportation Module (Transportation Setup XT205) 
--	Parms: (ContactID)
--*************************************************************

CREATE PROC dbo.pXT205TruckWashDBNav
		(@parm1 as varchar(10))
AS
Select * from cftTruckWash tr
JOIN cftContact c on tr.ContactID=c.ContactID
where tr.ContactID like @parm1

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT205TruckWashDBNav] TO [SOLOMON]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT205TruckWashDBNav] TO [MSDSL]
    AS [dbo];

