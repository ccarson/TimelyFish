 CREATE PROCEDURE
	smCommSpecial_All
		@parm1	varchar(10)
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
    ON OBJECT::[dbo].[smCommSpecial_All] TO [MSDSL]
    AS [dbo];

