 CREATE PROCEDURE SOHeader_S4Future02
	@parm1 varchar( 30 )
AS
	SELECT *
	FROM SOHeader
	WHERE S4Future02 LIKE @parm1
	ORDER BY S4Future02

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.


