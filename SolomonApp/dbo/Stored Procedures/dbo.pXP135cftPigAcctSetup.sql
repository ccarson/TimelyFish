--*************************************************************
--	Purpose:Retrieve all from cftPigAcctSetup			
--	Author: Charity Anderson
--	Date: 8/5/2004
--	Usage: PigTransportRecord 
--	Parms:
--*************************************************************

CREATE PROC dbo.pXP135cftPigAcctSetup
AS
Select *
From
cftPGSetup


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP135cftPigAcctSetup] TO [MSDSL]
    AS [dbo];

