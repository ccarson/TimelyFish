 CREATE PROCEDURE RtgStep_WorkCenterID
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM RtgStep
	WHERE WorkCenterID LIKE @parm1
	ORDER BY WorkCenterID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RtgStep_WorkCenterID] TO [MSDSL]
    AS [dbo];

