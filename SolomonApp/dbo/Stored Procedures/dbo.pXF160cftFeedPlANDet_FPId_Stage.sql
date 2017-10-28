CREATE PROCEDURE pXF160cftFeedPlANDet_FPId_Stage 
	@parm1 varchar (4), 
	@parm2beg smallint, 
	@parm2end smallint 
	AS 
    	SELECT * FROM cftFeedPlANDet 
	WHERE FeedPlanId = @parm1 
	AND Stage BETWEEN @parm2beg AND @parm2end
	ORDER BY FeedPlanId, Stage
