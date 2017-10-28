 CREATE PROCEDURE EDSNote_all
	@parm1min int, @parm1max int
AS
	SELECT *
	FROM EDSNote
	WHERE nID BETWEEN @parm1min AND @parm1max
	ORDER BY nID

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSNote_all] TO [MSDSL]
    AS [dbo];

