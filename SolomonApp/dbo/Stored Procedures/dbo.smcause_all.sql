 CREATE PROCEDURE smcause_all
	@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		smcause
	WHERE
		CauseID LIKE @parm1
	ORDER BY
		CauseID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smcause_all] TO [MSDSL]
    AS [dbo];

