 CREATE PROCEDURE POReqDet_ReqCntr
	@parm1 varchar( 2 )
AS
	SELECT *
	FROM POReqDet
	WHERE ReqCntr LIKE @parm1
	ORDER BY ReqCntr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POReqDet_ReqCntr] TO [MSDSL]
    AS [dbo];

