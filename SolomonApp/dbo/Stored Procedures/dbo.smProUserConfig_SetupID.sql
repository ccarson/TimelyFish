 CREATE PROCEDURE
	smProUserConfig_SetupID
		@parm1 	varchar(47)
AS
	SELECT
		*
	FROM
		smProUserConfig
	WHERE
		UserID LIKE @parm1
			AND
		SetupID LIKE 'PROSETUP'
	ORDER BY
		SetupID
		,UserID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smProUserConfig_SetupID] TO [MSDSL]
    AS [dbo];

