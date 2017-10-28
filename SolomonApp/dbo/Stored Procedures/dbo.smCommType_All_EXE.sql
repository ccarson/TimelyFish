 CREATE PROCEDURE
	smCommType_All_EXE
		@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		smCommType
	WHERE
		CommTypeId LIKE @parm1
	ORDER BY
		CommTypeId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smCommType_All_EXE] TO [MSDSL]
    AS [dbo];

