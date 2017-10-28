
/****** Object:  Stored Procedure dbo.pCF510AutoPigAcctBatch    Script Date: 1/25/2005 3:33:13 PM ******/

/****** Object:  Stored Procedure dbo.pCF510AutoPigAcctBatch    Script Date: 9/14/2004 8:30:23 AM ******/
--*************************************************************
--	Purpose:Retrieve last Batch Number
--	Author: Sue Matter	
--	Date: 8/4/2004
--	Usage: Pig Inventory Transfer 
--	Parms:
--*************************************************************

CREATE   PROC dbo.pCF510AutoPigAcctBatch
AS
Select LastBatNbr
From
cftPGSetup




