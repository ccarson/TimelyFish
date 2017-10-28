 CREATE PROCEDURE POReqHdr_ReqTotal_ReqNbr_ReqCn
	@parm1min float, @parm1max float,
	@parm2 varchar( 10 ),
	@parm3 varchar( 2 )
AS
	SELECT *
	FROM POReqHdr
	WHERE ReqTotal BETWEEN @parm1min AND @parm1max
	   AND ReqNbr LIKE @parm2
	   AND ReqCntr LIKE @parm3
	ORDER BY ReqTotal,
	   ReqNbr,
	   ReqCntr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


