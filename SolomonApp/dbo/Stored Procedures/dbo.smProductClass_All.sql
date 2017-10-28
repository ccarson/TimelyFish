 CREATE PROCEDURE
	smProductClass_All
		@parm1 varchar(10)
AS
	SELECT
		*
	FROM
		smProductClass
	WHERE
		ProdClassId LIKE @parm1
	ORDER BY
		ProdClassId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smProductClass_All] TO [MSDSL]
    AS [dbo];

