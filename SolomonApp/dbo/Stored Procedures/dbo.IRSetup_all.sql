 CREATE PROCEDURE IRSetup_all
	@parm1 varchar( 2 )
AS
	SELECT *
	FROM IRSetup
	WHERE SetupID LIKE @parm1
	ORDER BY SetupID

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.


