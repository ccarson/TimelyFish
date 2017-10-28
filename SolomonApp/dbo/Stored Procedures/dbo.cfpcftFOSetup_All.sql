--****************************************************************
--	Purpose:Select the feed order setup record
--	Author: Timothy Jones
--	Date: 7/29/2005
--	Program Usage: XF130,XF155
--	Parms: NONE
--****************************************************************
CREATE PROCEDURE cfpcftFOSetup_All 
	AS 
    	SELECT * FROM cftFOSetUp

GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfpcftFOSetup_All] TO [MSDSL]
    AS [dbo];

