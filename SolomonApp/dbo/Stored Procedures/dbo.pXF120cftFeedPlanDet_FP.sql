----------------------------------------------------------------------------------------
--	Purpose: 
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: 
----------------------------------------------------------------------------------------
CREATE PROCEDURE pXF120cftFeedPlanDet_FP 
	@parm1 varchar (4) 
	AS 
    	SELECT * FROM cftFeedPlanDet 
	WHERE FeedPlanId = @parm1
	ORDER BY FeedPlanId, Stage

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF120cftFeedPlanDet_FP] TO [MSDSL]
    AS [dbo];

