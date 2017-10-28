 CREATE PROCEDURE
	smCommSpecial_All_EXE
		@parm1 	varchar(10)
AS
	SELECT
		*
	FROM
		smCommSpecial
	WHERE
		CommSpecId LIKE @parm1
	ORDER BY
		CommSpecId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smCommSpecial_All_EXE] TO [MSDSL]
    AS [dbo];

