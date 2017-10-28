 CREATE PROCEDURE POReqHdr_CpnyID
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM POReqHdr
	WHERE CpnyID LIKE @parm1
	ORDER BY CpnyID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POReqHdr_CpnyID] TO [MSDSL]
    AS [dbo];

