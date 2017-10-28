 CREATE PROCEDURE LCReceipt_LCCode
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM LCReceipt
	WHERE LCCode LIKE @parm1
	ORDER BY LCCode

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LCReceipt_LCCode] TO [MSDSL]
    AS [dbo];

