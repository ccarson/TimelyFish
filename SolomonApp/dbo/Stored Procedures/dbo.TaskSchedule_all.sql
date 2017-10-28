 CREATE PROCEDURE TaskSchedule_all
	@parm1min smallint, @parm1max smallint
AS
	SELECT *
	FROM TaskSchedule
	WHERE LineNbr BETWEEN @parm1min AND @parm1max
	ORDER BY LineNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[TaskSchedule_all] TO [MSDSL]
    AS [dbo];

