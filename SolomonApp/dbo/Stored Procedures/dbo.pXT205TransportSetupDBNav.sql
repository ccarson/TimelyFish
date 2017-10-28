--*************************************************************
--	Purpose:DBNav for Transport Setup record
--		
--	Author: Charity Anderson
--	Date: 8/1/2005
--	Usage: Transportation Module	 
--	Parms: NONE
--*************************************************************

CREATE PROC dbo.pXT205TransportSetupDBNav

AS
Select * from cftTransportSetup

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT205TransportSetupDBNav] TO [SOLOMON]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT205TransportSetupDBNav] TO [MSDSL]
    AS [dbo];

