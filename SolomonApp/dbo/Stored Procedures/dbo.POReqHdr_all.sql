 CREATE PROCEDURE POReqHdr_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 2 )
AS
	SELECT *
	FROM POReqHdr
	WHERE ReqNbr LIKE @parm1
	   AND ReqCntr LIKE @parm2
	ORDER BY ReqNbr,
	   ReqCntr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


