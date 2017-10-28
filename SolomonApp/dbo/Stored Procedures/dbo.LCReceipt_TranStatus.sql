 CREATE PROCEDURE LCReceipt_TranStatus
	@parm1 varchar( 1 )
AS
	SELECT *
	FROM LCReceipt
	WHERE TranStatus LIKE @parm1
	ORDER BY TranStatus

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LCReceipt_TranStatus] TO [MSDSL]
    AS [dbo];

