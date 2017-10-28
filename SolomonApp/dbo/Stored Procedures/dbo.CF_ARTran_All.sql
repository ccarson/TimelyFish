--*************************************************************
--	Purpose:ARTran initiate
--	Author: Charity Anderson
--	Date: 10/21/2004
--	Usage: Pig Sales Entry		 
--	Parms: 
--*************************************************************

CREATE PROC dbo.CF_ARTran_All
	
AS
Select * from ARTran

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF_ARTran_All] TO [MSDSL]
    AS [dbo];

