 CREATE PROCEDURE
	smArea_All_EXE
		@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		smArea
	WHERE
		AreaId LIKE @parm1
	ORDER BY
		AreaId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smArea_All_EXE] TO [MSDSL]
    AS [dbo];

