 CREATE PROCEDURE LCReceipt_RcptNbr
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM LCReceipt
	WHERE RcptNbr LIKE @parm1
	ORDER BY RcptNbr

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LCReceipt_RcptNbr] TO [MSDSL]
    AS [dbo];

