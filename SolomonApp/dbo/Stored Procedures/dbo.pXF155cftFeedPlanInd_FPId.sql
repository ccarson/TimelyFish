CREATE PROCEDURE pXF155cftFeedPlanInd_FPId 
	@parm1 varchar (4) 
	AS 
    	SELECT * FROM cftFeedPlanInd 
	WHERE FeedPlanId = @parm1 
