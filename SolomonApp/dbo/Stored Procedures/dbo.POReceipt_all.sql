 CREATE PROCEDURE POReceipt_all
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM POReceipt
	WHERE RcptNbr LIKE @parm1
	ORDER BY RcptNbr

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POReceipt_all] TO [MSDSL]
    AS [dbo];

