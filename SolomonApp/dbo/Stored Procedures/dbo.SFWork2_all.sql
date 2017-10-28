 CREATE PROCEDURE SFWork2_all
	@parm1min int, @parm1max int
AS
	SELECT *
	FROM SFWork2
	WHERE ID BETWEEN @parm1min AND @parm1max
	ORDER BY ID

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SFWork2_all] TO [MSDSL]
    AS [dbo];

