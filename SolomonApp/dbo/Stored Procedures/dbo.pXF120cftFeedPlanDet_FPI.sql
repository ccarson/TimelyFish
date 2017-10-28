----------------------------------------------------------------------------------------
--	Purpose: 
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: 
----------------------------------------------------------------------------------------
CREATE PROCEDURE pXF120cftFeedPlanDet_FPI 
	@parm1 varchar (4), 
	@parm2 varchar (30) 
	AS 
    	SELECT * 
	FROM cftFeedPlanDet 
	WHERE FeedPlanId = @parm1 
	AND InvtId = @parm2

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF120cftFeedPlanDet_FPI] TO [MSDSL]
    AS [dbo];

