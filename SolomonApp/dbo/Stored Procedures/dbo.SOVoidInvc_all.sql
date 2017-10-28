 CREATE PROCEDURE SOVoidInvc_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 30 ),
	@parm3 varchar( 15 )
AS
	SELECT *
	FROM SOVoidInvc
	WHERE CpnyID LIKE @parm1
	   AND ReportName LIKE @parm2
	   AND InvcNbr LIKE @parm3
	ORDER BY CpnyID,
	   ReportName,
	   InvcNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOVoidInvc_all] TO [MSDSL]
    AS [dbo];

