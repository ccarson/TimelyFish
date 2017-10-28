 CREATE PROCEDURE
	smServCall_notCompleted_EXE
		@parm1 	varchar(10)
AS
	SELECT
		*
	FROM
		smServCall
	WHERE
		ServiceCallCompleted = 0
			AND
		ServiceCallDuration = 'L'
			AND
		ServiceCallStatus = 'R'
			AND
		ServiceCallId LIKE @parm1
	ORDER BY
		ServiceCallId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smServCall_notCompleted_EXE] TO [MSDSL]
    AS [dbo];

