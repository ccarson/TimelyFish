 CREATE PROCEDURE smBatch_all
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM smBatch
	WHERE Batnbr LIKE @parm1
	ORDER BY Batnbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


