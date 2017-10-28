 CREATE PROCEDURE SFWork1_all
	@parm1min int, @parm1max int
AS
	SELECT *
	FROM SFWork1
	WHERE ID BETWEEN @parm1min AND @parm1max
	ORDER BY ID

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SFWork1_all] TO [MSDSL]
    AS [dbo];

