
--*************************************************************
--	Purpose:PV for Health Service
--		
--	Author: Charity Anderson
--	Date: 4/7/2005
--	Usage: Health Service 
--	Parms: ContactID
--*************************************************************

CREATE PROC dbo.pXT110HealthServicePV
	(@parm1 as varchar(10))
AS
Select * from cftHealthService h
JOIN cftContact c on h.ContactID=c.ContactID
where h.ContactID like @parm1 order by c.ContactName



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT110HealthServicePV] TO [SOLOMON]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT110HealthServicePV] TO [MSDSL]
    AS [dbo];

