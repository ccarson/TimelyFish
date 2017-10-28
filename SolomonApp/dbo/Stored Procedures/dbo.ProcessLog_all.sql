 CREATE PROCEDURE ProcessLog_all
	@parm1min int, @parm1max int
AS
	SELECT *
	FROM ProcessLog
	WHERE ProcessLogID BETWEEN @parm1min AND @parm1max
	ORDER BY ProcessLogID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProcessLog_all] TO [MSDSL]
    AS [dbo];

