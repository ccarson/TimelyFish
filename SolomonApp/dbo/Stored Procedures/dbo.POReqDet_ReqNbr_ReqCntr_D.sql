 CREATE PROCEDURE POReqDet_ReqNbr_ReqCntr_D
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM POReqDet
	WHERE ReqNbr = @parm1
		ORDER BY ReqNbr, LineRef, ReqCntr Desc

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


