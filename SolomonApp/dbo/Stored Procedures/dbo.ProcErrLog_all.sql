 CREATE PROCEDURE ProcErrLog_all
	@parm1min int, @parm1max int
AS
	SELECT *
	FROM ProcErrLog
	WHERE RecordID BETWEEN @parm1min AND @parm1max
	ORDER BY RecordID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProcErrLog_all] TO [MSDSL]
    AS [dbo];

