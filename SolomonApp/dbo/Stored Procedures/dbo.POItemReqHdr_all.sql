 CREATE PROCEDURE POItemReqHdr_all
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM POItemReqHdr
	WHERE ItemReqNbr LIKE @parm1
	ORDER BY ItemReqNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POItemReqHdr_all] TO [MSDSL]
    AS [dbo];

