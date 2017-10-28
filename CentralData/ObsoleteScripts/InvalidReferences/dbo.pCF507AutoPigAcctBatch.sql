--*************************************************************
--	Purpose:Retrieve last Batch Number
--	Author: Charity Anderson
--	Date: 7/30/2004
--	Usage: PigTransportRecord 
--	Parms:
--*************************************************************

CREATE PROC dbo.pCF507AutoPigAcctBatch
AS
Select LastBatNbr
From
cftPGSetup

