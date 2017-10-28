----------------------------------------------------------------------------------------
--	Purpose: 
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: 
----------------------------------------------------------------------------------------
CREATE PROCEDURE pXF120cftFeedPlanInd_FPI 
	@parm1 varchar (4), 
	@parm2 varchar (10), 
	@parm3 varchar (10), 
	@parm4 varchar (30) 
	AS 
    	SELECT * 
	FROM cftFeedPlanInd 
	WHERE FeedPlanId = @parm1 
	AND PigGroupId = @parm2 
	AND InvtId = @parm4
	AND (RoomNbr = @parm3 OR RoomNbr = '')

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF120cftFeedPlanInd_FPI] TO [MSDSL]
    AS [dbo];

