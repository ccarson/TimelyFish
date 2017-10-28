 CREATE PROCEDURE
	smServCall_Invoice
		@parm1	varchar(1)
		,@parm2 varchar(10)
AS
	SELECT
		*
	FROM
		smServCall
	WHERE
		ServiceCallCompleted = CONVERT(int,@parm1)
			AND
		ServiceCallId LIKE @parm2
			AND
		ServiceCallStatus in ('R','C')
	ORDER BY
		ServiceCallId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smServCall_Invoice] TO [MSDSL]
    AS [dbo];

