 CREATE PROCEDURE POReqDet_InvtID
	@parm1 varchar( 30 )
AS
	SELECT *
	FROM POReqDet
	WHERE InvtID LIKE @parm1
	ORDER BY InvtID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POReqDet_InvtID] TO [MSDSL]
    AS [dbo];

