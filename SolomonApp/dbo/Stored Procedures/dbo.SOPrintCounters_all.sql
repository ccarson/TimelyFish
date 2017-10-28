 CREATE PROCEDURE SOPrintCounters_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 30 )
AS
	SELECT *
	FROM SOPrintCounters
	WHERE CpnyID LIKE @parm1
	   AND ReportName LIKE @parm2
	ORDER BY CpnyID,
	   ReportName

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOPrintCounters_all] TO [MSDSL]
    AS [dbo];

