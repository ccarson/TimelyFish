 CREATE PROCEDURE
	smCallStatus_All
		@parm1 varchar(10)

AS
	SELECT
		*
	FROM
		smCallStatus
	WHERE
		CallStatusId LIKE @parm1
	ORDER BY
		CallStatusId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smCallStatus_All] TO [MSDSL]
    AS [dbo];

