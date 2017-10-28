 CREATE PROCEDURE smBatch_Release
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM smBatch
	WHERE Batnbr LIKE @parm1
	   AND Status = 'B'
	   AND Handling in ('L','R','N')
	ORDER BY
	   Batnbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


