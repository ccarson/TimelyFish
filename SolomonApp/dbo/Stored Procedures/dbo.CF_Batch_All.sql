--*************************************************************
--	Purpose:Batch initiate
--	Author: Charity Anderson
--	Date: 10/21/2004
--	Usage: Pig Sales Entry		 
--	Parms: 
--*************************************************************

CREATE PROC dbo.CF_Batch_All
	
AS
Select * from Batch

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF_Batch_All] TO [MSDSL]
    AS [dbo];

