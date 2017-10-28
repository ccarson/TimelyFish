----------------------------------------------------------------------------------------
--	Purpose: 
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: 
----------------------------------------------------------------------------------------
CREATE PROCEDURE pXF120cftFeedPlanInd_FPPR 
	@parm1 varchar (4), 
	@parm2 varchar (10), 
	@parm3 varchar (10) 
	AS 
    	SELECT * FROM cftFeedPlanInd 
	WHERE FeedPlanId = @parm1 
	AND PigGroupId = @parm2 
	AND (RoomNbr = @parm3 OR RoomNbr = '') 
	ORDER BY FeedPlanId, PigGroupId, RoomNbr, Stage

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF120cftFeedPlanInd_FPPR] TO [MSDSL]
    AS [dbo];

