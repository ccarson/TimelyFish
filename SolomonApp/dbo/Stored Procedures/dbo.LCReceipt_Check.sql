 CREATE PROCEDURE LCReceipt_Check
	@parm1 varchar( 10 )
	AS
	SELECT *
	FROM LCReceipt
	WHERE RcptNbr LIKE @parm1

	ORDER BY RcptNbr,
	   LineNbr

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LCReceipt_Check] TO [MSDSL]
    AS [dbo];

