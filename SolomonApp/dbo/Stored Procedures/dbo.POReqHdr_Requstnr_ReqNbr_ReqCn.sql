 CREATE PROCEDURE POReqHdr_Requstnr_ReqNbr_ReqCn
	@parm1 varchar( 47 ),
	@parm2 varchar( 10 ),
	@parm3 varchar( 2 )
AS
	SELECT *
	FROM POReqHdr
	WHERE Requstnr LIKE @parm1
	   AND ReqNbr LIKE @parm2
	   AND ReqCntr LIKE @parm3
	ORDER BY Requstnr,
	   ReqNbr,
	   ReqCntr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


