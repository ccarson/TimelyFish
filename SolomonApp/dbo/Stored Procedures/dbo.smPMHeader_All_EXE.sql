 CREATE PROCEDURE
	smPMHeader_All_EXE
		@parm1 	varchar(10)
AS
	SELECT
		*
	FROM
		smPMHeader
	WHERE
		PMType LIKE @parm1
	ORDER BY
		PMType

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smPMHeader_All_EXE] TO [MSDSL]
    AS [dbo];

