--****************************************************************
--	Purpose:Initialize insertable cursor in vbtools app
--	Author: Timothy Jones
--	Date: 8/8/2005
--	Program Usage: XF130
--	Parms: NONE
--****************************************************************
CREATE PROCEDURE cfpINTran_Init 
	AS 
    	SELECT * FROM INTran
	WHERE InvtID = 'Z' AND SiteID = 'Z' AND CpnyID = 'Z' AND RecordID=0

GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfpINTran_Init] TO [MSDSL]
    AS [dbo];

