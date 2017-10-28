CREATE PROCEDURE pXF155cftFeedPlanHdr_FPId 
	@parm1 varchar (4) -- FeedPlanID
	AS 
    	SELECT * FROM cftFeedPlanHdr 
	WHERE FeedPlanId LIKE @parm1
	ORDER BY FeedPlanId
