 CREATE PROCEDURE LCCode_all
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM lccode
	WHERE lccode LIKE @parm1
	ORDER BY lccode

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.


