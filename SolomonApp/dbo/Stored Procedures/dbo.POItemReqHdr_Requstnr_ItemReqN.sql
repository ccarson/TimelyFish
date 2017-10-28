 CREATE PROCEDURE POItemReqHdr_Requstnr_ItemReqN
	@parm1 varchar( 47 ),
	@parm2 varchar( 10 )
AS
	SELECT *
	FROM POItemReqHdr
	WHERE Requstnr LIKE @parm1
	   AND ItemReqNbr LIKE @parm2
	ORDER BY Requstnr,
	   ItemReqNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POItemReqHdr_Requstnr_ItemReqN] TO [MSDSL]
    AS [dbo];

