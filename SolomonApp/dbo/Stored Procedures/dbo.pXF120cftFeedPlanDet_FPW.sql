----------------------------------------------------------------------------------------
--	Purpose: 
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: 
----------------------------------------------------------------------------------------
CREATE PROCEDURE pXF120cftFeedPlanDet_FPW 
	@parm1 varchar (4), 
	@parm2 float 
	AS 
    	SELECT * 
	FROM cftFeedPlanDet 
	WHERE FeedPlanId = @parm1 
	AND @parm2 >= WgtLo AND @parm2 < WgtHi

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF120cftFeedPlanDet_FPW] TO [MSDSL]
    AS [dbo];

