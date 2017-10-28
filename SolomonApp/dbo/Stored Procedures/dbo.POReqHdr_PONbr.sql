 CREATE PROCEDURE POReqHdr_PONbr
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM POReqHdr
	WHERE PONbr LIKE @parm1
	ORDER BY PONbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POReqHdr_PONbr] TO [MSDSL]
    AS [dbo];

