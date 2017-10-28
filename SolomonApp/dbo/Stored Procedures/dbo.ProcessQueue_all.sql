 CREATE PROCEDURE ProcessQueue_all
	@parm1min smallint, @parm1max smallint,
	@parm2min int, @parm2max int
AS
	SELECT *
	FROM ProcessQueue
	WHERE ProcessPriority BETWEEN @parm1min AND @parm1max
	   AND ProcessQueueID BETWEEN @parm2min AND @parm2max
	ORDER BY ProcessPriority,
	   ProcessQueueID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProcessQueue_all] TO [MSDSL]
    AS [dbo];

