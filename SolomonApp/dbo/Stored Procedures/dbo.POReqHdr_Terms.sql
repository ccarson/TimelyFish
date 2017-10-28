 CREATE PROCEDURE POReqHdr_Terms
	@parm1 varchar( 2 )
AS
	SELECT *
	FROM POReqHdr
	WHERE Terms LIKE @parm1
	ORDER BY Terms

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POReqHdr_Terms] TO [MSDSL]
    AS [dbo];

