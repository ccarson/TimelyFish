 CREATE PROCEDURE
	smInvBatch_Batnbr_NotPrint
	@parm1 varchar(10),
	@parm2 varchar(10)
As
	SELECT * FROM smInvBatch
	WHERE EditScrnNbr LIKE @parm1 AND
		   Batnbr LIKE @parm2 AND
		   Status = 'N'
	ORDER BY EditScrnNbr, Batnbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


