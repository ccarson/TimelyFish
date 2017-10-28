 CREATE PROCEDURE WCSetup_all
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM WCSetup
	WHERE CpnyID LIKE @parm1
	ORDER BY CpnyID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WCSetup_all] TO [MSDSL]
    AS [dbo];

