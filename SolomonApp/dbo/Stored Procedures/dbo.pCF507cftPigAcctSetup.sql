--*************************************************************
--	Purpose:Retrieve all from cftPigAcctSetup			
--	Author: Charity Anderson
--	Date: 8/5/2004
--	Usage: PigTransportRecord 
--	Parms:
--*************************************************************

CREATE PROC dbo.pCF507cftPigAcctSetup
AS
Select *
From
cftPGSetup


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF507cftPigAcctSetup] TO [MSDSL]
    AS [dbo];

