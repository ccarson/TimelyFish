
CREATE PROCEDURE
	smServCall_All_EXE
		@parm1 	varchar(10)
AS
	SELECT
		*
	FROM
		smServCall
	WHERE
		ServiceCallId LIKE @parm1
	ORDER BY
		ServiceCallId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smServCall_All_EXE] TO [MSDSL]
    AS [dbo];

