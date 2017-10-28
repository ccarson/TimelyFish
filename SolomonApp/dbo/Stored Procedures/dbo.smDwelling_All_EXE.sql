 CREATE PROCEDURE
	smDwelling_All_EXE
		@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		smDwelling
	WHERE
		DwellingId LIKE @parm1
	ORDER BY
		DwellingId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smDwelling_All_EXE] TO [MSDSL]
    AS [dbo];

