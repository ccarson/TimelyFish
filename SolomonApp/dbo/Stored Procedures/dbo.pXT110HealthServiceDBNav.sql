--*************************************************************
--	Purpose:PV for Health Service
--		
--	Author: Charity Anderson
--	Date: 4/7/2005
--	Usage: Health Service 
--	Parms: ContactID
--*************************************************************

CREATE PROC dbo.pXT110HealthServiceDBNav
	(@parm1 as varchar(10))
AS
Select * from cftHealthService where ContactID like @parm1

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT110HealthServiceDBNav] TO [SOLOMON]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT110HealthServiceDBNav] TO [MSDSL]
    AS [dbo];

