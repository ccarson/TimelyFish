--*************************************************************
--	Purpose:Retrieve last Ref Number				
--	Author: Charity Anderson
--	Date: 7/30/2004
--	Usage: PigTransportRecord 
--	Parms:
--*************************************************************

CREATE PROC dbo.pXP135AutoPigAcctRef
AS
Select LastRefNbr
From
cftPGSetup


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP135AutoPigAcctRef] TO [MSDSL]
    AS [dbo];

