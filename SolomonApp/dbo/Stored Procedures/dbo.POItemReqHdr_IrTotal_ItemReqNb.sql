 CREATE PROCEDURE POItemReqHdr_IrTotal_ItemReqNb
	@parm1min float, @parm1max float,
	@parm2 varchar( 10 )
AS
	SELECT *
	FROM POItemReqHdr
	WHERE IrTotal BETWEEN @parm1min AND @parm1max
	   AND ItemReqNbr LIKE @parm2
	ORDER BY IrTotal,
	   ItemReqNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POItemReqHdr_IrTotal_ItemReqNb] TO [MSDSL]
    AS [dbo];

