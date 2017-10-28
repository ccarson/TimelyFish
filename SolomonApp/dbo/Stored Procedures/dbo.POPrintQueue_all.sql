 CREATE PROCEDURE POPrintQueue_all
	@parm1min smallint, @parm1max smallint,
	@parm2 varchar( 10 ),
	@parm3 varchar( 10 )
AS
	SELECT *
	FROM POPrintQueue
	WHERE RI_ID BETWEEN @parm1min AND @parm1max
	   AND CpnyID LIKE @parm2
	   AND PONbr LIKE @parm3
	ORDER BY RI_ID,
	   CpnyID,
	   PONbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POPrintQueue_all] TO [MSDSL]
    AS [dbo];

