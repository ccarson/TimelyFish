CREATE PROCEDURE pXF160cftFeedPlanInd_FPId_PG_Stage 
	@parm1 varchar (4), 
	@parm2 varchar (10), 
	@parm3 varchar (10), 
	@parm4beg smallint, 
	@parm4end smallint 
	AS 
    	SELECT * FROM cftFeedPlanInd 
	WHERE FeedPlanId = @parm1 
	AND PigGroupId = @parm2 
	AND RoomNbr = @parm3
	AND Stage BETWEEN @parm4beg AND @parm4end
	ORDER BY FeedPlanId, PigGroupId, Stage
