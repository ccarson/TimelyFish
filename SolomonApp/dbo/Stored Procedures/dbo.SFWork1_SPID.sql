 CREATE PROCEDURE SFWork1_SPID
	@parm1min smallint, @parm1max smallint
AS
	SELECT *
	FROM SFWork1
	WHERE SPID BETWEEN @parm1min AND @parm1max
	ORDER BY SPID

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SFWork1_SPID] TO [MSDSL]
    AS [dbo];

