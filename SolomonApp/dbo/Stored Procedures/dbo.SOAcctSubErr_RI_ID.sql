 CREATE PROCEDURE SOAcctSubErr_RI_ID
	@parm1min smallint, @parm1max smallint
AS
	SELECT *
	FROM SOAcctSubErr
	WHERE RI_ID BETWEEN @parm1min AND @parm1max
	ORDER BY RI_ID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOAcctSubErr_RI_ID] TO [MSDSL]
    AS [dbo];

