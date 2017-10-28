 CREATE PROCEDURE
	smMenu_all
		@parm1beg	smallint
		,@parm1end	smallint
AS
	SELECT
		*
	FROM
		smMenu
	WHERE
		linenbr BETWEEN @parm1beg AND @parm1end
	ORDER BY
		linenbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


