 CREATE PROCEDURE
	smPMHeader_All
		@parm1 varchar(10)
AS
	SELECT
		*
	FROM
		smPMHeader
	WHERE
		PMType LIKE @parm1
	ORDER BY
		PMtype

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smPMHeader_All] TO [MSDSL]
    AS [dbo];

