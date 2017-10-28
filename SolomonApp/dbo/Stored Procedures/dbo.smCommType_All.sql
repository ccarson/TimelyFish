 CREATE PROCEDURE
	smCommType_All
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
    ON OBJECT::[dbo].[smCommType_All] TO [MSDSL]
    AS [dbo];

