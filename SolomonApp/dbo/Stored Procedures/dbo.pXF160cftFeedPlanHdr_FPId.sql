CREATE PROCEDURE pXF160cftFeedPlanHdr_FPId 
	@parm1 varchar (4) as 
    	SELECT * FROM cftFeedPlanHdr 
	WHERE FeedPlanId LIKE @parm1
	ORDER BY FeedPlanId
