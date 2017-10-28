 CREATE PROCEDURE POReceipt_BatNbr_RcptNbr
	@parm1 varchar( 10 ),
	@parm2 varchar( 10 )
AS
	SELECT *
	FROM POReceipt
	WHERE BatNbr LIKE @parm1
	   AND RcptNbr LIKE @parm2
	ORDER BY BatNbr,
	   RcptNbr

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POReceipt_BatNbr_RcptNbr] TO [MSDSL]
    AS [dbo];

