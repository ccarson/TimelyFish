 CREATE PROCEDURE
	smOESetup_All
		@parm1	varchar(2)
AS
	SELECT
		*
	FROM
		OESetup
	WHERE
		SetupId LIKE @parm1
	ORDER BY
		SetupId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smOESetup_All] TO [MSDSL]
    AS [dbo];

