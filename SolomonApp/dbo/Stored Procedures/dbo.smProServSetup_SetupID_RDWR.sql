 CREATE PROCEDURE
	smProServSetup_SetupID_RDWR
		@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		smProServSetup
	WHERE
		SetupID LIKE @parm1
	ORDER BY
  		Setupid

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smProServSetup_SetupID_RDWR] TO [MSDSL]
    AS [dbo];

