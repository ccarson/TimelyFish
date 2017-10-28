 CREATE PROCEDURE LCReceipt_LineNbr
	@parm1min smallint, @parm1max smallint
AS
	SELECT *
	FROM LCReceipt
	WHERE LineNbr BETWEEN @parm1min AND @parm1max
	ORDER BY LineNbr

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LCReceipt_LineNbr] TO [MSDSL]
    AS [dbo];

