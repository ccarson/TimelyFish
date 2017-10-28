CREATE PROCEDURE pXF160cftPigGroupRoom_PGR 
	@parm1 varchar (4), 
	@parm2 varchar (10), 
	@parm3 varchar (10) 
	AS 
    	SELECT * FROM cftPigGroupRoom 
	WHERE FeedPlanId = @parm1 
	AND PigGroupId = @parm2 
	AND RoomNbr LIKE @parm3
	ORDER BY FeedPlanId, PigGroupId, RoomNbr

 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF160cftPigGroupRoom_PGR] TO [MSDSL]
    AS [dbo];

