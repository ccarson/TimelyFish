 CREATE PROCEDURE POReqAddlCost_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 2 ),
	@parm3 varchar( 5 )
AS
	SELECT *
	FROM POReqAddlCost
	WHERE ReqNbr LIKE @parm1
	   AND ReqCntr LIKE @parm2
	   AND LineRef LIKE @parm3
	ORDER BY ReqNbr,
	   ReqCntr,
	   LineRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


