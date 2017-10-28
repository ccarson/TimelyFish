 CREATE PROCEDURE ED810HeaderExt_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 10 )
AS
	SELECT *
	FROM ED810HeaderExt
	WHERE CpnyID LIKE @parm1
	   AND EDIInvID LIKE @parm2
	ORDER BY CpnyID,
	   EDIInvID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED810HeaderExt_all] TO [MSDSL]
    AS [dbo];

