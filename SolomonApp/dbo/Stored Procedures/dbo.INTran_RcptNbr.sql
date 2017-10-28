 CREATE PROCEDURE INTran_RcptNbr
	@parm1 varchar( 15 )
AS
	SELECT *
	FROM INTran
	WHERE RcptNbr LIKE @parm1
	ORDER BY RcptNbr

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.


