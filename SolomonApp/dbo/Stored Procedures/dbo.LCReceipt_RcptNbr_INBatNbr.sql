 CREATE PROCEDURE LCReceipt_RcptNbr_INBatNbr
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM LCReceipt
	WHERE RcptNbr LIKE @parm1
		and Inbatnbr > ''
	-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LCReceipt_RcptNbr_INBatNbr] TO [MSDSL]
    AS [dbo];

