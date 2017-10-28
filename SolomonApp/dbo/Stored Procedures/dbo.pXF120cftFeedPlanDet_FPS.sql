----------------------------------------------------------------------------------------
--	Purpose: 
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: 
----------------------------------------------------------------------------------------
CREATE PROCEDURE pXF120cftFeedPlanDet_FPS 
	@parm1 varchar (4), 
	@parm2 smallint 
	AS 
    	SELECT * 
	FROM cftFeedPlanDet 
	WHERE FeedPlanId = @parm1 
	AND Stage <= @parm2
	ORDER BY FeedPlanId, Stage DESC

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF120cftFeedPlanDet_FPS] TO [MSDSL]
    AS [dbo];

