 CREATE PROCEDURE POReqHdr_VendID_ReqNbr_ReqCntr
	@parm1 varchar( 15 ),
	@parm2 varchar( 10 ),
	@parm3 varchar( 2 )
AS
	SELECT *
	FROM POReqHdr
	WHERE VendID LIKE @parm1
	   AND ReqNbr LIKE @parm2
	   AND ReqCntr LIKE @parm3
	ORDER BY VendID,
	   ReqNbr,
	   ReqCntr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POReqHdr_VendID_ReqNbr_ReqCntr] TO [MSDSL]
    AS [dbo];

