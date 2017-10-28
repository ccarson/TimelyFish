 CREATE PROCEDURE ProcErrLog_SortKey
	@parm1min int, @parm1max int
AS
	SELECT *
	FROM ProcErrLog
	WHERE SortKey BETWEEN @parm1min AND @parm1max
	ORDER BY SortKey

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


