 CREATE PROCEDURE ANSetup_all
	@parm1 varchar( 2 )
AS
	SELECT *
	FROM ANSetup
	WHERE SetupID LIKE @parm1
	ORDER BY SetupID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


