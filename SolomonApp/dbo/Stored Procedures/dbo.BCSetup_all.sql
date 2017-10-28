 CREATE PROCEDURE BCSetup_all
	@parm1 varchar( 1 )
AS
	SELECT *
	FROM BCSetup
	WHERE SetupID LIKE @parm1
	ORDER BY SetupID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


