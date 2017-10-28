 CREATE PROCEDURE
	smCallStatus_All_EXE
		@parm1 	varchar(10)
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
    ON OBJECT::[dbo].[smCallStatus_All_EXE] TO [MSDSL]
    AS [dbo];

