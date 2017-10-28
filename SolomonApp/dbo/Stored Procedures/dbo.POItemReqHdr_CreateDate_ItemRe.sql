 CREATE PROCEDURE POItemReqHdr_CreateDate_ItemRe
	@parm1min smalldatetime, @parm1max smalldatetime,
	@parm2 varchar( 10 )
AS
	SELECT *
	FROM POItemReqHdr
	WHERE CreateDate BETWEEN @parm1min AND @parm1max
	   AND ItemReqNbr LIKE @parm2
	ORDER BY CreateDate,
	   ItemReqNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POItemReqHdr_CreateDate_ItemRe] TO [MSDSL]
    AS [dbo];

