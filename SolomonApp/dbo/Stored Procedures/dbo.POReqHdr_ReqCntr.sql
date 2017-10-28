 CREATE PROCEDURE POReqHdr_ReqCntr
	@parm1 varchar( 2 )
AS
	SELECT *
	FROM POReqHdr
	WHERE ReqCntr LIKE @parm1
	ORDER BY ReqCntr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


