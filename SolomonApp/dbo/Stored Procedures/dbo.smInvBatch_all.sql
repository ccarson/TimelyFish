 CREATE PROCEDURE
	smInvBatch_all
	@parm1 varchar(10)
As
	SELECT * FROM smInvBatch
	WHERE Batnbr LIKE @parm1
	ORDER BY Batnbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


