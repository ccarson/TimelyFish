 CREATE PROCEDURE
	smProServSetup_SetupID
		@parm1	varchar(10)
AS
	SELECT 	  *
	FROM 	  smProServSetup (NOLOCK)
	WHERE 	  SetupID LIKE @parm1
	ORDER BY  Setupid

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smProServSetup_SetupID] TO [MSDSL]
    AS [dbo];

