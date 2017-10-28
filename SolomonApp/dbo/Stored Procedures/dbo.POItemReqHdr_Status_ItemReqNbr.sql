 CREATE PROCEDURE POItemReqHdr_Status_ItemReqNbr
	@parm1 varchar( 2 ),
	@parm2 varchar( 10 )
AS
	SELECT *
	FROM POItemReqHdr
	WHERE Status LIKE @parm1
	   AND ItemReqNbr LIKE @parm2
	ORDER BY Status,
	   ItemReqNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POItemReqHdr_Status_ItemReqNbr] TO [MSDSL]
    AS [dbo];

