 CREATE PROCEDURE
	smAgeHeader_All_EXE
		@parm1 	varchar(10)
AS
	SELECT
		*
	FROM
		smAgeHeader
	WHERE
		AgeCode LIKE @parm1
	ORDER BY
		AgeCode

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smAgeHeader_All_EXE] TO [MSDSL]
    AS [dbo];

