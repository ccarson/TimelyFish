CREATE PROCEDURE pXF160cftFeedORDER_I7Cnt 
	@parm1 varchar (4), 
	@parm2 varchar (10) 
	AS 
	SELECT Count(*) FROM cftFeedORDER 
	WHERE FeedPlanId = @parm1 
	AND PigGroupId = @parm2
