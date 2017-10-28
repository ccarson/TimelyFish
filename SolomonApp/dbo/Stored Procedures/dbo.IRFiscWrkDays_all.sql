 CREATE PROCEDURE IRFiscWrkDays_all
	@parm1 varchar( 6 )
AS
	SELECT *
	FROM IRFiscWrkDays
	WHERE Period LIKE @parm1
	ORDER BY Period

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.


