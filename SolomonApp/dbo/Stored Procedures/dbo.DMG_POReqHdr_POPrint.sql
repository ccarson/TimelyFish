 CREATE PROCEDURE DMG_POReqHdr_POPrint
	@parm1 varchar( 10 ),
	@parm2 varchar( 2 )
AS
	SELECT *
	FROM POReqHdr
	WHERE ReqNbr LIKE @parm1
	   AND ReqCntr LIKE @parm2
	ORDER BY ReqNbr,
	   convert(integer, ReqCntr) Desc

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_POReqHdr_POPrint] TO [MSDSL]
    AS [dbo];

