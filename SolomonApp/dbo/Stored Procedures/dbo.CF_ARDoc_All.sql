--*************************************************************
--	Purpose:ARDoc initiate
--	Author: Charity Anderson
--	Date: 10/21/2004
--	Usage: Pig Sales Entry		 
--	Parms: 
--*************************************************************

CREATE PROC dbo.CF_ARDoc_All
	
AS
Select * from ArDoc

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF_ARDoc_All] TO [MSDSL]
    AS [dbo];

