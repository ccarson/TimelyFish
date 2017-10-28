--*************************************************************
--	Purpose:Retrieve last Batch Number
--	Author: Charity Anderson
--	Date: 7/30/2004
--	Usage: PigTransportRecord 
--	Parms:
--*************************************************************

CREATE PROC dbo.pXP135AutoPigAcctBatch
AS
Select LastBatNbr
From
cftPGSetup


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP135AutoPigAcctBatch] TO [MSDSL]
    AS [dbo];

