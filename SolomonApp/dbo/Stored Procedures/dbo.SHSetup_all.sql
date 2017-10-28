 CREATE PROCEDURE SHSetup_all
	@parm1 varchar( 2 )
AS
	SELECT *
	FROM SHSetup
	WHERE SetupID LIKE @parm1
	ORDER BY SetupID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SHSetup_all] TO [MSDSL]
    AS [dbo];

