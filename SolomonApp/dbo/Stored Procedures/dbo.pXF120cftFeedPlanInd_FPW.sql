----------------------------------------------------------------------------------------
--	Purpose: 
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: 
----------------------------------------------------------------------------------------
CREATE PROCEDURE pXF120cftFeedPlanInd_FPW 
	@parm1 varchar (4), 
	@parm2 varchar (10), 
	@parm3 varchar (10), 
	@parm4 float 
	AS 
    	SELECT * 
	FROM cftFeedPlanInd 
	WHERE FeedPlanId = @parm1 
	AND PigGroupId = @parm2 
	AND @parm4 >= WgtLo AND @parm4 < WgtHi
	AND (RoomNbr = @parm3 OR RoomNbr = '')

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF120cftFeedPlanInd_FPW] TO [MSDSL]
    AS [dbo];

