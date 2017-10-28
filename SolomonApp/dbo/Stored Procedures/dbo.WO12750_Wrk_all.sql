 CREATE PROCEDURE WO12750_Wrk_all
	@parm1min smallint, @parm1max smallint,
	@parm2 varchar( 16 ),
	@parm3 varchar( 32 ),
	@parm4min smallint, @parm4max smallint
AS
	SELECT *
	FROM WO12750_Wrk
	WHERE RI_ID BETWEEN @parm1min AND @parm1max
	   AND WONbr LIKE @parm2
	   AND Task LIKE @parm3
	   AND LineNbr BETWEEN @parm4min AND @parm4max
	ORDER BY RI_ID,
	   WONbr,
	   Task,
	   LineNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WO12750_Wrk_all] TO [MSDSL]
    AS [dbo];

