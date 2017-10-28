 CREATE PROCEDURE POReqDet_LineNbr
	@parm1min smallint, @parm1max smallint
AS
	SELECT *
	FROM POReqDet
	WHERE LineNbr BETWEEN @parm1min AND @parm1max
	ORDER BY LineNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POReqDet_LineNbr] TO [MSDSL]
    AS [dbo];

