 CREATE PROCEDURE
	smCancellation_All
		@parm1 	varchar(10)
AS
	SELECT
		*
	FROM
		smCancellation
	WHERE
		CancellationCode LIKE @parm1
	ORDER BY
		CancellationCode

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smCancellation_All] TO [MSDSL]
    AS [dbo];

