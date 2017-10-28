 CREATE PROCEDURE POReqHdr_Status_ReqNbr_ReqCntr
	@parm1 varchar( 2 ),
	@parm2 varchar( 10 ),
	@parm3 varchar( 2 )
AS
	SELECT *
	FROM POReqHdr
	WHERE Status LIKE @parm1
	   AND ReqNbr LIKE @parm2
	   AND ReqCntr LIKE @parm3
	ORDER BY Status,
	   ReqNbr,
	   ReqCntr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


