 CREATE PROCEDURE POItemReqHist_ItemReqNbr_LineR
	@parm1 varchar( 10 ),
	@parm2 varchar( 5 )
AS
	SELECT *
	FROM POItemReqHist
	WHERE ItemReqNbr LIKE @parm1
	   AND LineRef LIKE @parm2
	ORDER BY ItemReqNbr,
	   LineRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POItemReqHist_ItemReqNbr_LineR] TO [MSDSL]
    AS [dbo];

