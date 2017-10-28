
/****** Object:  Stored Procedure dbo.pCF510AutoPigAcctBatch2    Script Date: 8/28/2004 9:30:19 AM ******/
--*************************************************************
--	Purpose:Retrieve last Batch Number
--	Author: Sue Matter	
--	Date: 8/4/2004
--	Usage: Pig Inventory Transfer 
--	Parms:
--*************************************************************

CREATE  PROC dbo.pCF510AutoPigAcctBatch2
AS
Select *
From
cftPigAcctSetup2




GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF510AutoPigAcctBatch2] TO [MSDSL]
    AS [dbo];

